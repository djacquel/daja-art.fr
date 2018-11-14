# Test hook plugin
#

Jekyll::Hooks.register :pages, :pre_render do |page, payload|

  puts "Firing :pages, :pre_render from : " + File.basename(__FILE__)

end
