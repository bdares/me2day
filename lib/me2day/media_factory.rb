require 'me2day/factory'
require 'me2day/media/photo'

module Me2day
  class MediaFactory < Me2day::Factory

    # Instantiates a new media object
    #
    # @param attrs [Hash]
    # @raise [ArgumentError] Error raised when supplied argument is missing a :type key.
    # @return [Me2day::Media]
    def self.fetch_or_new(attrs={})
      super(:type, Me2day::Media, attrs)
    end

  end
end
