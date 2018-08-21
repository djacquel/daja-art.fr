# Test hook plugin
#

Jekyll::Hooks.register :pages, :pre_render do |page, payload|

  puts "Firing :pages, :pre_render from 0130-hook-pages-pre_render.rb"

end
