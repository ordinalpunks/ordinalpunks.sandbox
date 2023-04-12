#####
#  to run use:
#    $   ruby ./gold.rb


require 'punks'


##
#  more new golden archetypes & attributes
GOLDEN_PATCH = {
  'robotmalegold1'   =>  Image.read( './robot-male_gold_1.png'),
  'robotfemalegold1' =>  Image.read( './robot-female_gold_1.png'),

  'vampiremalegold1'   =>  Image.read( './vampire-male_gold_1.png'),
  'vampirefemalegold1' =>  Image.read( './vampire-female_gold_1.png'),

  'orcmalegold1'   =>  Image.read( './orc-male_gold_1.png'),
  'orcfemalegold1' =>  Image.read( './orc-female_gold_1.png'),
  'orcmalegold3'   =>  Image.read( './orc-male_gold_3.png'),
  'orcfemalegold3' =>  Image.read( './orc-female_gold_3.png'),

  'mummymalegold1'   =>  Image.read( './mummy-male_gold_1.png'),
  'mummyfemalegold1' =>  Image.read( './mummy-female_gold_1.png'),
}


GOLDEN = {
  'Human Male 1'   => 'Male Gold 1',
  'Human Male 2'   => 'Male Gold 1',
  'Human Male 3'   => 'Male Gold 1',
  'Human Male 4'   => 'Male Yellow',
  'Human Male Orange' => 'Male Gold 1',
  'Human Male Blue'  => 'Male Gold 1',

  'Human Female 1' => 'Female Gold 1',
  'Human Female 2' => 'Female Gold 1',
  'Human Female 3' => 'Female Gold 1',
  'Human Female 4' => 'Female Yellow',
  'Human Female Orange' => 'Female Gold 1',
  'Human Female Purple' => 'Female Gold 1',
  'Human Female Blue'  => 'Female Gold 1',

  'Zombie Male'    => 'Zombie Gold 1',
  'Zombie Female'  => 'Zombie Female Gold 1',
  'Ape Male'       => 'Ape Gold 1',
  'Ape Male Blue'  =>  'Ape Gold 1',
  'Ape Female'    => 'Ape Female Gold 1',
  'Alien Male'        => 'Alien Gold 1',
  'Alien Male Green'  => 'Alien Gold 1',
  'Alien Female Red Magenta' => 'Alien Female Gold 1',
  'Alien Female Violet' => 'Alien Female Gold 1',
  'Alien Ape Male' => 'Alien Ape Yellow',

  "Demon Male"     =>  'Demon Gold 1',
  'Demon Female'   =>  'Demon Female Gold 1',

  'Skeleton Male'  =>  'Skeleton Gold 1',
  'Skeleton Female'  =>  'Skeleton Female Gold 1',

  "Robot Male"     =>  'Robot Male Gold 1',
  'Robot Female'   =>  'Robot Female Gold 1',

  "Vampire Male"     =>  'Vampire Male Gold 1',
  'Vampire Female'   =>  'Vampire Female Gold 1',

  "Orc Male"     =>  'Orc Male Gold 3',
  'Orc Female'   =>  'Orc Female Gold 3',

  "Mummy Male"     =>  'Mummy Male Gold 1',
  'Mummy Female'   =>  'Mummy Female Gold 1',

  'Zombie Ape Male'  => 'Ape Male Gold 1',   ## for now simple ape (NOT ape zombie)
 }



MISSING = Hash.new(0)


def golden( *attributes )
  more_attributes = attributes[1..-1]

  base_golden = GOLDEN[ attributes[0] ]

  if base_golden.nil?
    puts "!! WARN - >#{attributes[0]}< no golden base type mapping found; sorry"
    MISSING[ attributes[0] ] +=1  unless attributes[0].index('Gold') ||
                                         attributes[0].index('Yellow')
    base_golden = attributes[0]
  else
    puts "==> bingo!  >#{attributes[0]}< mapping to >#{base_golden}<..."
  end


  ## quick fix:  frown not supported for now on female gold
  more_attributes = more_attributes.reject do |attr|
                                            ['Frown', 'Smile'].include?(attr)
                                           end  if ['Female Gold 1',
                                                    'Female Gold 2',
                                                    'Female Gold 3'
                                                   ].include?(base_golden)

                                                                                  base_golden ==
  golden = Punk::Image.generate( base_golden, *more_attributes, patch: GOLDEN_PATCH )
  golden
end





####
#  read in ordinals metadata
recs = read_csv( "../../ordinalpunks.starter/ordinalpunks.csv" )
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




composite = ImageComposite.new( 10, 10 )


ids = (0..99)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  gold = golden( *attributes )

  composite << gold
end


composite.save( "./tmp/golden.png" )
composite.zoom(4).save( "./tmp/golden@4x.png" )


puts "missing mappings:"
pp MISSING

puts "bye"
