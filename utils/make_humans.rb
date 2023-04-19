

def make_humans( color )
  base_m = Punk::Sheet.find_by( name: 'Male 4' )
  base_f = Punk::Sheet.find_by( name: 'Female 4' )

  color_map = derive_human_color_map( color )
  punk_m = base_m.change_colors( color_map )

  punk_m[10,12] = Color::WHITE     # left eye dark-ish pixel to white
  punk_m[15,12] = Color::WHITE     # right eye ---

  ## for female - change lips to all black (like in male for now) - why? why not?
  color_map[ '#711010' ] = '#000000'
  punk_f = base_f.change_colors( color_map )

  punk_f[10,13] = Color::WHITE     # left eye dark-ish pixel to white
  punk_f[15,13] = Color::WHITE     # right eye ---

  [punk_m, punk_f]
end


def derive_human_color_map( color )

  base = color

  hsl  = Color.to_hsl( color )
  pp hsl

  h, s, l = hsl
  h = h % 360   # make always positive (might be -50 or such)
  pp [h,s,l]

  darker   = Color.from_hsl(
    h,
    [0.0, s-0.05].max,
    [0.14, l-0.1].max)

  ## sub one degree on hue on color wheel (plus +10% on lightness??)
  darkest = Color.from_hsl(
                 (h-1) % 360,
                 s,
                 [0.05, l-0.1].max)


  lighter = Color.from_hsl(
                  (h+1) % 360,
                  s,
                  [1.0, l+0.1].min)

  color_map = {
     '#ead9d9'  =>   base,
     '#ffffff'  =>   lighter,
     '#a58d8d'  =>   darkest,
     '#c9b2b2'  =>   darker
  }
  color_map
end


