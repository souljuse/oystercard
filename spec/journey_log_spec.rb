require 'journey_log'

describe Journeylog do

  let(:journey) { double :journey }
  let(:station) { double :station, name: "Central", zone: 1}

  describe "#start" do

    it 'should start a new journey with an entry station' do
      allow(journey).to receive(:station)
      expect(subject.start(station)).to eq journey(entry_station: "Central")
    end
  end

  describe "#current_journey" do
    it 'should return an incomplete journey' do
      subject.start("Central")
      expect(subject.current_journey).to include({entry_station: "Central"})
    end
    it 'should create a new journey' do
      expect(subject.current_journey).to be_empty
      subject.start("Central")
    end
  end

  describe "#finish" do
    it 'should add an exit station to the current_journey' do
      subject.finish("South")
      expect(subject.current_journey).to include({exit_station: "South"})
    end
  end

end
