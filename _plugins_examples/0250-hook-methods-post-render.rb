# Test hook plugin
#

Jekyll::Hooks.register :methods, :post_render do |document|

  puts "Firing :methods, :post_render from : " + File.basename(__FILE__)

end
