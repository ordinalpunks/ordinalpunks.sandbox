require 'pixelart'

## auto-requre punks and punkmaker - why? why not?
require 'punks'
require 'punkmaker'



## our own code
require_relative 'punkart/version'   # let versoin go first




module Pixelart
class Image


def greenback
   raise ArgumentError, "sorry only 24x24 supported for now; called on image #{self.width}x#{self.height}"  unless self.width == 24 && self.height == 24

   ## change to greenback color palette
   dollar = Image.new( Dollar::DOLLAR_FRAME.width, Dollar::DOLLAR_FRAME.height )
   dollar.compose!( Dollar::DOLLAR_FRAME )
   dollar.compose!( change_palette8bit( Dollar::DOLLAR_PALETTE ), 16, 0 )
   dollar
end
alias_method :dollar,    :greenback
alias_method :dollarize, :greenback

end # class Image



module Dollar   ## use/rename to Greenback - why? why not?

  def self.gen_palette( color )
     color = Color.parse( color )  if color.is_a?( String )

     h,s,l = Color.to_hsl( color )

     pp h
     pp s
     pp l

     darker = 0.25    ## cut-off colors starting from black
     lighter = 0.05   ## cut-off colors starting from white

     ldiff = (1.0 - darker - lighter)

     puts "  ldiff: #{ldiff}"

    colors = []
    256.times do |i|
       lnew = darker+(ldiff*i / 256.0)
       puts "  #{i} - #{lnew}"
       colors << Color.from_hsl( h, s, lnew)
    end
    colors
  end

  DOLLAR_FRAME   = Image.read( "#{Module::Punkart.root}/config/dollar.png" )
  DOLLAR_PALETTE = gen_palette( '#536140' )
  #=>  #536140 / rgb( 83  97  64) - hsl( 85°  20%  32%)
end # Dollar
end # module Pixelart




