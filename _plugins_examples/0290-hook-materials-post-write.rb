# Test hook plugin
#

Jekyll::Hooks.register :materials, :post_write do |document|

  puts "Firing :materials, :post_write from : " + File.basename(__FILE__)

end
