#####
#  to run use:
#    $   ruby ./neon.rb


require 'punks'



module Pixelart

class Image

  ## neon glow special effect
  def neon( color='00ffaa' )
    ## note: must convert to black & white sketch
    sketch = sketch( 1 )

    inverse1 = sketch.change_colors( {
              'ffffff' => 0,  ## white to transparent
              '000000' => 'ffffff',  ## black to white
            })

    inverse2 = sketch.change_colors( {
               'ffffff' => 0,  ## white to transparent
               '000000' => color,  ## black to green
             })

####
# inspired by
#   https://css-tricks.com/how-to-create-neon-text-with-css/
#
# .neonText {
#    color: #fff;
#    text-shadow:
#      // white glow
#       0 0 7px #fff,
#       0 0 10px #fff,
#       0 0 21px #fff,
#      // green glow
#       0 0 42px #0fa,
#       0 0 82px #0fa,
#       0 0 92px #0fa,
#       0 0 102px #0fa,
#       0 0 151px #0fa;

    base = Image.new( sketch.width, sketch.height, Color::BLACK )
    base.compose!( inverse2.blur( 21 ) )  # -blur 21x21
    base.compose!( inverse2.blur( 10 ) )  # -blur 10x10
    base.compose!( inverse2.blur( 7 ) )   # -blur 7x7

    base.compose!( inverse1.blur( 2 ) )   # -blur 2x2
    base.compose!( inverse1 )
    base
  end
end # class Image
end # module Pixelart






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






colors = {
  'orange' => 'ff8800',   ## turn to sat to 100% why? - was "true" bitcoin orange #f7931a  
  'red'    => 'ff0000',
  'green'  => '00ff00',
  'blue'   => '0000ff',
  'pink'   => 'ff008C',
}

## 21 orange
## 21 red
## 21 green
## 21 blue
## 16 pink

