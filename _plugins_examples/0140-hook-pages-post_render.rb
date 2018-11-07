# Test hook plugin
#

Jekyll::Hooks.register :pages, :post_render do |page|

  puts "Firing :pages, :post_render from 0140-hook-pages-post_render.rb"

end
