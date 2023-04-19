#####
#  to run use:
#    $   ruby ./humans.rb


require 'punks'



EXCLUDE_FEMALE = ['Frown', 'Smile']
EXCLUDE_MALE   = ['Demon Horns']

def convert_to_human( *attributes, gender: )

  attributes_new = []
  attributes.each do |attribute|
    ## note: remove attributes (not available in female version)
    next if (gender == 'Female' && EXCLUDE_FEMALE.include?( attribute )) ||
            (gender == 'Male'   && EXCLUDE_MALE.include?( attribute ))

    attributes_new << attribute
  end

   attributes_new
end



####
#  read in ordinals metadata
recs = read_csv( "../ordinalpunks_v2.csv" )
puts "    #{recs.size} record(s)"


def rec_to_attributes( rec, id: )   ## note: index starting at 0 (not 1)
  type =      rec['type']
  gender =    rec['gender']
  skin_tone = rec['skin_tone']


  base = "#{type} #{gender}"
  base << " #{skin_tone}"       unless skin_tone.empty?

  ## convert to "classic" to "human"
  ## base = HUMANS[ base ]
  monk_skin_tone =  'M%02d' % ((id % 10)+1)
  base = "#{gender} #{monk_skin_tone}"

  accessories = rec['accessories'].split( '/' ).map { |acc| acc.strip }

  accessories = convert_to_human( *accessories, gender: gender )

  attributes = [base] + accessories
  attributes
end



composite = ImageComposite.new( 10, 10, width:  24,
                                        height: 24 )


ids = (0..99)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id], id: id )
  pp attributes

  punk = Punk::Image.generate( *attributes )

  punk.save( "./tmp/human-#{id+1}.png" )
  punk.zoom(4).save( "./tmp/human-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/humans.png" )
composite.zoom(4).save( "./tmp/humans@4x.png" )



puts "bye"
