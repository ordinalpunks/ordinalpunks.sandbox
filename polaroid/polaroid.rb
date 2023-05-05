#####
#  to run use:
#    $   ruby ./polaroid.rb



require 'punks'


POLAROID_FRAME   = Image.read( "./polaroid24x24.png" )
puts "   #{POLAROID_FRAME.width}x#{POLAROID_FRAME.height}"


def polaroid( punk )
  polaroid = Image.new( POLAROID_FRAME.width, POLAROID_FRAME.height )
  polaroid.compose!( POLAROID_FRAME )
  polaroid.compose!( Image.new( 24,24, '#52BBFE' ), 2, 2 )  ## add non-trasparent / opaque background first
  polaroid.compose!( punk, 2, 2 )
  polaroid
end






####
#  read in ordinals metadata
#    note: use ordinal punks v2 (the improved formula)
recs = read_csv( "../ordinalpunks_v2.csv" )
puts "    #{recs.size} record(s)"


def rec_to_attributes( rec )
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





###
#  generate (preview strips)

composite = ImageComposite.new( 3, 4, width:  POLAROID_FRAME.width+4,
                                      height: POLAROID_FRAME.height+4,
                                      background: '#ffffff' )


ids = (0..11)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes )

  photo = polaroid( punk )

  tile = Image.new( POLAROID_FRAME.width+4, POLAROID_FRAME.height+4 )
  tile.compose!( photo, 2, 2 )  ## add 2/2 padding
  composite << tile
end


composite.save( "./tmp/polaroids-strip.png" )
composite.zoom(4).save( "./tmp/polaroids-strip@4x.png" )



composite = ImageComposite.new( 10, 10, width:  POLAROID_FRAME.width,
                                        height: POLAROID_FRAME.height )

###
#  note: ids are off-by-one (starting at zero NOT one), sorry!

# ids = [29, 45, 54, 65, 69, 77, 92, 94]
ids = (0..99)
ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes )

  ## change to greenback color palette
  photo = polaroid( punk )

  photo.save( "./tmp/polaroid-#{id+1}.png" )
  photo.zoom(4).save( "./tmp/polaroid-#{id+1}@4x.png" )

  composite << photo
end


composite.save( "./tmp/polaroids.png" )


puts "bye"
