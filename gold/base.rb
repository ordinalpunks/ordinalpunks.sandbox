require 'punks'

def dump_colors( punk )
  hist = Hash.new(0)
  punk.pixels.each do |color|
    hist[ color ] +=1
  end

  hist.each do |color, count|
    print "#{count} pixels "
    print   Color.format( color )
    print "\n"
  end
end



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


base_m = Punks::Sheet.find_by( name: 'Robot' )
base_f = Punks::Sheet.find_by( name: 'Robot Female' )

base_m.zoom.save( "./tmp/robot-male.png" )
base_m.zoom( 8 ).save( "./tmp/robot-male@8x.png" )

base_f.zoom.save( "./tmp/robot-female.png" )
base_f.zoom( 8 ).save( "./tmp/robot-female@8x.png" )


dump_colors( base_m )
puts "---"
dump_colors( base_f )


def derive_robot_color_map( color )
# 384 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%) - α(  0%) - TRANSPARENT
# 74 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%)           - BLACK
# 100 pixels #a4a4a4 / rgb(164 164 164) - hsl(  0°   0%  64%) - hsv(  0°   0%  64%)           - 8-BIT GRAYSCALE #164
# 16 pixels #535353 / rgb( 83  83  83) - hsl(  0°   0%  33%) - hsv(  0°   0%  33%)           - 8-BIT GRAYSCALE #83
# 2 pixels #a9f7ff / rgb(169 247 255) - hsl(186° 100%  83%) - hsv(186°  34% 100%)
# ---
# 427 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%) - α(  0%) - TRANSPARENT
# 65 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%)           - BLACK
# 67 pixels #a4a4a4 / rgb(164 164 164) - hsl(  0°   0%  64%) - hsv(  0°   0%  64%)           - 8-BIT GRAYSCALE #164
# 15 pixels #535353 / rgb( 83  83  83) - hsl(  0°   0%  33%) - hsv(  0°   0%  33%)           - 8-BIT GRAYSCALE #83
# 2 pixels #a9f7ff / rgb(169 247 255) - hsl(186° 100%  83%) - hsv(186°  34% 100%)

  base = color

  hsl  = Color.to_hsl( color )
  pp hsl

  h, s, l = hsl
  h = h % 360   # make always positive (might be -50 or such)
  pp [h,s,l]


  darker = Color.from_hsl(
    h,
    s,
     [0.0,l-0.20].max)

  color_map = {
    '#a4a4a4' =>  base,
    '#535353' =>  darker,
  }

  color_map
end



colors.each do |name, color|
  color_map = derive_robot_color_map( color )
  punk_m = base_m.change_colors( color_map )

  punk_m.save( "./tmp/robot-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/robot-male_#{name}@4x.png" )


  punk_f = base_f.change_colors( color_map )

  punk_f.save( "./tmp/robot-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/robot-female_#{name}@4x.png" )
end



###
#  vampire

base_m = Punks::Sheet.find_by( name: 'Vampire' )
base_f = Punks::Sheet.find_by( name: 'Vampire Female' )

base_m.zoom.save( "./tmp/vampire-male.png" )
base_m.zoom( 8 ).save( "./tmp/vampire-male@8x.png" )

base_f.zoom.save( "./tmp/vampire-female.png" )
base_f.zoom( 8 ).save( "./tmp/vampire-female@8x.png" )


dump_colors( base_m )
puts "---"
dump_colors( base_f )



