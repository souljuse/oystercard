require 'spec_helper'

describe Oystercard do

  let(:station) { double :station, zone: 1 }

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
      it 'will not touch in if below minimum balance' do
        allow(subject).to receive(:balance) { 0 }
        expect { subject.touch_in(station) }.to raise_error "Insufficent balance to touch in"
      end
    end

    describe '#touch_out' do
      it 'should deduct amount' do
        subject.touch_in(station)
        expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_BALANCE)
      end
    end

    describe "#calculate_fare" do
      let(:station1) { double :station, zone:1 }
      let(:station2) { double :station, zone:2 }
      let(:station3) { double :station, zone:3 }

      it "should calculate the right fare" do
        subject.touch_in(station1)
        expect{subject.touch_out(station3)}.to change { subject.balance }.by(-3)
      end

      it "should calculate the right fare" do
        subject.touch_in(station3)
        expect{subject.touch_out(station2)}.to change { subject.balance }.by(-2)
      end

      it "should calculate the right fare" do
        subject.touch_in(station1)
        expect{subject.touch_out(station1)}.to change { subject.balance }.by(-1)
      end
    end

  end
end
