# Test hook plugin
#

Jekyll::Hooks.register :materials, :post_render do |document|

  puts "Firing :materials, :post_render from 0260-hook-materials-post-render.rb"

end
