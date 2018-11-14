# Test hook plugin
#

Jekyll::Hooks.register :manage, :post_init do |document|

  puts "Firing :manage, :post_init from : " + File.basename(__FILE__)
end
