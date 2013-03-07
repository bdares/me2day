require 'me2day/error/forbidden'

module Me2day
  class Error
    # Raised when a Tweet has already been favorited
    class AlreadyFavorited < Me2day::Error
      MESSAGE = "You have already favorited this status"
    end
  end
end
