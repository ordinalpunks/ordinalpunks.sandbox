#####
#  to run use:
#    $   ruby ./hollywood.rb



require_relative '../utils/punks'


FILM35MM   = Image.read( "./film35mm-26x24.png" )
puts "   #{FILM35MM.width}x#{FILM35MM.height}"
#=>  28x34 px


##
#  background - use??
# -  #4A0400  - dark red-ish ??
# - '#FFE5DA'
# - '#5A0201'
# -  #F1F2F6  - light gray-ish/white-ish ??
# -  #FB0102
# -  '#52BBFE' - light blue-ish

def film35mm( punk )
  frame = Image.new( FILM35MM.width, FILM35MM.height )
  frame.compose!( FILM35MM )
  frame.compose!( Image.new( 26, 24, '#FF6A00' ), 1, 5 )  ## use solid background
  frame.compose!( punk, 2, 5 )
  frame
end


####
#  read in ordinals metadata
#    note: use ordinal punks v2 (the improved formula)
ordpunks = Punk::Collection.read( '../ordinalpunks_v2.csv' )
puts "    #{ordpunks.size} record(s)"



###
#  generate (preview strips)

composite = ImageComposite.new( 3, 4, width:  FILM35MM.width,
                                      height: FILM35MM.height )

ids = (0..11)
ids.each do |id|
  composite << film35mm( ordpunks[ id ] )
end


composite.save( "./tmp/hollywood-strip.png" )
composite.zoom(4).save( "./tmp/hollywood-strip@4x.png" )


composite = ImageComposite.new( 10, 10, width:  FILM35MM.width,
                                        height: FILM35MM.height )

ordpunks.each do |punk, id|
  frame = film35mm( punk )

  frame.save( "./tmp/hollywood-#{id+1}.png" )
  frame.zoom(4).save( "./tmp/hollywood-#{id+1}@4x.png" )

  composite << frame
end


composite.save( "./tmp/hollywood.png" )


puts "bye"
