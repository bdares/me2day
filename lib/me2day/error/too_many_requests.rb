require 'me2day/error/client_error'

module Me2day
  class Error
    # Raised when Me2day returns the HTTP status code 429
    class TooManyRequests < Me2day::Error::ClientError
      HTTP_STATUS_CODE = 429
    end
    EnhanceYourCalm = TooManyRequests
    RateLimited = TooManyRequests
  end
end
