

def make_mummies( color )
  base_m = Punks::Sheet.find_by( name: 'Mummy' )
  base_f = Punks::Sheet.find_by( name: 'Mummy Female' )

  # base_m.zoom.save( "./tmp/mummy-male.png" )
  # base_m.zoom( 8 ).save( "./tmp/mummy-male@8x.png" )

  # base_f.zoom.save( "./tmp/mummy-female.png" )
  # base_f.zoom( 8 ).save( "./tmp/mummy-female@8x.png" )

  # dump_colors( base_m )
  # puts "---"
  # dump_colors( base_f )

  color_map = derive_mummy_color_map( color )
  punk_m = base_m.change_colors( color_map )
  punk_f = base_f.change_colors( color_map )

  [punk_m, punk_f]
end


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


