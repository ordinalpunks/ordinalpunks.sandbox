#################################
# to run use:
#
#  $ ruby sandbox/coins.rb

$LOAD_PATH.unshift( "./lib" )
require 'punkart'


img = ImagePalette8bit.new( Goldcoin::COIN_PALETTE, size: 4 )
img.save( "./tmp/palette_goldcoin.png" )
img.zoom(2).save( "tmp/palette_goldcoinx2.png" )



##
# generate gold/silver/bronze coin punks

specs = [
  ['Robot Male', 'Big Beard'],
  ['Human Male 2', 'Birthday Hat', 'Bubble Gum'],
  ['Human Female 1', 'Dark Hair', 'Flowers', 'Frown', 'Gold Chain'],
  ['Demon Male',     'Hoodie', 'Pipe'],
  ['Ape Male Blue',  'Bandana', 'Earring'],
  ['Human Male 3',  'Cowboy Hat', 'Smile', 'Laser Eyes'],
]

specs.each_with_index do |attributes, i|
   punk = Punk::Image.generate( *attributes )

   coin = punk.goldcoin  ## turn into goldcoin
   coin.save( "./tmp/goldcoin-#{i+1}.png" )
   coin.zoom(4).save( "./tmp/goldcoin-#{i+1}@4x.png" )
end


puts "bye"