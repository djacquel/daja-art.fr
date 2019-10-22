module Jekyll

  module PhotoManager

    require "active_support/core_ext/hash/deep_merge"
    ##
    # Manage tasks like resize, watermark, EXIF, ..., that are run over raw pictures
    #
    class Manager

      DEFAULT = {
        "enabled"=> false,
        "images_path"=> "/_photo_manager",
        "raw_images_path"=> "/raw",
        "ressources_path" => "/ressources",

        "tasks"=> {
          "metadatas"=> {
            "enabled"=> false,
            "set_copyright"=> false,
            "set_author"=> false,
            "author"=> "Not set",
            "prompted_metadatas"=> ["title"]
          },
          "orientation"=> {
              "enabled"=> false
          },
          "resize"=> {
              "enabled"=> false,
              "sizes"=>[1024, 250]
          },
          "signature"=> {
              "enabled"=> false,
              "signature_file"=> "/img/logo-dj.svg"
          },
          "tags"=> {
              "enabled"=> false,
          },
          "watermark"=> {
            "enabled"=> false,
            "watermark_file"=> "/img/watermark.svg"
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
        @config = DEFAULT.deep_merge(site.config['photo_manager']).freeze
        @pm_images_root_path = File.join(site.source, @config['images_path'])

        @pm_images_raw_path = File.join(@pm_images_root_path, @config['raw_images_path'])
        unless Dir.exist?(@pm_images_raw_path)
          raise Errors::FatalException,
                "Raw photos folder '#{@pm_images_raw_path}' doesn't exist. Please create it."
        end

        @enabled_tasks = getEnabledTasks
        if @enabled_tasks.empty?
          Jekyll.logger.warn "#{self.class}", "No module enabled. /
               Enable at least one by setting enabled to true in the config."
        end
      end

      # runs all enabled tasks on raw photos
      def run
        unless @config["enabled"]
          Jekyll.logger.warn "#{self.class}", "Photo Manager is disabled./
 Read the doc to learn how to enable it !"
          return
        end

        # task is an array like [ "taskname", {configVar=>{},...} ]
        @enabled_tasks.each_with_index { |task, index|
          Jekyll.logger.info "#{self.class}", "Init task : #{task.first} with config : #{task.last}"
          Jekyll.logger.info "#{self.class}", "task index = #{index}"

          # construct class name based on task name
          className = "Task#{task.first.capitalize}"
          taskClass = Jekyll::PhotoManager.const_get(className)

          if index == 0
            images_origin_path = @pm_images_raw_path
          else
            images_origin_path = File.join(@pm_images_root_path, --index.to_s)
          end

          images_destination_path = File.join(@pm_images_root_path, index.to_s)

          current_task = taskClass.new(images_origin_path,
                                       images_destination_path,
                                       task,
                                       @site)
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
