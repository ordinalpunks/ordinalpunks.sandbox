#####
#  to run use:
#    $   ruby ./bitmap.rb


require 'punks'


##
#  more new bitmap archetypes & attributes
BITMAP_PATCH = {
  'male1'     =>  Image.read( './male1.png'),
  'male2'     =>  Image.read( './male2.png'),

  'female1'   =>  Image.read( './female1.png'),
}



BITMAP = {
  'Human Male 1'      => 'Male 1',
  'Human Male 2'      => 'Male 1',
  'Human Male 3'      => 'Male 1',
  'Human Male 4'      => 'Male 1',
  'Human Male Orange' => 'Male 1',
  'Human Male Blue'   => 'Male 1',
  'Human Male Gold'   => 'Male 1',

  'Human Female 1' => 'Female 1',
  'Human Female 2' => 'Female 1',
  'Human Female 3' => 'Female 1',
  'Human Female 4' => 'Female 1',
  'Human Female Orange' => 'Female 1',
  'Human Female Purple' => 'Female 1',
  'Human Female Blue'  => 'Female 1',
  'Human Female Gold'  => 'Female 1',
  'Human Female Yellow'=> 'Female 1',

  'Zombie Male'    => 'Male 1',
  'Zombie Female'  => 'Female 1',
  'Ape Male'       => 'Male 1',
  'Ape Male Blue'  =>  'Male 1',
  'Ape Male Gold'  =>  'Male 1',
  'Ape Female'    => 'Female 1',

  'Alien Male'        => 'Male 1',
  'Alien Male Green'  => 'Male 1',
  'Alien Male Gold'   => 'Male 1',
  'Alien Male Yellow' => 'Male 1',

  'Alien Female Red Magenta' => 'Female 1',
  'Alien Female Violet' => 'Female 1',
  'Alien Ape Male' => 'Male 1',

  'Demon Male'     =>  'Male 1',
  'Demon Female'   =>  'Female 1',

  'Skeleton Male'  =>  'Male 1',
  'Skeleton Female'  =>  'Female 1',

  'Robot Male'     =>  'Male 1',
  'Robot Female'   =>  'Female 1',

  'Vampire Male'     =>  'Male 1',
  'Vampire Female'   =>  'Female 1',

  'Orc Male'     =>  'Male 1',
  'Orc Female'   =>  'Female 1',

  'Mummy Male'     =>  'Male 1',
  'Mummy Female'   =>  'Female 1',

  'Zombie Ape Male'  => 'Male 1',   ## for now simple ape (NOT ape zombie)
 }



MISSING = Hash.new(0)


def bitmap( *attributes )
  more_attributes = attributes[1..-1]

  base = BITMAP[ attributes[0] ]

  if base.nil?
    puts "!! WARN - >#{attributes[0]}< no bitmap base type mapping found; sorry"
    MISSING[ attributes[0] ] +=1
    base = attributes[0]
  else
    puts "==> bingo!  >#{attributes[0]}< mapping to >#{base}<..."
  end


  ## quick fix:  frown not supported for now on female gold
  more_attributes = more_attributes.reject do |attr|
                                            ['Frown', 'Smile'].include?(attr)
                                           end  if ['Female 1'
                                                   ].include?(base)

                                                                              
  bitmap = Punk::Image.generate( base, *more_attributes, patch: BITMAP_PATCH )
  bitmap
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

  bitmap = bitmap( *attributes )

  bitmap.save( "./tmp/bitmap-#{id+1}.png" )
  bitmap.zoom(4).save( "./tmp/bitmap-#{id+1}@4x.png" )

  composite << bitmap
end


composite.save( "./tmp/bitmap.png" )
composite.zoom(4).save( "./tmp/bitmap@4x.png" )


puts "missing mappings:"
pp MISSING

puts "bye"
