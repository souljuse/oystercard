require_relative 'station'

class Oystercard
  attr_reader :balance, :journey, :entry_station, :travel_history

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @entry_station
    @travel_history = []
  end

  def top_up(value)
    fail "Balance limit of #{BALANCE_LIMIT} exceeded" if @balance + value > BALANCE_LIMIT
    @balance += value
  end

  def touch_in(station)
    fail "Not enough credit" if balance < MINIMUM_FARE
    if in_journey?
      @travel_history << { in: @entry_station, out: nil }
      deduct(fare)
    end
    @entry_station = station
  end

  def touch_out(station)
    @travel_history << { in: @entry_station, out: station }
    deduct(fare)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def fare
    if !@travel_history.empty? && @travel_history.last[:in] == nil || @travel_history.last[:out] == nil
      PENALTY_FARE
    else
      MINIMUM_FARE
    end
  end

  def deduct(value)
   @balance -= value
  end

end
