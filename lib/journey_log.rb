class JourneyLog
  def initialize
    @journeys = []
  end

  attr_reader :journeys

  def start(origin)
    @journeys << { in: origin, out: nil }
  end

  def finish(destination)
    @journeys.last[:out] = destination
  end
  

end
