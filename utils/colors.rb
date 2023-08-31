
def dump_colors( punk )
  hist = Hash.new(0)
  punk.pixels.each do |color|
    hist[ color ] +=1
  end

  hist.each do |color, count|
    print "#{count} pixels "
    print   Color.format( color )
    print "\n"
  end
end
