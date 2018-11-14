# Test hook plugin
#

Jekyll::Hooks.register :site, :post_render do |site, payload|

  puts "Firing :site, :post_render from : " + File.basename(__FILE__)

end
