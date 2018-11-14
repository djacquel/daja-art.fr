# Test hook plugin
#

Jekyll::Hooks.register :site, :after_reset do |site|

  puts "Firing :site, :after_reset from : " + File.basename(__FILE__)

end
