require 'pixelart'
require 'punks'

names = [
   '', ## human
   'vampire-',
   'demon-',
   'zombie-',
   'ape-',
   'orc-',
   'alien-',
   'robot-',
   'mummy-',
   'skeleton-',
]


composite = ImageComposite.new( 10, 8, width: 24,
                                       height: 24 )


['deeppink', 'deeppink-blue'].each do |style|                                       
  names.each_with_index do |name,i|
      path = if style == 'deeppink-blue' && i == 7
               "./more/bitmap-female_deeppink.png"
             elsif style == 'deeppink-blue' && i == 8
               "./more/demon_horn-female_deeppink.png"
             elsif style == 'deeppink-blue' && i == 9
               "./more/hoodie-female_deepink.png"             
             else               
                "./more/#{name}female_#{style}.png"
             end
     composite << Image.read( path )
  end
end


hair_names = ['straighthairblonde',
'bob',
'blondeside',
'blondeside2',
'straighthairblonde2',
'wildblonde',
'wildblonde2',
'longcurly',
'blondehair2',
'clownhairblonde',
'heart',
'pigtails',
'pigtails2',
'halfshaved2',
'vampirehair',
'blondeshort2',
'blondeshort',
'buzzcut',
'spiky',
'mohawk']



hair_names.each do |hair_name|
  hair = Image.read( "./more/#{hair_name}.png" )
  composite << hair
end

### add thirty more "classics"

more_names = [
 'Mole',
 'Spots',
 'Rosy Cheeks',
 'Clown Nose',
 
 'Pilot Helmet',
 'Tassle Hat',
 'Tiara',
 'Cap',
 'Bandana',
 'Knitted Cap',
 'sombrero',
 'panama hat',
 'beret',
 'birthday hat',
 'top hat',
 'cowboy hat',
 'bow',
 'flowers',
 'cap m red',
 'cap m white',

  'Choker',
  'Silver Chain',
  'Gold Chain',
  'Earring',
  
  '3D Glasses',
  'VR',
  'Big Shades',
  'Classic Shades',
  'Regular Shades',
  'Nerd Glasses',
  'Horned Rim Glasses',
  'Eye Patch',
  'Eye Mask',
  'heart shades',
  'laser eyes',
  'laser eyes gold',

  'Pipe',
  'Cigarette',
  'Medical Mask',
  'bubble gum'
]


more_names.each do |name|
   img = Punk::Spritesheet.find_by( name: name.downcase.gsub( ' ', '' ), 
                                        gender: 'f',
                                        size: 's' )
   composite << img
end


composite.save( "./tmp/spritesheet.png" )
composite.zoom(4).save( "./tmp/spritesheet@4x.png" )

__END__

composite.save( "./tmp/blondes.png" )
composite.zoom(4).save( "./tmp/blondes@4x.png" )


composite = ImageComposite.new( 10, hair_names.size, width: 24,
                                                     height: 24 )


hair_names.each do |hair_name|
  hair = Image.read( "./more/#{hair_name}.png" )
  hair = hair.change_colors( { '#fff68e' => '#faf0be' } )
  names.each do |name|
     base = Image.read( "./more/#{name}female_deeppink-blue.png" )
     base.compose!( hair )
     composite << base
  end
end

composite.save( "./tmp/blondes2.png" )
composite.zoom(4).save( "./tmp/blondes2@4x.png" )


['', ## human
'demon-',
'zombie-',
'ape-',
'alien-',
'orc-',
'robot-',
'mummy-',
'skeleton-',
].each do |name|
   composite = ImageComposite.new( hair_names.size/4, 4, width: 24,
                                     height: 24 )
   base = Image.read( "./more/#{name}female_deeppink-blue.png" )
  
   hair_names.each do |hair_name|
      hair = Image.read( "./more/#{hair_name}.png" )
      img = Image.new( 24, 24 )
      img.compose!( base )
      img.compose!( hair )
      composite << img
   end
   composite.save( "./tmp/blondes_#{name}.png" )
   composite.zoom(4).save( "./tmp/blondes_#{name}@4x.png" )   
end
 


puts "  #{hair_names.size} hair name(s)"

puts "bye"
