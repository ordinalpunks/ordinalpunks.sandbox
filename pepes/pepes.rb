#####
#  to run use:
#    $   ruby ./pepes.rb


require_relative '../utils/punks'


pepe = Image.read( './pepe-24x24.png')


pepe.zoom(4).save( './tmp/pepe@4x.png')
pepe.zoom(8).save( './tmp/pepe@8x.png')


PATCH = {
  'pepe' => Image.read( './pepe_face-24x24.png'),
  'eyes' => Image.read( './pepe_eyes-24x24.png'),
  'mouth' => Image.read( './pepe_mouth-24x24.png'),
  'mouthsmile' => Image.read( './pepe_mouth-smile-24x24.png'),
  'mouthfrown' => Image.read( './pepe_mouth-smile-24x24.png'),
  'mouthwhite' => Image.read( './pepe_mouth-white-24x24.png'),
}



specs = parse_data( <<TXT )
Eyes, Big Beard, Mouth (White)
Eyes, Mouth, Birthday Hat, Bubble Gum
# Flowers / Frown / Gold Chain
Eyes, Mouth, Hoodie, Pipe
Eyes, Mouth, Cowboy Hat, Buck Teeth
Mouth, Cowboy Hat, Laser Eyes
Eyes, Mouth, Cap Burger King
Eyes, Mouth, Demon Horns
Eyes, Mouth, Crown
## add back Choker, Wild White Hair
Mole, Crazy Hair, Big Shades, Mouth Frown, Cigarette
Big Beard, Mouth (White), Mole, 3D Glasses, Earring
Mouth, Beanie, VR, Clown Nose

Eyes, Mouth, Top Hat, Silver Chain
Eyes, Mouth, Clown Hair Blue
## add back Tiara
Eyes, Rosy Cheeks, Mouth Smile
Eyes, Mouth, Medical Mask, Clown Nose, Hoodie
Eyes, Mouth (White), Sombrero, Mustache
Eyes, Mouth, Spots, Do-Rag, Bubble Gum
## Eyes, Mouth, Beanie
Mouth, Crazy Hair, Regular Shades, Cigar
Eyes, Mouth, Hoodie, Gold Chain, Cigarette
Eyes, Mouth, Jester Hat


Eyes, Mouth, Bandana, Cigarette

Eyes, Eye Mask, Spots, Mouth (White), Goat, Gold Chain, Earring
Eyes, Clown Nose, Medical Mask, Cigarette


## extras
Eyes, Mouth (Smile), Jester Hat
TXT

pp specs
puts "  #{specs.size} record(s)"



composite = ImageComposite.new( 4, 5 )

specs.each_with_index do |more_attributes,i|
   punk = Punk::Image.generate( 'pepe', *more_attributes, patch: PATCH )
   punk.save( "./tmp/pepe-#{i}.png" )
   punk.zoom(4).save( "./tmp/pepe-#{i}@4x.png" )

   composite << punk     if i < 20
end


composite.save( "./tmp/pepes.png" )
composite.zoom(4).save( "./tmp/pepes@4x.png" )



puts "bye"