module Jekyll
  module PhotoManager
    require_relative 'jekyll-photo-manager-task-module'

    class TaskSignature

      include Jekyll::PhotoManager::Task
      require 'mini_magick'
      require 'highline'

      def initialize(raw_path, task, index, site)
        super
        @cli = HighLine.new
      end

      def run
        Jekyll.logger.warn "#{self.class}", "START run"

        copy_files

        @work_files = get_files(@result_path)
        signature_path = File.join(@site.source,
                                   @task_config['signature_file'])
        @work_files.each do |file|
          @signature_file = MiniMagick::Image.open(signature_path)
          add_signature file
          # @todo: optionally remove source files
        end

        Jekyll.logger.warn "#{self.class}", "END run"

      end

      def add_signature(file)
        photo = MiniMagick::Image.new file

        # needed to calculate signature size

        @original_width = photo[:width]
        @original_height = photo[:height]

        set_dimension(photo)

        unless @max_dimension < @task_config['min_picture_size']
          sign(photo)
        end

      end

      def sign(photo)

        # @todo calculate signature size
        ratio = @original_width.to_f / @task_config['min_picture_size'].to_f
        percent = "#{@task_config['signature_ratio'] * ratio}%"

        @signature_file.resize(percent, '-background', 'none')

        result = photo.composite(@signature_file) do |c|
          c.compose "Over"    # OverCompositeOp
          c.watermark "50%"
          c.gravity "SouthEast"
          c.geometry "+10+10" # copy second_image onto first_image from (20, 20)
          c.background "none"
        end

        result.write photo.path

      end

    end
  end
end
