#####
#  to run use:
#    $   ruby ./fastfood.rb


require_relative '../utils/punks'


def fastfoodied( *attributes,  more: false, exclude: [] )
  base            = attributes[0]
  more_attributes = attributes[1..-1]

  has_headwear = false


  headwear_mcds = [
    'Cap M',                   # McDonald's Red
    'Cap M Flipped',
    'Cap M White',
    'Cap M White Flipped',
    'Cap M Gray',
    'Cap M Gray Flipped',
    'Cap M Black',
    'Cap M Black Flipped',
  ]
  headwear_mcds_m = [   ## male-only
     'Bucket Hat M',
     'Cowboy Hat M',
  ]

  headwear_more = [
    'Cap Br',                  # Baskin-Robbins
    'Cap Br Flipped',
    ## 'Cap Brk',                 # Burger King
    'Cap Burger King Flipped',
    'Cap Castle',              # Cap White Castle
    'Cap Castle Flipped',
    'Cap Dom',                 # Domino's Pizza
    'Cap Dom Flipped',
    'Cap Dunk',                # Dunkin' Donuts
    'Cap Dunk Flipped',
    'Cap Hut',                 # Pizza Hut
    'Cap Hut Flipped',
    'Cap Jack',                # Jack in the Box
    'Cap Jack Flipped',
    'Cap Kentucky',            # Kentucky Fried Chicken
    'Cap Kentucky Flipped',
    'Cap Sub',              # Subway
    'Cap Sub Flipped',
    'Cap W',                # Wendy's
    'Cap W Flipped',
  ]

  ## note: add more Cap M (Red)  for common classic base (4x)
  headwears  = ['Cap M', 'Cap M', 'Cap M']+headwear_mcds
  headwears += headwear_mcds_m   unless base.index( 'Female')
  headwears += headwear_more     if more


  headwear = nil
  headwear  =  more_attributes.find { |attr| exclude.include?( attr ) }


  more_attributes = more_attributes.reject {|attr| [
                                             'Crown',
                                             'Cap Burger King',
                                             'Birthday Hat',
                                             'Flowers',
                                             'Hoodie',
                                             'Cowboy Hat',
                                             'Demon Horns',
                                              'Wild White Hair',
                                              'Beanie',
                                              'Pilot Helmet',
                                              'Police Cap',
                                              'Knitted Cap',
                                              'Bow',
                                              'Top Hat',
                                              'Clown Hair Blue', 'Tiara',
                                              'Sombrero',
                                              'Do-Rag',
                                              'Crazy Hair',
                                              'Jester Hat', 'Cap Red',
                                              'Messy Hair',
                                              'Fedora',
                                              'Clown Hair Green',
                                              'Blonde Bob',
                                              'Bandana',
                                              'Frumpy Hair',
                                              'Cap Forward',
                                              'Blonde Short',
                                              'Cap',
                                              'Dark Hair' ].include?( attr )
                                          }



  if headwear
    ## do nothing - reuse headwear
  else
    headwear = headwears[ rand( headwears.size) ]
  end


  [base, headwear] + more_attributes
end



####
#  read in ordinals metadata
#    note: use ordinal punks v2 (the improved formula)
ordpunks = Punk::Collection.read( '../ordinalpunks_v2.csv' )
puts "    #{ordpunks.size} record(s)"



###
#  fast foodies - variant i - only mcds

composite     = ImageComposite.new( 10, 10 )


srand( 4243 )  # set random seed - for deterministic

ordpunks.each_meta do |attributes, id|
  punk =  ordpunks.generate( *fastfoodied( *attributes )  )

  punk.save( "./tmp2/fastfoodie-#{id+1}.png" )
  punk.zoom(4).save( "./tmp2/fastfoodie-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/fastfoodies.png" )
composite.zoom(4).save( "./tmp/fastfoodies@4x.png" )



###
#  fast foodies - variant ii - more

composite     = ImageComposite.new( 10, 10 )

srand( 4243 )  # set random seed - for deterministic

ordpunks.each_meta do |attributes, id|
  punk = ordpunks.generate( *fastfoodied( *attributes,
                                   more: true,
                                   exclude: ['Crown', 'Cap Burger King'] ))

  punk.save( "./tmp2/fastfoodie_more-#{id+1}.png" )
  punk.zoom(4).save( "./tmp2/fastfoodie_more-#{id+1}@4x.png" )

  composite << punk
end


composite.save( "./tmp/fastfoodies_ii.png" )
composite.zoom(4).save( "./tmp/fastfoodies_ii@4x.png" )

puts "bye"
