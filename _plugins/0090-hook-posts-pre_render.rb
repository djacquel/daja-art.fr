# Test hook plugin
#

Jekyll::Hooks.register :posts, :pre_render do |document, payload|

  puts "Firing :posts, :pre_render from 0090-hook-posts-pre_render.rb"

end
