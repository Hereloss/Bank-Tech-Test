require 'date'

class Atm_Bank

  attr_reader :my_balance

  def initialize
    @my_balance = 0
  end

  def make_withdrawal(amount)
    @my_balance -= amount
    "#{@my_balance},#{Date.today.strftime('%d-%m-%Y')}"
  end

  def make_deposit(amount)
    @my_balance += amount
    "#{@my_balance},#{Date.today.strftime('%d-%m-%Y')}"
  end

  def valid_withdrawal(amount)
    if (@my_balance - amount).negative?
      puts 'Error - Not enough money!'
      return false
    end
    return true
  end

end