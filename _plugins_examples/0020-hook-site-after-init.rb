# Test hook plugin
#

Jekyll::Hooks.register :site, :after_init do |site|

  puts "Firing :site, :after_init from 0020-hook-site-after-init.rb"

end
