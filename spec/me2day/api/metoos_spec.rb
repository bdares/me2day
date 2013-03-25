require 'helper'

describe Me2day::API::Metoos do

  before do
    @client = Me2day::Client.new
  end
  
  describe "#get_metoos" do
    before do
      stub_get("/api/get_metoos.json").with(:query => {:post_id => 'pyw8u0a-_1t5g'}).to_return(:body => fixture('metoos.json'), :headers => {:content_type => "application/json, charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.get_metoos('pyw8u0a-_1t5g')
      expect(a_get("/api/get_metoos.json").with(:query => {:post_id => 'pyw8u0a-_1t5g'})).to have_been_made
    end
    it "returns a metoo result" do
      metoo_result = @client.get_metoos('pyw8u0a-_1t5g')
      expect(metoo_result).to be_a Me2day::MetooResult
    end
  end
  
end
