#encoding: utf-8
require 'me2day/basic_person'
require 'me2day/publishable'
require 'me2day/exceptable'

module Me2day
  class Person < Me2day::BasicPerson
    include Me2day::Publishable
    include Me2day::Exceptable
    attr_reader :openid, :nickname, :description, :email, :cellphone, 
      :messenger, :location, :celebrity, :me2dayHome, :rssDaily, 
      :invitedBy, :pinMeCount, :updated, :totalPosts, :registered, :postIcons, :autoAccept, 
      :sex, :naverId, :face, :friendsCount
      
    # Return the person's birthday
    # @return [Date]
    def birthday
      @birthday ||= Date.strptime( @attrs[:birthday], '%Y년 %m월 %d일생') if @attrs[:birthday]
    end

  end
end
