module Jekyll
  module PhotoManager
    require_relative 'jekyll-photo-manager-task-module'

    ##
    # Ensures that all photos are rotated
    # as specified in EXIF metadatas
    class TaskOrientation

      include Jekyll::PhotoManager::Task
      require 'mini_magick'

      def run
        Jekyll.logger.warn "#{self.class}", "START run"
        copy_files
        @work_files = get_files(@result_path)

        @work_files.each do |file|
          photo = MiniMagick::Image.open file
          photo.auto_orient
          photo.write file
        end

        Jekyll.logger.warn "#{self.class}", "END run"
      end

    end
  end
end
