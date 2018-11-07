# Test hook plugin
#

Jekyll::Hooks.register :posts, :post_render do |document|

  puts "Firing :posts, :post_render from 0110-hook-posts-post_render.rb"

end
