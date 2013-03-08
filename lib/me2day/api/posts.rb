#encoding: utf-8
require 'me2day/api/arguments'
require 'me2day/api/utils'
require 'me2day/error/forbidden'

module Me2day
  module API
    module Posts
      include Me2day::API::Utils
      
      # 특정 미투데이 사용자의 글 목록이나, 특정 글의 정보를 조회합니다.
      # @see http://api.me2day.net/reference/manual.nhn?api=get_posts
      def get_posts(username=nil, options={})
        if username
          objects_from_response(Me2day::Post, :get, "/api/get_posts/#{username}.json", options)
        else
          objects_from_response(Me2day::Post, :get, "/api/get_posts.json", options).first
        end
      end
      
      # utility method for finding a single post by id
      def get_post(post_id)
        get_posts(nil, :post_id => post_id)
      end

      # 미투데이 글을 삭제합니다.
      # @see http://api.me2day.net/reference/manual.nhn?api=delete_post
      def delete_post(post_id)
        threaded_tweets_from_response(:post, "/api/delete_post.json", {:post_id=>post_id})
      end

      # 글 관련 API는 미투데이에 글을 쓰고, 읽고, 삭제하는 기능을 제공합니다.
      # @see http://api.me2day.net/reference/manual.nhn?api=create_post
      def create_post(body, options={})
        object_from_response(Me2day::Post, :post, "/api/create_post.json", options.merge('post[body]' => body))
      end
    end
  end
end
