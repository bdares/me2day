require 'helper'

describe Me2day::BasicPerson do

  describe "#==" do
    it "returns true when objects IDs are the same" do
      saved_search = Me2day::BasicPerson.new(:id => 1, :name => "foo")
      other = Me2day::BasicPerson.new(:id => 1, :name => "bar")
      expect(saved_search == other).to be_true
    end
    it "returns false when objects IDs are different" do
      saved_search = Me2day::BasicPerson.new(:id => 1)
      other = Me2day::BasicPerson.new(:id => 2)
      expect(saved_search == other).to be_false
    end
    it "returns false when classes are different" do
      saved_search = Me2day::BasicPerson.new(:id => 1)
      other = Me2day::Identity.new(:id => 1)
      expect(saved_search == other).to be_false
    end
  end

end
 