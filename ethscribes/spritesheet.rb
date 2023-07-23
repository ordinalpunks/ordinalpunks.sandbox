require 'pixelart'



composite = ImageComposite.new( 10, 2, width: 24,
                                       height: 24 )


names = [
   '', ## human
   'vampire-',
   'demon-',
   'zombie-',
   'ape-',
   'alien-',
   'orc-',
   'robot-',
   'mummy-',
   'skeleton-',
]

['male', 'female'].each do |gender|
   names.each do |name|
       path = "./more/#{name}#{gender}_green.png"
       composite << Image.read( path )
   end
end    


composite.save( "./tmp/spritesheet.png" )
composite.zoom(4).save( "./tmp/spritesheet@4x.png" )

puts "bye"
