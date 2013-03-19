require 'forwardable'
require 'me2day/publishable'
require 'me2day/identity'

module Me2day
  class Comment < Me2day::Identity
    extend Forwardable
    include Me2day::Publishable
    attr_reader :commentId, :body, :textBody, :postId
    alias id commentId 

    # @return [Me2day::User]
    def author
      return unless @attrs[:author]
      @user ||= Me2day::Person.fetch_or_new(@attrs[:author])
    end
    
    def author?
      !!author
    end
  end
end
