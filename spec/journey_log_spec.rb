require 'journey_log'

describe Journeylog do

  let(:journey) { double :journey, entry_station: "Central" }
  let(:station) { double :station, zone: 1}

  describe "#start" do

    it 'should start a new journey with an entry station' do
      allow(journey).to receive(:station)
      expect(subject.start(station)).to eq(journey(entry_station: station))
    end
  end  

end
