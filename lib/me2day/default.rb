require 'faraday'
require 'faraday/request/multipart'
require 'me2day/configurable'
require 'me2day/error/client_error'
require 'me2day/error/server_error'
require 'me2day/request/multipart_with_file'
require 'me2day/response/parse_json'
require 'me2day/response/raise_error'
require 'me2day/version'

module Me2day
  module Default
    ENDPOINT = 'http://me2day.net' unless defined? Me2day::Default::ENDPOINT
    CONNECTION_OPTIONS = {
      :headers => {
        :accept => 'application/json',
        :user_agent => "Me2day Ruby Gem #{Me2day::Version}",
      },
      :request => {
        :open_timeout => 5,
        :timeout => 10,
      },
      :ssl => {
        :verify => false
      },
    } unless defined? Me2day::Default::CONNECTION_OPTIONS
    IDENTITY_MAP = false unless defined? Me2day::Default::IDENTITY_MAP
    MIDDLEWARE = Faraday::Builder.new do |builder|
      # Convert file uploads to Faraday::UploadIO objects
      builder.use Me2day::Request::MultipartWithFile
      # Checks for files in the payload
      builder.use Faraday::Request::Multipart
      # Convert request params to "www-form-urlencoded"
      builder.use Faraday::Request::UrlEncoded
      # Handle 4xx server responses
      builder.use Me2day::Response::RaiseError, Me2day::Error::ClientError
      # Parse JSON response bodies using MultiJson
      builder.use Me2day::Response::ParseJson
      # Handle 5xx server responses
      builder.use Me2day::Response::RaiseError, Me2day::Error::ServerError
      # Set Faraday's HTTP adapter
      builder.adapter Faraday.default_adapter
    end unless defined? Me2day::Default::MIDDLEWARE

    class << self

      # @return [Hash]
      def options
        Hash[Me2day::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # @return [String]
      def application_key
        ENV['ME2DAY_APPLICATION_KEY']
      end

      # @return [String]
      def user_id
        ENV['ME2DAY_USER_ID']
      end

      # @return [String]
      def user_key
        ENV['ME2DAY_USER_KEY']
      end

      # @note This is configurable in case you want to use a Me2day-compatible endpoint.
      # @return [String]
      def endpoint
        ENDPOINT
      end

      def connection_options
        CONNECTION_OPTIONS
      end

      def identity_map
        IDENTITY_MAP
      end

      # @note Faraday's middleware stack implementation is comparable to that of Rack middleware.  The order of middleware is important: the first middleware on the list wraps all others, while the last middleware is the innermost one.
      # @see https://github.com/technoweenie/faraday#advanced-middleware-usage
      # @see http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
      # @return [Faraday::Builder]
      def middleware
        MIDDLEWARE
      end

    end
  end
end
