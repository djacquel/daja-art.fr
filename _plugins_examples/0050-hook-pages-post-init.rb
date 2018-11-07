# Test hook plugin
#

Jekyll::Hooks.register :pages, :post_init do |page|

  puts "Firing :pages, :post_init from 0050-hook-pages-post-init.rb"
  puts "page path is : #{page.path}"
end
