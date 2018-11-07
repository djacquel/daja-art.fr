# Test hook plugin
#

Jekyll::Hooks.register :materials, :post_write do |document|

  puts "Firing :materials, :post_write from 0290-hook-materials-post-write.rb"

end
