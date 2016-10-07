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
    register({entry_station: @entry_station})
  end

  def finish(station)
    @exit_station = station
    register({exit_station: @exit_station})
    log
    reset
  end

  def journeys
    @journeys.dup
  end

  def log
    @journeys << @current_journey
  end

  def reset
    @current_journey = []
  end

  def register(station)
    @current_journey <<  station
  end

private

  def current_journey
    @current_journey || self.start(station)
  end

end
