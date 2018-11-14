# Test hook plugin
#

Jekyll::Hooks.register :materials, :post_init do |document|

  puts "Firing :materials, :post_init from : " + File.basename(__FILE__)

end
