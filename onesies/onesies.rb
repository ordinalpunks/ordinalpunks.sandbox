#####
#  to run use:
#    $   ruby ./onesies.rb


require_relative '../utils/punks'


def onesied( *attributes, onesie:  )
  base            = attributes[0]
  more_attributes = attributes[1..-1]


  more_attributes = more_attributes.reject {|attr|
                                          [  'Hoodie',
                                             'Crown',
                                             'Cap Burger King',
                                             'Birthday Hat',
                                             'Flowers',
                                             'Cowboy Hat',
                                            'Demon Horns',
                                              'Wild White Hair',
                                              'Beanie',
                                              'Pilot Helmet',
                                              'Police Cap',
                                              'Knitted Cap',
                                              'Bow',
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



    [base, onesie] + more_attributes
end



####
#  read in ordinals metadata
#    note: use ordinal punks v2 (the improved formula)
ordpunks = Punk::Collection.read( '../ordinalpunks_v2.csv' )
puts "    #{ordpunks.size} record(s)"



###
# onesies variant i  - frog hoodies

composite     = ImageComposite.new( 10, 10 )


ordpunks.each_meta do |attributes, id|
  punk =  ordpunks.generate( *onesied( *attributes, onesie: 'Frog Hood' )  )

  punk.save( "./tmp2/frog-#{id+1}.png" )
  punk.zoom(4).save( "./tmp2/frog-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/frogs.png" )
composite.zoom(4).save( "./tmp/frogs@4x.png" )


###
# onesies variant ii  - bear hoodies

composite     = ImageComposite.new( 10, 10 )


ordpunks.each_meta do |attributes, id|
  punk =  ordpunks.generate( *onesied( *attributes, onesie: 'Bear Hood' )  )

  punk.save( "./tmp2/bear-#{id+1}.png" )
  punk.zoom(4).save( "./tmp2/bear-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/bears.png" )
composite.zoom(4).save( "./tmp/bears@4x.png" )


puts "bye"
