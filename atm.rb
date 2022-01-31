class Atm

  attr_reader :my_balance

  def initialize
    @my_balance = 0
    @account_history = ['date || credit || debit || balance']
  end


  def deposit(amount)
    if valid_amount(amount) == true
      make_deposit(amount)
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
    string_account_history = "#{@account_history[0]} \n"
    if @account_history.length > 1
      @account_history.reverse.each do |transaction|
        unless transaction == 'date || credit || debit || balance'
          string_account_history += transaction.to_s + " \n"
        end
      end
    end
    puts string_account_history
    string_account_history
  end

  private

  def make_deposit(amount)
    @my_balance += converting_from_string_to_amount(amount)
    @account_history << "#{Date.today.strftime("%d-%m-%Y").to_s} || #{converting_from_string_to_amount(amount)} || || #{my_balance}"
    @my_balance.to_s + Date.today.strftime("%d-%m-%Y").to_s
  end


  def valid_withdrawal(amount)
    if @my_balance - amount < 0
      puts "Error - Not enough money!"
      return "Error - Not enough money!"
    end
    make_withdrawal(amount)
  end

  def make_withdrawal(amount)
    @my_balance -= amount
    @account_history << "#{Date.today.strftime("%d-%m-%Y").to_s} || || #{converting_from_string_to_amount(amount)} || #{my_balance}"
    @my_balance.to_s + Date.today.strftime("%d-%m-%Y").to_s
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