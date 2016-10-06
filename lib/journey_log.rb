require_relative 'journey'

class Journeylog

  def initialize

  end

  def start(station)
    Journey.new(entry_station: station)
  end

  def current_journey
  end

end
