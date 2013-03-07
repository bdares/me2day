require 'forwardable'
require 'me2day/publishable'
require 'me2day/exceptable'
require 'me2day/identity'
require 'time'

module Me2day
  class Post < Me2day::Identity
    extend Forwardable
    include Me2day::Publishable
    include Me2day::Exceptable
    attr_reader :identifier, :iconUrl, :me2dayPage, :media, :commentClosed, :callbackUrl, 
      :tags, :location, :author, :fromapp, :body, :domain, :tagText, :icon, :pingback_to, 
      :textBody, :permalink, :commentsCount, :kind, :contentType, :post_id, :metooCount
    alias id post_id

    # @return [Me2day::User]
    def author
      @user ||= fetch_or_new(Me2day::Person, @attrs[:author])
    end
  end

  Status = Post
end
