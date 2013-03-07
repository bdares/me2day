require 'me2day/error/client_error'

module Me2day
  class Error
    # Raised when Me2day returns the HTTP status code 404
    class UnprocessableEntity < Me2day::Error::ClientError
      HTTP_STATUS_CODE = 422
    end
  end
end
