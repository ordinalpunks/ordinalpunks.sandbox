require 'pixelart'


img = Image.read( "./tmp/coins.png")   ## 700x400  (4x)  175x100

steps_x = Image.calc_sample_steps( 700, 175 )
steps_y = Image.calc_sample_steps( 400, 100 )

pix = img.pixelate( steps_x, steps_y )

pix.save( "./tmp/pixcoins.png" )
pix.zoom(4).save( "./tmp/pixcoins@4x.png" )




img = Image.read( "./tmp/pokerchip.png")   ## 224x224 =>  33x33

steps = Image.calc_sample_steps( 224, 33 )

pix = img.pixelate( steps )

pix.save( "./tmp/pixchip.png" )
pix.zoom(4).save( "./tmp/pixchip@4x.png" )


puts "bye"