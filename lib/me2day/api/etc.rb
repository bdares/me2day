require 'me2day/api/arguments'
require 'me2day/api/utils'

module Me2day
  module API
    module Etc
      include Me2day::API::Utils
      
      def noop
        get("/api/noop.json")
      end
      
      alias verify_credentials noop
      
      def get_bands
        objects_from_response(Me2day::Band, :get, "/api/get_bands.json")
      end
      
      private

    end
  end
end
