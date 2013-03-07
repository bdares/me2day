require 'helper'

describe Me2day::Base do

  context "identity map enabled" do
    before do
      Me2day.identity_map = Me2day::IdentityMap
      object = Me2day::Base.new(:id => 1)
      @base = Me2day::Base.store(object)
    end

    after do
      Me2day.identity_map = false
    end

    describe ".identity_map" do
      it "returns an instance of the identity map" do
        expect(Me2day::Base.identity_map).to be_a Me2day::IdentityMap
      end
    end

    describe ".fetch" do
      it "returns existing objects" do
        expect(Me2day::Base.fetch(:id => 1)).to be
      end

      it "raises an error on objects that don't exist" do
        expect{Me2day::Base.fetch(:id => 6)}.to raise_error Me2day::Error::IdentityMapKeyError
      end
    end

    describe ".store" do
      it "stores Me2day::Base objects" do
        object = Me2day::Base.new(:id => 4)
        expect(Me2day::Base.store(object)).to be_a Me2day::Base
      end
    end

    describe ".fetch_or_new" do
      it "returns existing objects" do
        expect(Me2day::Base.fetch_or_new(:id => 1)).to be
      end
      it "creates new objects and stores them" do
        expect(Me2day::Base.fetch_or_new(:id => 2)).to be
        expect(Me2day::Base.fetch(:id => 2)).to be
      end
    end

    describe "#[]" do
      it "calls methods using [] with symbol" do
        expect(@base[:object_id]).to be_an Integer
      end
      it "calls methods using [] with string" do
        expect(@base['object_id']).to be_an Integer
      end
      it "returns nil for missing method" do
        expect(@base[:foo]).to be_nil
        expect(@base['foo']).to be_nil
      end
    end

    describe "#to_hash" do
      it "returns a hash" do
        expect(@base.to_hash).to be_a Hash
        expect(@base.to_hash[:id]).to eq 1
      end
    end

    describe "identical objects" do
      it "have the same object_id" do
        expect(@base.object_id).to eq Me2day::Base.fetch(:id => 1).object_id
      end
    end

  end

  context "identity map disabled" do
    before(:all) do
      Me2day.identity_map = false
    end
    after(:all) do
      Me2day.identity_map = Me2day::IdentityMap
    end

    describe ".identity_map" do
      it "returns nil" do
        expect(Me2day::Base.identity_map).to be_nil
      end
    end

    describe ".fetch" do
      it "returns nil" do
        expect(Me2day::Base.fetch(:id => 1)).to be_nil
      end
    end

    describe ".store" do
      it "returns an instance of the object" do
        expect(Me2day::Base.store(Me2day::Base.new(:id => 1))).to be_a Me2day::Base
      end
    end

    describe ".fetch_or_new" do
      it "creates new objects" do
        expect(Me2day::Base.fetch_or_new(:id => 2)).to be
        expect(Me2day.identity_map).to be_false
      end
    end
  end

end
