#####
#  to run use:
#    $   ruby ./apes.rb


require 'punks'


##
#  more new ape archetypes
APES_PATCH = {
  'apedemonmale'    =>  Image.read( '../more/ape-demon-male.png' ),
  'apeorcmale'      =>  Image.read( '../more/ape-orc-male.png' ),
  'aperobotmale'    =>  Image.read( '../more/ape-robot-male.png' ),
  'apevampiremale'  =>  Image.read( '../more/ape-vampire-male.png' ),
  'apezombiemale'   =>  Image.read( '../more/ape-zombie-male.png' ),

  'apedemonfemale'    =>  Image.read( '../more/ape-demon-female.png' ),
  'apeorcfemale'      =>  Image.read( '../more/ape-orc-female.png' ),
  'aperobotfemale'    =>  Image.read( '../more/ape-robot-female.png' ),
  'apevampirefemale'  =>  Image.read( '../more/ape-vampire-female.png' ),
  'apezombiefemale'   =>  Image.read( '../more/ape-zombie-female.png' ),

  'apefemaledmt'       =>  Image.read( '../more/ape-female-dmt.png' ),
  'apefemalecheetah'   =>  Image.read( '../more/ape-female-cheetah.png' ),
  'apefemaleblack'     =>  Image.read( '../more/ape-female-black.png' ),
  'apefemaleblue'     =>  Image.read( '../more/ape-female-blue.png' ),
  'apefemaledarkbrown' =>  Image.read( '../more/ape-female-dark_brown.png' ),
  'apefemalebrown'     =>  Image.read( '../more/ape-female-brown.png' ),
  'apefemalecream'     =>  Image.read( '../more/ape-female-cream.png' ),
  'apefemalewhite'     =>  Image.read( '../more/ape-female-white.png' ),
  'apefemaletrippy'     =>  Image.read( '../more/ape-female-trippy.png' ),
  'apefemalesolidgold'  =>  Image.read( '../more/ape-female-solid_gold.png' ),
  'apealienfemale330'   =>  Image.read( '../more/ape-alien-female-330.png' ),
  'apealienfemale270'   =>  Image.read( '../more/ape-alien-female-270.png' ),

}



APES = {
  'Human Male 1'      => 'Ape Male Black',
  'Human Male 2'      => 'Ape Male Dark Brown',
  'Human Male 3'      => 'Ape Male Brown',
  'Human Male 4'      => 'Ape Male Cream',
  'Human Male Orange' => 'Ape Male Cheetah',
  'Human Male Blue'   => 'Ape Male Blue',
  'Human Male Gold'   => 'Ape Male Solid Gold',


  'Human Female 1' => 'Ape Female Black',
  'Human Female 2' => 'Ape Female Dark Brown',
  'Human Female 3' => 'Ape Female Brown',
  'Human Female 4' => 'Ape Female Cream',
  'Human Female Orange' => 'Ape Female Cheetah',
  'Human Female Purple' => 'Ape Female DMT',
  'Human Female Blue'  => 'Ape Female Blue',
  'Human Female Gold'  => 'Ape Female Solid Gold',
  'Human Female Yellow'=> 'Ape Female Solid Gold',

  'Zombie Male'    => 'Ape Zombie Male',
  'Zombie Female'  => 'Ape Zombie Female',
   'Ape Male'       => 'Ape Male',
   'Ape Male Blue'  =>  'Ape Male Blue',
   'Ape Male Gold'  =>  'Ape Male Solid Gold',
   'Ape Female'    => 'Ape Female',

  'Alien Male'        => 'Alien Ape Male',
  'Alien Male Green'  => 'Alien Ape Male 120',
  'Alien Male Gold'   => 'Alien Ape Male 60',
  'Alien Male Yellow' => 'Alien Ape Male 60',

  'Alien Female Red Magenta' => 'Ape Alien Female 330',
  'Alien Female Violet' => 'Ape Alien Female 270',
  'Alien Ape Male' => 'Alien Ape Male',

  'Demon Male'     =>  'Ape Demon Male',
  'Demon Female'   =>  'Ape Demon Female',

  'Skeleton Male'  =>  'Ape Male White',
  'Skeleton Female'  =>  'Ape Female White',

  'Robot Male'     =>  'Ape Robot Male',
  'Robot Female'   =>  'Ape Robot Female',

  'Vampire Male'     =>  'Ape Vampire Male',
  'Vampire Female'   =>  'Ape Vampire Female',

  'Orc Male'     =>  'Ape Orc Male',
  'Orc Female'   =>  'Ape Orc Female',

  'Mummy Male'     =>  'Ape Male Trippy',
  'Mummy Female'   =>  'Ape Female Trippy',

  'Zombie Ape Male'  => 'Zombie Ape Male',
 }



MISSING = Hash.new(0)


def apein( *attributes )
  more_attributes = attributes[1..-1]

  base_ape = APES[ attributes[0] ]

  if base_ape.nil?
    puts "!! WARN - >#{attributes[0]}< no ape base type mapping found; sorry"
    MISSING[ attributes[0] ] +=1
    base_ape = attributes[0]
  else
    puts "==> bingo!  >#{attributes[0]}< mapping to >#{base_ape}<..."
  end

  ## quick fix:  frown not supported for now on female gold
  more_attributes = more_attributes.reject do |attr|
    ['Frown', 'Smile'].include?(attr)
   end  if ['Ape Female',
            'Ape Female Black',
            'Ape Female Cheetah',
            'Ape Female DMT',
            'Ape Female Blue',
            'Ape Female Dark Brown',
            'Ape Female Brown',
            'Ape Female Cream',
           ].include?(base_ape)


  ape = Punk::Image.generate( base_ape, *more_attributes, patch: APES_PATCH )
  ape
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




composite = ImageComposite.new( 10, 10 )


ids = (0..99)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  ape = apein( *attributes )

  ape.save( "./tmp/ape-#{id+1}.png" )
  ape.zoom(4).save( "./tmp/ape-#{id+1}@4x.png" )

  composite << ape
end


composite.save( "./tmp/apes.png" )
composite.zoom(4).save( "./tmp/apes@4x.png" )


puts "missing mappings:"
pp MISSING

puts "bye"
