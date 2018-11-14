# Test hook plugin
#

Jekyll::Hooks.register :manage, :post_write do |document|

  puts "Firing :manage, :post_write from : " + File.basename(__FILE__)

end
