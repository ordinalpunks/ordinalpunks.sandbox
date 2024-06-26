#####
#  to run use:
#    $   ruby ./dollar.rb


$LOAD_PATH.unshift( '../../../learnpixelart/pixelart/pixelart/lib' )
require 'punks'


def gen_palette( hex )
  ## from black to color
  color = Color.parse( hex )
  h,s,l = Color.to_hsl( color )

  pp h
  pp s
  pp l

  darker = 0.25    ## cut-off colors starting from black
  lighter = 0.05   ## cut-off colors starting from white

  ldiff = (1.0 - darker - lighter)

  puts "  ldiff: #{ldiff}"

  colors = []
  256.times do |i|
     lnew = darker+(ldiff*i / 256.0)
     puts "  #{i} - #{lnew}"
     colors << Color.from_hsl( h, s, lnew)
  end

  colors
end


puts "colors:"
puts Color.format( Color.parse(  '#536140' ))
#=>  #536140 / rgb( 83  97  64) - hsl( 85°  20%  32%)


DOLLAR_PALETTE = gen_palette( '#536140' )
DOLLAR_FRAME   = Image.read( "./dollar.png" )
puts "   #{DOLLAR_FRAME.width}x#{DOLLAR_FRAME.height}"


def dollarize( punk, id: )
  ## change to greenback color palette
  base = punk.change_palette8bit( DOLLAR_PALETTE )
  base.zoom(8).save( "./ordzaar/tmp/base#{id+1}@8x.png" )

  dollar = Image.new( DOLLAR_FRAME.width, DOLLAR_FRAME.height )
  dollar.compose!( DOLLAR_FRAME )
  dollar.compose!( base, 16, 0 )
  dollar
end






####
#  read in ordinals metadata
#    note: use ordinal punks v2 (the improved formula)
recs = read_csv( "../ordinalpunks_v2.csv" )
puts "    #{recs.size} record(s)"


def rec_to_attributes( rec )
  type =     rec['type']
  gender =   rec['gender']
  skin_tone = rec['skin_tone']

  # note: merge type+gender+skin_tone into one attribute
  base = "#{type} #{gender}"
  base << " #{skin_tone}"       unless skin_tone.empty?

  accessories = rec['accessories'].split( '/' ).map { |acc| acc.strip }
  attributes = [base] + accessories
  attributes
end



##
# add logo

punk = Punk::Image.generate( 'ape gold', 'laser eyes' )
dollar = dollarize( punk, id: 0 )
dollar.save( "./ordzaar/tmp/profile.png" )



composite = ImageComposite.new( 10, 10, width:  DOLLAR_FRAME.width+4,
                                        height: DOLLAR_FRAME.height+4,
                                        background: '#000000' )


banner = ImageComposite.new( 20, 5,  width:  DOLLAR_FRAME.width+4,
                                     height: DOLLAR_FRAME.height+4,
                                     background: '#000000' )



ids = (0..99)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes )

  dollar = dollarize( punk, id: id )


  num = '%02d' % id
  dollar.save( "./ordzaar/greenback#{num}.png" )
  dollar.zoom(8).save( "./ordzaar/@8x/greenback#{num}@8x.png" )


  tile = Image.new( DOLLAR_FRAME.width+4, DOLLAR_FRAME.height+4 )
  tile.compose!( dollar, 2, 2 )  ## add 2/2 padding
  composite << tile
  banner    << tile
end


composite.save( "./ordzaar/greenbacks.png" )
composite.zoom(2).save( "./ordzaar/greenbacks@2x.png" )
composite.zoom(4).save( "./ordzaar/greenbacks@4x.png" )


banner.save( "./ordzaar/tmp/banner.png" )
banner.zoom(2).save( "./ordzaar/tmp/banner@2x.png" )
banner.zoom(3).save( "./ordzaar/tmp/banner@3x.png" )
banner.zoom(4).save( "./ordzaar/tmp/banner@4x.png" )



puts "bye"
