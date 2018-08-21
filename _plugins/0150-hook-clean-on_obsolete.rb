# Test hook plugin
#

Jekyll::Hooks.register :clean, :on_obsolete do |out|

  puts "Firing :clean, :on_obsolete from 0150-hook-clean-on_obsolete.rb"

end
