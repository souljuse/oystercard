require 'station'

describe Station do

  describe "#name" do
    it "should know the station" do
      expect(subject.name).to eq name
    end
  end

  describe "#zone" do
    it "should know the zone" do
      expect(subject.zone).to eq zone
    end
  end

end
