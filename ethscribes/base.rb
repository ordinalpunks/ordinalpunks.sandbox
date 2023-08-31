require 'punkmaker'



ETHSCRIBES_GREEN = Color.from_hex( '#c3ff00' )


puts "(ethscribes) green:"
puts "  #{Color.format( ETHSCRIBES_GREEN )}"
puts

#=>   #c3ff00 / rgb(195 255   0) - hsl( 74° 100%  50%) - hsv( 74° 100% 100%)


colors = {
  'green' =>  ETHSCRIBES_GREEN,
}

types = [
  Punk::Robot,
  Punk::Vampire,
  Punk::Orc,
  Punk::Mummy,
  Punk::Ape,
  Punk::Zombie,
  Punk::Human,
  Punk::Demon,
  Punk::Alien,
  Punk::Skeleton,
]


colors.each do |color_name, color|
  types.each do |type|
    ## get last name e.g. Orc from Punk::Orc
    name = type.name.split('::')[-1].downcase
 
    punk_m = type.make( color, gender: 'm' )
    punk_f = type.make( color, gender: 'f' )

    punk_m.save( "./tmp/#{name}-male_#{color_name}.png" )
    punk_m.zoom(4).save( "./tmp/#{name}-male_#{color_name}@4x.png" )

    punk_f.save( "./tmp/#{name}-female_#{color_name}.png" )
    punk_f.zoom(4).save( "./tmp/#{name}-female_#{color_name}@4x.png" )
  end
end



puts "bye"