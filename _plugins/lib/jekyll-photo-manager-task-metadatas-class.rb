module Jekyll

  module PhotoManager

    require_relative 'jekyll-photo-manager-task-module'

    class TaskMetadatas

      include Jekyll::PhotoManager::Task
      require 'mini_exiftool'
      require 'highline'

      def initialize(raw_path, task, index, site)
        super
        @cli = HighLine.new
      end


      def run
        Jekyll.logger.warn "#{self.class}", "START run"

        copy_files

        @work_files = get_files(@result_path)

        @work_files.each do |file|

          photo = MiniExiftool.new file

          set_default_metadatas(photo)

          unless @task_config['prompted_metadatas'].nil?
            set_prompted_metadatas(photo)
          end

          save_changes(photo)

          # @todo: optionally remove source files

        end

        Jekyll.logger.warn "#{self.class}", "END run"

      end

      # sets default metadatas defined in configuration
      def set_default_metadatas(photo)
        Jekyll.logger.info "#{self.class} set_default_metadatas",
                           "#{photo}"
        if @task_config['set_author']
          photo.author = @task_config['author']
        end

        if @task_config['set_copyright']
          photoDate = photo.createdate
          photoYear = photoDate.strftime("%Y")

          copyright_string = "Copyright #{photoYear} #{@task_config['author']}"
          photo.copyright = copyright_string
        end
      end

      # sets metadatas that needs user interaction
      def set_prompted_metadatas(photo)
        datas = @task_config['prompted_metadatas']

        datas.each do |data|
          showPhotoMessage = 'Would you like to see this picture in order to set ' + data + ' ?'
          showPhoto = yesOrNo(showPhotoMessage, :no)

          if showPhoto == true
            commandResult = showPhoto(photo.filename)
          end

          current = photo[data]
          promptMessage = "New #{data} = ? "

          default_value = if !current || current == ""
                            'NOT SET'
                          else
                            current
                          end

          response = @cli.ask(promptMessage) { |q| q.default = default_value }

          if response != default_value
            photo[data] = response
          end

        end
      end

      # recap changed tags and save photo
      def save_changes(photo)
        changed = photo.changed_tags

        if changed.empty?
          Jekyll.logger.info "#{self.class}", "Nothing changed skipping save"
        else
          changed.each do |tag|
            Jekyll.logger.info "#{self.class}", "changed '#{tag}' to '#{photo[tag]}'"
          end

          photo.save

          Jekyll.logger.info "#{self.class}", "changes saved"
        end
      end

      # launch a system command to show photo in current image viewer
      # UBUNTU ONLY ! or maybe linux
      # NOT WIN NOR MAC
      def showPhoto(path)
        cmd = 'xdg-open ' + path
        Jekyll.logger.info "#{self.class}", "system command #{cmd}"
        wasGood = system( cmd )
      end

    end

  end

end
