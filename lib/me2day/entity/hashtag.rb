require 'me2day/entity'

module Me2day
  class Entity
    class Hashtag < Me2day::Entity
      attr_reader :text
    end
  end
end
