# Test hook plugin
#

Jekyll::Hooks.register :methods, :post_write do |document|

  puts "Firing :methods, :post_write from 0280-hook-methods-post-write.rb"

end
