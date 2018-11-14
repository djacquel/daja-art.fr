# Test hook plugin
#

Jekyll::Hooks.register :manage, :post_render do |document|

  puts "Firing :manage, :post_render from : " + File.basename(__FILE__)

end
