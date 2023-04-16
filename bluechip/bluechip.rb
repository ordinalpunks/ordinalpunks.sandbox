#####
#  to run use:
#    $   ruby ./bluechip.rb



require 'punks'


def gen_palette( color )
  ## from black to color
  h,s,l = Color.to_hsl( color )

  pp h
  pp s
  pp l

  darker = 0.35    ## cut-off colors starting from black
  lighter = 0.0   ## cut-off colors starting from white

  ldiff = (1.0 - darker - lighter)

  puts "  ldiff: #{ldiff}"

  colors = []
  256.times do |i|
     lnew = darker+(ldiff*i / 256.0)
     puts "  #{i} - #{lnew}"
     colors << Color.from_hsl( h, s, lnew)
  end

  colors
end



CHIP_BASE    =   Color.from_hex( '#371BA8' )
CHIP_PALETTE =   gen_palette(  CHIP_BASE )

img = ImagePalette8bit.new( CHIP_PALETTE, size: 4 )
img.save( "./tmp/palette_chip.png" )
img.zoom(2).save( "tmp/palette_chipx2.png" )



CHIP_FRAME   = Image.read( "./bluechip-33x33.png" )
puts "   #{CHIP_FRAME.width}x#{CHIP_FRAME.height}"


def old_mint( punk )
  ## change to coin color palette
  chip = Image.new( 33, 33 )
  chip.compose!( Image.new( 24, 24, '#ffffff'), 6, 3 )
  chip.compose!( punk.grayscale, 6, 3 )
  chip.compose!( CHIP_FRAME )
  chip
end

def mint( punk )
  ## change to coin color palette
  chip = Image.new( 33, 33 )
  chip.compose!( Image.new( 22, 22, CHIP_BASE ), 6, 6 )
  chip.compose!( punk.change_palette8bit( CHIP_PALETTE.reverse ), 6, 3 )
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
