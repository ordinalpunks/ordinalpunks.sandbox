#####
#  to run use:
#    $   ruby ./sketch.rb




require_relative '../utils/punks'




####
#  read in ordinals metadata
#    note: use ordinal punks v2 (the improved formula)
ordpunks = Punk::Collection.read( '../ordinalpunks_v2.csv' )
puts "    #{ordpunks.size} record(s)"




###
#   line: 1px, spacing: 1px  - 49x49px

composite     = ImageComposite.new( 10, 10,  width:  25*1+24*1,
                                             height: 25*1+24*1 )

composite_color = ImageComposite.new( 10, 10,  width:  25*1+24*1,
                                               height: 25*1+24*1 )


ordpunks.each do |punk, id|
  sketch = punk.sketch( 1 )

  sketch.save( "./tmp/sketch-#{id+1}.png" )
  sketch.zoom(4).save( "./tmp/sketch-#{id+1}@4x.png" )

  composite << sketch

  ## try "blocky-style"  - line color is transparent
  blockie = punk.sketch( 1, line: 1, line_color: 0x0, colorize: true )

  blockie.save( "./tmp/blockie-#{id+1}.png" )
  blockie.zoom(4).save( "./tmp/blockie-#{id+1}@4x.png" )

  ## try with color - change black to anthrazit
  punk = punk.change_colors( { 0xff => 0x242124ff } )
  sketch = punk.sketch( 1, colorize: true )

  sketch.save( "./tmp/sketch_color-#{id+1}.png" )
  sketch.zoom(4).save( "./tmp/sketch_color-#{id+1}@4x.png" )

  composite_color << sketch
end


composite.save( "./tmp/sketches.png" )
composite.zoom(4).save( "./tmp/sketches@4x.png" )

composite_color.save( "./tmp/sketches_color.png" )
composite_color.zoom(4).save( "./tmp/sketches_color@4x.png" )


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

composite_color   = ImageComposite.new( 10, 10,  width:  24*4+25*1,
                                                 height: 24*4+25*1 )


ordpunks.each do |punk, id|
  sketch = punk.sketch( 4, line: 1 )

  sketch.save( "./tmp2/sketch-#{id+1}.png" )

  composite << sketch

  ## try "blocky-style"  - line color is transparent
  blockie = punk.sketch( 4, line: 2, line_color: 0x0, colorize: true )

  blockie.save( "./tmp2/blockie-#{id+1}.png" )
  blockie.zoom(4).save( "./tmp2/blockie-#{id+1}@4x.png" )

  ## try with color
  punk = punk.change_colors( { 0xff => 0x242124ff } )
  sketch = punk.sketch( 4, line: 1, colorize: true )

  sketch.save( "./tmp2/sketch_color-#{id+1}.png" )
  sketch.zoom(4).save( "./tmp2/sketch_color-#{id+1}@4x.png" )

  composite_color << sketch
end


composite.save( "./tmp/sketches-ii.png" )
composite_color.save( "./tmp/sketches_color-ii.png" )


##
#  invert  - that is, black (0x000000) to white (0xffffff)
#                      and white to black
composite_inverted = composite.invert
composite_inverted.save( "./tmp/sketches-ii-invert.png" )

composite_inverted = composite_inverted.change_colors( {'#000000' => 'F2A900'} )
composite_inverted.save( "./tmp/sketches-ii-invert_orange.png" )

puts "bye"
