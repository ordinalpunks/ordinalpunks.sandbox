#####
#  to run use:
#    $   ruby ./sepia.rb


require_relative '../utils/punks'



frame_inner = Image.read( "./frame-24x24.png" ) ## frame in 30x29

## add 2x2 padding - why? why not?
frame = Image.new( 30+4, 29+4 )
frame.compose!( frame_inner, 2, 2 )


frame.zoom( 4 ).save( "./tmp/frame@4x.png" )



####
#  read in ordinals metadata
#    note: use ordinal punks v2 (the improved formula)
ordpunks = Punk::Collection.read( '../ordinalpunks_v2.csv' )
puts "    #{ordpunks.size} record(s)"


composite = ImageComposite.new( 10, 10, width: 30+4,
                                        height: 29+4 )


ordpunks.each_meta do |attributes, id|
  punk =  ordpunks.generate( *attributes )

  img = Image.new( frame.width, frame.height )
  img.compose!( frame )
  img.compose!( punk.change_palette8bit( Palette8bit::SEPIA ), 3+2, 3+2 )

  img.save( "./tmp/sepia-#{id+1}.png" )
  img.zoom(4).save( "./tmp/sepia-#{id+1}@4x.png" )

  composite << img
end


composite.save( "./tmp/sepias.png" )
composite.zoom(4).save( "./tmp/sepias@4x.png" )

puts "bye"
