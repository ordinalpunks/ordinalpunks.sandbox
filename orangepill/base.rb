require 'punks'


require_relative '../utils/make'


BITCOIN_ORANGE = Color.from_hex( '#f7931a' )


puts "(bitcoin) orange:"
puts "  #{Color.format( BITCOIN_ORANGE )}"
puts
#=>   #f7931a / rgb(247 147  26) - hsl( 33°  93%  54%) - hsv( 33°  89%  97%)


colors = {
  'orange' =>  BITCOIN_ORANGE,
}


colors.each do |name, color|
  ####
  # robots
  punk_m, punk_f = make_robots( color )

  punk_m.save( "./tmp/robot-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/robot-male_#{name}@4x.png" )

  punk_f.save( "./tmp/robot-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/robot-female_#{name}@4x.png" )

  ###
  #  vampire
  punk_m, punk_f = make_vampires( color )

  punk_m.save( "./tmp/vampire-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/vampire-male_#{name}@4x.png" )

  punk_f.save( "./tmp/vampire-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/vampire-female_#{name}@4x.png" )

  ###
  #  orc
  punk_m, punk_f = make_orcs( color )

  punk_m.save( "./tmp/orc-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/orc-male_#{name}@4x.png" )

  punk_f.save( "./tmp/orc-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/orc-female_#{name}@4x.png" )

  ###
  #  mummy
  punk_m, punk_f = make_mummies( color )

  punk_m.save( "./tmp/mummy-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/mummy-male_#{name}@4x.png" )

  punk_f.save( "./tmp/mummy-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/mummy-female_#{name}@4x.png" )

  ####
  # apes
  punk_m, punk_f = make_apes( color )

   punk_m.save( "./tmp/ape-male_#{name}.png" )
   punk_m.zoom(4).save( "./tmp/ape-male_#{name}@4x.png" )

   punk_f.save( "./tmp/ape-female_#{name}.png" )
   punk_f.zoom(4).save( "./tmp/ape-female_#{name}@4x.png" )

  ###
  #  zombie
  punk_m, punk_f = make_zombies( color )

  punk_m.save( "./tmp/zombie-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/zombie-male_#{name}@4x.png" )

  punk_f.save( "./tmp/zombie-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/zombie-female_#{name}@4x.png" )

  ###
  #  human
  punk_m, punk_f = make_humans( color )

  punk_m.save( "./tmp/male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/male_#{name}@4x.png" )

  punk_f.save( "./tmp/female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/female_#{name}@4x.png" )

  ####
  #  demons
  punk_m, punk_f = make_demons( color )

  punk_m.save( "./tmp/demon-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/demon-male_#{name}@4x.png" )

  punk_f.save( "./tmp/demon-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/demon-female_#{name}@4x.png" )

  ####
  #  aliens
  punk_m, punk_f = make_aliens( color )

  punk_m.save( "./tmp/alien-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/alien-male_#{name}@4x.png" )

  punk_f.save( "./tmp/alien-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/alien-female_#{name}@4x.png" )

  #####
  #  skeletons
  punk_m, punk_f = make_skeletons( color )

  punk_m.save( "./tmp/skeleton-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/skeleton-male_#{name}@4x.png" )

  punk_f.save( "./tmp/skeleton-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/skeleton-female_#{name}@4x.png" )
end



puts "bye"