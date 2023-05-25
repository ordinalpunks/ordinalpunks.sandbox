#####
#  to run use:
#    $   ruby ./invert.rb


require_relative '../utils/punks'


####
#  read in ordinals metadata
#    note: use ordinal punks v2 (the improved formula)
ordpunks = Punk::Collection.read( '../ordinalpunks_v2.csv' )
puts "    #{ordpunks.size} record(s)"



composite     = ImageComposite.new( 10, 10 )


ordpunks.each_meta do |attributes, id|
  punk =  ordpunks.generate( *attributes ).invert

  punk.save( "./tmp/inverted-#{id+1}.png" )
  punk.zoom(4).save( "./tmp/inverted-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/inverted.png" )
composite.zoom(4).save( "./tmp/inverted@4x.png" )


puts "bye"
