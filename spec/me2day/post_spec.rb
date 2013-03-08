#encoding: utf-8
require 'helper'

describe Me2day::Post do

  before do
    @old_stderr = $stderr
    $stderr = StringIO.new
  end

  after do
    $stderr = @old_stderr
  end

  describe "#==" do
    it "returns true when objects IDs are the same" do
      post = Me2day::Post.new(:post_id => 1, :text => "foo")
      other = Me2day::Post.new(:post_id => 1, :text => "bar")
      expect(post == other).to be_true
    end
    it "returns false when objects IDs are different" do
      post = Me2day::Post.new(:post_id => 1)
      other = Me2day::Post.new(:post_id => 2)
      expect(post == other).to be_false
    end
    it "returns false when classes are different" do
      post = Me2day::Post.new(:post_id => 1)
      other = Me2day::Identity.new(:post_id => 1)
      expect(post == other).to be_false
    end
  end

  describe "#pubDate" do
    it "returns a Time when set" do
      post = Me2day::Post.new(:post_id => 28669546014, :pubDate => "Mon Jul 16 12:59:01 +0000 2007")
      expect(post.pubDate).to be_a Time
    end
    it "returns nil when not set" do
      post = Me2day::Post.new(:post_id => 28669546014)
      expect(post.pubDate).to be_nil
    end
  end

  describe "#metooCount" do
    it "returns the count of metoos when metooCount is set" do
      post = Me2day::Post.new(:post_id => 28669546014, :metooCount => '1')
      expect(post.metooCount).to be_an Integer
      expect(post.metooCount).to eq 1
    end
    it "returns nil when not set" do
      post = Me2day::Post.new(:post_id => 28669546014)
      expect(post.metooCount).to be_nil
    end
  end


  describe "#location" do
    it "returns a Me2day::Location when set" do
      post = Me2day::Post.new(:post_id => 28669546014, :location => {:latitude => 0, :longitude => 0})
      expect(post.location).to be_a Me2day::Location
    end
    it "returns nil when not set" do
      post = Me2day::Post.new(:post_id => 28669546014)
      expect(post.location).to be_nil
    end
  end

  describe "#tags" do
    it "returns an Array of Me2day::Tag" do
      tags_array = [
        {
          :name => "행복하세요",
          :url => "http://me2day.net/marinboy3/tag/행복하세요",
        }
      ]
      tags = Me2day::Post.new(:post_id => 28669546014, :tags => tags_array).tags
      expect(tags).to be_an Array
      expect(tags.first).to be_a Me2day::Tag
      expect(tags.first.name).to eq '행복하세요'
      expect(tags.first.url).to eq 'http://me2day.net/marinboy3/tag/행복하세요'
    end
    it "is empty when not set" do
      tags = Me2day::Post.new(:post_id => 28669546014).tags
      expect(tags).to be_empty
    end
  end


  describe "#commentsCount" do
    it "returns the count of comments when commentsCount is set" do
      post = Me2day::Post.new(:post_id => 28669546014, :commentsCount => '1')
      expect(post.commentsCount).to be_an Integer
      expect(post.commentsCount).to eq 1
    end
    it "returns nil when not set" do
      post = Me2day::Post.new(:post_id => 28669546014)
      expect(post.commentsCount).to be_nil
    end
  end


  describe "#author" do
    it "returns a Person when author is set" do
      person = Me2day::Post.new(:post_id => 28669546014, :author => {:id => 7505382}).author
      expect(person).to be_a Me2day::Person
    end
    it "returns nil when user is not set" do
      person = Me2day::Post.new(:post_id => 28669546014).author
      expect(person).to be_nil
    end
  end

  describe "#author?" do
    it "returns true when author is set" do
      author = Me2day::Post.new(:post_id => 28669546014, :author => {:id => 7505382}).author?
      expect(author).to be_true
    end
    it "returns false when author is not set" do
      author = Me2day::Post.new(:post_id => 28669546014).author?
      expect(author).to be_false
    end
  end

end
