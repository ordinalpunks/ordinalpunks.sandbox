module Manman

class Opts

  def base=(value)
    @base = value
  end
  
  def base
    @base || './paket'
  end


  def template=(value)
    @template = value
  end
  
  def template
    @template || 'paket.txt.erb'
  end
  
  
  def output=(value)
    @output = value
  end
    
  def output
    @output || 'paket.txt'
  end
  

  def release=(value)
    @release = value
  end
  
  def release
    @release    # NB: has no default; required arg
  end

  
  def env=(value)
    @env = value
  end
  
  def env
    @env       # NB: has no default; required arg
  end

  
  def valid=(value)
    @valid = value
  end
  
  def valid
    @valid     # NB: has no default; required arg
  end
      
 
  def config_path=(value)
    @config_path = value
  end
  
  def config_path
    @config_path || '~/.manman'
  end

end # class Opts

end # module Manman