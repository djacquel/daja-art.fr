# Photo Workflow Manager plugin for Jekyll
#
#   - manage photo metadatas (EXIF and XMP)
#   - watermarks photos
#   - add a signature
#   - creates resized photos
#

Jekyll::Hooks.register :site, :after_init do |site|

  Jekyll.logger.info "Hook :site :after_init", File.basename(__FILE__)
  Jekyll.logger.info "+++++++++++++++++ START Photo Manager"

  # metadatas
  if !site.config['photo_manager']
    Jekyll.logger.warn "PhotoManager:", "No custom configuration found. Please, refer to documentation."
  else
    if !site.config['photo_manager']['enabled']
      Jekyll.logger.warn "PhotoManager:", "photo_worflow_manager NOT ENABLED in config !"
    else
      # runs if config ok
      Jekyll::PhotoManager::Manager.new(site).run
    end
  end

  Jekyll.logger.info "+++++++++++++++++ END Photo Manager"
end



