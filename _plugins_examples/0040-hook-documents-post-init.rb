# Test hook plugin
#

Jekyll::Hooks.register :documents, :post_init do |document|

  puts "Firing :documents, :post_init from 0040-hook-documents-post-init.rb"

end
