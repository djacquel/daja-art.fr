# Test hook plugin
#

Jekyll::Hooks.register :documents, :post_render do |document|

  puts "Firing :documents, :post_render from 0120-hook-documents-post_render.rb"

end
