module Jekyll

  # uses mini_exiftool https://github.com/janfri/mini_exiftool

  class PhotoManager

    require 'mini_exiftool'
    require 'highline'

    def initialize(fileName, path, config)
      photoPath = File.join(path, fileName)
      @photo = MiniExiftool.new photoPath
      @config = config
      @cli = HighLine.new
      Jekyll.logger.info "PhotoManager:", "initialized for #{fileName}"
    end

    # sets default metadatas defined in configuration
    def setDefaultMetadatas()
      datas = @config['default_metadatas']
      datas.each do |data|
        @photo[data[0]] = data[1]
      end
    end

    # sets metadatas that needs user interaction
    def setPromptedMetadatas()
      datas = @config['prompted_metadatas']

      datas.each do |data|
        showPhoto = yesOrNo('Would you like to see this picture in order to set ' + data + ' ?')
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

    def yesOrNo(message)
      @cli.choose do |menu|
        menu.prompt = message
        menu.choice(:yes) { true }
        menu.choices(:no) { false }
        menu.default = :yes
      end
    end

    def showPhoto(path)
      cmd = 'xdg-open ' + path
      Jekyll.logger.info "PhotoManager:", "system command #{cmd}"
      wasGood = system( cmd )
    end

    def endsEdit
      @photo.save
      datas = @config['default_metadatas']
      datas.each do |data|
        puts "edited : photo #{data[0]} >> #{@photo[data[0]]}"
      end
      prompted = @config['prompted_metadatas']
      prompted.each do |data|
        puts "edited : photo #{data} >> #{@photo[data]}"
      end
    end

  end

end
