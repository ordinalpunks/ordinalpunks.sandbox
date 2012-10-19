module Manman

class Runner

  def initialize
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::INFO

    @opts    = Opts.new
  end

  attr_reader :logger, :opts

  def run( args )
    opt=OptionParser.new do |cmd|
    
      cmd.banner = "Usage: manman [options]"

      cmd.on( '-r', '--release RELEASE', 'Release Version (e.g. 2013.08)' ) do |release|
        opts.release = release
      end
    
      cmd.on( '-e', '--env ENV', 'Environment (e.g. TEST)' ) do |env|
        opts.env = env
      end
      
      cmd.on( '-u', '--valid_until VALID', 'Valid until (e.g. 2014.01.31)' ) do |valid|
        opts.valid = valid
      end

      cmd.on( '-d', '--dir PATH', "Path to Packages (default is #{opts.base})" ) do |path|
        opts.base = path
      end

      
      cmd.on( '-t', '--template FILE', "Input Template (default is #{opts.template})" ) do |file|
        opts.template = file
      end
      
      cmd.on( '-o', '--out FILE', "Output File (default is #{opts.output})" ) do |file|
        opts.output = file
      end
      
      
      cmd.on( '-v', '--version', "Show version" ) do
        puts Manman.banner
        exit
      end

      cmd.on( "--verbose", "Show debug trace" )  do
        logger.datetime_format = "%H:%H:%S"
        logger.level = Logger::DEBUG
      end

      cmd.on_tail( "-h", "--help", "Show this message" ) do
        puts <<EOS

manman - Manifest Manager, Version #{VERSION}

#{cmd.help}

Examples:
    manman -r 2013.08 -e TEST -u 2014.12.31
  
EOS
        exit
      end
    end

    opt.parse!( args )
  
    puts Manman.banner

    
    # check for required args
    
    puts "*** Missing Argument: -r/--release Release Argument Required"   if opts.release.nil?
    puts "*** Missing Argument: -e/--env Argument Required"               if opts.env.nil?
     
    if opts.release.nil? || opts.env.nil?
      puts
      puts "Use -h/--help for usage options."
      return    ## exit ??
    end

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
     
      headers_release = [ 'RELEASE', 'VERSION' ]
      headers_env     = [ 'ENV', 'UMGEBUNG' ]
      headers_valid   = [ 'VALID_UNTIL', 'GUELTIG_BIS' ]
     
      headers = headers_release + headers_env + headers_valid
      headers += opts.headers   # add possible user defined extra headers
     
      if headers.include?( key )
        if headers_release.include?( key )
          new_lines << "#{key}: #{opts.release}\n"
        elsif headers_env.include?( key )
          new_lines << "#{key}: #{opts.env}\n"
        elsif headers_valid.include?( key )
          new_lines << "#{key}: #{opts.valid}\n"
        else    # assume extra headers
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

    File.open( opts.output, 'w') do |f|
      new_lines.each do |line|
        f.write( line )
      end
    end
    
  end # method generate_manifest


  def calc_digest_md5( fn )
    # digest/hash is a string of 20 hexadecimal 8-bit numbers
    # example:
    #   5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8
  
    md5 = Digest::MD5.hexdigest( File.open( fn, 'rb') { |f| f.read } )
    md5
  end



end # class Runner
end # module Manman