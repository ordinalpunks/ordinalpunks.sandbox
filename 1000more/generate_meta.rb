

ATTRIBUTES = {
  'base' => [
     ['male m01',    ## bonus/extra - change male 1/2/3/4 to male m01/m02/...
      'male m02',
      'male m03',
      'male m04',
      'male m05',
      'male m06',
      'male m07',
      'male m08',
      'male m09',
      'male m10',
      'male blue',
      'male orange',
      'male gold',
      'zombie male',
      'vampire male',
      'demon male',
      'orc male',
      'mummy male',
      'skeleton male',
      'ape male blue',
      'ape male gold',
      'zombie ape male',
      'alien ape male',
      'alien male green',
     ## 'alien male yellow',
      'alien male gold',
      'robot male',
    ],
    [
      'female m01',  ## bonus/extra - change female 1/2/3/4 to female m01/m02/...
      'female m02',
      'female m03',
      'female m04',
      'female m05',
      'female m06',
      'female m07',
      'female m08',
      'female m09',
      'female m10',
      'female blue',
      'female purple',
      'female orange',
   ##   'female yellow',
      'female gold',
      'zombie female',
      'demon female',
      'vampire female',
      'orc female',
      'mummy female',
      'skeleton female',
      'ape female',
      'alien female red magenta',
      'alien female violet',
      'robot female'
    ]],

    'hair' => [[ 'clown hair blue',
                     'crazy hair',
                     'messy hair',
                     'frumpy hair',
                     ],
                     [
                      'frumpy hair',
                      'wild white hair',
                      'blonde bob',
                      'blonde short',
                      'dark hair',
                      'clown hair green',
                     ]],
   'hat' => [['birthday hat',
              'cowboy hat',
   'demon horns',
   'beanie',
   'police cap',
   'knitted cap',
   'top hat',
   'sombrero',
   'do-rag',
   'jester hat',
   'fedora',
   'bandana',
   'cap forward',
   'cap red',
   'cap burger king',
   'hoodie',],
   [
                    'birthday hat',
                      'cowboy hat',
                      'crown',
                      'beanie',
                      'pilot helmet',
                      'knitted cap',
                       'bow',
                       'flowers',
                       'tiara',
                       'top hat',
                       'sombrero',
                       'do-rag',
                       'bandana',
                       'cap forward',
                       'cap',
                       'hoodie',
   ]],
   'face_nose'=> [['mole', 'spots', 'clown nose'],
                   ['mole', 'rosy cheeks', 'clown nose']
                  ],
    'beard_makeup' => [[
                      'big beard',
                      'goat',
                      'chinstrap',
                      'mustache',
                      'clown eyes blue',
                      'clown eyes green',
                        ],
                        ['clown eyes green',
                         'green eye shadow',
                         'blue eye shadow',
                        ]],
    'mouthprop'  => [[
      'bubble gum',
      'cigarette',
      'cigar',
      'pipe',
      'medical mask',
        ],
        ['cigarette',
         'cigar',
         'pipe',
         'medical mask',]
       ],
    'eyewear'    => [['laser eyes',
                      'laser eyes gold',   ## bonus/extra
                      'laser eyes blue',   ## bonus/extra
                      'big shades',
                      '3d glasses',
                      'vr',
                      'regular shades',
                      'classic shades',
                       'heart shades',
                       'eye patch',
                      'eye mask',],
                    ['laser eyes',     ## bonus/extra
                    'big shades',
                    '3d glasses',
                    'vr',
                    'classic shades',
                    'nerd glasses',
                    'heart shades',
                    'eye patch',
                    'eye mask',]],
    'ear_neck'   => [['earring',
                       'gold chain',
                       'silver chain',
                     ],
                     ['earring',
                     'gold chain',
                     'silver chain',
                     'choker']],
  }

pp ATTRIBUTES



def random_attributes
  attributes = []

  ##  gender:  0 - male
  ##           1 - female
  gender = rand( 2 )

  base_attributes = ATTRIBUTES['base'][gender]
  base = base_attributes[ rand( base_attributes.size ) ]
  attributes << base

  hair_attributes = ATTRIBUTES['hair'][gender]
  hat_attributes =  ATTRIBUTES['hat'][gender]

  ##   0,1,2 - hair   (30%)
  ##   3,4,5,6,7,8 - hat (60%)
  ##   9 -none           (10%)

  hair_or_hat  = rand( 10 )
  if [0,1,2].include?( hair_or_hat )
      attributes << hair_attributes[ rand( hair_attributes.size ) ]
  elsif [3,4,5,6,7,8].include?( hair_or_hat )
      attributes << hat_attributes[ rand( hat_attributes.size ) ]
  else
    ## none; continue
  end



  accessories_total = ATTRIBUTES.keys.size - 3
  # pp accessories_count
  #=> 6

  accessories_count = 1 + rand( accessories_total-3 )
  pp accessories_count

  accessories_categories = []
  accessories_count.times do
       i = rand( accessories_total )
       next if accessories_categories.include?( i )
       accessories_categories << i
  end

  accessories_categories = accessories_categories.sort
  pp accessories_categories


  accessories_categories.each do |i|
      category = ATTRIBUTES.keys[i+3]
      accessories = ATTRIBUTES[ category ][ gender ]
      if accessories.size > 0
        attribute = accessories[ rand( accessories.size ) ]
        attributes << attribute
      end
  end

  attributes
end




def generate_meta( max=1000, seed: 4242 )

  srand( seed )   ## make deterministic

  recs = []
  max.times do |id|
    attributes = random_attributes
    puts "==> punk #{id}:"
    pp attributes

    base = attributes[0]
    accessories = attributes[1..-1]

    rec = []
    rec << (id+1).to_s   ## add id - starting at one
    rec << base
    rec << accessories.join(' / ')

    recs << rec
  end

  recs
end



recs = generate_meta( 1000 )
pp recs


headers = ['id', 'type', 'accessories']
File.open( "./tmp2/morepunks.csv", "w:utf-8" ) do |f|
   f.write( headers.join( ', '))
   f.write( "\n")
   recs.each do |values|
     f.write( values.join( ', ' ))
     f.write( "\n" )
   end
end


puts "bye"

