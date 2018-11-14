# Test hook plugin
#

Jekyll::Hooks.register :posts, :post_init do |document|

  puts "Firing :posts, :post_init from : " + File.basename(__FILE__)

end
