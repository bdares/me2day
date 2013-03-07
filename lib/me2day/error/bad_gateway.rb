require 'me2day/error/server_error'

module Me2day
  class Error
    # Raised when Me2day returns the HTTP status code 502
    class BadGateway < Me2day::Error::ServerError
      HTTP_STATUS_CODE = 502
      MESSAGE = "Me2day is down or being upgraded."
    end
  end
end
