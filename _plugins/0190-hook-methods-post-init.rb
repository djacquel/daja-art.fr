# Test hook plugin
#

Jekyll::Hooks.register :methods, :post_init do |document|

  puts "Firing :methods, :post_init from 0190-hook-methods-post-init.rb"

end
