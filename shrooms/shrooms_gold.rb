#####
#  to run use:
#    $   ruby ./shrooms_gold.rb


require 'pixelart'


shroom_gold = Image.read( './shroom24x30-gold.png' )

punks = ImageComposite.read( "../gold/i/golden.png" )



composite = ImageComposite.new( 10, 10, width: 24,
                                        height: 30 )

punks.each_with_index do |punk, id|                                        

  frame = Image.new( 24, 30,  '#F2A900' )
  frame.compose!( shroom_gold )
  frame.compose!( punk )

  frame.save( "./tmp/goldenshroom-#{id+1}.png" )
  frame.zoom(4).save( "./tmp/goldenshroom-#{id+1}@4x.png" )

  composite << frame
end


composite.save( "./tmp/goldenshroompunks.png" )
composite.zoom(4).save( "./tmp/goldenshroompunks@4x.png" )


puts "bye"

