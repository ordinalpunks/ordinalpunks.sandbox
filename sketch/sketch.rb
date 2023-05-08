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



###
#   line: 1px, spacing: 1px  - 49x49px

composite     = ImageComposite.new( 10, 10,  width:  25*1+24*1,
                                             height: 25*1+24*1 )

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
composite_inverted.save( "./tmp/sketches-invert.png" )
composite_inverted.zoom(4).save( "./tmp/sketches-invert@4x.png" )

composite_inverted = composite_inverted.change_colors( {'#000000' => 'F2A900'} )
composite_inverted.save( "./tmp/sketches-invert_orange.png" )
composite_inverted.zoom(4).save( "./tmp/sketches-invert_orange@4x.png" )



###
#   line: 1px, spacing: 4px   - 121x121px

composite     = ImageComposite.new( 10, 10,  width:  24*4+25*1,
                                             height: 24*4+25*1 )

ids = (0..99)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes ).sketch( 4, line: 1 )
  punk.save( "./tmp2/sketch-#{id+1}.png" )

  composite << punk
end


composite.save( "./tmp/sketches-ii.png" )

##
#  invert  - that is, black (0x000000) to white (0xffffff)
#                      and white to black
composite_inverted = composite.invert
composite_inverted.save( "./tmp/sketches-ii-invert.png" )

composite_inverted = composite_inverted.change_colors( {'#000000' => 'F2A900'} )
composite_inverted.save( "./tmp/sketches-ii-invert_orange.png" )

puts "bye"
