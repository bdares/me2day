require 'me2day/error/client_error'

module Me2day
  class Error
    # Raised when Me2day returns the HTTP status code 406
    class NotAcceptable < Me2day::Error::ClientError
      HTTP_STATUS_CODE = 406
    end
  end
end
