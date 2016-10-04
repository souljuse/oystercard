require 'juorney_log'

describe JourneyLog do
  it { is_expected.to respond_to(:start).with 1.argument }
  it { is_expected.to respond_to(:finish).with 1.argument }

  describe '#journeys' do
    let { :origin } double { :station }
    let { :destination } double { :station }

    before do
      subject.start(origin)
      subject.finish(destination)
    end

    it 'logs the origin' do
      expect(subject.journeys.last[:in]).to eq origin
    end

    it 'logs the destination' do
      expect(subject.journeys.last[:out]).to eq destination
    end
  end
end