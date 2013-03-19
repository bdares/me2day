require 'forwardable'
require 'me2day/api/utils'
require 'me2day/comment'

module Me2day
  # returned by the comments api (get_comments)
  class CommentList < Me2day::Base
    extend Forwardable
    attr_reader :page, :postAuthorId, :postAuthorNickname, :totalCount, :totalPage, :itemsPerPage
  
    def comments
      return unless @attrs[:comments]
      @comments ||= @attrs[:comments].map{|x| Me2day::Comment.fetch_or_new(x)}
    end
  end
end