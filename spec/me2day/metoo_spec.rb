#encoding: utf-8
require 'helper'

describe Me2day::Metoo do

  before do
    @old_stderr = $stderr
    $stderr = StringIO.new
  end

  after do
    $stderr = @old_stderr
  end

  describe "#pubDate" do
    it "returns a Time when set" do
      metoo = Me2day::Metoo.new(:pubDate => "Mon Jul 16 12:59:01 +0000 2007")
      expect(metoo.pubDate).to be_a Time
    end
    it "returns nil when not set" do
      metoo = Me2day::Metoo.new
      expect(metoo.pubDate).to be_nil
    end
  end

  describe "#author" do
    it "returns a Person when author is set" do
      person = Me2day::Metoo.new(:author => {:id => 7505382}).author
      expect(person).to be_a Me2day::Person
    end
    it "returns nil when user is not set" do
      person = Me2day::Metoo.new.author
      expect(person).to be_nil
    end
  end

  describe "#author?" do
    it "returns true when author is set" do
      author = Me2day::Metoo.new(:author => {:id => 7505382}).author?
      expect(author).to be_true
    end
    it "returns false when author is not set" do
      author = Me2day::Metoo.new.author?
      expect(author).to be_false
    end
  end

end
