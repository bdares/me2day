require 'me2day/api/arguments'
require 'me2day/api/utils'
require 'me2day/post'
require 'me2day/person'

module Me2day
  module API
    module Undocumented
      include Me2day::API::Utils
      
      def search(term, options={})
        objects_from_response(Me2day::Post, :get, "/search.json", options.merge(:query => term))
      end

    end
  end
end
