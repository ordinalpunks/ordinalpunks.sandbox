#####
#  to run use:
#    $   ruby ./men.rb



require 'punks'



##
#  more new men archetypes & attributes
MEN_PATCH = {
 'blondebob'     => Image.read( './more/m/blondebob.png' ),
 'blondeshort'   => Image.read( './more/m/blondeshort.png' ),
 'choker'        => Image.read( './more/m/choker.png' ),
 'darkhair'      => Image.read( './more/m/darkhair.png' ),
 'pilothelmet'   => Image.read( './more/m/pilothelmet.png' ),
 'tiara'         => Image.read( './more/m/tiara.png' ),
 'wildwhitehair' => Image.read( './more/m/wildwhitehair.png' ),
}





EXCLUDE = ['Black Lipstick',
           'Blue Eyeshadow', 'Green Eye Shadow']



def convert_to_punk( *attributes )

  attributes_new = []
  attributes.each do |attribute|

    ## note: remove attributes (not available in male version)
    next if EXCLUDE.include?( attribute )


    attribute = 'Boater'            if attribute == 'Flowers'
    attribute = 'Headband'           if attribute == 'Bow'


    attributes_new << attribute
  end

   attributes_new
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
  ## all male ;-)
  base = "#{type} Male"
  base << " #{skin_tone}"       unless skin_tone.empty?

  accessories = rec['accessories'].split( '/' ).map { |acc| acc.strip }

  ## note: convert/change/process only female accessories for now
  accessories = convert_to_punk( *accessories )   if gender == 'Female'

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

  punk = Punk::Image.generate( *attributes, patch: MEN_PATCH )

  punk.save( "./tmp/man-#{id+1}.png" )
  punk.zoom(4).save( "./tmp/man-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/men.png" )
composite.zoom(4).save( "./tmp/men@4x.png" )



puts "bye"
