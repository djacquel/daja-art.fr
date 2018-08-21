# Test hook plugin
#

Jekyll::Hooks.register :documents, :pre_render do |document, payload|

  puts "Firing :documents, :pre_render from 0100-hook-documents-pre_render.rb"

end
