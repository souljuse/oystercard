require 'spec_helper'

describe Journeylog do

  let(:journey) { double :journey, entry_station: "Central" }
  let(:station) { double :station, name: "Central", zone: 1}
  subject { described_class.new }

  # describe "#current_journey" do
  #   it 'should return an incomplete journey' do
  #     subject.start("Central")
  #     expect(subject.current_journey).to include({entry_station: "Central"})
  #   end
  #
  #   it 'should create a new journey' do
  #     expect(subject.current_journey).to be_empty
  #     subject.start("Central")
  #   end
  # end

  describe "#finish" do
    it 'should add current journey to journeys' do
      subject.start("Central")
      subject.finish("South")
      expect(subject.journeys).to include([{entry_station: "Central"}, {exit_station: "South"}])
    end
  end
#
#   it 'should add an exit station to the current_journey' do
#   subject.start("South")
#   expect(subject.current_journey).to include({entry_station: "South"})
# end

end
