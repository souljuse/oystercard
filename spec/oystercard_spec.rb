require 'oystercard'

describe Oystercard do
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

  	  it { is_expected.to respond_to(:top_up).with(1).argument }

      it 'should raise error if maximum balance is exceeded' do
        expect { subject.top_up(1) }.to raise_error "Maximum balance exceeded. Maximum balance allowed is £#{Oystercard::MAXIMUM_BALANCE}"
      end
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'should deduct amount from balance' do
      subject.top_up(10)
      expect { subject.deduct(5) }.to change{ subject.balance }.by -5
    end
  end

  describe '#in_journey?' do
    it 'is initially not in a journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it { is_expected.to respond_to(:touch_in) }

    it 'can touch in' do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'will not touch in if below minimum balance' do
      # allow(subject).to receive(:balance) { 0 }
      expect { subject.touch_in }.to raise_error "Insufficent balance to touch in"
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to(:touch_out) }

    it 'can touch out' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end
