# Test hook plugin
#

Jekyll::Hooks.register :documents, :post_write do |document|

  puts "Firing :documents, :post_write from : " + File.basename(__FILE__)

end
