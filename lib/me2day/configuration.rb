require 'me2day/base'

module Me2day
  class Configuration < Me2day::Base
    attr_reader :characters_reserved_per_media, :max_media_per_upload,
      :non_username_paths, :photo_size_limit, :short_url_length, :short_url_length_https

    # Returns an array of photo sizes
    #
    # @return [Array<Me2day::Size>]
    def photo_sizes
      @photo_sizes ||= Array(@attrs[:photo_sizes]).inject({}) do |object, (key, value)|
        object[key] = Me2day::Size.fetch_or_new(value)
        object
      end
    end

  end
end
