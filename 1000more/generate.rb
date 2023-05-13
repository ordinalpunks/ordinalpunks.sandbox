####
#  to run use:
#    $ ./generate.rb


require 'punks'

recs = read_csv( "./morepunks.csv" )
puts "    #{recs.size} record(s)"



def rec_to_attributes( rec )
  type =     rec['type']

  accessories = rec['accessories'].split( '/' ).map { |acc| acc.strip }
  attributes = [type] + accessories
  attributes
end



####
# generate preview strip 10x10 (incl. 100 punks)

composite = ImageComposite.new( 10, 10, width: 24,
                                        height: 24 )


recs[0..99].each do |rec|
  id  =  rec['id']
  puts "==> generating punk ##{id}..."

  pp rec
  attributes = rec_to_attributes( rec )
  pp attributes

  img = Punk::Image.generate( *attributes )
  composite << img   ## bonus: add to composite
end

## save all-in-one composite
composite.save( "./tmp/morepunks-preview.png" )
composite.zoom(4).save( "./tmp/morepunks-preview@4x.png" )




composite = ImageComposite.new( 25, 40, width: 24,
                                        height: 24 )




recs.each do |rec|
  id  =  rec['id']
  puts "==> generating punk ##{id}..."

  pp rec
  attributes = rec_to_attributes( rec )
  pp attributes

  img = Punk::Image.generate( *attributes )
  img.save( "./tmp/morepunk#{id}.png")
  img.zoom(4).save( "./tmp/morepunk#{id}@4x.png")

  composite << img   ## bonus: add to composite
end


## save all-in-one composite
composite.save( "./tmp/morepunks.png" )
composite.zoom(4).save( "./tmp/morepunks@4x.png" )



puts 'bye'

