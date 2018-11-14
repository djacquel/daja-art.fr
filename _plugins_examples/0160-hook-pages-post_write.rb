# Test hook plugin
#

Jekyll::Hooks.register :pages, :post_write do |page|

  puts "Firing :pages, :post_write from : " + File.basename(__FILE__)

end
