require 'forwardable'
require 'me2day/publishable'
require 'me2day/identity'
require 'me2day/api/utils'

module Me2day
  class Comment < Me2day::Identity
    extend Forwardable
    include Me2day::Publishable
    attr_reader :page, :postAuthorId, :postAuthorNickname, :totalCount, :totalPage

    # @return [Me2day::User]
    def comments
      return unless @attrs[:comments]
      @comments ||= Me2day::API::Utils.objects_from_array(Me2day::Comment, @attrs[:comments])
    end
  end
end
