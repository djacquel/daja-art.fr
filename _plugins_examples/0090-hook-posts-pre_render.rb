# Test hook plugin
#

Jekyll::Hooks.register :posts, :pre_render do |document, payload|

  puts "Firing :posts, :pre_render from : " + File.basename(__FILE__)

end
