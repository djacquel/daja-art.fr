# Test hook plugin
#

Jekyll::Hooks.register :clean, :on_obsolete do |out|

  puts "Firing :clean, :on_obsolete from : " + File.basename(__FILE__)

end
