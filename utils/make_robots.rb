
def make_robots( color )
  base_m = Punks::Sheet.find_by( name: 'Robot' )
  base_f = Punks::Sheet.find_by( name: 'Robot Female' )

  # base_m.zoom.save( "./tmp/robot-male.png" )
  # base_m.zoom( 8 ).save( "./tmp/robot-male@8x.png" )

  # base_f.zoom.save( "./tmp/robot-female.png" )
  # base_f.zoom( 8 ).save( "./tmp/robot-female@8x.png" )

  # dump_colors( base_m )
  # puts "---"
  # dump_colors( base_f )

  color_map = derive_robot_color_map( color )
  punk_m = base_m.change_colors( color_map )
  punk_f = base_f.change_colors( color_map )

  [punk_m, punk_f]
end


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



