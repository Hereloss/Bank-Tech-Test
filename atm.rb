class Atm

  attr_reader :my_balance

  def initialize
    @my_balance = 0
  end


  def deposit(amount)
    @my_balance += amount
    return @my_balance.to_s + Date.today.to_s
  end

  def withdraw(amount)
    if @my_balance - amount < 0
      puts "Error - Not enough money!"
      return "Error - Not enough money!"
    end
    @my_balance -= amount
    return @my_balance.to_s + Date.today.to_s
  end
end