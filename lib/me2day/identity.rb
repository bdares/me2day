require 'me2day/base'
require 'me2day/error/identity_map_key_error'

module Me2day
  class Identity < Me2day::Base

    def self.fetch(attrs, primary_key=:id)
      return unless identity_map

      id = attrs[primary_key]
      if id  && object = identity_map.fetch(id)
        return object.update(attrs)
      end

      return yield if block_given?
      raise Me2day::Error::IdentityMapKeyError, "key not found"
    end

    # Stores an object in the identity map.
    #
    # @param object [Object]
    # @return [Me2day::Identity]
    def self.store(object)
      return object unless identity_map
      identity_map.store(object.id, object)
    end

    # Initializes a new object
    #
    # @param attrs [Hash]
    # @raise [ArgumentError] Error raised when supplied argument is missing an :id key.
    # @return [Me2day::Identity]
    def initialize(attrs={})
      super
      raise ArgumentError, "argument must have an :id key" unless id
    end

    # @param other [Me2day::Identity]
    # @return [Boolean]
    def ==(other)
      super || attr_equal(:id, other) || attrs_equal(other)
    end

    # @return [Integer]
    def id
      @attrs[:id] || @attrs[:post_id]
    end

  end
end
