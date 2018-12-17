module Jekyll
  module PhotoManager
    class Photo
      def initialize(path)
        @path = path
        Jekyll.logger.info "Photo manager Photo:", "initialized with path : #{@path}"
      end
    end
  end
end