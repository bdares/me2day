require 'helper'

describe Me2day::API::Posts do

  before do
    @client = Me2day::Client.new
  end

  describe "#get_posts" do
    context "with a user defined" do
      before do
        stub_get("/api/get_posts/codian.json").to_return(:body => fixture("posts.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end
      it "requests the correct resource" do
        @client.get_posts('codian')
        expect(a_get("/api/get_posts/codian.json")).to have_been_made
      end
      it "returns an array of posts" do
        posts = @client.get_posts('codian')
        expect(posts).to be_an Array
        expect(posts.first).to be_a Me2day::Post
        expect(posts.first.body).to eq "<a href='http://designmodo.github.com/Flat-UI/'>Flat UI</a>, Free WebUI Kit"
      end
    end
    
    context "without a user defined" do
      before do
        stub_get("/api/get_posts.json").to_return(:body => fixture("post.json"), :headers => {:content_type => "application/json; charset=utf-8"})
      end
      it "requests the correct resource" do
        post = @client.get_posts(:post_id => 'pyw8u0a-_1t5g')
        expect(a_get("/api/get_posts.json")).to have_been_made
      end
      it "returns a single post" do
        post = @client.get_posts(:post_id => 'pyw8u0a-_1t5g')
        expect(post).to be_a Me2day::Post
      end
    end
  end

  describe "#create_post" do
    before do
      stub_post("/api/create_post.json").to_return(:body => fixture("post.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.create_post('test')
      expect(a_post("/api/create_post.json")).to have_been_made
    end
    it "returns the created post" do
      post = @client.create_post('test')
      expect(post).to be_a Me2day::Post
    end
  end
=begin
  describe "#delete_post" do
    before do
      stub_post("/api/delete_post.json").to_return(:body => fixture("status.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.delete_post('pyw8u0a-_1t5g')
      expect(a_post("/api/delete_post.json")).to have_been_made
    end
    it "returns the deleted post" do
      post = @client.delete_post('pyw8u0a-_1t5g')
      expect(post).to be_a Me2day::Post
    end
  end
=end  
end
