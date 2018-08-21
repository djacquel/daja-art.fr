# Test hook plugin
#

Jekyll::Hooks.register :manage, :post_init do |document|

  puts "Firing :manage, :post_init from 0210-hook-manage-post-init.rb"

end
