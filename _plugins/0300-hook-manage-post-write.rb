# Test hook plugin
#

Jekyll::Hooks.register :manage, :post_write do |document|

  puts "Firing :manage, :post_write from 0300-hook-manage-post-write.rb"

end
