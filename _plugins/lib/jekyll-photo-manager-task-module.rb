module Jekyll

  module PhotoManager

    module Task

      def initialize(images_origin_path, images_destination_path, task, site)
        @current_path = images_origin_path
        @result_path  = images_destination_path
        @task_name = task.first
        @task_config = task.last
        @site = site
        Jekyll.logger.warn "#{self.class}", "#{@task_name} initialized with config : #{@task_config}"
      end

      def copy_files
        FileUtils.copy_entry(@current_path,
                             @result_path,
                             dereference_root = true,
                             preserve = true,
                             remove_destination = true)
      end

      # search for files only, in a given directory
      def get_files(path)
        entries = Dir.glob("#{path}/**/*").select {|f| !File.directory? f}
      end

      def yesOrNo(message, defaultAnswer= :yes)
        @cli.choose do |menu|
          menu.prompt = message
          menu.choice(:yes) { true }
          menu.choices(:no) { false }
          menu.default = defaultAnswer
        end
      end

    end

  end

end
