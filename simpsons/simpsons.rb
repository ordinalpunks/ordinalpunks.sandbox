#####
#  to run use:
#    $   ruby ./simpsons.rb


require_relative '../utils/punks'


bart = Image.read( './bart-24x24.png')


bart.zoom(4).save( './tmp/bart@4x.png')
bart.zoom(8).save( './tmp/bart@8x.png')

bart_ii = Image.read( './bart_ii-24x24.png')


bart_ii.zoom(4).save( './tmp/bart_ii@4x.png')
bart_ii.zoom(8).save( './tmp/bart_ii@8x.png')


PATCH = {
  'bart'  => bart,
  'bart2' => bart_ii,
  'eyes'  => Image.read( './bart_eyes-24x24.png' )
}



specs = parse_data( <<TXT )
Bart, Big Beard
Bart 2, Birthday Hat, Bubble Gum
# Flowers / Frown / Gold Chain
Bart 2, Hoodie, Pipe
Bart 2, Cowboy Hat,  Buck Teeth
Bart 2, Cowboy Hat, Laser Eyes
Bart 2, Cap Burger King
Bart, Demon Horns
Bart 2, Crown
## add back Choker, Wild White Hair
Bart 2, Mole, Crazy Hair, Big Shades, Frown, Cigarette
Bart, Big Beard, Mole, 3D Glasses, Earring
Bart 2, Beanie, VR, Clown Nose

Bart, Top Hat, Silver Chain
Bart, Clown Hair Blue, Eyes
## add back Tiara
Bart, Rosy Cheeks, Smile
Bart 2, Medical Mask, Clown Nose, Hoodie
Bart 2, Sombrero, Mustache
Bart 2, Spots, Do-Rag, Bubble Gum
## Eyes, Mouth, Beanie
Bart 2, Crazy Hair, Regular Shades, Cigar
Bart 2, Hoodie,  Gold Chain, Cigarette
Bart 2, Jester Hat


Bart 2, Bandana, Cigarette

Bart, Eye Mask, Spots, Goat, Gold Chain, Earring

### more
Bart, Clown Nose, Medical Mask, Cigarette

TXT

pp specs
puts "  #{specs.size} record(s)"



background_sky = Image.read( './background_sky-24x24.png' )


composite = ImageComposite.new( 4, 5 )

specs.each_with_index do |attributes,i|
   punk = Punk::Image.generate( *attributes, patch: PATCH )

   frame = Image.new( 24, 24 )
   frame.compose!( background_sky )
   frame.compose!( punk )

   frame.save( "./tmp/bart-#{i}.png" )
   frame.zoom(4).save( "./tmp/bart-#{i}@4x.png" )

   composite << frame     if i < 20
end


composite.save( "./tmp/barts.png" )
composite.zoom(4).save( "./tmp/barts@4x.png" )



puts "bye"