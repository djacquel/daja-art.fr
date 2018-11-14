# Test hook plugin
#

Jekyll::Hooks.register :methods, :post_init do |document|

  puts "Firing :methods, :post_init from : " + File.basename(__FILE__)

end
