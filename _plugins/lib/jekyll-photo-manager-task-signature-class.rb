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

        signature_path = File.join(@site.source,
                                   @task_config['signature_file'])

        @signature_file = MiniMagick::Image.new(signature_path)
      end

      def run
        Jekyll.logger.warn "#{self.class}", "START run"

        copy_files

        @work_files = get_files(@result_path)

        @work_files.each do |file|
          add_signature file
          # @todo: optionally remove source files
        end

        Jekyll.logger.warn "#{self.class}", "END run"

      end

      def add_signature(file)
        photo = MiniMagick::Image.new file

        # needed to calculate signature size
        w = photo[:width]
        h = photo[:height]

        # @todo calculate signature size

        result = photo.composite(@signature_file) do |c|
          c.compose "Over"    # OverCompositeOp
          c.watermark "70%"
          c.gravity "SouthEast"
          c.geometry "+50+200" # copy second_image onto first_image from (20, 20)
          c.background "none"
        end
        result.write photo.path
      end

    end
  end
end
