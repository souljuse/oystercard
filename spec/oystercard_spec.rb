require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'can top up the balance' do
      expect { subject.top_up(10) }.to change{ subject.balance }.by 10
    end

    context 'when topping up' do
      before do
        subject.top_up(Oystercard::MAXIMUM_BALANCE)
      end

      it 'should raise error if maximum balance is exceeded' do
        expect { subject.top_up(1) }.to raise_error "Maximum balance exceeded. Maximum balance allowed is £#{Oystercard::MAXIMUM_BALANCE}"
      end
    end
  end

  context 'when touch in and touch out' do
    before do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
    end

    describe '#touch_in' do
      it 'can be touched in' do
        subject.touch_in(entry_station)
        expect(subject).to be_in_journey
      end

      it 'will not touch in if below minimum balance' do
        allow(subject).to receive(:balance) { 0 }
        expect { subject.touch_in(entry_station) }.to raise_error "Insufficent balance to touch in"
      end
    end

    describe '#touch_out' do
      it 'can be touched out' do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject).not_to be_in_journey
      end

      it 'should deduct amount' do
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
      end
    end
  end
end
