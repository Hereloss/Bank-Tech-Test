class Atm

  attr_reader :my_balance

  def initialize
    @my_balance = 0
  end


  def deposit(amount)
    if valid_amount(amount) == true
      amount = converting_from_string_to_amount(amount)
      @my_balance += amount
      return @my_balance.to_s + Date.today.to_s
    else
      return "Not a valid amount"
    end
  end

  def withdraw(amount)
    if valid_amount(amount) == true
      amount = converting_from_string_to_amount(amount)
      if @my_balance - amount < 0
        puts "Error - Not enough money!"
        return "Error - Not enough money!"
      end
    @my_balance -= amount
    return @my_balance.to_s + Date.today.to_s
    else
      return "Not a valid amount"
    end
  end

  def valid_amount(amount)
    if (amount[0] == "£" && amount[1..-1].to_i != 0)
      return true
    elsif (amount.is_a? Integer)
      return true
    else
      return false
    end
  end

  def converting_from_string_to_amount(amount)
    if amount.is_a? Integer
      return amount
    else
      return amount[1..-1].to_i
    end
  end
end