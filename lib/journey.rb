class Journey

  MINIMUM_BALANCE = 1


  attr_reader :in_journey, :check

  def initialize
    @in_journey = false
    @check = false
  end

  def start
    @in_journey = true
    @check = !@check
  end

  def finish
    @in_journey = false
    @check = !@check
  end

  def karma_police?
    @check == @in_journey ? true : false
  end

end
