require 'me2day/api/arguments'
require 'me2day/api/utils'
require 'me2day/post'
require 'me2day/person'
require 'time'

module Me2day
  module API
    module Undocumented
      include Me2day::API::Utils
      
      def search(term, options={})
        objects_from_response(Me2day::Post, :get, "/search.json", options.merge(:query => term))
      end
      
      # helper method for setting time parameters
      def search_in_time(term, begin_time, end_time, options={})
        search(term, options.merge(begin_time:begin_time.strftime('%Y.%m.%dT%H:%M'), end_time:end_time.strftime('%Y.%m.%dT%H:%M'), tz:'Asia/Seoul',time:'custom'))
      end
      
    end
  end
end
