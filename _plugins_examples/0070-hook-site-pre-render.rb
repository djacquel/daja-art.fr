# Test hook plugin
#

Jekyll::Hooks.register :site, :pre_render do |site, payload|

  puts "Firing :site, :pre_render from : " + File.basename(__FILE__)
end
