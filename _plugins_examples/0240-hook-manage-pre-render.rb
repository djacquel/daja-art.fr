# Test hook plugin
#

Jekyll::Hooks.register :manage, :pre_render do |document|

  puts "Firing :manage, :pre_render from : " + File.basename(__FILE__)

end
