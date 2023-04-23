#####
#  to run use:
#    $   ruby ./orangepill.rb


require 'punks'


##
#  more new orange pill archetypes & attributes
ORANGEPILL_PATCH = {
  'maleorange'   =>  Image.read( './more/male_orange.png'),
  'femaleorange' =>  Image.read( './more/female_orange.png'),

  'zombiemaleorange'   =>  Image.read( './more/zombie-male_orange.png'),
  'zombiefemaleorange' =>  Image.read( './more/zombie-female_orange.png'),

  'apemaleorange'   =>  Image.read( './more/ape-male_orange.png'),
  'apefemaleorange' =>  Image.read( './more/ape-female_orange.png'),

  'alienmaleorange'   =>  Image.read( './more/alien-male_orange.png'),
  'alienfemaleorange' =>  Image.read( './more/alien-female_orange.png'),

  'robotmaleorange'   =>  Image.read( './more/robot-male_orange.png'),
  'robotfemaleorange' =>  Image.read( './more/robot-female_orange.png'),

  'vampiremaleorange'   =>  Image.read( './more/vampire-male_orange.png'),
  'vampirefemaleorange' =>  Image.read( './more/vampire-female_orange.png'),

  'demonmaleorange'   =>  Image.read( './more/demon-male_orange.png'),
  'demonfemaleorange' =>  Image.read( './more/demon-female_orange.png'),

  'orcmaleorange'   =>  Image.read( './more/orc-male_orange.png'),
  'orcfemaleorange' =>  Image.read( './more/orc-female_orange.png'),

  'skeletonmaleorange'   =>  Image.read( './more/skeleton-male_orange.png'),
  'skeletonfemaleorange' =>  Image.read( './more/skeleton-female_orange.png'),

  'mummymaleorange'   =>  Image.read( './more/mummy-male_orange.png'),
  'mummyfemaleorange' =>  Image.read( './more/mummy-female_orange.png'),
}



ORANGEPILL = {
  'Human Male 1'   => 'Male Orange',
  'Human Male 2'   => 'Male Orange',
  'Human Male 3'   => 'Male Orange',
  'Human Male 4'   => 'Male Orange',
  'Human Male Orange' => 'Male Orange',
  'Human Male Blue'  => 'Male Orange',
  "Human Male Gold"  => 'Male Orange',

  'Human Female 1' => 'Female Orange',
  'Human Female 2' => 'Female Orange',
  'Human Female 3' => 'Female Orange',
  'Human Female 4' => 'Female Orange',
  'Human Female Orange' => 'Female Orange',
  'Human Female Purple' => 'Female Orange',
  'Human Female Blue'  => 'Female Orange',
  "Human Female Gold"   => 'Female Orange',
  "Human Female Yellow" => 'Female Orange',

  'Zombie Male'    => 'Zombie Male Orange',
  'Zombie Female'  => 'Zombie Female Orange',

  'Ape Male'       => 'Ape Male Orange',
  'Ape Male Blue'  =>  'Ape Male Orange',
  'Ape Male Gold'  =>  'Ape Male Orange',
  'Ape Female'    => 'Ape Female Orange',

  'Alien Male'        => 'Alien Male Orange',
  'Alien Male Green'  => 'Alien Male Orange',
  "Alien Male Gold"   => 'Alien Male Orange',
  "Alien Male Yellow" => 'Alien Male Orange',
  'Alien Female Red Magenta' => 'Alien Female Orange',
  'Alien Female Violet' => 'Alien Female Orange',
  'Alien Ape Male' => 'Alien Male Orange',    ## for now simple alien (NOT alien ape)

  "Demon Male"     =>  'Demon Male Orange',
  'Demon Female'   =>  'Demon Female Orange',

  'Skeleton Male'  =>  'Skeleton Male Orange',
  'Skeleton Female'  =>  'Skeleton Female Orange',

  "Robot Male"     =>  'Robot Male Orange',
  'Robot Female'   =>  'Robot Female Orange',

  "Vampire Male"     =>  'Vampire Male Orange',
  'Vampire Female'   =>  'Vampire Female Orange',

  "Orc Male"     =>  'Orc Male Orange',
  'Orc Female'   =>  'Orc Female Orange',

  "Mummy Male"     =>  'Mummy Male Orange',
  'Mummy Female'   =>  'Mummy Female Orange',

  'Zombie Ape Male'  => 'Ape Male Orange',   ## for now simple ape (NOT ape zombie)
 }



MISSING = Hash.new(0)


def orangepill( *attributes )
  more_attributes = attributes[1..-1]

  base_orange = ORANGEPILL[ attributes[0] ]

  if base_orange.nil?
    puts "!! WARN - >#{attributes[0]}< no orange pill base type mapping found; sorry"
    MISSING[ attributes[0] ] +=1
    base_orange = attributes[0]
  else
    puts "==> bingo!  >#{attributes[0]}< mapping to >#{base_orange}<..."
  end


  ## quick fix:  frown not supported for now on female gold
  more_attributes = more_attributes.reject do |attr|
                                            ['Frown', 'Smile'].include?(attr)
                                           end  if ['Female Orange',
                                                    'Female Orange',
                                                    'Female Orange'
                                                   ].include?(base_orange)

                                                                                  base_orange ==
  orangepill = Punk::Image.generate( base_orange, *more_attributes, patch: ORANGEPILL_PATCH )
  orangepill
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



BITCOIN_TILE = Image.read( "./bitcoin-24x24.png" )


composite     = ImageComposite.new( 10, 10 )
composite_ii  = ImageComposite.new( 10, 10 )

ids = (0..99)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = orangepill( *attributes )
  punk.save( "./tmp2/orangepill-#{id+1}.png" )
  punk.zoom(4).save( "./tmp2/orangepill-#{id+1}@4x.png" )

  composite << punk

  punk_ii = punk.background( BITCOIN_TILE )
  punk_ii.save( "./tmp2/orangepill_ii-#{id+1}.png" )
  punk_ii.zoom(4).save( "./tmp2/orangepill_ii-#{id+1}@4x.png" )

  composite_ii << punk_ii
end


composite.save( "./tmp/orangepilled.png" )
composite.zoom(4).save( "./tmp/orangepilled@4x.png" )

composite_ii.save( "./tmp/orangepilled_ii.png" )
composite_ii.zoom(4).save( "./tmp/orangepilled_ii@4x.png" )


puts "missing mappings:"
pp MISSING

puts "bye"
