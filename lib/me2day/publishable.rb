require 'time'
module Me2day
  module Publishable

    # Time when the object was created on Me2day
    #
    # @return [Time]
    def pubDate
      @pubDate ||= Time.parse(@attrs[:pubDate]) if published?
    end

  private

    def published?
      !@attrs[:pubDate].nil?
    end

  end
end
