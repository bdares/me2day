require 'helper'

describe Me2day::GeoFactory do

  describe ".new" do
    it "generates a Point" do
      geo = Me2day::GeoFactory.fetch_or_new(:type => 'Point')
      expect(geo).to be_a Me2day::Geo::Point
    end
    it "generates a Polygon" do
      geo = Me2day::GeoFactory.fetch_or_new(:type => 'Polygon')
      expect(geo).to be_a Me2day::Geo::Polygon
    end
    it "raises an ArgumentError when type is not specified" do
      expect{Me2day::GeoFactory.fetch_or_new}.to raise_error ArgumentError
    end
  end

end
