require 'punkmaker'




types = [
  Punk::Human,
  Punk::Vampire,
  Punk::Demon,
  Punk::Zombie,
  Punk::Ape,
  Punk::Alien,
  Punk::Orc,
  Punk::Robot,
  Punk::Mummy,
  Punk::Skeleton,
]


composite = ImageComposite.new( 10, 2, width: 24,
                                       height: 24 )

ETHSCRIBES_GREEN = Color.from_hex( '#c3ff00' )

['m', 'f'].each do |gender|
  types.each do |type|
    punk = type.make( ETHSCRIBES_GREEN, gender: gender )
    composite << punk
   end
end    


composite.save( "./tmp/spritesheet.png" )
composite.zoom(4).save( "./tmp/spritesheet@4x.png" )

puts "bye"
