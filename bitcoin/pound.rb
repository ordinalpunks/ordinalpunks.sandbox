require 'punks'

POUND_TILE = Image.read( "./pound-24x24.png" )



####
#  read in ordinals metadata
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




composite = ImageComposite.new( 10, 10 )


ids = (0..99)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes )
  punk = punk.background( POUND_TILE )

  punk.save( "./tmp2/pound-#{id+1}.png" )
  punk.zoom(4).save( "./tmp2/pound-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp2/pounds.png" )
composite.zoom(4).save( "./tmp2/pounds@4x.png" )



###
# test drive pound background tile (as "empty" mosaic)
composite = ImageComposite.new( 3, 3 )

9.times do
  composite << POUND_TILE
end

composite.save( "./tmp2/background-pound.png" )
composite.zoom(4).save( "./tmp2/background-pound@4x.png" )
composite.zoom(8).save( "./tmp2/background-pound@8x.png" )



puts "bye"

