require 'faraday'
require 'me2day/error/bad_gateway'
require 'me2day/error/bad_request'
require 'me2day/error/forbidden'
require 'me2day/error/gateway_timeout'
require 'me2day/error/internal_server_error'
require 'me2day/error/not_acceptable'
require 'me2day/error/not_found'
require 'me2day/error/service_unavailable'
require 'me2day/error/too_many_requests'
require 'me2day/error/unauthorized'
require 'me2day/error/unprocessable_entity'

module Me2day
  module Response
    class RaiseError < Faraday::Response::Middleware

      def on_complete(env)
        status_code = env[:status].to_i
        error_class = @klass.errors[status_code]
        raise error_class.from_response(env) if error_class
      end

      def initialize(app, klass)
        @klass = klass
        super(app)
      end

    end
  end
end
