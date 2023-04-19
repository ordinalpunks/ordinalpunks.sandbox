

def make_apes( color )
  base_m = Punks::Sheet.find_by( name: 'Ape' )
  base_f = Punks::Sheet.find_by( name: 'Ape Female' )

  # base_m.zoom.save( "./tmp/ape-male.png" )
  # base_m.zoom( 8 ).save( "./tmp/ape-male@8x.png" )

  # base_f.zoom.save( "./tmp/ape-female.png" )
  # base_f.zoom( 8 ).save( "./tmp/ape-female@8x.png" )

  # dump_colors( base_m )

  color_map = derive_ape_color_map( color )
  punk_m = base_m.change_colors( color_map )
  punk_f = base_f.change_colors( color_map )

  [punk_m, punk_f]
end



def derive_ape_color_map( color )
  darkest = color

  hsl  = Color.to_hsl( color )
  pp hsl

  h, s, l = hsl
  h = h % 360   # make always positive (might be -50 or such)
  pp [h,s,l]

  darker = Color.from_hsl(
    h,
    s,
    [1.0,l+0.05].min)

  light = Color.from_hsl(
     (h+1)%360,
     [1.0,s+0.10].min,
     [1.0,l+0.20].min)

  lighter = Color.from_hsl(
    (h+1)%360,
    [1.0,s+0.20].min,
    [1.0,l+0.35].min)

  color_map = {
      '#352410' =>  darkest,  # darkest  - 56 pixels (base!!)
      '#6a563f' => darker,    # darker   -  4 pixels
      '#856f56' => light,     # light    - 63 pixels
      '#a98c6b' => lighter    # lighter
  }

  color_map
end

