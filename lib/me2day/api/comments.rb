#encoding: utf-8
require 'me2day/api/arguments'
require 'me2day/api/utils'

module Me2day
  module API
    module Comments
      include Me2day::API::Utils
      
      # 지정한 글에 달린 댓글을 조회합니다.
      # @see http://api.me2day.net/reference/manual.nhn?api=get_comments
      def get_comments(post_id, options={})
        object_from_response(Me2day::CommentList, :get, "/api/get_comments.json", options.merge(:post_id => post_id))
      end
      
      # 지정한 글에 댓글을 작성합니다.
      # @see http://api.me2day.net/reference/manual.nhn?api=create_comment
      def create_comment(post_id, body, options={}) 
        post("/api/create_comment.json", options.merge(:body => body, :post_id => post_id))[:body]
      end
      
      # 지정한 댓글을 삭제합니다.
      # 자신이 작성한 댓글 및 자신이 작성한 글에 달린 댓글만 삭제할 수 있습니다.
      # @see http://api.me2day.net/reference/manual.nhn?api=delete_comment
      def delete_comment(comment_id)
        delete("/api/delete_comment.json", {:comment_id => comment_id})[:body]
      end
      
      # 지정한 사용자가 작성한 글에 달린 댓글 혹은 지정한 사용자가 직접 작성한 댓글을 조회합니다.
      # @see http://api.me2day.net/reference/manual.nhn?api=track_comments
      def track_comments(user_name, scope="all")
        object_from_response(Me2day::CommentLog, :get, "/api/track_comments/#{user_name}.json", {:scope => scope})
      end
    end
  end
end
