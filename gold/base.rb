require 'punks'

require_relative '../utils/make'



GOLD          =  Color.from_hex( '#ffd700' )
GOLDENROD     =  Color.from_hex( '#daa520' )
DARKGOLDENROD =  Color.from_hex( '#b8860b' )

puts "gold:"
puts "  #{Color.format( GOLD )}"
puts "goldenrod:"
puts "  #{Color.format( GOLDENROD )}"
puts "darkgoldenrod:"
puts "  #{Color.format( DARKGOLDENROD )}"
puts


colors = {
  'gold_1' =>  GOLD,
  'gold_2' =>  GOLDENROD,
  'gold_3' =>  DARKGOLDENROD
}


#####
# robots

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

colors.each do |name, color|
  punk_m, punk_f = make_orcs( color )

  punk_m.save( "./tmp/orc-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/orc-male_#{name}@4x.png" )

  punk_f.save( "./tmp/orc-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/orc-female_#{name}@4x.png" )
end



###
#  mummy

colors.each do |name, color|
  punk_m, punk_f = make_mummies( color )

  punk_m.save( "./tmp/mummy-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/mummy-male_#{name}@4x.png" )

  punk_f.save( "./tmp/mummy-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/mummy-female_#{name}@4x.png" )
end


puts "bye"