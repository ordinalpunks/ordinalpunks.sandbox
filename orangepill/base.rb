require 'punks'


require_relative '../utils/colors'    ## incl. dump_colors, etc.
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
  punk_m, punk_f = make_robots( color )

  punk_m.save( "./tmp/robot-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/robot-male_#{name}@4x.png" )

  punk_f.save( "./tmp/robot-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/robot-female_#{name}@4x.png" )
end


###
#  vampire

colors.each do |name, color|
  punk_m, punk_f = make_vampires( color )

  punk_m.save( "./tmp/vampire-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/vampire-male_#{name}@4x.png" )

  punk_f.save( "./tmp/vampire-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/vampire-female_#{name}@4x.png" )
end



###
#  orc

base_m = Punks::Sheet.find_by( name: 'Orc' )
base_f = Punks::Sheet.find_by( name: 'Orc Female' )

base_m.zoom.save( "./tmp/orc-male.png" )
base_m.zoom( 8 ).save( "./tmp/orc-male@8x.png" )

base_f.zoom.save( "./tmp/orc-female.png" )
base_f.zoom( 8 ).save( "./tmp/orc-female@8x.png" )


dump_colors( base_m )
puts "---"
dump_colors( base_f )




colors.each do |name, color|
  color_map = derive_orc_color_map( color )
  punk_m = base_m.change_colors( color_map )

  punk_m.save( "./tmp/orc-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/orc-male_#{name}@4x.png" )


  punk_f = base_f.change_colors( color_map )

  punk_f.save( "./tmp/orc-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/orc-female_#{name}@4x.png" )
end



###
#  mummy

base_m = Punks::Sheet.find_by( name: 'Mummy' )
base_f = Punks::Sheet.find_by( name: 'Mummy Female' )

base_m.zoom.save( "./tmp/mummy-male.png" )
base_m.zoom( 8 ).save( "./tmp/mummy-male@8x.png" )

base_f.zoom.save( "./tmp/mummy-female.png" )
base_f.zoom( 8 ).save( "./tmp/mummy-female@8x.png" )


dump_colors( base_m )
puts "---"
dump_colors( base_f )


colors.each do |name, color|
  color_map = derive_mummy_color_map( color )
  punk_m = base_m.change_colors( color_map )

  punk_m.save( "./tmp/mummy-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/mummy-male_#{name}@4x.png" )


  punk_f = base_f.change_colors( color_map )

  punk_f.save( "./tmp/mummy-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/mummy-female_#{name}@4x.png" )
end



####
# apes

base_m = Punks::Sheet.find_by( name: 'Ape' )
base_f = Punks::Sheet.find_by( name: 'Ape Female' )

base_m.zoom.save( "./tmp/ape-male.png" )
base_m.zoom( 8 ).save( "./tmp/ape-male@8x.png" )

base_f.zoom.save( "./tmp/ape-female.png" )
base_f.zoom( 8 ).save( "./tmp/ape-female@8x.png" )


dump_colors( base_m )


colors.each do |name, color|
   color_map = derive_ape_color_map( color )
   ape_m = base_m.change_colors( color_map )

   ape_m.save( "./tmp/ape-male_#{name}.png" )
   ape_m.zoom(4).save( "./tmp/ape-male_#{name}@4x.png" )


   ape_f = base_f.change_colors( color_map )

   ape_f.save( "./tmp/ape-female_#{name}.png" )
   ape_f.zoom(4).save( "./tmp/ape-female_#{name}@4x.png" )
end



###
#  zombie


base_m = Punks::Sheet.find_by( name: 'Zombie' )
base_f = Punks::Sheet.find_by( name: 'Zombie Female' )


base_m.zoom.save( "./tmp/zombie-male.png" )
base_m.zoom( 8 ).save( "./tmp/zombie-male@8x.png" )

base_f.zoom.save( "./tmp/zombie-female.png" )
base_f.zoom( 8 ).save( "./tmp/zombie-female@8x.png" )


dump_colors( base_m )


