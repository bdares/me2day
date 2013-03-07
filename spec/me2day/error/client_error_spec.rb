require 'helper'

describe Me2day::Error::ClientError do

  before do
    @client = Me2day::Client.new
  end

  Me2day::Error::ClientError.errors.each do |status, exception|
    [nil, "error", "errors"].each do |body|
      context "when HTTP status is #{status} and body is #{body.inspect}" do
        before do
          body_message = '{"' + body + '":"Client Error"}' unless body.nil?
          stub_get("/api/get_person/chefedward.json").to_return(:status => status, :body => body_message)
        end
        it "raises #{exception.name}" do
          expect{@client.get_person('chefedward')}.to raise_error exception
        end
      end
    end
  end

end
