require 'helper'

describe Me2day::Error do

  describe "#initialize" do
    it "wraps another error class" do
      begin
        raise Faraday::Error::ClientError.new("Oops")
      rescue Faraday::Error::ClientError
        begin
          raise Me2day::Error
        rescue Me2day::Error => error
          expect(error.message).to eq "Oops"
          expect(error.wrapped_exception.class).to eq Faraday::Error::ClientError
        end
      end
    end
  end

end 
