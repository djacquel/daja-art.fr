module Jekyll

  class PhotoMetadatas

    require 'mini_exiftool'
    require 'highline'

    def initialize(photoPath, config)
      watermarkPath = File.join()
      @photo = MiniExiftool.new photoPath
      @config = config
      @cli = HighLine.new
      Jekyll.logger.info "Photo metadatas:", "initialized for #{photoPath}"
    end

    # sets default metadatas defined in configuration
    def setDefaultMetadatas()
      if @config['set_author']
        @photo.author = @config['author']
      end

      if @config['set_copyright']
        photoDate = @photo.createdate
        photoYear = photoDate.strftime("%Y")

        copyright_string = "Copyright #{photoYear} #{@config['author']}"
        @photo.copyright = copyright_string
      end
    end

    # sets metadatas that needs user interaction
    def setPromptedMetadatas()
      datas = @config['prompted_metadatas']

      datas.each do |data|
        showPhotoMessage = 'Would you like to see this picture in order to set ' + data + ' ?'
        showPhoto = yesOrNo(showPhotoMessage, :no)

        if showPhoto == true
          commandResult = showPhoto(@photo.filename)
        end

        current = @photo[data]
        promptMessage = "New #{data} = ? "

        if !current || current == ""
          default_value = "NOT SET"
        else
          default_value = current
        end

        response = @cli.ask(promptMessage) { |q| q.default = default_value }

        if response != default_value
          @photo[data] = response
        end

      end
    end

    # recap changed tags and save photo
    def endsMetadatasEdit
      changed = @photo.changed_tags

      if changed.empty?
        Jekyll.logger.info "Nothing changed skipping save"
      else
        changed.each do |tag|
          Jekyll.logger.info "Photo metadatas:", "changed for #{tag} to #{@photo[tag]}"
        end

        @photo.save

        Jekyll.logger.info "Photo metadatas:", "changes saved"
      end
    end

    def yesOrNo(message, defaultAnswer= :yes)
      @cli.choose do |menu|
        menu.prompt = message
        menu.choice(:yes) { true }
        menu.choices(:no) { false }
        menu.default = defaultAnswer
      end
    end

    # launch a system command to show photo in current image viewer
    # UBUNTU ONLY ! or maybe linux
    # NOT WIN NOR MAC
    def showPhoto(path)
      cmd = 'xdg-open ' + path
      Jekyll.logger.info "Photo metadatas:", "system command #{cmd}"
      wasGood = system( cmd )
    end

  end

end
