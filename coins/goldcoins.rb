#####
#  to run use:
#    $   ruby ./goldcoins.rb


$LOAD_PATH.unshift( '../../../learnpixelart/pixelart/pixelart/lib' )
require 'punks'



# note: use dark to light
COIN_PALETTE = Gradient.new( '#CA7128',
                             '#D9862C',
                             '#F2AF39',
                             '#F6C451',
                             '#FBE272' ).colors( 256 )


img = ImagePalette8bit.new( COIN_PALETTE, size: 4 )
img.save( "./tmp/palette_gold.png" )
img.zoom(2).save( "tmp/palette_goldx2.png" )


COIN_FRAME   = Image.read( "./goldcoin-32x32.png" )
COIN_FRAME_FRONT   = Image.read( "./goldcoin-32x32-front.png" )
COIN_FRAME_BACK    = Image.read( "./goldcoin-32x32-back.png" )



def mint( punk, id:  )
  ## change to coin color palette
  base = punk.change_palette8bit( COIN_PALETTE )
  base.zoom(8).save( "./ordzaar2/tmp/base#{id+1}@8x.png" )

  coin = Image.new( 32, 32 )
  coin.compose!( COIN_FRAME_BACK )
  coin.compose!( base, 5, 3 )
  coin.compose!( COIN_FRAME_FRONT )
  coin
end


##
# add logo
punk = Punk::Image.generate( 'ape gold', 'laser eyes' )
coin = mint( punk, id: 0 )
coin.save( "./ordzaar2/tmp/profile.png" )





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
  coin.save( "./ordzaar2/goldcoin#{num}.png" )
  coin.zoom(8).save( "./ordzaar2/@8x/goldcoin#{num}@8x.png" )

  composite << coin
  banner << coin
end


composite.save( "./ordzaar2/goldcoins.png" )
composite.zoom(2).save( "./ordzaar2/goldcoins@2x.png" )
composite.zoom(4).save( "./ordzaar2/goldcoins@4x.png" )

banner.save( "./ordzaar2/tmp/banner.png" )
banner.zoom(2).save( "./ordzaar2/tmp/banner@2x.png" )
banner.zoom(3).save( "./ordzaar2/tmp/banner@3x.png" )
banner.zoom(4).save( "./ordzaar2/tmp/banner@4x.png" )


puts "bye"
