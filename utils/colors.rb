
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

