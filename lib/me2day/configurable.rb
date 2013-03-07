require 'forwardable'
require 'me2day/error/configuration_error'

module Me2day
  module Configurable
    extend Forwardable
    attr_writer :application_key, :user_id, :user_key
    attr_accessor :endpoint, :connection_options, :identity_map, :middleware
    def_delegator :options, :hash

    class << self

      def keys
        @keys ||= [
          :application_key,
          :user_id,
          :user_key,
          :endpoint,
          :connection_options,
          :identity_map,
          :middleware,
        ]
      end

    end

    # Convenience method to allow configuration options to be set in a block
    #
    # @raise [Me2day::Error::ConfigurationError] Error is raised when supplied
    #   me2day credentials are not a String or Symbol.
    def configure
      yield self
      validate_credential_type!
      self
    end

    # @return [Boolean]
    def credentials?
      credentials.values.all?
    end

    def reset!
      Me2day::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Me2day::Default.options[key])
      end
      self
    end
    alias setup reset!

  private

    # @return [Hash]
    def credentials
      {
        :application_key => @application_key,
        :user_id => @user_id,
        :user_key => @user_key,
      }
    end

    # @return [Hash]
    def options
      Hash[Me2day::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

    # Ensures that all credentials set during configuration are of a
    # valid type. Valid types are String and Symbol.
    #
    # @raise [Me2day::Error::ConfigurationError] Error is raised when
    #   supplied me2day credentials are not a String or Symbol.
    def validate_credential_type!
      credentials.each do |credential, value|
        next if value.nil?

        unless value.is_a?(String) || value.is_a?(Symbol)
          raise(Error::ConfigurationError, "Invalid #{credential} specified: #{value} must be a string or symbol.")
        end
      end
    end

  end
end
