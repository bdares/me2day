require 'helper'

describe Me2day::Client do

  subject do
    Me2day::Client.new(:consumer_key => "CK", :consumer_secret => "CS", :oauth_token => "OT", :oauth_token_secret => "OS")
  end

  context "with module configuration" do

    before do
      Me2day.configure do |config|
        Me2day::Configurable.keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      Me2day.reset!
    end

    it "inherits the module configuration" do
      client = Me2day::Client.new
      Me2day::Configurable.keys.each do |key|
        expect(client.instance_variable_get(:"@#{key}")).to eq key
      end
    end

    context "with class configuration" do

      before do
        @configuration = {
          :connection_options => {:timeout => 10},
          :application_key => 'AK',
          :user_id => 'UI',
          :user_key => 'UK',
          :endpoint => 'http://tumblr.com/',
          :middleware => Proc.new{},
          :identity_map => ::Hash
        }
      end

      context "during initialization" do
        it "overrides the module configuration" do
          client = Me2day::Client.new(@configuration)
          Me2day::Configurable.keys.each do |key|
            expect(client.instance_variable_get(:"@#{key}")).to eq @configuration[key]
          end
        end
      end

      context "after initialization" do
        it "overrides the module configuration after initialization" do
          client = Me2day::Client.new
          client.configure do |config|
            @configuration.each do |key, value|
              config.send("#{key}=", value)
            end
          end
          Me2day::Configurable.keys.each do |key|
            expect(client.instance_variable_get(:"@#{key}")).to eq @configuration[key]
          end
        end
      end

    end
  end

  describe "#delete" do
    before do
      stub_delete("/custom/delete").with(:query => {:deleted => "object"})
    end
    it "allows custom delete requests" do
      subject.delete("/custom/delete", {:deleted => "object"})
      expect(a_delete("/custom/delete").with(:query => {:deleted => "object"})).to have_been_made
    end
  end

  describe "#put" do
    before do
      stub_put("/custom/put").with(:body => {:updated => "object"})
    end
    it "allows custom put requests" do
      subject.put("/custom/put", {:updated => "object"})
      expect(a_put("/custom/put").with(:body => {:updated => "object"})).to have_been_made
    end
  end

  describe "#credentials?" do
    it "returns true if all credentials are present" do
      client = Me2day::Client.new(:application_key => 'AK', :user_id => 'UI', :user_key => 'UK')
      expect(client.credentials?).to be_true
    end
    it "returns false if any credentials are missing" do
      client = Me2day::Client.new(:application_key => 'AK', :user_id => 'UI')
      expect(client.credentials?).to be_false
    end
  end

  describe "#connection" do
    it "looks like Faraday connection" do
      expect(subject.send(:connection)).to respond_to(:run_request)
    end
    it "memoizes the connection" do
      c1, c2 = subject.send(:connection), subject.send(:connection)
      expect(c1.object_id).to eq c2.object_id
    end
  end

  describe "#request" do
    it "catches Faraday errors" do
      subject.stub!(:connection).and_raise(Faraday::Error::ClientError.new("Oops"))
      expect{subject.send(:request, :get, "/path")}.to raise_error Me2day::Error::ClientError
    end
    it "catches MultiJson::DecodeError errors" do
      subject.stub!(:connection).and_raise(MultiJson::DecodeError.new("unexpected token", [], "<!DOCTYPE html>"))
      expect{subject.send(:request, :get, "/path")}.to raise_error Me2day::Error::DecodeError
    end
  end

end
