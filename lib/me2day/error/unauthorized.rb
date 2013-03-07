require 'me2day/error/client_error'

module Me2day
  class Error
    # Raised when Me2day returns the HTTP status code 401
    class Unauthorized < Me2day::Error::ClientError
      HTTP_STATUS_CODE = 401
    end
  end
end
