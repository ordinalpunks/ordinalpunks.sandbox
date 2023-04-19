

def make_skeletons( color )
  base_m = Punks::Sheet.find_by( name: 'Skeleton' )
  base_f = Punks::Sheet.find_by( name: 'Skeleton Female' )

  # base_m.zoom.save( "./tmp/skeleton-male.png" )
  # base_m.zoom( 8 ).save( "./tmp/skeleton-male@8x.png" )

  # base_f.zoom.save( "./tmp/skeleton-female.png" )
  # base_f.zoom( 8 ).save( "./tmp/skeleton-female@8x.png" )

  # dump_colors( base_m )

  color_map = derive_skeleton_color_map( color )
  punk_m = base_m.change_colors( color_map )
  punk_f = base_f.change_colors( color_map )

  [punk_m, punk_f]
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

