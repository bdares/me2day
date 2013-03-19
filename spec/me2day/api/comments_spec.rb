require 'helper'

describe Me2day::API::Comments do

  before do
    @client = Me2day::Client.new
  end
  
  describe "#get_comments" do
    before do
      stub_get("/api/get_comments.json").with(:query => {:post_id => 'pyw8u0a-_1t5g'}).to_return(:body => fixture('comment_list.json'), :headers => {:content_type => "application/json, charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.get_comments('pyw8u0a-_1t5g')
      expect(a_get("/api/get_comments.json").with(:query => {:post_id => 'pyw8u0a-_1t5g'})).to have_been_made
    end
    it "returns a comment list" do
      get_comment_list = @client.get_comments('pyw8u0a-_1t5g')
      expect(get_comment_list).to be_a Me2day::CommentList
    end
  end
  
  describe "#create_comment" do
    before do
      stub_post("/api/create_comment.json").with(:body => {:post_id => 'foo',:body => 'bar'}).to_return(:headers => {:content_type => "application/json, charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.create_comment('foo', 'bar')
      expect(a_post("/api/create_comment.json").with(:body => {:post_id => 'foo',:body => 'bar'})).to have_been_made
    end
  end
  
  describe "#delete_comment" do
    before do
      stub_delete("/api/delete_comment.json").with(:query => {:comment_id => 'foobar'}).to_return(:headers => {:content_type => "application/json, charset=utf-8"})
    end
    it "requests the correct resource" do
      @client.delete_comment("foobar")
      expect(a_delete("/api/delete_comment.json").with(:query => {:comment_id => 'foobar'})).to have_been_made
    end
  end
  
  describe "#track_comments" do
    context "scope='all'" do
      before do
        stub_get("/api/track_comments/codian.json").with(:query => {:scope => 'all'}).to_return(:body => fixture('comment_log.json'), :headers => {:content_type => "application/json, charset=utf-8"})
      end
      it "requests the correct resource" do
        @client.track_comments("codian")
        expect(a_get("/api/track_comments/codian.json").with(:query => {:scope => 'all'})).to have_been_made
      end
      
      it "returns a comment log" do
        comment_log = @client.track_comments("codian")
        expect(comment_log).to be_a Me2day::CommentLog
        expect(comment_log.comment_by_mes).to be_an Array
        expect(comment_log.comment_by_mes.first).to be_an Me2day::CommentByMe
        expect(comment_log.comment_by_mes.first.comment).to be_an Me2day::Comment
        expect(comment_log.comment_by_mes.first.post).to be_an Me2day::Post
      end
    end
    
    context "scope='by_me'" do
      before do
        stub_get("/api/track_comments/codian.json").with(:query => {:scope => 'by_me'}).to_return(:body => fixture('comment_log_by_me.json'), :headers => {:content_type => "application/json, charset=utf-8"})
      end
      
      it "returns a comment log with comment_by_mes but without comment_to_mes" do
        comment_log = @client.track_comments("codian", 'by_me')
        expect(comment_log.comment_to_mes.empty?).to eq(true)
        expect(comment_log.comment_by_mes).to be_an Array
      end
    end
    
  end
end
