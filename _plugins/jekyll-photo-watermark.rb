module Jekyll

  class PhotoWatermark

    require "mini_magick"
    require 'highline'

    def initialize(photoPath, watermarkPath, config)
      @photoPath = photoPath
      @watermarkPath = watermarkPath
      @config = config
      @cli = HighLine.new
      Jekyll.logger.info "Photo watermark:", "initialized for #{photoPath}"
    end

    def watermark
      img    = MiniMagick::Image.new(@photoPath)
      wm     = MiniMagick::Image.new(@watermarkPath)

      result = img.composite(wm) do |c|
        c.compose "Over"    # OverCompositeOp
        c.watermark "50%"
        c.gravity "south"
        c.geometry "+20+20" # copy second_image onto first_image from (20, 20)
        c.background "none"
      end
      result.write "output.jpg"
    end

    def yesOrNo(message, defaultAnswer= :yes)
      @cli.choose do |menu|
        menu.prompt = message
        menu.choice(:yes) { true }
        menu.choices(:no) { false }
        menu.default = defaultAnswer
      end
    end

    def showPhoto(path)

    end

  end

end
