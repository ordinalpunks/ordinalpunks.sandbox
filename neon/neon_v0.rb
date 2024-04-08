#####
#  to run use:
#    $   ruby ./neon_v0.rb


require 'punks'



module Pixelart

class Image

  ## neon glow special effect
  def neon( color='00ffaa' )
    ## note: must convert to black & white sketch
    sketch = sketch( 1 )

    inverse1 = sketch.change_colors( {
              'ffffff' => 0,  ## white to transparent
              '000000' => 'ffffff',  ## black to white
            })

    inverse2 = sketch.change_colors( {
               'ffffff' => 0,  ## white to transparent
               '000000' => color,  ## black to green
             })

####
# inspired by
#   https://css-tricks.com/how-to-create-neon-text-with-css/
#
# .neonText {
#    color: #fff;
#    text-shadow:
#      // white glow
#       0 0 7px #fff,
#       0 0 10px #fff,
#       0 0 21px #fff,
#      // green glow
#       0 0 42px #0fa,
#       0 0 82px #0fa,
#       0 0 92px #0fa,
#       0 0 102px #0fa,
#       0 0 151px #0fa;

    base = Image.new( sketch.width, sketch.height, Color::BLACK )
    base.compose!( inverse2.blur( 21 ) )  # -blur 21x21
    base.compose!( inverse2.blur( 10 ) )  # -blur 10x10
    base.compose!( inverse2.blur( 7 ) )   # -blur 7x7

    base.compose!( inverse1.blur( 2 ) )   # -blur 2x2
    base.compose!( inverse1 )
    base
  end
end # class Image
end # module Pixelart






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






colors = {
  'neon'        => 'f7931a',   ## bitcoin orange
  'neon-green'  => '00ff00',
  'neon-blue'   => '0000ff',
  'neon-red'    => 'ff0000',
}


colors.each do |name, color|
  composite     = ImageComposite.new( 10, 10,  width:  49,
                                               height: 49 )

  ids = (0..99)
  ids.each do |id|
    attributes = rec_to_attributes( recs[id] )
    pp attributes

    punk = Punk::Image.generate( *attributes ).neon( color )
    punk.save( "./tmp/#{name}-#{id+1}.png" )
    punk.zoom(4).save( "./tmp/#{name}-#{id+1}@4x.png" )

    composite << punk
  end

  composite.save( "./tmp/#{name}.png" )
  composite.zoom(4).save( "./tmp/#{name}@4x.png" )
end


puts "bye"
