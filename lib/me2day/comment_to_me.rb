require 'forwardable'

module Me2day
  class CommentToMe < Me2day::Base
    # @return [Me2day::Post]
    def post
      return unless @attrs[:post]
      @post ||= Me2day::Post.fetch_or_new(@attrs[:post])
    end
    
    # @return [Me2day::Comment]
    def comment
      return unless @attrs[:comment]
      @comment ||= Me2day::Comment.fetch_or_new(@attrs[:comment])
    end
  end
end