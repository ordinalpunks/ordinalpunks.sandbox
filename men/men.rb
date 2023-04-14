#####
#  to run use:
#    $   ruby ./men.rb



require 'punks'


EXCLUDE = ['Choker', 'Black Lipstick', 'Blue Eyeshadow', 'Green Eye Shadow']



def convert_to_punk( *attributes )

  attributes_new = []
  attributes.each do |attribute|

    ## note: remove attributes (not available in male version)
    next if EXCLUDE.include?( attribute )

    attribute = 'Big Hair White'    if attribute == 'Wild White Hair'
    attribute = 'Big Hair Blonde'    if attribute == 'Blonde Bob'
    attribute = 'Blonde Afro'       if attribute == 'Blonde Short'
    attribute = 'Big Hair Black'       if attribute == 'Dark Hair'


    attribute = 'Wizard Hat'        if attribute == 'Flowers'
    attribute = 'Boater'            if attribute == 'Pilot Helmet'
    attribute = 'Top Hat'           if attribute == 'Bow'
    attribute = 'Headband'          if attribute == 'Tiara'


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

  punk = Punk::Image.generate( *attributes )

  punk.save( "./tmp/man-#{id+1}.png" )
  punk.zoom(4).save( "./tmp/man-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/men.png" )
composite.zoom(4).save( "./tmp/men@4x.png" )



puts "bye"
