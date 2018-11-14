# Test hook plugin
#

Jekyll::Hooks.register :site, :after_init do |site|

  puts "Firing :site, :after_init from : " + File.basename(__FILE__)

end
