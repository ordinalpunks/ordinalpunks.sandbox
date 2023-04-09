#####
#  to run use:
#    $   ruby ./dollar.rb



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


def dollarize( punk )
  ## change to greenback color palette
  dollar = Image.new( DOLLAR_FRAME.width, DOLLAR_FRAME.height )
  dollar.compose!( DOLLAR_FRAME )
  dollar.compose!( punk.change_palette8bit( DOLLAR_PALETTE ), 16, 0 )
  dollar
end






####
#  read in ordinals metadata
recs = read_csv( "../../ordinalpunks.starter/ordinalpunks.csv" )
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







composite = ImageComposite.new( 3, 4, width:  DOLLAR_FRAME.width+4,
                                      height: DOLLAR_FRAME.height+4,
                                      background: '#000000' )


ids = (0..11)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes )

  dollar = dollarize( punk )

  tile = Image.new( DOLLAR_FRAME.width+4, DOLLAR_FRAME.height+4 )
  tile.compose!( dollar, 2, 2 )  ## add 2/2 padding
  composite << tile
end


composite.save( "./tmp/dollars.png" )
composite.zoom(4).save( "./tmp/dollars@4x.png" )


###
#  note: ids are off-by-one (starting at zero NOT one), sorry!

ids = [29, 92]
ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes )

  ## change to greenback color palette
  dollar = dollarize( punk )

  dollar.save( "./tmp/dollar-#{id+1}.png" )
  dollar.zoom(4).save( "./tmp/dollar-#{id+1}@4x.png" )
  dollar.zoom(8).save( "./tmp/dollar-#{id+1}@8x.png" )
end



puts "bye"
