# frozen_string_literal: true

require 'date'

# Stores and prints out the account history
class AtmPrinter
  def initialize
    @account_history_header = 'date || credit || debit || balance'
    @account_history = []
  end

  def print_transaction_history
    string_account_history = "#{@account_history_header} \n"
    @account_history.reverse.each do |transaction|
      string_account_history += "#{transaction} \n"
    end
    puts string_account_history
    string_account_history
  end

  def update_account_history(amount, balance, type)
    date = Date.today.strftime('%d-%m-%Y')
    transaction = if type == 'Withdrawal'
                    "#{date} || || #{amount} || #{balance}"
                  else
                    "#{date} || #{amount} || || #{balance}"
                  end
    @account_history << transaction
  end
end
