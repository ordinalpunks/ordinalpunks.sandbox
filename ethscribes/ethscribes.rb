#####
#  to run use:
#    $   ruby ./ethscribes.rb


require 'punks'


##
#  more new ethscribed archetypes & attributes
ETHSCRIBED_PATCH = {
  'malegreen'   =>  Image.read( './more/male_green.png'),
  'femalegreen' =>  Image.read( './more/female_green.png'),

  'zombiemalegreen'   =>  Image.read( './more/zombie-male_green.png'),
  'zombiefemalegreen' =>  Image.read( './more/zombie-female_green.png'),

  'apemalegreen'   =>  Image.read( './more/ape-male_green.png'),
  'apefemalegreen' =>  Image.read( './more/ape-female_green.png'),

  'alienmalegreen'   =>  Image.read( './more/alien-male_green.png'),
  'alienfemalegreen' =>  Image.read( './more/alien-female_green.png'),

  'robotmalegreen'   =>  Image.read( './more/robot-male_green.png'),
  'robotfemalegreen' =>  Image.read( './more/robot-female_green.png'),

  'vampiremalegreen'   =>  Image.read( './more/vampire-male_green.png'),
  'vampirefemalegreen' =>  Image.read( './more/vampire-female_green.png'),

  'demonmalegreen'   =>  Image.read( './more/demon-male_green.png'),
  'demonfemalegreen' =>  Image.read( './more/demon-female_green.png'),

  'orcmalegreen'   =>  Image.read( './more/orc-male_green.png'),
  'orcfemalegreen' =>  Image.read( './more/orc-female_green.png'),

  'skeletonmalegreen'   =>  Image.read( './more/skeleton-male_green.png'),
  'skeletonfemalegreen' =>  Image.read( './more/skeleton-female_green.png'),

  'mummymalegreen'   =>  Image.read( './more/mummy-male_green.png'),
  'mummyfemalegreen' =>  Image.read( './more/mummy-female_green.png'),
}



ETHSCRIBED = {
  'Human Male 1'   => 'Male Green',
  'Human Male 2'   => 'Male Green',
  'Human Male 3'   => 'Male Green',
  'Human Male 4'   => 'Male Green',
  'Human Male Orange' => 'Male Green',
  'Human Male Blue'  => 'Male Green',
  "Human Male Gold"  => 'Male Green',

  'Human Female 1' => 'Female Green',
  'Human Female 2' => 'Female Green',
  'Human Female 3' => 'Female Green',
  'Human Female 4' => 'Female Green',
  'Human Female Orange' => 'Female Green',
  'Human Female Purple' => 'Female Green',
  'Human Female Blue'  => 'Female Green',
  "Human Female Gold"   => 'Female Green',
  "Human Female Yellow" => 'Female Green',

  'Zombie Male'    => 'Zombie Male Green',
  'Zombie Female'  => 'Zombie Female Green',

  'Ape Male'       => 'Ape Male Green',
  'Ape Male Blue'  =>  'Ape Male Green',
  'Ape Male Gold'  =>  'Ape Male Green',
  'Ape Female'    => 'Ape Female Green',

  'Alien Male'        => 'Alien Male Green',
  'Alien Male Green'  => 'Alien Male Green',
  "Alien Male Gold"   => 'Alien Male Green',
  "Alien Male Yellow" => 'Alien Male Green',
  'Alien Female Red Magenta' => 'Alien Female Green',
  'Alien Female Violet' => 'Alien Female Green',
  'Alien Ape Male' => 'Alien Male Green',    ## for now simple alien (NOT alien ape)

  "Demon Male"     =>  'Demon Male Green',
  'Demon Female'   =>  'Demon Female Green',

  'Skeleton Male'  =>  'Skeleton Male Green',
  'Skeleton Female'  =>  'Skeleton Female Green',

  "Robot Male"     =>  'Robot Male Green',
  'Robot Female'   =>  'Robot Female Green',

  "Vampire Male"     =>  'Vampire Male Green',
  'Vampire Female'   =>  'Vampire Female Green',

  "Orc Male"     =>  'Orc Male Green',
  'Orc Female'   =>  'Orc Female Green',

  "Mummy Male"     =>  'Mummy Male Green',
  'Mummy Female'   =>  'Mummy Female Green',

  'Zombie Ape Male'  => 'Ape Male Green',   ## for now simple ape (NOT ape zombie)
 }



MISSING = Hash.new(0)



def ethscribed( *attributes )
  more_attributes = attributes[1..-1]

  base_green = ETHSCRIBED[ attributes[0] ]

  if base_green.nil?
    puts "!! WARN - >#{attributes[0]}< no ethscribed base type mapping found; sorry"
    MISSING[ attributes[0] ] +=1
    base_green = attributes[0]
  else
    puts "==> bingo!  >#{attributes[0]}< mapping to >#{base_green}<..."
  end


  ## quick fix:  frown not supported for now on female gold
  more_attributes = more_attributes.reject do |attr|
                                            ['Frown', 'Smile'].include?(attr)
                                           end if ['Female Green'].include?(base_green)


  ethscribed = Punk::Image.generate( base_green, *more_attributes, patch: ETHSCRIBED_PATCH )
  ethscribed
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




composite     = ImageComposite.new( 10, 10 )

ids = (0..99)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = ethscribed( *attributes )
  punk.save( "./tmp2/ethscribe-#{id+1}.png" )
  punk.zoom(4).save( "./tmp2/ethscribe-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/ethscribes.png" )
composite.zoom(4).save( "./tmp/ethscribes@4x.png" )


puts "missing mappings:"
pp MISSING

puts "bye"
