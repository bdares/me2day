require 'me2day/error/client_error'

module Me2day
  class Error
    # Raised when Me2day returns the HTTP status code 403
    class Forbidden < Me2day::Error::ClientError
      HTTP_STATUS_CODE = 403
    end
  end
end
