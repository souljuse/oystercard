require 'journey'
require 'oystercard_spec'

describe Journey do
  let(:journey){ { in:entry_station, out:exit_station } }

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end

    context 'when touching in' do
      it 'stores the entry station' do
        subject.touch_in(entry_station)
        expect(subject.entry_station).to eq entry_station
      end
    end

    context 'when touching out' do
      it 'stores exit station' do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.journeys).to include journey
      end
    end
  end
end
