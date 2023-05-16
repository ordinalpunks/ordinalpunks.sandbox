require 'punks'
require_relative '../utils/make_humans'


skin_tone = Color.parse( '#FFCDD2' )


punk_m, punk_f = make_humans( skin_tone )


punk_m.save( "./tmp2/human.png" )
punk_m.zoom(4).save( "./tmp2/human@4x.png" )

puts "bye"

