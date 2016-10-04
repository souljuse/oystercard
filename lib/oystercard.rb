class Oystercard
  attr_reader :balance, :journey, :entry_station

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station
  end

  def top_up(value)
    fail "Balance limit of #{BALANCE_LIMIT} exceeded" if @balance + value > BALANCE_LIMIT
    @balance += value
  end

  def touch_in(station)
    fail "Not enough credit" if balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(value)
   @balance -= value
  end

end
