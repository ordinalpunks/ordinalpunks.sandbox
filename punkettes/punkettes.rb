#####
#  to run use:
#    $   ruby ./punkettes.rb



require 'punks'


##
#  more new punkette archetypes & attributes
PUNKETTE_PATCH = {
  'apefemaleblue'     =>  Image.read( './ape-female-blue.png'),
  'zombieapefemale'   =>  Image.read( './zombie-ape-female.png'),
  'alienapefemale'    =>  Image.read( './alien-ape-female.png'),
}



BEARD =  [ 'Big Beard', 'Front Beard Dark', 'Handlebars', 'Front Beard',
              'Chinstrap',
              'Goat',
              'Muttonchops',
              'Luxurious Beard',
              'Mustache',
              'Normal Beard Black', 'Normal Beard',
              'Shadow Beard' ]


EXCLUDE = BEARD + ['Buck Teeth'] + ['Smile']   ## no smile for Alien Female Yellow ...


def convert_to_punkette( *attributes )

  attributes_new = []
  attributes.each do |attribute|

    ## note: remove all beard (facial hair) + buck teeth attributes
    next if EXCLUDE.include?( attribute )

    attribute = 'Cowboy Hat'   if attribute == 'Cowboy Hat B & W'
    attribute = 'Beanie'       if attribute == 'Beanie B & W'
    attribute = 'Police Cap'   if attribute == 'Police Cap B & W'
    attribute = '3D Glasses'   if attribute == '3D Glasses B & W'
    attribute = 'Fedora'       if attribute == 'Fedora B & W'
    attribute = 'Cap Forward'  if attribute == 'Cap Forward B & W'

    attributes_new << attribute
  end

   attributes_new
end




####
#  read in ordinals metadata
recs = read_csv( "../../ordinalpunks.starter/ordinalpunks.csv" )
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

  ## note: convert/change/process only male accessories for now
  accessories = convert_to_punkette( *accessories )   if gender == 'Male'

  attributes = [base] + accessories
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

  composite << punk
end


composite.save( "./tmp/punkettes.png" )
composite.zoom(4).save( "./tmp/punkettes@4x.png" )



puts "bye"
