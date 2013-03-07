require 'me2day/base'

module Me2day
  class ProfileBanner < Me2day::Base

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
