require 'helper'

describe Me2day::API::People do

  before do
    @client = Me2day::Client.new
  end
  
  describe "#get_person" do
    before do
      stub_get("/api/get_person/chefedward.json").to_return(:body => fixture('chefedward.json'), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.get_person('chefedward')
      expect(a_get("/api/get_person/chefedward.json")).to have_been_made
    end
    it "returns a person" do
      person = @client.get_person('chefedward')
      expect(person).to be_a Me2day::Person
    end
  end
  
  describe "#get_settings" do
    
  end


end
