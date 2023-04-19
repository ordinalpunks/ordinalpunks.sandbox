
def make_zombies( color )
  base_m = Punks::Sheet.find_by( name: 'Zombie' )
  base_f = Punks::Sheet.find_by( name: 'Zombie Female' )

  # base_m.zoom.save( "./tmp/zombie-male.png" )
  # base_m.zoom( 8 ).save( "./tmp/zombie-male@8x.png" )

  # base_f.zoom.save( "./tmp/zombie-female.png" )
  # base_f.zoom( 8 ).save( "./tmp/zombie-female@8x.png" )

  # dump_colors( base_m )

  color_map = derive_zombie_color_map( color )
  punk_m = base_m.change_colors( color_map )
  punk_f = base_f.change_colors( color_map )

  [punk_m, punk_f]
end

def derive_zombie_color_map( color )

#    2 pixels #9bbc88 / rgb(155 188 136) - hsl( 98°  28%  64%)  - lighter
#  125 pixels #7da269 / rgb(125 162 105) - hsl( 99°  23%  52%) - base  (use as base)
#    7 pixels #5e7253 / rgb( 94 114  83) - hsl( 99°  16%  39%)  - darker

  base = color

  hsl  = Color.to_hsl( color )
  pp hsl

  h, s, l = hsl
  h = h % 360   # make always positive (might be -50 or such)
  pp [h,s,l]

  darker = Color.from_hsl(
    h,
    [0.0,s-0.05].max,
    [0.0,l-0.12].max)

  ## todo/check - check "formula" used in skintones script for humans!!!
  lighter = Color.from_hsl(
     (h+1)%360,   # todo/check: make lighter by -1 on hue? or +1????
     [1.0,s+0.10].min,
     [1.0,l+0.25].min)


  color_map = {
      '#7da269' =>  base,
      '#5e7253' => darker,
      '#9bbc88' => lighter
  }

  color_map
end


