# Photo Metadata Manager plugin for Jekyll
#
# This plugin help manage photo metadatas (EXIF and XMP)
#
#   - make a list of waiting image stored in an /img/to_be_processed folder
#   - for each img
#     - ensures that author, copyright fields are set with configured
#       values (site.photoMetadata.author and site.photoMetadata.copyright)
#     - ensure that title, comment are set by showing image

Jekyll::Hooks.register :site, :after_init do |site|
  Jekyll.logger.info "Hook :site :after_init", File.basename(__FILE__)
  Jekyll.logger.info "MetadataManager:", "+++++++++++++++++ START PHOTO METADATA MANAGER"

  # Check plugin configuration
  if !site.config['photoMetadata']
    Jekyll.logger.warn "MetadataManager:", "No custom configuration found. Please, refer to documentation."
  end

  Jekyll::MetadataManager.new(site).run

  Jekyll.logger.info "MetadataManager:", "+++++++++++++++++ END PHOTO METADATA MANAGER"
end



