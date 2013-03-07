require 'me2day/api/arguments'
require 'me2day/api/utils'
require 'me2day/core_ext/enumerable'
require 'me2day/error/not_found'
require 'me2day/profile_banner'
require 'me2day/settings'
require 'me2day/person'

module Me2day
  module API
    module People
      include Me2day::API::Utils
      
      def get_person(id)
        object_from_response(Me2day::Person, :get, "/api/get_person/#{id}.json")
      end

    end
  end
end
