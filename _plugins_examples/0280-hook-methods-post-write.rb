# Test hook plugin
#

Jekyll::Hooks.register :methods, :post_write do |document|

  puts "Firing :methods, :post_write from : " + File.basename(__FILE__)

end
