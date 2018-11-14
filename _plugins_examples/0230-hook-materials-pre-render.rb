# Test hook plugin
#

Jekyll::Hooks.register :materials, :pre_render do |document|

  puts "Firing :materials, :pre_render from : " + File.basename(__FILE__)

end
