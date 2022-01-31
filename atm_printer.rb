require 'date'
class Atm_Printer

  def initialize
    @account_history = ['date || credit || debit || balance']
  end

  def print_transaction_history
    string_account_history = "#{@account_history[0]} \n"
    if @account_history.length > 1
      @account_history.reverse.each do |transaction|
        string_account_history += "#{transaction} \n" unless transaction == 'date || credit || debit || balance'
      end
    end
    puts string_account_history
    string_account_history
  end

  def update_account_history(transaction)
    @account_history << transaction
  end

end