# Test hook plugin
#

Jekyll::Hooks.register :methods, :pre_render do |document|

  puts "Firing :methods, :pre_render from : " + File.basename(__FILE__)

end
