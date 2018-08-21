# Test hook plugin
#

Jekyll::Hooks.register :materials, :pre_render do |document|

  puts "Firing :materials, :pre_render from 0230-hook-materials-pre-render.rb"

end
