# Test hook plugin
#

Jekyll::Hooks.register :manage, :pre_render do |document|

  puts "Firing :manage, :pre_render from 0240-hook-manage-pre-render.rb"

end