def derive_vampire_color_map( color )
# 366 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%) - α(  0%) - TRANSPARENT
# 67 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%)           - BLACK
# 126 pixels #e0e0e0 / rgb(224 224 224) - hsl(  0°   0%  88%) - hsv(  0°   0%  88%)           - 8-BIT GRAYSCALE #224
# 4 pixels #535353 / rgb( 83  83  83) - hsl(  0°   0%  33%) - hsv(  0°   0%  33%)           - 8-BIT GRAYSCALE #83
# 2 pixels #ffffff / rgb(255 255 255) - hsl(  0°   0% 100%) - hsv(  0°   0% 100%)           - WHITE
# 2 pixels #f6000b / rgb(246   0  11) - hsl(357° 100%  48%) - hsv(357° 100%  96%)
# 9 pixels #131313 / rgb( 19  19  19) - hsl(  0°   0%   7%) - hsv(  0°   0%   7%)           - 8-BIT GRAYSCALE #19
# ---
# 403 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%) - α(  0%) - TRANSPARENT
# 62 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%)           - BLACK
# 92 pixels #e0e0e0 / rgb(224 224 224) - hsl(  0°   0%  88%) - hsv(  0°   0%  88%)           - 8-BIT GRAYSCALE #224
# 4 pixels #535353 / rgb( 83  83  83) - hsl(  0°   0%  33%) - hsv(  0°   0%  33%)           - 8-BIT GRAYSCALE #83
# 2 pixels #ffffff / rgb(255 255 255) - hsl(  0°   0% 100%) - hsv(  0°   0% 100%)           - WHITE
# 2 pixels #f6000b / rgb(246   0  11) - hsl(357° 100%  48%) - hsv(357° 100%  96%)
# 11 pixels #131313 / rgb( 19  19  19) - hsl(  0°   0%   7%) - hsv(  0°   0%   7%)           - 8-BIT GRAYSCALE #19
base = color

hsl  = Color.to_hsl( color )
pp hsl

h, s, l = hsl
h = h % 360   # make always positive (might be -50 or such)
pp [h,s,l]


darker = Color.from_hsl(
  h,
  s,
   [0.0,l-0.20].max)


darkest = Color.from_hsl(
  h,
  s,
   [0.0,l-0.35].max)

color_map = {
  '#e0e0e0' =>  base,
  '#535353' =>  darker,
  '#131313' =>  darkest,
}

color_map
end


colors.each do |name, color|
  color_map = derive_vampire_color_map( color )
  punk_m = base_m.change_colors( color_map )

  punk_m.save( "./tmp/vampire-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/vampire-male_#{name}@4x.png" )


  punk_f = base_f.change_colors( color_map )

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


def derive_orc_color_map( color )
# 380 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%) - α(  0%) - TRANSPARENT
# 63 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%)           - BLACK
# 120 pixels #50650e / rgb( 80 101  14) - hsl( 74°  76%  23%) - hsv( 74°  86%  40%)
# 7 pixels #171a08 / rgb( 23  26   8) - hsl( 70°  53%   7%) - hsv( 70°  69%  10%)
# 6 pixels #ffffff / rgb(255 255 255) - hsl(  0°   0% 100%) - hsv(  0°   0% 100%)           - WHITE
# ---
# 423 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%) - α(  0%) - TRANSPARENT
# 55 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%)           - BLACK
# 87 pixels #50650e / rgb( 80 101  14) - hsl( 74°  76%  23%) - hsv( 74°  86%  40%)
# 7 pixels #171a08 / rgb( 23  26   8) - hsl( 70°  53%   7%) - hsv( 70°  69%  10%)
# 4 pixels #ffffff / rgb(255 255 255) - hsl(  0°   0% 100%) - hsv(  0°   0% 100%)           - WHITE
base = color

hsl  = Color.to_hsl( color )
pp hsl

h, s, l = hsl
h = h % 360   # make always positive (might be -50 or such)
pp [h,s,l]


darker = Color.from_hsl(
  h,
  s,
   [0.0,l-0.16].max)



color_map = {
  '#50650e' =>  base,
  '#171a08' =>  darker,
}

color_map
end


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


