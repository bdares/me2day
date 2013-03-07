require 'me2day/base'

module Me2day
  class Language < Me2day::Base
    attr_reader :code, :name, :status
  end
end
