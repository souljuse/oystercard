require 'journey_log'

describe Journeylog do

  let(:journey) { double :journey }
  let(:station) { double :station, zone: 1}

  describe "#start" do

    it 'should start a new journey with an entry station' do
      allow(journey).to receive(:station)
      expect(subject.start(station)).to eq journey(entry_station: "Central")
    end
  end

  describe "#current_journey" do
    it 'should return an incomplete journey' do
      expect(subject.current_journey).to eq true
    end
    it 'should create a new journey' do
      allow(subject).to receive(current_journey).and_return(false)
      expect(subject.current_journey).to subject.start(station)
    end
  end

end
