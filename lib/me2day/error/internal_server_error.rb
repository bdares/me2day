require 'me2day/error/server_error'

module Me2day
  class Error
    # Raised when Me2day returns the HTTP status code 500
    class InternalServerError < Me2day::Error::ServerError
      HTTP_STATUS_CODE = 500
      MESSAGE = "Something is technically wrong."
    end
  end
end
