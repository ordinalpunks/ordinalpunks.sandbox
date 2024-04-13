#####
#  to run use:
#    $   ruby ./based.rb



require 'punks'


## add upstream  (patched led version with transparent background)
module Pixelart
class Image
  def led2( led=4, spacing: 1 )

    width  = @img.width*led  + (@img.width-1)*spacing
    height = @img.height*led + (@img.height-1)*spacing

    puts "  #{width}x#{height}"

    img = Image.new( width, height )

    @img.width.times do |x|
      @img.height.times do |y|
        pixel = @img[x,y]
        led.times do |n|
          led.times do |m|
            img[x*led+n + spacing*x,
                y*led+m + spacing*y] = pixel
          end
        end
      end
    end
    img
  end
end # class Image
end # module Pixelart






CIRCLE_BASE  = Image.read( "./circle-24x24.png" )
CIRCLE_FRAME = begin
                  img = Image.new( 24*4+23, 24*4+23 )
                  img.compose!( CIRCLE_BASE.led2( 4, spacing: 1 ) )

                  img.save( "./tmp/circle_frame.png" )
                  img.zoom(2).save( "tmp/circle_frame@2x.png" )
                  
                  img 
               end
puts "   #{CIRCLE_FRAME.width}x#{CIRCLE_FRAME.height}"
#=>  119x119


def mint( punk )
  ## change to coin color palette
  ## add 4px padding, 4+4=16
  img = Image.new( CIRCLE_FRAME.width+4*4*2, CIRCLE_FRAME.height+4*4*2, Color::BLACK )
  img.compose!( CIRCLE_FRAME, 4*4, 4*4 )
  img.compose!( punk.led2( 4, spacing: 1 ), 4*4, 4*4 )
  img
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





###
#  generate 


composite  = ImageComposite.new( 10, 10, width:  CIRCLE_FRAME.width+4*4*2,
                                         height: CIRCLE_FRAME.width+4*4*2 )

composite2 = ImageComposite.new( 10, 10, width:  CIRCLE_FRAME.width+4*4*2,
                                         height: CIRCLE_FRAME.width+4*4*2 )


ids = (0..99)
ids.each do |id|
  attributes = rec_to_attributes( recs[id] )
  pp attributes

  punk = Punk::Image.generate( *attributes )

  num = '%02d' % id
  based = mint( punk )
  based.save( "./tmp/based#{num}.png" )
  based.zoom(4).save( "./tmp/based#{num}@4x.png" )
  composite << based

  based = mint( punk.silhouette )
  based.save( "./tmp2/based_shadow#{num}.png" )
  based.zoom(4).save( "./tmp2/based_shadow#{num}@4x.png" )
  composite2 << based
end


composite.save( "./tmp/based.png" )
composite.zoom(2).save( "./tmp/based@2x.png" )

composite2.save( "./tmp/based_shadow.png" )
composite2.zoom(2).save( "./tmp/based_shadow@2x.png" )


puts "bye"
