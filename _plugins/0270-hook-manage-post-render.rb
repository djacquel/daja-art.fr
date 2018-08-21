# Test hook plugin
#

Jekyll::Hooks.register :manage, :post_render do |document|

  puts "Firing :manage, :post_render from 0270-hook-manage-post-render.rb"

end
