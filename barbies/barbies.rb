#####
#  to run use:
#    $   ruby ./barbies.rb



require 'punks'



BARBIES_PATCH = {
  'humanfemalepink'    =>  Image.read( './more/female_deeppink.png'),
  'zombiefemalepink'   =>  Image.read( './more/zombie-female_deeppink.png'),
  'apefemalepink'      =>  Image.read( './more/ape-female_deeppink.png'),
  'alienfemalepink'    =>  Image.read( './more/alien-female_deeppink.png'),
  'robotfemalepink'    =>  Image.read( './more/robot-female_deeppink.png'),
  'vampirefemalepink'  =>  Image.read( './more/vampire-female_deeppink.png'),
  'demonfemalepink'    =>  Image.read( './more/demon-female_deeppink.png'),
  'orcfemalepink'      =>  Image.read( './more/orc-female_deeppink.png'),
  'skeletonfemalepink' =>  Image.read( './more/skeleton-female_deeppink.png'),
  'mummyfemalepink'    =>  Image.read( './more/mummy-female_deeppink.png'),

  'demonhorns'   =>  Image.read( './more/demon_horns-female_deeppink.png'),

  'blondeside'           =>  Image.read( './more/blondeside.png'),
  'straighthairblonde2'  =>  Image.read( './more/straighthairblonde2.png'),
  'pigtails2'            =>  Image.read( './more/pigtails2.png'),
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

def convert_to_barbie( *attributes )

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

   # ['Blonde Side'] 
   ['Pig Tails 2'] + attributes_new
end




####
#  read in ordinals metadata
recs = read_csv( "../ordinalpunks_v2.csv" )
puts "    #{recs.size} record(s)"


def rec_to_attributes( rec )
  type =      rec['type']
  gender =    rec['gender']
  skin_tone = rec['skin_tone']


  type = 'Zombie'  if type == 'Zombie Ape'
  type = 'Ape'     if type == 'Alien Ape'


  # note: merge type+gender+skin_tone into one attribute
  ## all female ;-)
  base = "#{type} Female Pink"
 
  accessories = rec['accessories'].split( '/' ).map { |acc| acc.strip }

  accessories = convert_to_barbie( *accessories )

  attributes = [base] + accessories

  ## note: auto-add demon horns on top for all demons - why? why not?
  attributes << 'Demon Horns'    if type == 'Demon'


  ## not yet supported - smile and frown for barbies
  attributes = attributes.reject { |attr| ['Smile', 'Frown'].include?(attr) }  

  attributes
end



composite = ImageComposite.new( 10, 10, width:  24,
                                        height: 24 )


ids = (0..99)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes, patch: BARBIES_PATCH )

  punk.save( "./tmp/barbie-#{id+1}.png" )
  punk.zoom(4).save( "./tmp/barbie-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/barbies.png" )
composite.zoom(4).save( "./tmp/barbies@4x.png" )



puts "bye"
