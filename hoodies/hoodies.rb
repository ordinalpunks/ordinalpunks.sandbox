#####
#  to run use:
#    $   ruby ./hoodies.rb


require_relative '../utils/punks'


def hoodied( *attributes )
  base            = attributes[0]
  more_attributes = attributes[1..-1]

  has_hoodie =  more_attributes.find { |attr| attr == 'Hoodie' }


  more_attributes = more_attributes.reject {|attr| [
   ##                                          'Crown',
   ##                                         'Flowers',
   ##                                         'Bow',
                                            'Cap Burger King',
                                             'Birthday Hat',
                                             'Cowboy Hat',
                                            'Demon Horns',
                                              'Wild White Hair',
                                              'Beanie',
                                              'Pilot Helmet',
                                              'Police Cap',
                                              'Knitted Cap',
                                              'Top Hat',
                                              'Clown Hair Blue', 'Tiara',
                                              'Sombrero',
                                              'Do-Rag',
                                              'Crazy Hair',
                                              'Jester Hat', 'Cap Red',
                                              'Messy Hair',
                                              'Fedora',
                                              'Clown Hair Green',
                                              'Blonde Bob',
                                              'Bandana',
                                              'Frumpy Hair',
                                              'Cap Forward',
                                              'Blonde Short',
                                              'Cap',
                                              'Dark Hair' ].include?( attr )
                                          }



  if has_hoodie
    [base] + more_attributes
  else
    [base, 'Hoodie'] + more_attributes
  end
end



####
#  read in ordinals metadata
#    note: use ordinal punks v2 (the improved formula)
ordpunks = Punk::Collection.read( '../ordinalpunks_v2.csv' )
puts "    #{ordpunks.size} record(s)"



composite     = ImageComposite.new( 10, 10 )


ordpunks.each_meta do |attributes, id|
  punk =  ordpunks.generate( *hoodied( *attributes )  )

  punk.save( "./tmp2/hoodie-#{id+1}.png" )
  punk.zoom(4).save( "./tmp2/hoodie-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/hoodies.png" )
composite.zoom(4).save( "./tmp/hoodies@4x.png" )


puts "bye"
