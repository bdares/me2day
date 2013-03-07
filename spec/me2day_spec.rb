require 'helper'

describe Me2day do

  after do
    Me2day.reset!
  end

  context "when delegating to a client" do

    before do
      stub_get("/api/get_posts/codian.json").to_return(:body => fixture("posts.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "requests the correct resource" do
      Me2day.get_posts('codian')
      expect(a_get("/api/get_posts/codian.json")).to have_been_made
    end

    it "returns the same results as a client" do
      expect(Me2day.get_posts('codian')).to eq Me2day::Client.new.get_posts('codian')
    end

  end

  describe ".respond_to?" do
    it "delegates to Me2day::Client" do
      expect(Me2day.respond_to?(:get_person)).to be_true
    end 
    it "takes an optional argument" do
      expect(Me2day.respond_to?(:client, true)).to be_true
    end
  end

  describe ".client" do
    it "returns a Me2day::Client" do
      expect(Me2day.client).to be_a Me2day::Client
    end

    context "when the options don't change" do
      it "caches the client" do
        expect(Me2day.client).to eq Me2day.client
      end 
    end
    context "when the options change" do
      it "busts the cache" do
        client1 = Me2day.client
        Me2day.configure do |config|
          config.user_id = 'abc'
          config.user_key = '123'
        end
        client2 = Me2day.client
        expect(client1).not_to eq client2
      end
    end
  end

  describe ".configure" do
    Me2day::Configurable.keys.each do |key|
      it "sets the #{key.to_s.gsub('_', ' ')}" do
        Me2day.configure do |config|
          config.send("#{key}=", key)
        end
        expect(Me2day.instance_variable_get(:"@#{key}")).to eq key
      end
    end

    context "when invalid credentials are provided" do
      it "raises a ConfigurationError exception" do
        expect {
          Me2day.configure do |config|
            config.user_id = [12345, 54321]
            config.user_key = 'valid_data'
          end
        }.to raise_exception(Me2day::Error::ConfigurationError)
      end
    end

    context "when no credentials are provided" do
      it "does not raise an exception" do
        expect {
          Me2day.configure do |config|
            config.application_key = nil
            config.user_id = nil
            config.user_key = nil
          end
        }.to_not raise_exception(Me2day::Error::ConfigurationError)
      end
    end
  end

  describe ".credentials?" do
    it "returns true if all credentials are present" do
      Me2day.configure do |config|
        config.application_key = 'AK'
        config.user_id = 'UI'
        config.user_key = 'UK'
      end
      expect(Me2day.credentials?).to be_true
    end
    it "returns false if any credentials are missing" do
      Me2day.configure do |config|
        config.user_id = 'UI'
        config.user_key = 'UK'
      end
      expect(Me2day.credentials?).to be_false
    end
  end

end
