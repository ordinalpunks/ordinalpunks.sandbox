require 'punkmaker'


## using color from barbie text logo on wikipedia
##   here ->
BARBIE_PINK = Color.from_hex( '#ec4399' )


puts "barbie pink:"
puts "  #{Color.format( BARBIE_PINK )}"
puts

#=>   #ec4399 / rgb(236  67 153) - hsl(329°  82%  59%) - hsv(329°  72%  93%)


colors = {
#  'pink' =>  BARBIE_PINK,
  'deeppink' => Color.from_hex( '#ff1493'), ## html deeppink
}


types = [
  Punk::Robot,
  Punk::Vampire,
  Punk::Orc,
  Punk::Mummy,
  Punk::Ape,
  Punk::Zombie,
  Punk::Human,
  Punk::Demon,
  Punk::Alien,
  Punk::Skeleton,
]



colors.each do |color_name, color|
  types.each do |type|
    ## get last name e.g. Orc from Punk::Orc
    name = type.name.split('::')[-1].downcase
 
    punk_f = type.make( color, gender: 'f' )

    punk_f.save( "./tmp2/#{name}-female_#{color_name}.png" )
    punk_f.zoom(4).save( "./tmp/#{name}-female_#{color_name}@4x.png" )
  end
end


puts "bye"