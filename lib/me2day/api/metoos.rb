#encoding: utf-8
require 'me2day/api/arguments'
require 'me2day/api/utils'

module Me2day
  module API
    module Metoos
      include Me2day::API::Utils
      
      # 미투 관련 API는 미투데이 글에 미투하기 및 미투한 사용자 목록을 조회하는 기능을 제공합니다.
      # @see http://api.me2day.net/reference/manual.nhn?api=get_metoos
      def get_metoos(post_id, options={})
        object_from_response(Me2day::MetooResult, :get, "/api/get_metoos.json", options.merge(:post_id => post_id))
      end

      # 지정한 글에 미투합니다.
      # @see http://api.me2day.net/reference/manual.nhn?api=metoo
      # returns a hash: {:cnt => [Fixnum], :description => [String], :message => [String], :code => [Fixnum]}
      def metoo(post_id)
        post("/api/metoo.json", {:post_id=>post_id})[:body]
      end
    end
  end
end
