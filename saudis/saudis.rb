#####
#  to run use:
#    $   ruby ./saudis.rb


require_relative '../utils/punks'




def saudied( *attributes )
  base            = attributes[0]
  more_attributes = attributes[1..-1]


 shemaghs = ['White Shemagh',
             'White Shemagh & Agal',
             'White Shemagh & Gold Agal',
             'White Shemagh & Stylish Gold Agal',
             'Brown Shemagh & Agal',
             'Red Shemagh',
             'Red Shemagh & Agal',
            ]

  niquabs =     ['Niquab Black',
                 'Niquab Blue',
                ]

  if base.index( 'Female' )

    below_attributes = []
    above_attributes = []

    more_attributes.each do |attr|
                              if ['Pilot Helmet',
                                  'Hoodie',
                                  'Wild White Hair',
                                  'Clown Hair Green',
                                  'Blonde Bob',
                                  'Blonde Short',
                                   'Frumpy Hair',
                                   'Cowboy Hat',
                                   'Medical Mask',
                                   'Bandana',
                                   'Cap',
                                   'Cap Forward',
                                   'Do-Rag',
                                   'Top Hat',
                                   'Dark Hair',
                                   'Sombrero',
                                   'Beanie',
                                   'Knitted Cap',
                                 ].include?(attr)
                                 ## do nothing; reject/drop/remove
                              elsif ['Flowers',
                                     'Crown',
                                     'Big Shades',
                                     '3D Glasses',
                                     'Cigarette',
                                     'Cigar',
                                     'Pipe',
                                     'Bow',
                                     'Classic Shades',
                                     'Eye Mask',
                                     'Eye Patch',
                                     'Heart Shades',
                                     'Birthday Hat',
                                     'VR',
                                     'Nerd Glasses',
                                ].include?(attr)
                                   above_attributes << attr
                              else
                                  below_attributes << attr
                              end
                       end

     niquab = niquabs[ rand( niquabs.size ) ]
     more_attributes = below_attributes + [ niquab ] + above_attributes
  else
    below_attributes = []
    above_attributes = []

    more_attributes.each do |attr|
                              if ['Hoodie',
                                   'Birthday Hat',
                                   'Cowboy Hat',
                                   'Top Hat',
                                   'Sombrero',
                                   'Fedora',
                                   'Beanie',
                                   'Bandana',
                                   'Do-Rag',
                                   'Cap Red',
                                   'Cap Forward',
                                   'Frumpy Hair',
                                   'Messy Hair',
                                   'Crazy Hair',
                                   'Cap Burger King',
                                   'Jester Hat',
                                   'Clown Hair Blue',
                                   'Knitted Cap',
                                   'Police Cap',
                                 ].include?(attr)
                                 ## do nothing; reject/drop/remove
                              elsif ['Laser Eyes',
                                     '3D Glasses',
                                     'Cigarette',
                                     'Cigar',
                                     'Pipe',
                                     'Bubble Gum',
                                     'Regular Shades',
                                     'Classic Shades',
                                     'Heart Shades',
                                     'VR',
                                     'Big Shades',
                                     'Eye Patch',
                                     'Eye Mask',
                                     'Medical Mask',
                                ].include?(attr)
                                   above_attributes << attr
                              else
                                  below_attributes << attr
                              end
                       end


    shemagh = shemaghs[ rand( shemaghs.size) ]
    more_attributes = below_attributes + [ shemagh ] + above_attributes
  end

  [base] + more_attributes
end


####
#  read in ordinals metadata
#    note: use ordinal punks v2 (the improved formula)
ordpunks = Punk::Collection.read( '../ordinalpunks_v2.csv' )
puts "    #{ordpunks.size} record(s)"




composite     = ImageComposite.new( 10, 10, background: '#006C35' )

srand( 4242 )  # set random seed - for deterministic

ordpunks.each_meta do |attributes, id|
  punk = ordpunks.generate( *saudied( *attributes ))

  punk.save( "./tmp2/saudi-#{id+1}.png" )
  punk.zoom(4).save( "./tmp2/saudi-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/saudis.png" )
composite.zoom(4).save( "./tmp/saudis@4x.png" )

puts "bye"