specs = parse_csv( <<DATA )
id, color
1,  orange  # Robot,   Male,,        Big Beard
2,  green  # Human,   Male,    2,   Birthday Hat / Bubble Gum
3,  pink     # Human,   Female,  1,   Flowers / Frown / Gold Chain
4,  red # Demon,   Male,,        Hoodie / Pipe
5,  blue # Ape,     Male, Blue,   Cowboy Hat / Buck Teeth
6,  orange # Human,   Male,    3,   Cowboy Hat / Laser Eyes
7,  green # Human,   Male,    1,   Cap Burger King
8,  red   # Vampire, Male,,        Demon Horns
9,  pink     # Human,   Female,  Orange,   Crown
10, blue # Human,  Female,  3,   Choker / Wild White Hair /  Mole / Big Shades / Frown / Cigarette
11, orange  # Zombie,  Male,,       Big Beard / Frown / Mole / 3D Glasses /  Earring
12, green  # Orc,     Male,,       Beanie / VR / Clown Nose
13, pink     # Human,   Female, 4,   Pilot Helmet / Silver Chain / Clown Eyes Green
14, red  # Human,   Male,  Orange,   Beanie
15, blue  # Human,   Male,   4,   Police Cap / Regular Shades
16, orange # Human,   Male,   4,   3D Glasses
17, red  # Demon,   Male,,        Laser Eyes / Cigarette
18, green  # Human,   Male,    4,   Buck Teeth  / Frown / Gold Chain / Knitted Cap / Earring / Mole / Cigarette
19, pink     # Human,   Female,  1,   Bow
20, blue  # Zombie Ape, Male,,     Bubble Gum
21, orange  # Alien,   Male,  Gold,   Top Hat / Silver Chain
22, red  # Human,  Male,   Blue,   Clown Hair Blue
23, pink     # Human, Female,     2,   Rosy Cheeks / Tiara / Smile
24, green  # Human, Male,       1,   Medical Mask / Clown Nose / Hoodie
25, blue  # Human, Male,       2,   Sombrero / Mustache
26, orange  # Vampire, Male,,         Spots / Do-Rag / Bubble Gum
27, red  # Mummy,   Male,,         Beanie
28, green  # Human,   Male,     2,   Crazy Hair / Regular Shades / Cigar
29, blue  # Zombie,  Male,,         Hoodie / Gold Chain / Cigarette
30, orange # Human,   Male,     2,   Jester Hat
31, red  # Human,   Male,     1,   Cap Red
32, green  # Human,   Male,     4,   Messy Hair / Laser Eyes
33,  pink     # Human,  Female,     2,  Eye Patch / Hoodie
34,  blue # Human,  Female,     3,  Black Lipstick / Eye Mask / Choker
35, orange  # Skeleton, Male,,         Eye Patch / Fedora
36, red  # Human,  Female,     4,   Clown Hair Green / Classic Shades
37, green  # Human,  Male,       1,   3D Glasses /  Buck Teeth / Cigarette
38,  pink     # Orc,    Female,,         Blonde Bob
39,  blue # Zombie, Female,,         Birthday Hat / VR
40,  orange # Human,  Male,       2,   Bandana / Laser Eyes
41,  green # Mummy,  Female,,         Crown
42,  red # Demon,  Female,,         Cigar / Choker
43,  blue # Human,  Female,     4,   Frumpy Hair / Nerd Glasses
44,  pink     # Human,  Female,     1,   Cowboy Hat / Pipe
45,  orange # Human,  Male,       2,   Top Hat / Smile / Silver Chain
46,  red # Human,  Male,    Blue,   Cap Burger King  / Classic Shades
47,  green # Human,  Female,  Purple,  Clown Eyes Green / Blonde Bob
48,  blue # Human,  Male,     Gold,    Cap Forward / Laser Eyes
49,  orange # Human,  Female,     3,   Blue Eyeshadow / Beanie / Earring
50,  red # Alien Ape,  Male,,       Goat / Fedora
51,  green # Human,  Female,      Blue,   Blonde Short / Nerd Glasses
52,  pink     #  Alien,  Female,      Red Magenta,  3D Glasses
53,  red # Demon,  Female,,             Frumpy Hair / Clown Nose
54,  orange # Human,  Male,           3,   Do-Rag / Heart Shades
55,  blue # Skeleton, Female,,           Bandana / Cigarette
56,  green # Human,  Female,         2,   Earring / Mole / Cap / Smile
57,  blue # Human,  Male,           4,   Clown Nose / Top Hat
58,  orange # Vampire, Female,,       Heart Shades
59,  red # Human,  Male,        Blue,   Cowboy Hat  / Pipe
60,  green # Human,  Male,           1,   Crazy Hair / Clown Eyes Blue / Eye Mask
61,  pink     #  Demon,  Female,,             Blue Eyeshadow
62,  blue # Human,  Male,           2,   Beanie / Big Shades
63,  orange # Zombie, Female,,             Frown
64,  green # Orc,    Female,,             Mole / Frumpy Hair / Green Eye Shadow
65,  red # Human,  Male,           1,   Frown / Do-Rag / Gold Chain / Classic Shades
66,  blue # Ape,    Female,,             Sombrero
67,  orange # Alien,  Male,      Yellow,   Smile / Goat
68,  red # Human,  Female,    Gold,     Clown Hair Green / Choker
69,  pink     #  Robot,  Female,,             3D Glasses
70,  green # Human,  Male,      Orange,   Bandana / Chinstrap
71,  blue # Human,  Female,        3,   Green Eye Shadow / Top Hat
72,  orange # Mummy,  Female,,            Dark Hair
73,  blue # Alien,  Female,    Violet,   Knitted Cap / Pipe
74,  green # Human,  Female,    Orange,   Cap Forward
75,  red # Demon,  Male,,               Big Beard
76,  orange # Robot,  Male,,               Classic Shades / Cigarette
77,  red # Human,  Male,           4,   Eye Mask / Silver Chain / Bandana / Clown Nose
78,  green # Zombie, Male,,               Hoodie / Pipe
79,  blue # Human,  Male,           3,   Earring / 3D Glasses
80,  green # Orc,    Male,,
81,  pink     #  Vampire, Female,,            Dark Hair
82,  red # Mummy,   Male,,              Cowboy Hat  / Eye Mask
83,  orange # Alien,   Male,      Green,   Clown Eyes Green
84,  blue # Human,   Male,          1,   Eye Mask / Chinstrap / Fedora
85,  red # Human,   Male,          4,   Silver Chain / Cap Forward / Pipe / Demon Horns
86,  orange  # Skeleton, Male,,             Clown Eyes Green
87,  green # Human,   Female,        3,   Do-Rag / Gold Chain
88,  blue # Human,   Male,          4,   Cap Forward  / 3D Glasses
89,  pink  # Zombie,  Female,,            Cap / Earring / Green Eye Shadow / Cigar
90,  red # Vampire, Male,,              Demon Horns / Chinstrap
91,  pink     #  Human,   Female,        1,   Cowboy Hat / Green Eye Shadow / Black Lipstick / Choker
92,  blue # Robot,   Male,,              Crazy Hair
93,  green # Orc,     Male,,              Eye Mask / Goat / Gold Chain
94,  orange # Alien Ape, Male,,            Frumpy Hair / Eye Patch
95,  pink   # Human,   Female,        3,   Clown Nose / Medical Mask / Cigarette
96,  green # Human,   Male,      Orange,   Big Beard /  Bandana / Classic Shades
97,  blue # Alien,   Male,        Gold,   Beanie / 3D Glasses / Cigarette / Silver Chain / Mole
98,  pink     #  Human,   Female,    Yellow,   Crown / Silver Chain
99,  orange # Ape,     Male,      Gold,     Cap Forward / Earring / Medical Mask
100, red # Demon,   Male,            ,   Cowboy Hat / Buck Teeth
DATA


pp specs

stats = Hash.new(0)

specs.each do |rec|
  stats[rec['color']] += 1
end

pp stats


##
# add logo

punk = Punk::Image.generate( 'ape gold', 'laser eyes' )
neon = punk.neon( colors[ 'orange' ] ) 
neon.save( "./ordzaar/tmp/profile.png" )




composite     = ImageComposite.new( 10, 10,  width:  49,
                                             height: 49 )
banner        = ImageComposite.new( 20, 5 ,  width:  49,
                                             height: 49 )


ids = (0..99)
ids.each do |id|

  attributes = rec_to_attributes( recs[id] )
  pp attributes

  name = specs[id]['color']
  color = colors[name]

  punk = Punk::Image.generate( *attributes ).neon( color )

  num = '%02d' % id
  punk.save( "./ordzaar/neon#{num}.png" )
  punk.zoom(4).save( "./ordzaar/@4x/#{name}#{num}@4x.png" )

  composite << punk
  banner << punk
end


composite.save( "./ordzaar/tmp/neon.png" )
composite.zoom(2).save( "./ordzaar/tmp/neon@2x.png" )

banner.save( "./ordzaar/tmp/banner.png" )
banner.zoom(2).save( "./ordzaar/tmp/banner@2x.png" )
banner.zoom(3).save( "./ordzaar/tmp/banner@3x.png" )
banner.zoom(4).save( "./ordzaar/tmp/banner@4x.png" )


puts "bye"
