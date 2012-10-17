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

      cmd.on( '-c', '--config PATH', "Configuration Path (default is #{opts.config_path})" ) do |path|
        opts.config_path = path
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

manman - Manifest Manager

#{cmd.help}

Examples:
    manman                          # to be done
  
EOS
        exit
      end
    end

    opt.parse!( args )
  
    puts Manman.banner

    
    puts 'Done.'
    
  end   # method run


end # class Runner
end # module Manman