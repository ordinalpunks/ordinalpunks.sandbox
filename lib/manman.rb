
require 'yaml'
require 'pp'
require 'logger'
require 'optparse'
require 'fileutils'
require 'date'
require 'digest/md5'



# rubygems

#### nothing here for now

# our own code

require 'manman/version'
require 'manman/opts'
require 'manman/runner'
require 'manman/worker'

module Manman

  def self.banner
    "manman #{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.main
    Runner.new.run(ARGV)
  end

end  # module Manman


Manman.main if __FILE__ == $0