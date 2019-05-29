module Jekyll

  module PhotoManager

    module Task

      def initialize(raw_path, task, index, site)
        @current_path = raw_path + '/' + index.to_s
        @result_path  = raw_path + '/' + (index+1).to_s
        @task_name = task.first
        @task_config = task.last
        @site = site
        Jekyll.logger.warn "#{self.class}",
                           "#{@task_name} initialized with config : #{@task_config}"

        if Dir.exist?(@result_path)
          FileUtils.remove_dir(@result_path)
        end
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

      def set_dimension(photo)
        @original_width = photo[:width]
        @original_height = photo[:height]
        @max_dimension = if @original_height > @original_width # portrait
                           @original_height
                         else # landscape or square
                           @original_width
                         end
      end

    end

  end

end
