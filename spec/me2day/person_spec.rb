#encoding: utf-8
require 'helper'

describe Me2day::Person do

  describe "#==" do
    it "returns true when objects IDs are the same" do
      user = Me2day::Person.new(:id => 1, :nickname => "foo")
      other = Me2day::Person.new(:id => 1, :nickname => "bar")
      expect(user == other).to be_true
    end
    it "returns false when objects IDs are different" do
      user = Me2day::Person.new(:id => 1)
      other = Me2day::Person.new(:id => 2)
      expect(user == other).to be_false
    end
    it "returns false when classes are different" do
      user = Me2day::Person.new(:id => 1)
      other = Me2day::Identity.new(:id => 1)
      expect(user == other).to be_false
    end
  end

  describe "#pubDate" do
    it "returns a Time when pubDate is set" do
      user = Me2day::Person.new(:id => 7505382, :pubDate => "Mon Jul 16 12:59:01 +0000 2007")
      expect(user.pubDate).to be_a Time
    end
    it "returns nil when pubDate is not set" do
      user = Me2day::Person.new(:id => 7505382)
      expect(user.pubDate).to be_nil
    end
  end
  
  describe "#birthday" do
    it "returns a Date when birthday is set" do
      stub_get("/api/get_person/chefedward.json").to_return(:body => fixture('chefedward.json'), :headers => {:content_type => "application/json; charset=utf-8"})
      user = Me2day.get_person('chefedward')
      expect(user.birthday).to be_a Date
    end
    it "returns nil when birthday is not set" do
      user = Me2day::Person.new(:id => 1)
      expect(user.birthday).to be_nil
    end
  end

end
