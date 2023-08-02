require 'pixelart'


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

=begin
## export to blue
composite = ImageComposite.read( './tmp/spritesheet.png', width: 24,
                                                          height: 24 )


names.each_with_index do |name,i|
   base = composite[i]
   base.save( "./more/female#{name}_deeppink-blue.png" )
   base.zoom(4).save( "./tmp/female#{name}_deeppink-blue@4x.png" )
end
=end


#################
## add samples with blonde hair

hair_names = [
'straighthairblonde',
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



composite = ImageComposite.new( 10, hair_names.size, width: 24,
                                                     height: 24 )



hair_names.each do |hair_name|
  hair = Image.read( "./more/#{hair_name}.png" )
  names.each do |name|
     base = Image.read( "./more/#{name}female_deeppink-blue.png" )
     base.compose!( hair )
     composite << base
  end
end

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
