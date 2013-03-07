require 'helper'

describe Me2day::API::Undocumented do

  before do
    @client = Me2day::Client.new
  end
  
  describe "#search" do
    before do
      stub_get("/search.json?query=test").to_return(:body => fixture("search.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.search('test')
      expect(a_get("/search.json?query=test")).to have_been_made
    end
    it "returns an array of Posts" do
      posts = @client.search('test')
      expect(posts).to be_an Array
      expect(posts.first).to be_a Me2day::Post
    end
  end 
end