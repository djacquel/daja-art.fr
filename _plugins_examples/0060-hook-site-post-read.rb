# Test hook plugin
#

Jekyll::Hooks.register :site, :post_read do |site|

  puts "Firing :site, :post_read from 0060-hook-site-post-read.rb"

end
