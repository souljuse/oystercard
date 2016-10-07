class Journeylog

  attr_reader :entry_station, :exit_station

  def initialize
    @journeys = []
    @current_journey = []
    @entry_station
    @exit_station
  end

  def start(station)
    @entry_station = station
    @current_journey << { entry_station: @entry_station }
  end

  def finish(station)
    @exit_station = station
    @current_journey << {exit_station: @exit_station}
    @journeys << @current_journey
    @current_journey = []
  end

  def journeys
    @journeys.dup
  end

private
  def current_journey
    @current_journey || self.start(station)
  end

end
