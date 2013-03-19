require 'me2day/comment'
require 'me2day/comment_by_me'
require 'me2day/comment_list'
require 'me2day/comment_log'
require 'me2day/comment_to_me'
require 'me2day/client'
require 'me2day/configurable'
require 'me2day/configuration'
require 'me2day/default'
require 'me2day/location'
require 'me2day/post'
require 'me2day/settings'
require 'me2day/size'
require 'me2day/tag'
require 'me2day/person'

module Me2day
  class << self
    include Me2day::Configurable

    # Delegate to a Me2day::Client
    #
    # @return [Me2day::Client]
    def client
      @client = Me2day::Client.new(options) unless defined?(@client) && @client.hash == options.hash
      @client
    end

    def respond_to_missing?(method_name, include_private=false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
    def respond_to?(method_name, include_private=false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"

  private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end

  end
end

Me2day.setup