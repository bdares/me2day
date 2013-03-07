require 'me2day/error/server_error'

module Me2day
  class Error
    # Raised when Me2day returns the HTTP status code 504
    class GatewayTimeout < Me2day::Error::ServerError
      HTTP_STATUS_CODE = 504
      MESSAGE = "The Me2day servers are up, but the request couldn't be serviced due to some failure within our stack. Try again later."
    end
  end
end
