require 'station'

describe Station do
  it 'takes a name as an argument on initialization' do
    expect(subject.name).to eq name
  end
  it 'takes a zone as an argument on initialization' do
    expect(subject.zone).to eq zone
  end
end