require 'punks'



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

  accessories = rec['accessories'].split( '/' ).map { |acc| acc.strip }

  attributes = [base] + accessories
  attributes
end



stats = Hash.new( 0 )

ids = (0..99)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  stats[ attributes[0] ] += 1
end

puts "types:"
pp stats


puts "bye"

__END__

types:
{"Robot Male"=>3,
 "Human Male 2"=>7,
 "Human Female 1"=>4,
 "Demon Male"=>4,
 "Ape Male Blue"=>1,
 "Human Male 3"=>3,
 "Human Male 1"=>7,
 "Vampire Male"=>3,
 "Human Female Orange"=>2,
 "Human Female 3"=>6,
 "Zombie Male"=>3,
 "Orc Male"=>3,
 "Human Female 4"=>3,
 "Human Male Orange"=>3,
 "Human Male 4"=>8,
 "Zombie Ape Male"=>1,
 "Alien Male Gold"=>2,
 "Human Male Blue"=>3,
 "Human Female 2"=>3,
 "Mummy Male"=>2,
 "Skeleton Male"=>2,
 "Orc Female"=>2,
 "Zombie Female"=>3,
 "Mummy Female"=>2,
 "Demon Female"=>3,
 "Human Female Purple"=>1,
 "Human Male Gold"=>1,
 "Alien Ape Male"=>2,
 "Human Female Blue"=>1,
 "Alien Female Red Magenta"=>1,
 "Skeleton Female"=>1,
 "Vampire Female"=>2,
 "Ape Female"=>1,
 "Alien Male Yellow"=>1,
 "Human Female Gold"=>1,
 "Robot Female"=>1,
 "Alien Female Violet"=>1,
 "Alien Male Green"=>1,
 "Human Female Yellow"=>1,
 "Ape Male Gold"=>1}


