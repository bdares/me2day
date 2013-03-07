require 'time'

module Me2day
  module Creatable

    # Time when the object was created on Me2day
    #
    # @return [Time]
    def created_at
      @created_at ||= Time.parse(@attrs[:created_at]) if created?
    end

  private

    def created?
      !@attrs[:created_at].nil?
    end

  end
end
