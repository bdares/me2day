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
          object_from_response(Me2day::Post, :get, "/api/get_posts.json", options)
        end
      end


      # 미투데이 글을 삭제합니다.
      # @see http://api.me2day.net/reference/manual.nhn?api=delete_post
      def delete_post(post_id)
        threaded_tweets_from_response(:post, "/api/delete_post.json", {:post_id=>post_id})
      end

      # 글 관련 API는 미투데이에 글을 쓰고, 읽고, 삭제하는 기능을 제공합니다.
      # @see http://api.me2day.net/reference/manual.nhn?api=create_post
      def create_post(status, options={})
        object_from_response(Me2day::Post, :post, "/1.1/statuses/update.json", options.merge(:status => status))
      end

      # Retweets the specified Tweets as the authenticating user
      #
      # @see https://dev.me2day.com/docs/api/1.1/post/statuses/retweet/:id
      # @rate_limited Yes
      # @authentication Requires user context
      # @raise [Me2day::Error::Unauthorized] Error raised when supplied user credentials are not valid.
      # @return [Array<Me2day::Tweet>] The original tweets with retweet details embedded.
      # @overload retweet(*ids)
      #   @param ids [Array<Integer>, Set<Integer>] An array of Tweet IDs.
      #   @example Retweet the Tweet with the ID 28561922516
      #     Me2day.retweet(28561922516)
      # @overload retweet(*ids, options)
      #   @param ids [Array<Integer>, Set<Integer>] An array of Tweet IDs.
      #   @param options [Hash] A customizable set of options.
      #   @option options [Boolean, String, Integer] :trim_user Each tweet returned in a timeline will include a user object with only the author's numerical ID when set to true, 't' or 1.
      def retweet(*args)
        arguments = Me2day::API::Arguments.new(args)
        arguments.flatten.threaded_map do |id|
          begin
            post_retweet(id, arguments.options)
          rescue Me2day::Error::Forbidden => error
            raise unless error.message == Me2day::Error::AlreadyRetweeted::MESSAGE
          end
        end.compact
      end

    private

      # @param request_method [Symbol]
      # @param path [String]
      # @param args [Array]
      # @return [Array<Me2day::Tweet>]
      def threaded_tweets_from_response(request_method, path, args)
        arguments = Me2day::API::Arguments.new(args)
        arguments.flatten.threaded_map do |id|
          object_from_response(Me2day::Tweet, request_method, path + "/#{id}.json", arguments.options)
        end
      end

      def post_retweet(id, options)
        response = post("/1.1/statuses/retweet/#{id}.json", options)
        retweeted_status = response.dup
        retweeted_status[:body] = response[:body].delete(:retweeted_status)
        retweeted_status[:body][:retweeted_status] = response[:body]
        Me2day::Tweet.from_response(retweeted_status)
      end

    end
  end
end
