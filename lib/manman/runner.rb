module Manman

class Runner

  def initialize( logger=nil )
    if logger.nil?
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
    else
      @logger = logger
    end

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

    # puts "Using settings:"
    # pp opts
    
    worker = Worker.new( logger, opts )
    worker.run
        
    # puts 'Done.'
    
  end   # method run

end # class Runner
end # module Manman