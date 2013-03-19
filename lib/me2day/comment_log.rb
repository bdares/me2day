require 'forwardable'
require 'me2day/api/utils'
require 'me2day/comment_by_me'
require 'me2day/comment_to_me'

module Me2day
  # returned by the comments api (track_comments)
  class CommentLog < Me2day::Base
    extend Forwardable
    attr_reader :me
  
    def comment_by_mes
      return unless @attrs[:comment_by_mes]
      @comment_by_mes ||= @attrs[:comment_by_mes].map{|x| CommentByMe.new x}
    end
    
    def comment_to_mes
      return unless @attrs[:comment_to_mes]
      @comment_to_mes ||= @attrs[:comment_to_mes].map{|x| CommentToMe.new x}
    end
  end
end
