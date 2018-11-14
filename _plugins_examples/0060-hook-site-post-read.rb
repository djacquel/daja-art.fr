# Test hook plugin
#

Jekyll::Hooks.register :site, :post_read do |site|

  puts "Firing :site, :post_read from : " + File.basename(__FILE__)

end
