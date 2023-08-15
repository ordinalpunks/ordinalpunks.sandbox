#####
#  to run use:
#    $   ruby ./visionpro.rb


require 'punks'


def visionpro( *attributes, id )
  base            = attributes[0]
  more_attributes = attributes[1..-1]

  ## quick fix:  frown not supported for now on female gold
  more_attributes = more_attributes.reject do |attr|
                                            ['Big Shades',
                                             '3D Glasses',
                                             'VR',
                                             'Clown Eyes Green',
                                             'Clown Eyes Blue',
                                             'Regular Shades',
                                             'Eye Patch',
                                             'Eye Mask',
                                             'Classic Shades',
                                             'Nerd Glasses',
                                             'Blue Eyeshadow',
                                             'Green Eye Shadow',
                                             'Heart Shades',
                                             'Laser Eyes',
                                            ].include?(attr)
                                           end

  punk = Punk::Image.generate( base, *more_attributes )
  punk

  if base.downcase.index( 'female')
    punk.compose!( Image.read( './more/visionpro-female.png') )
  else
    punk.compose!( Image.read( './more/visionpro-male.png') )
  end
  punk
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

  punk = visionpro( *attributes, id )

  punk.save( "./tmp2/visionpro-#{id+1}.png" )
  punk.zoom(4).save( "./tmp2/visionpro-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/visionpro.png" )
composite.zoom(4).save( "./tmp/visonpro@4x.png" )

puts "bye"
