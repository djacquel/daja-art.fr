# Test hook plugin
#

Jekyll::Hooks.register :site, :pre_render do |site, payload|

  puts "Firing :site, :pre_render from 0070-hook-site-pre-render.rb"

end
