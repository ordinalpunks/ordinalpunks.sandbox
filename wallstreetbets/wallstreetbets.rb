#####
#  to run use:
#    $   ruby ./wallstreetbets.rb



require 'punks'



##
#  more new wallstreetbets attributes
WALLSTREET_PATCH = {
 ## more attributes
 'choker'        => Image.read( '../more/m/choker.png' ),
}



EXCLUDE = [     ## women-only attributes not supported or converted
           'Blue Eyeshadow', 'Green Eye Shadow'] +
          ['Birthday Hat',
           'Cowboy Hat',
           'Beanie',
           'Fedora',
           'Bandana',
          ]    ## headwear attributes



def convert_to_wallstreet( *attributes )

  has_hair = false

  attributes_new = []
  attributes.each do |attribute|

    next if EXCLUDE.include?( attribute )

    ## change lipstick to beard - why? why not?
    if attribute == 'Black Lipstick'
      attribute = 'Luxurious Beard'   ## black
    end

    if attribute == 'Blonde Short'
       has_hair = true
       attribute = 'Wallstreetbets Hair 1'   # 1-short
    elsif attribute == 'Wild White Hair' ||
          attribute == 'Blonde Bob'
      has_hair = true
      attribute = 'Wallstreetbets Hair 2'   # 2-wild
    elsif attribute == 'Clown Hair Blue' ||
          attribute == 'Clown Hair Green' ||
          attribute == 'Messy Hair' ||
          attribute == 'Dark Hair'  ||
          attribute == 'Frumpy Hair'
          has_hair = true
          attribute = 'Wallstreetbets Hair Dark 2'
    else
    end

    ## change headwear to hair
    if attribute == 'Crown' ||
       attribute == 'Tiara' ||
       attribute == 'Cap Burger King'
          has_hair = true
         attribute = 'Wallstreetbets Hair 2'
    elsif attribute == 'Do-Rag' ||
          attribute == 'Demon Horns' ||
          attribute == 'Flowers' ||
          attribute == 'Cap Forward'  ||
          attribute == 'Knitted Cap' ||
          attribute == 'Police Cap'  ||
          attribute == 'Cap Red' ||
          attribute == 'Cap'
             has_hair = true
             attribute = 'Wallstreetbets Hair Dark 1'
    elsif attribute == 'Top Hat' || attribute == 'Hoodie' ||
          attribute == 'Crazy Hair' ||
          attribute == 'Bow' ||
          attribute == 'Sombrero' ||
          attribute == 'Jester Hat' ||
          attribute == 'Pilot Helmet'
            has_hair = true
            attribute = 'Wallstreetbets Hair Dark 2'
    else
    end

    attributes_new << attribute
  end


  if has_hair
    attributes_new
  else
     ## note: let hair go first
    ['Wallstreetbets Hair 1'] + attributes_new
  end
end




####
#  read in ordinals metadata
recs = read_csv( "../ordinalpunks_v2.csv" )
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

  accessories = convert_to_wallstreet( *accessories )

  ## auto-add regular shades if only has hair - why? why not?
  accessories << 'Regular Shades'   if accessories.size == 1


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

  punk = Punk::Image.generate( *attributes, patch: WALLSTREET_PATCH )

  punk.save( "./tmp/wallstreetbet-#{id+1}.png" )
  punk.zoom(4).save( "./tmp/wallstreetbet-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/wallstreetbets.png" )
composite.zoom(4).save( "./tmp/wallstreetbets@4x.png" )



puts "bye"
