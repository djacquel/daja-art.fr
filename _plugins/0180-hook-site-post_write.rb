# Test hook plugin
#

Jekyll::Hooks.register :site, :post_write do |site|

  puts "Firing :site, :post_write from 0180-hook-site-post_write.rb"

end
