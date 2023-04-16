#####
#  to run use:
#    $   ruby ./bluechip.rb



require 'punks'




CHIP_FRAME   = Image.read( "./bluechip-33x33.png" )
puts "   #{CHIP_FRAME.width}x#{CHIP_FRAME.height}"


def mint( punk )
  ## change to coin color palette
  chip = Image.new( 33, 33 )
  chip.compose!( Image.new( 24, 24, '#ffffff'), 6, 3 )
  chip.compose!( punk.grayscale, 6, 3 )
  chip.compose!( CHIP_FRAME )
  chip
end






####
#  read in ordinals metadata
recs = read_csv( "../../ordinalpunks.starter/ordinalpunks.csv" )
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







composite = ImageComposite.new( 3, 4, width:  33+4,
                                      height: 33+4 )


ids = (0..11)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes )

  chip = mint( punk )

  tile = Image.new( 33+4, 33+4 )
  tile.compose!( chip, 2, 2 )  ## add 2/2 padding
  composite << tile
end


composite.save( "./tmp/bluechips.png" )
composite.zoom(4).save( "./tmp/bluechips@4x.png" )


puts "bye"