colors.each do |name, color|
  color_map = derive_zombie_color_map( color )
  zombie_m = base_m.change_colors( color_map )

  zombie_m.save( "./tmp/zombie-male_#{name}.png" )
  zombie_m.zoom(4).save( "./tmp/zombie-male_#{name}@4x.png" )


  zombie_f = base_f.change_colors( color_map )

  zombie_f.save( "./tmp/zombie-female_#{name}.png" )
  zombie_f.zoom(4).save( "./tmp/zombie-female_#{name}@4x.png" )
end


###
#  human

base_m = Punk::Sheet.find_by( name: 'Male 4' )
base_f = Punk::Sheet.find_by( name: 'Female 4' )

colors.each do |name, color|
  color_map = derive_human_color_map( color )
  punk_m = base_m.change_colors( color_map )

  punk_m[10,12] = Color::WHITE     # left eye dark-ish pixel to white
  punk_m[15,12] = Color::WHITE     # right eye ---

  punk_m.save( "./tmp/male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/male_#{name}@4x.png" )


  ## for female - change lips to all black (like in male for now) - why? why not?
  color_map[ '#711010' ] = '#000000'
  punk_f = base_f.change_colors( color_map )

  punk_f[10,13] = Color::WHITE     # left eye dark-ish pixel to white
  punk_f[15,13] = Color::WHITE     # right eye ---

  punk_f.save( "./tmp/female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/female_#{name}@4x.png" )
end



####
#  demons

base_m = Punks::Sheet.find_by( name: 'Demon' )
base_f = Punks::Sheet.find_by( name: 'Demon Female' )

base_m.zoom.save( "./tmp/demon-male.png" )
base_m.zoom( 8 ).save( "./tmp/demon-male@8x.png" )

base_f.zoom.save( "./tmp/demon-female.png" )
base_f.zoom( 8 ).save( "./tmp/demon-female@8x.png" )


dump_colors( base_m )



colors.each do |name, color|
  color_map = derive_demon_color_map( color )
  punk_m = base_m.change_colors( color_map )

  punk_m.save( "./tmp/demon-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/demon-male_#{name}@4x.png" )


  punk_f = base_f.change_colors( color_map )

  punk_f.save( "./tmp/demon-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/demon-female_#{name}@4x.png" )
end



####
#  aliens

base_m = Punks::Sheet.find_by( name: 'Alien' )
base_f = Punks::Sheet.find_by( name: 'Alien Female' )

base_m.zoom.save( "./tmp/alien-male.png" )
base_m.zoom( 8 ).save( "./tmp/alien-male@8x.png" )

base_f.zoom.save( "./tmp/alien-female.png" )
base_f.zoom( 8 ).save( "./tmp/alien-female@8x.png" )


dump_colors( base_m )


colors.each do |name, color|
  color_map = derive_alien_color_map( color )
  punk_m = base_m.change_colors( color_map )

  punk_m.save( "./tmp/alien-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/alien-male_#{name}@4x.png" )


  punk_f = base_f.change_colors( color_map )

  punk_f.save( "./tmp/alien-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/alien-female_#{name}@4x.png" )
end


#####
#  skeletons


base_m = Punks::Sheet.find_by( name: 'Skeleton' )
base_f = Punks::Sheet.find_by( name: 'Skeleton Female' )

base_m.zoom.save( "./tmp/skeleton-male.png" )
base_m.zoom( 8 ).save( "./tmp/skeleton-male@8x.png" )

base_f.zoom.save( "./tmp/skeleton-female.png" )
base_f.zoom( 8 ).save( "./tmp/skeleton-female@8x.png" )


dump_colors( base_m )


colors.each do |name, color|
  color_map = derive_skeleton_color_map( color )
  punk_m = base_m.change_colors( color_map )

  punk_m.save( "./tmp/skeleton-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/skeleton-male_#{name}@4x.png" )


  punk_f = base_f.change_colors( color_map )

  punk_f.save( "./tmp/skeleton-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/skeleton-female_#{name}@4x.png" )
end






puts "bye"