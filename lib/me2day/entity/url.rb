require 'me2day/entity'

module Me2day
  class Entity
    class Url < Me2day::Entity
      attr_reader :display_url, :expanded_url, :url
    end
  end
end
