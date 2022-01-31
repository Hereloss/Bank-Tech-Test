class Atm

  def initialize
    @my_balance = 0
  end


  def balance
    return @my_balance
  end

  def deposit(amount)
    @my_balance += amount
  end

  def withdraw(amount)
    if @my_balance - amount < 0
      puts "Error - Not enough money!"
      return "Error - Not enough money!"
    end
    @my_balance -= amount
  end
end