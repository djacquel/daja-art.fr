# Test hook plugin
#

Jekyll::Hooks.register :posts, :post_render do |document|

  puts "Firing :posts, :post_render from : " + File.basename(__FILE__)

end
