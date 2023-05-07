#####
#  to run use:
#    $   ruby ./sketch.rb


## get latest version; wait for Image#invert getting added upstream
$LOAD_PATH.unshift( '../../../pixelart/pixelart/pixelart/lib' )


require 'punks'


####
#  read in ordinals metadata
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





composite     = ImageComposite.new( 10, 10,  width:  49,
                                             height: 49 )

ids = (0..99)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes ).sketch( 1 )
  punk.save( "./tmp/sketch-#{id+1}.png" )
  punk.zoom(4).save( "./tmp/sketch-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/sketches.png" )
composite.zoom(4).save( "./tmp/sketches@4x.png" )


##
#  invert  - that is, black (0x000000) to white (0xffffff)
#                      and white to black
composite_inverted = composite.invert
composite_inverted.save( "./tmp/sketches_invert.png" )
composite_inverted.zoom(4).save( "./tmp/sketches_invert@4x.png" )


puts "bye"