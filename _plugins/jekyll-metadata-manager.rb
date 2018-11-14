module Jekyll

  class MetadataManager

    DEFAULT = {
      'enabled' => false,
      'pending_images_path' => '/img/pending',
      'set_copyright' => false,
      'set_author' => false,
      'author' => 'NOT_SET',
      'prompted_metadatas' => [
        'title'
      ]
    }.freeze

    def initialize(site)
      @site   = site
      @config = DEFAULT.merge(site.config['photoMetadata'] || {})
      @pending_path = File.join(site.source, @config['pending_images_path'])
    end

    # runs on all pending photos
    def run
      unless Dir.exist?(@pending_path)
        raise Errors::FatalException,
              "Pending photos folder doesn't exist : #{@pending_path}"
      end

      photos = getAllPending

      photos.each do |photo|
        photoObj = Jekyll::Photo.new(photo, @pending_path, @config)
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
