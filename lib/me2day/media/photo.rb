require 'me2day/identity'

module Me2day
  module Media
    class Photo < Me2day::Identity
      attr_reader :display_url, :expanded_url, :indices, :media_url,
        :media_url_https, :url

      # Returns an array of photo sizes
      #
      # @return [Array<Me2day::Size>]
      def sizes
        @sizes ||= Array(@attrs[:sizes]).inject({}) do |object, (key, value)|
          object[key] = Me2day::Size.fetch_or_new(value)
          object
        end
      end

    end
  end
end
