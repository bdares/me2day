require 'helper'

describe Me2day::Size do

  describe "#==" do
    it "returns false for empty objects" do
      size = Me2day::Size.new
      other = Me2day::Size.new
      expect(size == other).to be_false
    end
    it "returns true when objects height and width are the same" do
      size = Me2day::Size.new(:h => 1, :w => 1, :resize => true)
      other = Me2day::Size.new(:h => 1, :w => 1, :resize => false)
      expect(size == other).to be_true
    end
    it "returns false when objects height or width are different" do
      size = Me2day::Size.new(:h => 1, :w => 1)
      other = Me2day::Size.new(:h => 1, :w => 2)
      expect(size == other).to be_false
    end
    it "returns false when classes are different" do
      size = Me2day::Size.new(:h => 1, :w => 1)
      other = Me2day::Base.new(:h => 1, :w => 1)
      expect(size == other).to be_false
    end
    it "returns true when objects non-height and width attributes are the same" do
      size = Me2day::Size.new(:resize => true)
      other = Me2day::Size.new(:resize => true)
      expect(size == other).to be_true
    end
    it "returns false when objects non-height and width attributes are different" do
      size = Me2day::Size.new(:resize => true)
      other = Me2day::Size.new(:resize => false)
      expect(size == other).to be_false
    end
  end

end
