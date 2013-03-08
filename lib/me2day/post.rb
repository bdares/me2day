require 'forwardable'
require 'me2day/publishable'
require 'me2day/exceptable'
require 'me2day/identity'

module Me2day
  class Post < Me2day::Identity
    extend Forwardable
    include Me2day::Publishable
    include Me2day::Exceptable
    attr_reader :identifier, :iconUrl, :me2dayPage, :media, :commentClosed, :callbackUrl, 
      :tags, :fromapp, :body, :domain, :tagText, :icon, :pingback_to, 
      :textBody, :permalink, :commentsCount, :kind, :contentType, :post_id
    alias id post_id 

    # @return [Me2day::User]
    def author
      return unless @attrs[:author]
      @user ||= Me2day::Person.fetch_or_new(@attrs[:author])
    end
    
    def author?
      !!author
    end
    
    def location
      @location ||= Me2day::Location.new(@attrs[:location]) if @attrs[:location]
    end
    
    def metooCount
      @attrs[:metooCount].to_i if @attrs[:metooCount]
    end
    
    def commentsCount
      @attrs[:commentsCount].to_i if @attrs[:commentsCount]
    end
    
    def tags
      return [] unless @attrs[:tags]
      @tags ||= @attrs[:tags].map{|x| Me2day::Tag.new(x)}
    end
  end
end
