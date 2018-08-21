# Test hook plugin
#

Jekyll::Hooks.register :site, :after_reset do |site|

  puts "Firing :site, :after_reset from 0010-hook-site-after-reset.rb"

end
