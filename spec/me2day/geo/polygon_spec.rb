require 'helper'

describe Me2day::Geo::Polygon do

  before do
    @polygon = Me2day::Geo::Polygon.new(:coordinates => [[[-122.40348192, 37.77752898], [-122.387436, 37.77752898], [-122.387436, 37.79448597], [-122.40348192, 37.79448597]]])
  end

  describe "#==" do
    it "returns false for empty objects" do
      polygon = Me2day::Geo::Polygon.new
      other = Me2day::Geo::Polygon.new
      expect(polygon == other).to be_false
    end
    it "returns true when objects coordinates are the same" do
      other = Me2day::Geo::Polygon.new(:coordinates => [[[-122.40348192, 37.77752898], [-122.387436, 37.77752898], [-122.387436, 37.79448597], [-122.40348192, 37.79448597]]])
      expect(@polygon == other).to be_true
    end
    it "returns false when objects coordinates are different" do
      other = Me2day::Geo::Polygon.new(:coordinates => [[[37.77752898, -122.40348192], [37.77752898, -122.387436], [37.79448597, -122.387436], [37.79448597, -122.40348192]]])
      expect(@polygon == other).to be_false
    end
    it "returns false when classes are different" do
      other = Me2day::Geo.new(:coordinates => [[[-122.40348192, 37.77752898], [-122.387436, 37.77752898], [-122.387436, 37.79448597], [-122.40348192, 37.79448597]]])
      expect(@polygon == other).to be_false
    end
  end

end
