require 'helper'

describe Me2day::MediaFactory do

  describe ".new" do
    it "generates a Photo" do
      media = Me2day::MediaFactory.fetch_or_new(:id => 1, :type => 'photo')
      expect(media).to be_a Me2day::Media::Photo
    end
    it "raises an ArgumentError when type is not specified" do
      expect{Me2day::MediaFactory.fetch_or_new}.to raise_error ArgumentError
    end
  end

end
