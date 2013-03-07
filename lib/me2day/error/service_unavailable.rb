require 'me2day/error/server_error'

module Me2day
  class Error
    # Raised when Me2day returns the HTTP status code 503
    class ServiceUnavailable < Me2day::Error::ServerError
      HTTP_STATUS_CODE = 503
      MESSAGE = "(__-){ Me2day is over capacity."
    end
  end
end
