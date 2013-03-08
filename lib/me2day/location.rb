require 'me2day/base'

module Me2day
  class Location < Me2day::Base
    attr_reader :name, :longitude, :latitude, :address
  end
end
