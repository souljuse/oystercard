class Journeylog

  def initialize
    @journeys = []
    @current_journey = []
  end

  def start(station)
    @current_journey << { entry_station: station }
  end

  def finish(station)
    @current_journey << {exit_station: station}
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
