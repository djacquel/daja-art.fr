module Jekyll
  module PhotoManager
    require_relative 'jekyll-photo-manager-task-module'

    class TaskResize

      include Jekyll::PhotoManager::Task
      require 'mini_magick'
      require 'highline'

      # def initialize(raw_path, task, index, site)
      #   super
      # end

      def run
        Jekyll.logger.warn "#{self.class}", "START run"

        copy_files

        @work_files = get_files(@result_path)

        @work_files.each do |file|
          resize file
          # @todo: optionally remove source files
        end

        Jekyll.logger.warn "#{self.class}", "END run"

      end

      def resize(file)
        photo = MiniMagick::Image.new(file)

        sizes = @task_config['sizes']

        sizes.each do |size|
          # resize image
          photo.resize("#{size}x#{size}>")
          photo.quality(@task_config['quality'])
          # generate a name
          original_filename = File.basename(file, '.*')
          extension = File.extname(file).delete('.')

          new_filename = "#{original_filename}-#{photo[:width]}x#{photo[:height]}.#{extension}"
          new_path = File.join(@result_path, new_filename)
          # save
          photo.write new_path
        end

        # delete work image
        File.delete file
      end

    end
  end
end
