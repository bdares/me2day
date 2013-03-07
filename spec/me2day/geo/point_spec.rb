require 'helper'

describe Me2day::Geo::Point do

  before do
    @point = Me2day::Geo::Point.new(:coordinates => [-122.399983, 37.788299])
  end

  describe "#==" do
    it "returns false for empty objects" do
      point = Me2day::Geo::Point.new
      other = Me2day::Geo::Point.new
      expect(point == other).to be_false
    end
    it "returns true when objects coordinates are the same" do
      other = Me2day::Geo::Point.new(:coordinates => [-122.399983, 37.788299])
      expect(@point == other).to be_true
    end
    it "returns false when objects coordinates are different" do
      other = Me2day::Geo::Point.new(:coordinates => [37.788299, -122.399983])
      expect(@point == other).to be_false
    end
    it "returns false when classes are different" do
      other = Me2day::Geo.new(:coordinates => [-122.399983, 37.788299])
      expect(@point == other).to be_false
    end
  end

  describe "#latitude" do
    it "returns the latitude" do
      expect(@point.latitude).to eq(-122.399983)
    end
  end

  describe "#longitude" do
    it "returns the longitude" do
      expect(@point.longitude).to eq 37.788299
    end
  end

end
