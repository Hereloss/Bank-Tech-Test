class Atm

  attr_reader :my_balance

  def initialize
    @my_balance = 0
    @account_history = ['date || credit || debit || balance']
  end


  def deposit(amount)
    if valid_amount(amount) == true
      @my_balance += converting_from_string_to_amount(amount)
      @account_history << "#{Date.today.to_s} || #{converting_from_string_to_amount(amount)} || || #{my_balance}"
      @my_balance.to_s + Date.today.to_s
    else
      "Not a valid amount"
    end
  end

  def withdraw(amount)
    if valid_amount(amount) == true
      valid_withdrawal(converting_from_string_to_amount(amount))
    else
      "Not a valid amount"
    end
  end

  def print_transaction_history
    string_account_history = ""
    @account_history.each do |transaction|
      string_account_history += transaction.to_s + " \n"
    end
    return string_account_history
  end

  private


  def valid_withdrawal(amount)
    if @my_balance - amount < 0
      puts "Error - Not enough money!"
      return "Error - Not enough money!"
    end
    @my_balance -= amount
    @account_history << "#{Date.today.to_s} || || #{converting_from_string_to_amount(amount)} || #{my_balance}"
    @my_balance.to_s + Date.today.to_s
  end

  def valid_amount(amount)
    if (amount[0] == "£" && amount[1..-1].to_i != 0) || (amount.is_a? Integer)
      true
    else
      false
    end
  end

  def converting_from_string_to_amount(amount)
    if amount.is_a? Integer
      amount
    else
      amount[1..-1].to_i
    end
  end
end