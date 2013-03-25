require 'forwardable'
require 'me2day/publishable'

module Me2day
  class Metoo < Me2day::Base
    extend Forwardable
    include Me2day::Publishable

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
