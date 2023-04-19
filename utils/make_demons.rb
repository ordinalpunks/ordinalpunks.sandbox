
def make_demons( color )
  base_m = Punks::Sheet.find_by( name: 'Demon' )
  base_f = Punks::Sheet.find_by( name: 'Demon Female' )

  # base_m.zoom.save( "./tmp/demon-male.png" )
  # base_m.zoom( 8 ).save( "./tmp/demon-male@8x.png" )

  # base_f.zoom.save( "./tmp/demon-female.png" )
  # base_f.zoom( 8 ).save( "./tmp/demon-female@8x.png" )

  # dump_colors( base_m )

  color_map = derive_demon_color_map( color )
  punk_m = base_m.change_colors( color_map )
  punk_f = base_f.change_colors( color_map )

  [punk_m, punk_f]
end


def derive_demon_color_map( color )
# 134 pixels #850008 / rgb(133   0   8) - hsl(356° 100%  26%)  - base
#   2 pixels #630006 / rgb( 99   0   6) - hsl(356° 100%  19%)  - darker
#   4 pixels #390102 / rgb( 57   1   2) - hsl(359°  97%  11%)  - darkest
#
# 373 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - α(  0%) - TRANSPARENT
#  63 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%)           - BLACK

base = color

hsl  = Color.to_hsl( color )
pp hsl

h, s, l = hsl
h = h % 360   # make always positive (might be -50 or such)
pp [h,s,l]

darker = Color.from_hsl(
  h,
  s,
  [0.0,l-0.08].max)

darkest = Color.from_hsl(
  (h+2)%360,
  [0.0,s-0.05].max,
  [0.0,l-0.15].max)


color_map = {
    '#850008' =>  base,
    '#630006' => darker,
    '#390102' => darkest,
}

color_map
end

