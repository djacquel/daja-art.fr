# Test hook plugin
#

Jekyll::Hooks.register :methods, :pre_render do |document|

  puts "Firing :methods, :pre_render from 0220-hook-methods-pre-render.rb"

end
