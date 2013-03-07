require 'me2day/entity'

module Me2day
  class Entity
    class UserMention < Me2day::Entity
      attr_reader :id, :name, :screen_name
    end
  end
end
