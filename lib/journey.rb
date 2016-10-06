class Journey

  MINIMUM_BALANCE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station, :fare

  def initialize(args = {})
    @entry_station = args[:entry_station]
    @complete = false
    @fare = PENALTY_FARE
  end
  
  def finish(station)
    @complete = true
    @fare = MINIMUM_BALANCE
    self
  end

  def complete?
    @complete
  end

end
