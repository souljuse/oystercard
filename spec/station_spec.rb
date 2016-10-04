require 'station'

describe Station do
  subject { Station.new("Central", 1) }
  it 'takes a name as an argument on initialization' do
    expect(subject.name).to eq "Central"
  end
  it 'takes a zone as an argument on initialization' do
    expect(subject.zone).to eq 1
  end
end