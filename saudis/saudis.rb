#####
#  to run use:
#    $   ruby ./saudis.rb


require 'punks'




def saudied( *attributes, id )
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

  saudi = Punk::Image.generate( base, *more_attributes )
  saudi
end





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



composite     = ImageComposite.new( 10, 10, background: '#006C35' )

ids = (0..99)
pp ids


srand( 4242 )  # set random seed - for deterministic

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = saudied( *attributes, id )
  punk.save( "./tmp2/saudi-#{id+1}.png" )
  punk.zoom(4).save( "./tmp2/saudi-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/saudis.png" )
composite.zoom(4).save( "./tmp/saudis@4x.png" )

puts "bye"
