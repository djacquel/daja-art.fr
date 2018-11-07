# Test hook plugin
#

Jekyll::Hooks.register :methods, :post_render do |document|

  puts "Firing :methods, :post_render from 0250-hook-methods-post-render.rb"

end
