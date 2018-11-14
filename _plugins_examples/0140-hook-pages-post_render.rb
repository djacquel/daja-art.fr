# Test hook plugin
#

Jekyll::Hooks.register :pages, :post_render do |page|

  puts "Firing :pages, :post_render from : " + File.basename(__FILE__)

end
