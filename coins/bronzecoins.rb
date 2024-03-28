#####
#  to run use:
#    $   ruby ./bronzecoins.rb


$LOAD_PATH.unshift( '../../../learnpixelart/pixelart/pixelart/lib' )
require 'punks'



# note: use dark to light
COIN_PALETTE = Gradient.new( '#7C433A',
                             '#8D5144',
                             '#B16C57',
                             '#C87E63',
                             '#E99775' ).colors( 256 )


img = ImagePalette8bit.new( COIN_PALETTE, size: 4 )
img.save( "./tmp/palette_bronze.png" )
img.zoom(2).save( "tmp/palette_bronzex2.png" )


COIN_FRAME         = Image.read( "./bronzecoin-32x32.png" )
COIN_FRAME_FRONT   = Image.read( "./bronzecoin-32x32-front.png" )
COIN_FRAME_BACK    = Image.read( "./bronzecoin-32x32-back.png" )


def mint( punk, id: )
  ## change to coin color palette
  coin = Image.new( 32, 32 )

  base = punk.change_palette8bit( COIN_PALETTE )
  base.zoom(8).save( "./ordzaar/tmp/base#{id+1}@8x.png" )

  coin = Image.new( 32, 32 )
  # coin.compose!( COIN_FRAME )
  coin.compose!( COIN_FRAME_BACK )
  coin.compose!( base, 5, 3 )
  coin.compose!( COIN_FRAME_FRONT )
  coin
end



##
# add logo

punk = Punk::Image.generate( 'ape gold', 'laser eyes' )
coin = mint( punk, id: 0 )
coin.save( "./ordzaar/tmp/profile.png" )




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




composite = ImageComposite.new( 10, 10, width:  32,
                                        height: 32 )


banner = ImageComposite.new( 20, 5,  width:  32,
                                     height: 32, background: '#000000' )



ids = (0..99)
ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes )

  coin = mint( punk, id: id )

  num = '%02d' % id
  coin.save( "./ordzaar/penny#{num}.png" )
  coin.zoom(8).save( "./ordzaar/@8x/penny#{num}@8x.png" )

  composite << coin
  banner    << coin
end


composite.save( "./ordzaar/pennies.png" )
composite.zoom(2).save( "./ordzaar/pennies@2x.png" )
composite.zoom(4).save( "./ordzaar/pennies@4x.png" )

banner.save( "./ordzaar/tmp/banner.png" )
banner.zoom(2).save( "./ordzaar/tmp/banner@2x.png" )
banner.zoom(3).save( "./ordzaar/tmp/banner@3x.png" )
banner.zoom(4).save( "./ordzaar/tmp/banner@4x.png" )



puts "bye"
