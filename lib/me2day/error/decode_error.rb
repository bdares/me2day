require 'me2day/error'

module Me2day
  class Error
    # Raised when JSON parsing fails
    class DecodeError < Me2day::Error
    end
  end
end
