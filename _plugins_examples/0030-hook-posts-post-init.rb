# Test hook plugin
#

Jekyll::Hooks.register :posts, :post_init do |document|

  puts "Firing :posts, :post_init from 0030-hook-posts-post-init.rb"

end
