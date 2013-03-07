require 'me2day/base'

module Me2day
  class Settings < Me2day::Base
    attr_reader :always_use_https, :discoverable_by_email, :geo_enabled,
      :language, :protected, :screen_name, :show_all_inline_media, :sleep_time,
      :time_zone

    # @return [Me2day::Place]
    def trend_location
      @trend_location ||= Me2day::Place.fetch_or_new(Array(@attrs[:trend_location]).first)
    end

  end
end
