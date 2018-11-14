# Test hook plugin
#

Jekyll::Hooks.register :documents, :post_init do |document|

  puts "Firing :documents, :post_init from : " + File.basename(__FILE__)"

end
