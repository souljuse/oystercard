require 'oystercard'

describe Oystercard do
  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end
  
  describe '#top_up' do
	  it { is_expected.to respond_to(:to_up) }
  end
end
