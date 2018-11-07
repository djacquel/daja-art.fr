# Test hook plugin
#

Jekyll::Hooks.register :pages, :post_write do |page|

  puts "Firing :pages, :post_write from 0160-hook-pages-post_write.rb"

end
