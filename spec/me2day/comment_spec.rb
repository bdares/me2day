#encoding: utf-8
require 'helper'

describe Me2day::Comment do

  describe "#==" do
    it "returns true when objects IDs are the same" do
      comment = Me2day::Comment.new(:commentId => 1, :body => "foo")
      other = Me2day::Comment.new(:commentId => 1, :body => "bar")
      expect(comment == other).to be_true
    end
    it "returns false when objects IDs are different" do
      comment = Me2day::Comment.new(:commentId => 1)
      other = Me2day::Comment.new(:commentId => 2)
      expect(comment == other).to be_false
    end
    it "returns false when classes are different" do
      comment = Me2day::Comment.new(:commentId => 1)
      other = Me2day::Identity.new(:id => 1)
      expect(comment == other).to be_false
    end
  end

  describe "#pubDate" do
    it "returns a Time when set" do
      comment = Me2day::Comment.new(:commentId => 28669546014, :pubDate => "Mon Jul 16 12:59:01 +0000 2007")
      expect(comment.pubDate).to be_a Time
    end
    it "returns nil when not set" do
      comment = Me2day::Comment.new(:commentId => 28669546014)
      expect(comment.pubDate).to be_nil
    end
  end

  describe "#author" do
    it "returns a Person when author is set" do
      person = Me2day::Comment.new(:commentId => 28669546014, :author => {:id => 7505382}).author
      expect(person).to be_a Me2day::Person
    end
    it "returns nil when user is not set" do
      person = Me2day::Comment.new(:commentId => 28669546014).author
      expect(person).to be_nil
    end
  end

  describe "#author?" do
    it "returns true when author is set" do
      author = Me2day::Comment.new(:commentId => 28669546014, :author => {:id => 7505382}).author?
      expect(author).to be_true
    end
    it "returns false when author is not set" do
      author = Me2day::Comment.new(:commentId => 28669546014).author?
      expect(author).to be_false
    end
  end

end
