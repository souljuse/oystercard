require 'spec_helper'

describe Station do
  subject { described_class.new("Old Street", 1) }

  describe "#name" do
    it "should know the station" do
      expect(subject.name).to eq("Old Street")
    end
  end

  describe "#zone" do
    it "should know the zone" do
      expect(subject.zone).to eq(1)
    end
  end

end
