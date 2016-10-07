require_relative 'journey'
require_relative 'journey_log'
require_relative 'station'

class Oystercard
  attr_reader :balance, :journey, :journey_log

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  PENALTY_FARE = 6

  def initialize(journey = Journey.new, journey_log = Journeylog.new )
    @journey = journey
    @journey_log = journey_log
    @balance = 0
  end

  def top_up(amount)
    fail "Maximum balance exceeded. Maximum balance allowed is £#{MAXIMUM_BALANCE}" if amount > (MAXIMUM_BALANCE - balance)
    @balance += amount
    "Your Balance is now: £#{balance}"
  end

  def touch_in(station)
    fail "Insufficent balance to touch in" if balance < MINIMUM_BALANCE
    journey.check ? deduct(PENALTY_FARE) : start(station)
  end

  def touch_out(station)
    finish(station)
    journey.check ? deduct(PENALTY_FARE) : deduct(fare)
  end

  private

  def deduct(amount)
    @balance -= amount
    "Your Balance is now: £#{balance}"
  end

  def start(station)
    journey.start
    journey_log.start(station)
  end

  def finish(station)
    journey.finish
    journey_log.finish(station)
  end

  def fare
    journey.complete? ? MINIMUM_BALANCE : PENALTY_FARE
  end

end
