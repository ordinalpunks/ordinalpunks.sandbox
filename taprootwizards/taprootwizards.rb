#####
#  to run use:
#    $   ruby ./taprootwizards.rb



require 'punks'



##
#  more new taproot wizard attributes
WIZARD_PATCH = {
 'wizardhatblue'      => Image.read( './more/wizardhat-blue.png' ),
 'wizardhatdarkblue'  => Image.read( './more/wizardhat-darkblue.png' ),
 'wizardhatgold'      => Image.read( './more/wizardhat-gold.png' ),
 'wizardhatorange'    => Image.read( './more/wizardhat-orange.png' ),
 'wizardhatred'       => Image.read( './more/wizardhat-red.png' ),
 'wizardhatviolet'    => Image.read( './more/wizardhat-violet.png' ),

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



def convert_to_wizard( *attributes )

  has_wizardhat = false

  attributes_new = []
  attributes.each do |attribute|

    next if EXCLUDE.include?( attribute )

    ## change hair (or lipstick) to beard
    if attribute == 'Wild White Hair' ||
       attribute == 'Blonde Short'  ||
       attribute == 'Blonde Bob'
       attribute = 'Luxurious Beard White'
    elsif attribute == 'Clown Hair Blue' ||
          attribute == 'Clown Hair Green'
        attribute = 'Normal Beard White'
    elsif attribute == 'Messy Hair' ||
          attribute == 'Dark Hair'  ||
          attribute == 'Frumpy Hair' ||
          attribute == 'Black Lipstick'
       attribute = 'Luxurious Beard'   ## black
    else
    end

    ## change headwear to wizard hat
    if attribute == 'Crown' ||
       attribute == 'Tiara'
        has_wizardhat = true
         attribute = 'Wizardhat Gold'
    elsif attribute == 'Top Hat' || attribute == 'Hoodie' ||
          attribute == 'Cap Forward'  ||
          attribute == 'Police Cap'   ||
          attribute == 'Do-Rag'
      has_wizardhat = true
      attribute = 'Wizardhat Dark Blue'
    elsif attribute == 'Crazy Hair' ||
          attribute == 'Bow' ||
          attribute == 'Sombrero' ||
          attribute == 'Cap Red' ||
          attribute == 'Flowers' ||
          attribute == 'Demon Horns'
      has_wizardhat = true
      attribute = 'Wizardhat Red'
    elsif attribute == 'Jester Hat' ||
          attribute == 'Knitted Cap' ||
          attribute == 'Cap Burger King'
      has_wizardhat = true
      attribute = 'Wizardhat Orange'
    elsif attribute == 'Cap' ||
          attribute == 'Pilot Helmet'
      has_wizardhat = true
      attribute = 'Wizardhat Violet'
    else
    end

    attributes_new << attribute
  end


  if has_wizardhat
    attributes_new
  else
     ## note: let wizard hat go first
    ['wizardhat blue'] + attributes_new
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

  accessories = convert_to_wizard( *accessories )

  attributes = [base] + accessories
  attributes
end



composite = ImageComposite.new( 10, 10, width:  24,
                                        height: 24 )


ids = (0..99)
pp ids

ids.each do |id|
  attributes = rec_to_attributes( recs[id], id )
  pp attributes

  punk = Punk::Image.generate( *attributes, patch: WIZARD_PATCH )

  punk.save( "./tmp/taprootwizard-#{id+1}.png" )
  punk.zoom(4).save( "./tmp/taprootwizard-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/taprootwizards.png" )
composite.zoom(4).save( "./tmp/taprootwizards@4x.png" )



puts "bye"
