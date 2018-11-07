# Test hook plugin
#

Jekyll::Hooks.register :documents, :post_write do |document|

  puts "Firing :documents, :post_write from 0170-hook-documents-post_write.rb"

end
