require 'helper'

describe Me2day::Identity do

  describe "#initialize" do
    it "raises an ArgumentError when type is not specified" do
      expect{Me2day::Identity.new}.to raise_error ArgumentError
    end
  end

  context "identity map enabled" do
    before do
      Me2day.identity_map = Me2day::IdentityMap
    end

    after do
      Me2day.identity_map = false
    end

    describe ".fetch" do
      it "returns existing objects" do
        Me2day::Identity.store(Me2day::Identity.new(:id => 1))
        expect(Me2day::Identity.fetch(:id => 1)).to be
      end

      it "raises an error on objects that don't exist" do
        expect{Me2day::Identity.fetch(:id => 6)}.to raise_error Me2day::Error::IdentityMapKeyError
      end
    end
  end

  describe "#==" do
    it "returns true when objects IDs are the same" do
      one = Me2day::Identity.new(:id => 1, :screen_name => "sferik")
      two = Me2day::Identity.new(:id => 1, :screen_name => "garybernhardt")
      expect(one == two).to be_true
    end
    it "returns false when objects IDs are different" do
      one = Me2day::Identity.new(:id => 1)
      two = Me2day::Identity.new(:id => 2)
      expect(one == two).to be_false
    end
    it "returns false when classes are different" do
      one = Me2day::Identity.new(:id => 1)
      two = Me2day::Base.new(:id => 1)
      expect(one == two).to be_false
    end
  end

end
