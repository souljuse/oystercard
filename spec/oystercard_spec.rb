require 'oystercard'

describe Oystercard do

  it { is_expected.to respond_to(:touch_in).with(1).argument }
  it { is_expected.to respond_to(:touch_out).with(1).argument }

  let(:station) { double :station }
  let(:destination) { double :destination }

  describe "#balance" do
    it 'should check if balance is 0' do
      expect( subject.balance ).to eq(0)
    end
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should add money to the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it 'should raise an error if balance exceed the limit' do
      max_balance = described_class::BALANCE_LIMIT
      subject.top_up(max_balance)
      expect{ subject.top_up 1 }.to raise_error("Balance limit of #{max_balance} exceeded")
    end
  end

  describe '#deduct' do
    # it { is_expected.to respond_to(:deduct).with(1).argument }

    # it 'should deduct an amount from the balance' do
    #   subject.top_up(20)
    #   expect{ subject.deduct 4 }.to change { subject.balance }.by -4
    # end

    it "deduct the due amount from my oystercard on touch out" do
      subject.top_up(20)
      subject.touch_in(station)
      expect{ subject.touch_out(destination) }.to change{ subject.balance }.by -(described_class::MINIMUM_FARE)
    end

  end

  describe '#touch_in' do

    it 'should change the status of journey to true' do
      subject.top_up(20)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'should not let you pass if you don\'t have at least 1£' do
      expect{ subject.touch_in(station) }.to raise_error("Not enough credit")
    end

  end

  describe '#touch_out' do

    it 'should change the status of journey to false' do
      subject.touch_out(destination)
      expect(subject).to_not be_in_journey
    end

    it "should create two new entries in the hash with the key in and key out" do
      subject.top_up(20)
      subject.touch_in(station)
      subject.touch_out(destination)
      expect(subject.travel_history).to include({ :in => station, :out => destination })
    end

  end

  context "top up and touch_in first" do

    before do
      subject.top_up(20)
      subject.touch_in(station)
    end

    describe '#in_journey?' do
      it 'should report whether the user is traveling' do
        expect(subject).to be_in_journey
      end
    end

    describe '#entry_station' do
      it 'records entry_station on touch_in(station)' do
        expect(subject.entry_station).to eq station
      end

      it 'forgets entry_station on touch_out' do
        subject.touch_out(destination)
        expect(subject.entry_station).to be_nil
      end
    end
  end

  describe "#travel_history" do
    it "should return an empty array when initialized" do
      expect( subject.travel_history ).to be_empty
    end
  end

end
