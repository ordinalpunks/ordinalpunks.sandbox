



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



def derive_alien_color_map( color )

# 2 pixels #f1ffff / rgb(241 255 255) - hsl(180° 100%  97%)  - lighter
# 125 pixels #c8fbfb / rgb(200 251 251) - hsl(180°  86%  88%)   - base (use as base)
#  6 pixels #9be0e0 / rgb(155 224 224) - hsl(180°  53%  74%)   - darker
#  2 pixels #75bdbd / rgb(117 189 189) - hsl(180°  35%  60%)  - darkest

base = color

hsl  = Color.to_hsl( color )
pp hsl

h, s, l = hsl
h = h % 360   # make always positive (might be -50 or such)
pp [h,s,l]

## todo/check - check "formula" used in skintones script for humans!!!
lighter = Color.from_hsl(
   (h+1)%360,   # todo/check: make lighter by -1 on hue? or +1????
   [1.0,s+0.10].min,
   [1.0,l+0.25].min)


darker = Color.from_hsl(
  h,
  [0.0,s-0.05].max,
  [0.0,l-0.10].max)

darkest = Color.from_hsl(
  h,
  [0.0,s-0.10].max,
  [0.0,l-0.20].max)


color_map = {
    '#c8fbfb' =>  base,
    '#f1ffff' => lighter,
    '#9be0e0' => darker,
    '#75bdbd' => darkest,
}

color_map
end


def derive_skeleton_color_map( color )
# 122 pixels #e0e0e0 / rgb(224 224 224) - hsl(  0°   0%  88%)           - 8-BIT GRAYSCALE #224

# 385 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%) - α(  0%) - TRANSPARENT
#  69 pixels #000000 / rgb(  0   0   0) - hsl(  0°   0%   0%)           - BLACK

  base = color

  color_map = {
    '#e0e0e0' =>  base,
  }

  color_map
end

