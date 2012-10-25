module Manman

class Worker

  def initialize( logger=nil, opts=nil )
    if logger.nil?    
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
    else
      @logger = logger
    end

    if opts.nil?
      @opts    = Opts.new
    else
      @opts = opts
    end
  end

  attr_reader :logger, :opts

  
  def run
    puts "Using settings:"
    pp opts
    
    generate_manifest()
    
    puts 'Done.'
  end   # method run


  def generate_manifest

    puts "  working folder is: #{Dir.pwd}"
    
    puts "Loading template #{opts.template}..."
    
    old_lines = File.read( opts.template )

    new_lines = []

    header_lines = []

    
    ### todo/fix: move to template  ???
    header_lines << "####################################################\n"
    header_lines << "# generated on  #{Time.now} using  #{Manman.banner}\n"
    header_lines << "# - version: #{opts.release}, env: #{opts.env}\n"
  
    old_lines.each_line do |line|
  
      if line =~ /^\s*#/
        # skip komments and do NOT copy to result (keep comments secret!)
        logger.debug 'skipping comment line'
        next
      end
        
      if line =~ /^\s*$/ 
        # kommentar oder leerzeile überspringen 
        logger.debug 'skipping blank line'
        new_lines << line
        next
      end
  
      # split/process key value pair
  
      tokens = line.split( ':' )
  
      key    = tokens[0]
      values = tokens[1]

      ## special keys (NOT files; do NOT calculate md5 digest)
     
      headers_release  = [ 'RELEASE', 'VERSION' ]
      headers_env      = [ 'ENV', 'UMGEBUNG' ]
      headers_valid    = [ 'VALID_UNTIL', 'GUELTIG_BIS' ]
      headers_checksum = [ 'CHECKSUM' ]
     
      headers = headers_release + headers_env + headers_valid + headers_checksum
      headers += opts.headers   # add possible user defined extra headers
     
      if headers.include?( key )
        if headers_release.include?( key )
          new_lines << "#{key}: #{opts.release}\n"
        elsif headers_env.include?( key )
          new_lines << "#{key}: #{opts.env}\n"
        elsif headers_valid.include?( key )
          new_lines << "#{key}: #{opts.valid}\n"
        else    # assume extra headers or checksum
          new_lines << line     ## just pass header line throug; not modified
        end
        next
      end

      ### calculate md5 digests
      
      md5 = ""  
      fn = "#{opts.base}/#{key}"   # filename
      
      if File.exists?( fn ) == false
        md5 = "xxxxxxx"
        msg = "*** ERROR: #{key} missing; using path #{fn}"
        puts msg
        header_lines << "#  #{msg}\n"     # add error to header in manifest
      else
        md5 = calc_digest_md5( fn )
        puts "OK #{key} -> #{md5}"
      end
      
      new_lines << "#{key}: #{md5}, #{values}"
             
    end # oldlines.each


    header_lines << "#####################################\n"
    header_lines << "\n"

    new_lines = header_lines + new_lines

    # lines all in one string (no array/ary of lines)
    new_lines_all_in_one = ""
    new_lines.each do |line|
      new_lines_all_in_one << line
    end

    puts "[debug] new_lines_all_in_one:"
    puts new_lines_all_in_one
    
    ## allow custom filter (lets you add custom headers,checksums,etc.)
    new_lines_all_in_one = filter_callback( new_lines_all_in_one )

    ## last step - calculate checksum
    new_lines_all_in_one = generate_checksum( new_lines_all_in_one )
    
    File.open( opts.output, 'w') do |f|
      f.write( new_lines_all_in_one )
    end
    
  end # method generate_manifest


  def encrypt_callback( text )
    if opts.encrypt_callback.nil?    
      puts "[debug] no encrypt callback configured"
      text   # pass through; identity; do nothing
    else
      opts.encrypt_callback.encrypt_callback( text )
    end
  end

  def filter_callback( text )
    if opts.filter_callback.nil?
      puts "[debug] no filter callback configured"     
      text
    else
      opts.filter_callback.filter_callback( text )
    end
  end

  def generate_checksum( text )

    # NB: remove possible old checksum in checksum line w/ empty line before md5 calculation
    hash = Digest::MD5.hexdigest( text.gsub( /^CHECKSUM:.*/, '' ) )
    puts "Paket-Hash >#{hash}<"
    encrypted_hash = encrypt_callback( hash )

    ## use strip why? why not?
    ##  was encrypted_hash.strip
 
    text.gsub( /^CHECKSUM:.*/, "CHECKSUM: #{encrypted_hash}" )
  end

  def calc_digest_md5( fn )
    # digest/hash is a string of 20 hexadecimal 8-bit numbers
    # example:
    #   5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8
  
    ## NB: use b - binary
    #  required for Windows-only (avoids changing of newlines \n to \n\r or similar)
  
    md5 = Digest::MD5.hexdigest( File.open( fn, 'rb') { |f| f.read } )
    md5
  end



end # class Worker
end # module Manman