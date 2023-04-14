#####
#  to run use:
#    $   ruby ./humans.rb


require 'punks'



HUMANS = {
"Human Male 1"      =>"Male M10",
"Human Male 2"      =>"Male M07",
"Human Male 3"      =>"Male M04",
"Human Male 4"      =>"Male M01",
"Human Male Orange" =>"Male M09",
"Human Male Blue"   =>"Male M08",
"Human Male Gold"   =>"Male M06",
 "Robot Male"       =>"Male M05",
 "Demon Male"       =>"Male M03",
 "Vampire Male"     =>"Male M02",
 "Zombie Male"      =>"Male M09",
 "Zombie Ape Male"  =>"Male M08",
 "Orc Male"         =>"Male M07",
 "Mummy Male"       =>"Male M06",
 "Skeleton Male"    =>"Male M05",
 "Ape Male Gold"    =>"Male M04",
 "Ape Male Blue"    =>"Male M03",
 "Alien Male Gold"  =>"Male M02",
 "Alien Male Yellow"=>"Male M04",
 "Alien Male Green" =>"Male M05",
 "Alien Ape Male"   =>"Male M06",

 "Human Female 1"   =>"Female M10",
 "Human Female 2"   =>"Female M07",
 "Human Female 3"   =>"Female M04",
 "Human Female 4"   =>"Female M01",
 "Human Female Orange"=>"Female M09",
 "Human Female Purple"=>"Female M08",
 "Human Female Blue"=>"Female M06",
 "Human Female Gold"=>"Female M05",
 "Human Female Yellow"=>"Female M03",
 "Orc Female"=>"Female M02",
 "Zombie Female"=>"Female M09",
 "Mummy Female"=>"Female M08",
 "Demon Female"=>"Female M07",
 "Skeleton Female"=>"Female M06",
 "Vampire Female"=>"Female M05",
 "Ape Female"=>"Female M04",
 "Robot Female"=>"Female M03",
 "Alien Female Violet"=>"Female M02",
 "Alien Female Red Magenta"=>"Female M05",
}


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
recs = read_csv( "../../ordinalpunks.starter/ordinalpunks.csv" )
puts "    #{recs.size} record(s)"


def rec_to_attributes( rec )
  type =      rec['type']
  gender =    rec['gender']
  skin_tone = rec['skin_tone']


  base = "#{type} #{gender}"
  base << " #{skin_tone}"       unless skin_tone.empty?

  ## convert to "classic" to "human"
  base = HUMANS[ base ]

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
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes )

  punk.save( "./tmp/human-#{id+1}.png" )
  punk.zoom(4).save( "./tmp/human-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/humans.png" )
composite.zoom(4).save( "./tmp/humans@4x.png" )



puts "bye"
