module Jekyll

  class PhotoWorkflowManager

    DEFAULT = {
      'enabled' => false,
      'pending_images_path' => '/img/pending',
      'photoMetadata' => {
        'enabled' => false,
        'set_copyright' => false,
        'set_author' => false,
        'author' => 'NOT_SET',
        'prompted_metadatas' => [ 'title' ]
      },
      'watermark' => {
        'enabled' => false,
        'watermark_file' => '/img/watermark.svg'
      }
    }.freeze

    def initialize(site)
      @site   = site
      @config = DEFAULT.merge(site.config['photo_worflow_manager'] || {})
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

        photoPath = File.join(@pending_path, photo)

        if @config['photoMetadata']['enabled'] == true
          pm = Jekyll::PhotoMetadatas.new(photoPath,
                                          @config['photoMetadata'])
          pm.setDefaultMetadatas()
          pm.setPromptedMetadatas()
          pm.endsMetadatasEdit()
        end

        if @config['watermark']['enabled'] == true

          watermarkPath = File.join(@site.source, @config['watermark']['watermark_file'])

          wm = Jekyll::PhotoWatermark.new(
              photoPath,
              watermarkPath,
              @config['watermark']
          )

          wm.watermark()
        end

      end
    end

    def getAllPending
      entries = Dir.entries(@pending_path)
      entries.reject! { |x| x =~ /^\./ } # no ., .., and dotfiles
    end

  end
end
