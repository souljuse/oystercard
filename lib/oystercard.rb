class Oystercard
  attr_reader :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance exceeded. Maximum balance allowed is £#{MAXIMUM_BALANCE}" if amount > (MAXIMUM_BALANCE - balance)
    @balance += amount
    "Your Balance is now: £#{balance}"
  end

  def touch_in
    fail "Insufficent balance to touch in" if balance < MINIMUM_BALANCE
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
  end

  private

  def deduct(amount)
    @balance -= amount
    "Your Balance is now: £#{balance}"
  end
end
