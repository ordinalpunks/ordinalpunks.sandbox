#####
#  to run use:
#    $   ruby ./marilyns.rb



require 'punks'


##
#  more new punkette archetypes & attributes
##  note: use zombie ape and alien ape  !!!!  (in key lookup)
PUNKETTE_PATCH = {
  'apefemaleblue'     =>  Image.read( '../more/ape-female-blue.png'),
  'zombieapefemale'   =>  Image.read( '../more/ape-zombie-female.png'),
  'alienapefemale'    =>  Image.read( '../more/ape-alien-female.png'),
}



BEARD =  [ 'Big Beard', 'Front Beard Dark', 'Handlebars', 'Front Beard',
              'Chinstrap',
              'Goat',
              'Muttonchops',
              'Luxurious Beard',
              'Mustache',
              'Normal Beard Black', 'Normal Beard',
              'Shadow Beard' ]


EXCLUDE = BEARD + ['Buck Teeth']

def convert_to_marilyn( *attributes )

  attributes_new = []
  attributes.each do |attribute|

    ## note: remove all beard (facial hair) + buck teeth attributes
    next if EXCLUDE.include?( attribute )

    next if ['Hoodie',
             'Cowboy Hat',
             'Cap Burger King',
             'Wild White Hair',
             'Beanie',
             'Pilot Helmet',
             'Police Cap',
             'Knitted Cap',
             'Top Hat',
             'Clown Hair Blue',
             'Do-Rag',
             'Crazy Hair',
             'Cap Red',
             'Messy Hair',
             'Fedora',
             'Clown Hair Green',
             'Blonde Bob',
             'Bandana',
             'Frumpy Hair',
             'Cap Forward',
             'Cap',
             'Dark Hair',
            ].include?( attribute )

    attributes_new << attribute
  end

   attributes_new

   ['Wild Blonde'] + attributes_new
end




####
#  read in ordinals metadata
recs = read_csv( "../ordinalpunks_v2.csv" )
puts "    #{recs.size} record(s)"


def rec_to_attributes( rec )
  type =      rec['type']
  gender =    rec['gender']
  skin_tone = rec['skin_tone']


  # note: merge type+gender+skin_tone into one attribute
  ## all female ;-)
  base = "#{type} Female"
  base << " #{skin_tone}"       unless skin_tone.empty?

  accessories = rec['accessories'].split( '/' ).map { |acc| acc.strip }

  accessories = convert_to_marilyn( *accessories )

  attributes = [base] + accessories

  ## note: auto-add demon horns on top for all demons - why? why not?
  attributes << 'Demon Horns'    if type == 'Demon'


  ## not yet supported - smile for alien, ....'
  attributes = attributes.reject { |attr| attr=='Smile' }   if type == 'Alien'

  attributes
end



composite = ImageComposite.new( 10, 10, width:  24,
                                        height: 24 )


ids = (0..99)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes, patch: PUNKETTE_PATCH )

  punk.save( "./tmp/marilyn-#{id+1}.png" )
  punk.zoom(4).save( "./tmp/marilyn-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/marilyns.png" )
composite.zoom(4).save( "./tmp/marilyns@4x.png" )



puts "bye"
