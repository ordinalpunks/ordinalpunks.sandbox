module Manman

class Opts

  # extra headers for manifest
  #  - headers get ignored (assumed NOT to be files that get md5 checksum/digest/hash calculated)
  def headers=(value)
    # NB: value is supposed to be an array of strings
    @headers = value
  end

  ## fix/todo:
  ##  also make it into a command line option!!
  
  def headers
    # NB: return value is supposed to be an array of strings
    @headers || []
  end
    
  
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
 

end # class Opts

end # module Manman