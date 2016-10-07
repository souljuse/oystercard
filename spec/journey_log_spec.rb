require 'spec_helper'

describe Journeylog do

  let(:journey) { double :journey, entry_station: "Central" }
  let(:station) { double :station, name: "Central", zone: 1}
  subject { described_class.new }

  describe "#finish" do
    it 'should add current journey to journeys' do
      subject.start("Central")
      subject.finish("South")
      expect(subject.journeys).to include([{entry_station: "Central"}, {exit_station: "South"}])
    end
  end

end
