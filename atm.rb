class Atm

  def initialize
    @my_balance = 0
  end


  def balance
    return @my_balance
  end

  def deposit(amount)
    @my_balance += amount
    return amount
  end
end