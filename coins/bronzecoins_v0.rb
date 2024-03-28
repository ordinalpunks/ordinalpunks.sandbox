#####
#  to run use:
#    $   ruby ./bronzecoins_v0.rb


##
# to be done:
#   check for alpha channel e.g. pipe smoke  (gets gray-ish) - why?


require 'punks'




puts "colors:"
puts Color.format( Color.parse(  '#B16C57' ))
#=>

# note: use dark to light
COIN_PALETTE = Gradient.new( '#7C433A',
                             '#8D5144',
                             '#B16C57',
                             '#C87E63',
                             '#E99775' ).colors( 256 )


img = ImagePalette8bit.new( COIN_PALETTE, size: 4 )
img.save( "./tmp/palette_bronze.png" )
img.zoom(2).save( "tmp/palette_bronzex2.png" )


COIN_FRAME   = Image.read( "./bronzecoin-32x32.png" )
puts "   #{COIN_FRAME.width}x#{COIN_FRAME.height}"


def mint( punk )
  ## change to coin color palette
  coin = Image.new( 32, 32 )
  coin.compose!( COIN_FRAME )
  coin.compose!( punk.change_palette8bit( COIN_PALETTE ), 5, 3 )
  coin
end






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
#  generate (preview strips)

composite = ImageComposite.new( 3, 4, width:  32+4,
                                      height: 32+4 )


ids = (0..11)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes )

  coin = mint( punk )

  tile = Image.new( 32+4, 32+4 )
  tile.compose!( coin, 2, 2 )  ## add 2/2 padding
  composite << tile
end


composite.save( "./tmp/bronzecoins-strip.png" )
composite.zoom(4).save( "./tmp/bronzecoins-strip@4x.png" )




composite = ImageComposite.new( 10, 10, width:  32,
                                        height: 32 )

ids = (0..99)
ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes )

  coin = mint( punk )

  coin.save( "./tmp3/bronzecoin-#{id+1}.png" )
  coin.zoom(4).save( "./tmp3/bronzecoin-#{id+1}@4x.png" )

  composite << coin
end


composite.save( "./tmp/bronzecoins.png" )

puts "bye"
