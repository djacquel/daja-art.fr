# Test hook plugin
#

Jekyll::Hooks.register :pages, :post_init do |page|

  puts "Firing :pages, :post_init from : " + File.basename(__FILE__)
  puts "page path is : #{page.path}"
end
