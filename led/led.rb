#####
#  to run use:
#    $   ruby ./led.rb


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





## note: 24x4 + 23x1 = 119px

composite     = ImageComposite.new( 10, 10,  width:  24*4+23,
                                             height: 24*4+23 )

ids = (0..99)
ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes )
  punk = punk.change_colors( { 0xff => 0x242124ff } )
  punk = punk.led( 4, spacing: 1 )

  ## note: paste/compose punk into black frame - makes alpha channel (e.g. smoke) render properly
  frame = Image.new( 24*4+23, 24*4+23, Color::BLACK )
  frame.compose!( punk )

  frame.save( "./tmp/led-#{id+1}.png" )
  frame.zoom(4).save( "./tmp/led-#{id+1}@4x.png" )

  composite << frame
end

composite.save( "./tmp/leds.png" )


puts "bye"
