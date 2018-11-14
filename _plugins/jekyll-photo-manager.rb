module Jekyll

  # uses mini_exiftool https://github.com/janfri/mini_exiftool

  class Photo

    require 'mini_exiftool'
    require 'highline'

    def initialize(fileName, path, config)
      photoPath = File.join(path, fileName)
      @photo = MiniExiftool.new photoPath
      @config = config
      @cli = HighLine.new
      Jekyll.logger.info "Photo:", "initialized for #{fileName}"
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
      Jekyll.logger.info "PhotoManager:", "system command #{cmd}"
      wasGood = system( cmd )
    end

    def endsEdit
      changed = @photo.changed_tags

      if changed.empty?
        Jekyll.logger.info "Nothing changed skipping save"
      else
        changed.each do |tag|
          Jekyll.logger.info "Photo:", "changed for #{tag} to #{@photo[tag]}"
        end

        @photo.save
        Jekyll.logger.info "Photo:", "changes saved"
      end

    end

  end

end
