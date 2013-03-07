require 'me2day/base'

module Me2day
  class Geo < Me2day::Base
    attr_reader :coordinates
    alias coords coordinates

    # @param other [Me2day::Geo]
    # @return [Boolean]
    def ==(other)
      super || attr_equal(:coordinates, other) || attrs_equal(other)
    end

  end
end
