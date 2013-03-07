require 'me2day/error/forbidden'

module Me2day
  class Error
    # Raised when a Tweet has already been retweeted
    class AlreadyRetweeted < Me2day::Error
      MESSAGE = "sharing is not permissible for this status (Share validations failed)"
    end
  end
end
