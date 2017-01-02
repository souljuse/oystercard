require 'spec_helper'

describe Journey do

  let(:card) { Oystercard.new }
  let(:station) { double :station, name: "Central", zone: 1 }

  describe '#complete?' do
    it "knows if a journey is not complete" do
      card.top_up(10)
      card.touch_in(station)
      expect(subject).to be_karma_police
    end

    it "knows if a journey is complete" do
      expect(subject).to be_karma_police
    end
  end
end
