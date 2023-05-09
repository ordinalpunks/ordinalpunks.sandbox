#####
#  to run use:
#    $   ruby ./lasereyes.rb


require 'punks'


def lasereyed( *attributes, id )
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
                                            ].include?(attr)
                                           end

  has_lasereyes = more_attributes.find { |attr| attr=='Laser Eyes' }


  unless has_lasereyes
     laser =  if id % 6 == 0
                  'Laser Eyes Gold'
              elsif [20,34,77].include?( id )
                  'Laser Eyes Blue'
              else
                  'Laser Eyes'
              end
      more_attributes << laser
  end

  lasereyed = Punk::Image.generate( base, *more_attributes )
  lasereyed
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

  punk = lasereyed( *attributes, id )
  punk.save( "./tmp2/lasereyed-#{id+1}.png" )
  punk.zoom(4).save( "./tmp2/lasereyed-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/lasereyed.png" )
composite.zoom(4).save( "./tmp/lasereyed@4x.png" )

puts "bye"
