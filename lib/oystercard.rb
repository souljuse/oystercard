class Oystercard
  attr_reader :balance
  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Maximum balance exceeded. Maximum credit allowed is #{MAXIMUM_BALANCE}" if amount > (MAXIMUM_BALANCE - balance)
    @balance += amount
  end
end
