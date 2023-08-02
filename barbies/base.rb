require 'punks'


require_relative '../utils/make'


## using color from barbie text logo on wikipedia
##   here ->
BARBIE_PINK = Color.from_hex( '#ec4399' )


puts "barbie pink:"
puts "  #{Color.format( BARBIE_PINK )}"
puts

#=>   #ec4399 / rgb(236  67 153) - hsl(329°  82%  59%) - hsv(329°  72%  93%)


colors = {
#  'pink' =>  BARBIE_PINK,
  'deeppink' => Color.from_hex( '#ff1493'), ## html deeppink
}


colors.each do |name, color|
  ####
  # robots
  _, punk_f = make_robots( color )

  punk_f.save( "./tmp2/robot-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/robot-female_#{name}@4x.png" )

  ###
  #  vampire
  _, punk_f = make_vampires( color )

  punk_f.save( "./tmp2/vampire-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/vampire-female_#{name}@4x.png" )

  ###
  #  orc
  _, punk_f = make_orcs( color )

  punk_f.save( "./tmp2/orc-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/orc-female_#{name}@4x.png" )

  ###
  #  mummy
  _, punk_f = make_mummies( color )

  punk_f.save( "./tmp2/mummy-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/mummy-female_#{name}@4x.png" )

  ####
  # apes
  _, punk_f = make_apes( color )

   punk_f.save( "./tmp2/ape-female_#{name}.png" )
   punk_f.zoom(4).save( "./tmp/ape-female_#{name}@4x.png" )

  ###
  #  zombie
  _, punk_f = make_zombies( color )

  punk_f.save( "./tmp2/zombie-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/zombie-female_#{name}@4x.png" )

  ###
  #  human
  _, punk_f = make_humans( color )

  punk_f.save( "./tmp2/female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/female_#{name}@4x.png" )

  ####
  #  demons
  _, punk_f = make_demons( color )

  punk_f.save( "./tmp2/demon-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/demon-female_#{name}@4x.png" )

  ####
  #  aliens
  _, punk_f = make_aliens( color )

  punk_f.save( "./tmp2/alien-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/alien-female_#{name}@4x.png" )

  #####
  #  skeletons
  _, punk_f = make_skeletons( color )

  punk_f.save( "./tmp2/skeleton-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/skeleton-female_#{name}@4x.png" )
end



puts "bye"