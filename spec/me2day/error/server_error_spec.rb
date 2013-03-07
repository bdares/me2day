require 'helper'

describe Me2day::Error::ServerError do

  before do
    @client = Me2day::Client.new
  end

  Me2day::Error::ServerError.errors.each do |status, exception|
    context "when HTTP status is #{status}" do
      before do
        stub_get("/api/get_person/chefedward.json").to_return(:status => status)
      end
      it "raises #{exception.name}" do
        expect{@client.get_person('chefedward')}.to raise_error exception
      end
    end
  end

end
