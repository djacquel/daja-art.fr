# Test hook plugin
#

Jekyll::Hooks.register :documents, :post_render do |document|

  puts "Firing :documents, :post_render from : " + File.basename(__FILE__)

end
