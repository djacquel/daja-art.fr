# Test hook plugin
#

Jekyll::Hooks.register :materials, :post_render do |document|

  puts "Firing :materials, :post_render from : " + File.basename(__FILE__)

end
