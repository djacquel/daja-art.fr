module Jekyll

  module PhotoManager

    require "active_support/core_ext/hash/deep_merge"
    ##
    # Manage tasks like resize, watermark, EXIF, ..., that are run over raw pictures
    #
    class Manager

      DEFAULT = {
        "enabled"=> true,
        "images_path"=> "/img",
        "raw_images_path"=> "/raw",
        "tasks"=> {
          "metadatas"=> {
            "enabled"=> false,
            "set_copyright"=> false,
            "set_author"=> false,
            "author"=> "Not set",
            "prompted_metadatas"=> ["title"]
          },
          "watermark"=> {
            "enabled"=> false,
            "watermark_file"=> "/img/watermark.svg"
          },
          "signature"=> {
            "enabled"=> false,
            "signature_file"=> "/img/logo-dj.svg"
          },
          "resize"=> {
            "enabled"=> false
          },
          "post"=> {
            "enabled"=> false
          }
        }
      }.freeze

      ##
      # Initialize the Manager
      #
      #
      def initialize(site)
        @site   = site
        @config = DEFAULT.deep_merge(site.config['photo_manager'])

        @raw_path = File.join(site.source, @config['images_path'], @config['raw_images_path'])

        unless Dir.exist?(@raw_path)
          raise Errors::FatalException,
                "Raw photos folder '#{@raw_path}' doesn't exist. Please create it."
        end
        @enabled_tasks = getEnabledTasks

        if @enabled_tasks.empty?
          Jekyll.logger.warn "#{self.class}", "No module enabled. /
               Enable at least one by setting enabled to true in the config."
        end
      end

      # runs on all tasks on raw photos
      def run
        # task is an array like [ "taskname", {configVar=>{},...} ]
        @enabled_tasks.each_with_index { |task, index|
          Jekyll.logger.info "#{self.class}", "Init task : #{task.first} with config : #{task.last}"
          Jekyll.logger.info "#{self.class}", "task index = #{index}"

          # construct class name based on task name
          className = "Task#{task.first.capitalize}"
          taskClass = Jekyll::PhotoManager.const_get(className)

          current_task = taskClass.new(@raw_path, task, index)
          current_task.run
        }
      end

      def getEnabledTasks
        modules_config = @config['tasks']
        modules_config.select do |task, config|
          config['enabled'] == true
        end
      end

    end
  end
end
