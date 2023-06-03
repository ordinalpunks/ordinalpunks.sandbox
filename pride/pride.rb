#####
#  to run use:
#    $   ruby ./pride.rb


require_relative '../utils/punks'




####
#  read in ordinals metadata
#    note: use ordinal punks v2 (the improved formula)
ordpunks = Punk::Collection.read( '../ordinalpunks_v2.csv' )
puts "    #{ordpunks.size} record(s)"


composite = ImageComposite.new( 10, 10, width: 24,
                                        height: 24 )


ordpunks.each_meta do |attributes, id|
  punk =  ordpunks.generate( *attributes ).rainbow

  punk.save( "./tmp/pride-#{id+1}.png" )
  punk.zoom(4).save( "./tmp/pride-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/pridepunks.png" )
composite.zoom(4).save( "./tmp/pridepunks@4x.png" )

puts "bye"