def derive_mummy_color_map( color )
# 385 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%) - α(  0%) - TRANSPARENT
# 52 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%)           - BLACK
# 17 pixels #5f5147 / rgb( 95  81  71) - hsl( 25°  14%  33%) - hsv( 25°  25%  37%)
# 31 pixels #927b6a / rgb(146 123 106) - hsl( 26°  16%  49%) - hsv( 26°  27%  57%)
# 51 pixels #2a231c / rgb( 42  35  28) - hsl( 30°  20%  14%) - hsv( 30°  33%  16%)
# 14 pixels #d9b599 / rgb(217 181 153) - hsl( 26°  46%  73%) - hsv( 26°  29%  85%)
# 24 pixels #1f1a15 / rgb( 31  26  21) - hsl( 30°  19%  10%) - hsv( 30°  32%  12%)
# 2 pixels #f6000b / rgb(246   0  11) - hsl(357° 100%  48%) - hsv(357° 100%  96%)
# ---
# 428 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%) - α(  0%) - TRANSPARENT
# 44 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - hsv(  0°   0%   0%)           - BLACK
# 35 pixels #2a231c / rgb( 42  35  28) - hsl( 30°  20%  14%) - hsv( 30°  33%  16%)
# 20 pixels #927b6a / rgb(146 123 106) - hsl( 26°  16%  49%) - hsv( 26°  27%  57%)
# 12 pixels #d9b599 / rgb(217 181 153) - hsl( 26°  46%  73%) - hsv( 26°  29%  85%)
# 14 pixels #5f5147 / rgb( 95  81  71) - hsl( 25°  14%  33%) - hsv( 25°  25%  37%)
# 21 pixels #1f1a15 / rgb( 31  26  21) - hsl( 30°  19%  10%) - hsv( 30°  32%  12%)
# 2 pixels #f6000b / rgb(246   0  11) - hsl(357° 100%  48%) - hsv(357° 100%  96%)
base = color

hsl  = Color.to_hsl( color )
pp hsl

h, s, l = hsl
h = h % 360   # make always positive (might be -50 or such)
pp [h,s,l]


darker = Color.from_hsl(
  h, # (h+4)%360,
  s,
   [0.0,l-0.30].max)

darkest = Color.from_hsl(
  h, # (h+4)%360,
  s,
   [0.0,l-0.45].max)

# darkest -  24 pixels #1f1a15 / rgb( 31  26  21) - hsl( 30°  19%  10%) - hsv( 30°  32%  12%)
# darker -   51 pixels #2a231c / rgb( 42  35  28) - hsl( 30°  20%  14%) - hsv( 30°  33%  16%)
# base   -   31 pixels #927b6a / rgb(146 123 106) - hsl( 26°  16%  49%) - hsv( 26°  27%  57%)

# dark - 17 pixels #5f5147 / rgb( 95  81  71) - hsl( 25°  14%  33%) - hsv( 25°  25%  37%)
# lighter    - 14 pixels #d9b599 / rgb(217 181 153) - hsl( 26°  46%  73%) - hsv( 26°  29%  85%)


dark = Color.from_hsl(
  h, # (h+4)%360,
  s,
   [0.0,l-0.15].max)

lighter = Color.from_hsl(
  h, # (h+4)%360,
  s,
   [100.0,l+0.25].min)


color_map = {
   '#5f5147' => dark,
  '#927b6a' =>  base,
  '#d9b599'  => lighter,
  '#2a231c' =>  darker,
  '#1f1a15' =>  darkest,
}

color_map
end


colors.each do |name, color|
  color_map = derive_mummy_color_map( color )
  punk_m = base_m.change_colors( color_map )

  punk_m.save( "./tmp/mummy-male_#{name}.png" )
  punk_m.zoom(4).save( "./tmp/mummy-male_#{name}@4x.png" )


  punk_f = base_f.change_colors( color_map )

  punk_f.save( "./tmp/mummy-female_#{name}.png" )
  punk_f.zoom(4).save( "./tmp/mummy-female_#{name}@4x.png" )
end



puts "bye"