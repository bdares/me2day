require 'faraday'
require 'multi_json'
require 'me2day/api/etc'
require 'me2day/api/metoos'
require 'me2day/api/people'
require 'me2day/api/posts'
require 'me2day/api/undocumented'
require 'me2day/configurable'
require 'me2day/error/client_error'
require 'me2day/error/decode_error'
require 'me2day/error/configuration_error'
require 'simple_oauth'
require 'uri'

module Me2day
  # Wrapper for the Me2day REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in {http://dev.me2day.com/doc the Me2day API Documentation}.
  # @see http://dev.me2day.com/pages/every_developer
  class Client
    include Me2day::API::Posts
    include Me2day::API::Undocumented
    include Me2day::API::People
    include Me2day::API::Metoos
    include Me2day::API::Etc
    include Me2day::Configurable

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Me2day::Client]
    def initialize(options={})
      Me2day::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Me2day.instance_variable_get(:"@#{key}"))
      end
    end

    # Perform an HTTP DELETE request
    def delete(path, params={})
      request(:delete, path, params)
    end

    # Perform an HTTP GET request
    def get(path, params={})
      request(:get, path, params)
    end

    # Perform an HTTP POST request
    def post(path, params={})
      signature_params = params.values.any?{|value| value.respond_to?(:to_io)} ? {} : params
      request(:post, path, params, signature_params)
    end

    # Perform an HTTP PUT request
    def put(path, params={})
      request(:put, path, params)
    end
    
    # Return an authorization url
    def auth_url
      raise Me2day::Error::ClientError.new unless options[:application_key]
      connection.get("/api/get_auth_url.json") do |request|
        request.headers[:me2_application_key] = options[:application_key]
      end.env[:body][:url]
    rescue Faraday::Error::ClientError
      raise Me2day::Error::ClientError
    end

  private

    # standard request
    def request(method, path, params={}, signature_params=params)
      connection.send(method.to_sym, path, params.merge(auth)).env
    rescue Faraday::Error::ClientError
      raise Me2day::Error::ClientError
    rescue MultiJson::DecodeError
      raise Me2day::Error::DecodeError
    end
    
    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= Faraday.new(@endpoint, @connection_options.merge(:builder => @middleware))
    end

    def auth
      return {} unless options[:user_id] && options[:user_key]
      # raise Me2day::Error::ConfigurationError.new("user_id and user_key must be defined") unless options[:user_id] && options[:user_key]
      {:uid => options[:user_id], :ukey => ukey(options[:user_key])}
    end
    
    def ukey(user_key)
      nonce = rand(0xffffffff).to_s(16)
      nonce + Digest::MD5.hexdigest(nonce + user_key)
    end
  end
end
