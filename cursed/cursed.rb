#####
#  to run use:
#    $   ruby ./cursed.rb


require_relative '../utils/punks'


####
#  read in ordinals metadata
#    note: use ordinal punks v2 (the improved formula)
ordpunks = Punk::Collection.read( '../ordinalpunks_v2.csv' )
puts "    #{ordpunks.size} record(s)"



composite          = ImageComposite.new( 10, 10 )
composite_invert   = ImageComposite.new( 10, 10 )


ordpunks.each_meta do |attributes, id|
  punk =  ordpunks.generate( *attributes )

  frame = Image.new( 24, 24, '#333333')
  frame.compose!( punk.grayscale )

  frame.save( "./tmp/cursed-#{id+1}.png" )
  frame.zoom(4).save( "./tmp/cursed-#{id+1}@4x.png" )

  composite << frame


  frame = Image.new( 24, 24, '#333333')
  frame.compose!( punk.grayscale.invert )

  frame.save( "./tmp/cursed_invert-#{id+1}.png" )
  frame.zoom(4).save( "./tmp/cursed_invert-#{id+1}@4x.png" )

  composite_invert << frame
end


composite.save( "./tmp/cursed.png" )
composite.zoom(4).save( "./tmp/cursed@4x.png" )


composite_invert.save( "./tmp/cursed_invert.png" )
composite_invert.zoom(4).save( "./tmp/cursed_invert@4x.png" )


puts "bye"
