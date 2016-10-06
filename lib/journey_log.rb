require_relative 'journey'

class Journeylog

  attr_reader :current_journey

  def initialize
    @journeys = []
    @current_journey = []
  end

  def start(station)
    Journey.new(entry_station: station)
    @current_journey << { entry_station: station }
  end

  def current_journey
    @current_journey || self.start(station)
  end

end
