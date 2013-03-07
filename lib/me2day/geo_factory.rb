require 'me2day/factory'
require 'me2day/geo/point'
require 'me2day/geo/polygon'

module Me2day
  class GeoFactory < Me2day::Factory

    # Instantiates a new geo object
    #
    # @param attrs [Hash]
    # @raise [ArgumentError] Error raised when supplied argument is missing a :type key.
    # @return [Me2day::Geo]
    def self.fetch_or_new(attrs={})
      super(:type, Me2day::Geo, attrs)
    end

  end
end
