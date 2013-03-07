require 'me2day/base'

module Me2day
  class Size < Me2day::Base
    attr_reader :h, :resize, :w
    alias height h
    alias width w

    # @param other [Me2day::Size]
    # @return [Boolean]
    def ==(other)
      super || size_equal(other) || attrs_equal(other)
    end

  protected

    # @param other [Me2day::Size]
    # @return [Boolean]
    def size_equal(other)
      self.class == other.class && !other.h.nil? && h == other.h && !other.w.nil? && w == other.w
    end

  end
end
