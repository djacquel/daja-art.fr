module Jekyll
  module Tags

    # Custom include tag
    # add comments around includes
    # if *comment_includes* configuration is set to *true* in _config.yml
    class IncludeTag

      # override original method
      alias_method :old_read_file, :read_file

      def read_file(file, context)
        fileContent = File.read(file, file_read_opts(context))

        site  = context.registers[:site]
        debug = site.config['comment_includes']

        if debug
          file.slice!(site.source)
          fileContent = "<!-- #{file} -->\n#{fileContent}<!-- End #{file} -->"
        end

        fileContent

      end

    end
  end
end

# Liquid::Template.register_tag("include", Jekyll::Tags::IncludeCustomTag)
