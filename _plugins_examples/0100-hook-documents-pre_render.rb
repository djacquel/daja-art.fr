# Test hook plugin
#

Jekyll::Hooks.register :documents, :pre_render do |document, payload|

  puts "Firing :documents, :pre_render from : " + File.basename(__FILE__)

end
