# Test hook plugin
#

Jekyll::Hooks.register :materials, :post_init do |document|

  puts "Firing :materials, :post_init from 0200-hook-materials-post-init.rb"

end
