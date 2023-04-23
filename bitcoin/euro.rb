require 'punks'

EURO_TILE = Image.read( "./euro-24x24.png" )



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
  punk = punk.background( EURO_TILE )

  punk.save( "./tmp2/euro-#{id+1}.png" )
  punk.zoom(4).save( "./tmp2/euro-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp2/euros.png" )
composite.zoom(4).save( "./tmp2/euros@4x.png" )



###
# test drive euro background tile (as "empty" mosaic)
composite = ImageComposite.new( 3, 3 )

9.times do
  composite << EURO_TILE
end

composite.save( "./tmp/background-euro.png" )
composite.zoom(4).save( "./tmp/background-euro@4x.png" )
composite.zoom(8).save( "./tmp/background-euro@8x.png" )



puts "bye"

