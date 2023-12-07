#####
#  to run use:
#    $   ruby ./shrooms.rb


require_relative '../utils/punks'



shroom = Image.read( './shroom24x30.png' )


####
#  read in ordinals metadata
#    note: use ordinal punks v2 (the improved formula)
ordpunks = Punk::Collection.read( '../ordinalpunks_v2.csv' )
puts "    #{ordpunks.size} record(s)"


YELLOW = '#ffff00'
RED    = '#ff0000'
GREEN  = '#00ff00'
BLUE   = '#0000ff'

composite = ImageComposite.new( 10, 10, width: 24,
                                        height: 30, 
                                background: [YELLOW, RED, GREEN, BLUE] )


ordpunks.each_meta do |attributes, id|
  punk =  ordpunks.generate( *attributes )

  frame = Image.new( 24, 30 )
  frame.compose!( shroom )
  frame.compose!( punk )

  frame.save( "./tmp/shroom-#{id+1}.png" )
  frame.zoom(4).save( "./tmp/shroom-#{id+1}@4x.png" )

  composite << frame
end


composite.save( "./tmp/shroompunks.png" )
composite.zoom(4).save( "./tmp/shroompunks@4x.png" )

puts "bye"
