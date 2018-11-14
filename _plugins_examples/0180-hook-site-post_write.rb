# Test hook plugin
#

Jekyll::Hooks.register :site, :post_write do |site|

  puts "Firing :site, :post_write from : " + File.basename(__FILE__)

end
