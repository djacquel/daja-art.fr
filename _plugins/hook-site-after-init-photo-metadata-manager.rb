# Photo Metadata Manager plugin for Jekyll
#
# This plugin help manage photo metadatas (EXIF and XMP)
#

Jekyll::Hooks.register :site, :after_init do |site|
  Jekyll.logger.info "Hook :site :after_init", File.basename(__FILE__)
  Jekyll.logger.info "MetadataManager:", "+++++++++++++++++ START PHOTO METADATA MANAGER"

  # metadatas
  if !site.config['photoMetadata']
    Jekyll.logger.warn "MetadataManager:", "No custom configuration found. Please, refer to documentation."
  else
    if !site.config['photoMetadata']['enabled']
      Jekyll.logger.warn "MetadataManager:", "PhotoMetadata NOT ENABLED in config !"
    else
      # runs if config ok
      Jekyll::MetadataManager.new(site).run
    end
  end

  Jekyll.logger.info "MetadataManager:", "+++++++++++++++++ END PHOTO METADATA MANAGER"
end



