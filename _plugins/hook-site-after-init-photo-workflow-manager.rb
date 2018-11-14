# Photo Workflow Manager plugin for Jekyll
#
#   - manage photo metadatas (EXIF and XMP)
#   - watermarks photos
#   - creates resized photos
#

Jekyll::Hooks.register :site, :after_init do |site|
  Jekyll.logger.info "Hook :site :after_init", File.basename(__FILE__)
  Jekyll.logger.info "+++++++++++++++++ START Photo Workflow manager"

  # metadatas
  if !site.config['photo_worflow_manager']
    Jekyll.logger.warn "PWM:", "No custom configuration found. Please, refer to documentation."
  else
    if !site.config['photo_worflow_manager']['enabled']
      Jekyll.logger.warn "PWM:", "photo_worflow_manager NOT ENABLED in config !"
    else
      # runs if config ok
      Jekyll::PhotoWorkflowManager.new(site).run
    end
  end

  Jekyll.logger.info "+++++++++++++++++ END Photo Workflow manager"
end



