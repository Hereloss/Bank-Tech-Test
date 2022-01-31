# frozen_string_literal: true

require 'date'
require_relative 'atm_printer'
require_relative 'atm_bank'

class Atm
  def initialize(atm_bank = Atm_Bank.new, atm_printer = Atm_Printer.new)
    @bank = atm_bank
    @printer = atm_printer
  end

  def check_balance
    puts "Your balance is: #{@bank.my_balance}"
    @bank.my_balance
  end

  def deposit(amount)
    if valid_amount(amount) == true
      @bank.make_deposit(converting_from_string_to_amount(amount))
      @printer.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || #{converting_from_string_to_amount(amount)} || || #{@bank.my_balance}")
    else
      'Not a valid amount'
    end
  end

  def withdraw(amount)
    if valid_amount(amount) == true
      if @bank.valid_withdrawal(converting_from_string_to_amount(amount))
        @bank.make_withdrawal(converting_from_string_to_amount(amount))
        @printer.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || || #{converting_from_string_to_amount(amount)} || #{@bank.my_balance}")
      else
        'Error - Not enough money!'
      end
    else
      'Not a valid amount'
    end
  end

  def print_transaction_history
    @printer.print_transaction_history
  end

  private

  def valid_amount(amount)
    if (amount[0] == '£' && amount[1..-1].to_i != 0) || (amount.is_a? Integer)
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
