
def make_vampires( color )
  base_m = Punks::Sheet.find_by( name: 'Vampire' )
  base_f = Punks::Sheet.find_by( name: 'Vampire Female' )

  # base_m.zoom.save( "./tmp/vampire-male.png" )
  # base_m.zoom( 8 ).save( "./tmp/vampire-male@8x.png" )

  # base_f.zoom.save( "./tmp/vampire-female.png" )
  # base_f.zoom( 8 ).save( "./tmp/vampire-female@8x.png" )


  # dump_colors( base_m )
  # puts "---"
  # dump_colors( base_f )

  color_map = derive_vampire_color_map( color )
  punk_m = base_m.change_colors( color_map )
  punk_f = base_f.change_colors( color_map )

  [punk_m, punk_f]
end


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
