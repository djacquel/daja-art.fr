module Jekyll

  class MetadataManager

    DEFAULT = {
      'pending_images_path' => '/img/pending',
      'default_metadatas' => {
          'author' => 'NO AUTHOR SET',
          'copyright' => 'NO COPYRIGHT SET'
      },
      'prompted_metadatas' => [
        'title'
      ]
    }.freeze

    def initialize(site)
      @site         = site
      @config       = DEFAULT.merge(site.config['photoMetadata'] || {})
      @pending_path = File.join(site.source, @config['pending_images_path'])

      unless Dir.exist?(@pending_path)
        raise Errors::FatalException,
              "Pending photos folder doesn't exist : #{@pending_path}"
      end

      Jekyll.logger.info "MetadataManager:", "initialized"
    end

    # runs on all pending photos
    def run
      # get all pending pictures
      photos = getAllPending
      photos.each do |photo|
        photoObj = Jekyll::PhotoManager.new(photo, @pending_path, @config)
        photoObj.setDefaultMetadatas()
        photoObj.setPromptedMetadatas()
        photoObj.endsEdit()
      end
    end

    def getAllPending
      entries = Dir.entries(@pending_path)
      entries.reject! { |x| x =~ /^\./ } # no ., .., and dotfiles
    end



  end
end
