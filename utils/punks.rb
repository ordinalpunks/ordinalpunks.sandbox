
## note: get latest (unpublished) version of pixelart gem
##   - wait for Image#invert getting added upstream ;-)
$LOAD_PATH.unshift( '../../../pixelart/pixelart/pixelart/lib' )


require 'punks'


module Punk
class Collection
  def self.read( path )
     recs = read_csv( path )
     new( recs )
  end

  def initialize( recs )
    @recs = recs
  end

  def size
    @recs.size
  end
  alias_method :count, :size

  ## change/renamte to each_attributes or such - why? why not?
  def each_meta( &blk )
    @recs.each_with_index do |rec,i|
      attributes = _rec_to_attributes( rec )
      pp attributes
      blk.call( attributes, i )   ## note: add optional index (by default) - why? why not?
    end
  end

  def each_image( &blk )
    each_meta do |attributes, i|
      punk = Punk::Image.generate( *attributes )
      blk.call( punk, i )  ## note: add optional index (by default) - why? why not?
    end
  end
  alias_method :each, :each_image


  def []( i )
    attributes = _rec_to_attributes( @recs[i] )
    Punk::Image.generate( *attributes )
  end


  def generate( *attributes )
    Punk::Image.generate( *attributes )
  end


  def _rec_to_attributes( rec )
    type =     rec['type']
    gender =   rec['gender']
    skin_tone = rec['skin_tone']

    # note: merge type+gender+skin_tone into one attribute
    base = "#{type} #{gender}"
    base << " #{skin_tone}"       unless skin_tone.empty?

    accessories = rec['accessories'].split( '/' ).map { |acc| acc.strip }
    attributes = [base] + accessories
    attributes
  end


end  # class Collection
end  # module Punk

