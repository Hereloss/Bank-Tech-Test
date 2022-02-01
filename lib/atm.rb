# frozen_string_literal: true

require 'date'
require_relative 'atm_printer'
require_relative 'atm_bank'
require_relative 'atm_validity'

# This class is the one to interact with in the terminal and calls the others upon checking for valid input
class Atm
  def initialize(atm_bank = AtmBank.new, atm_printer = AtmPrinter.new, validity_checker = AtmValidity.new)
    @bank = atm_bank
    @printer = atm_printer
    @validity_checker = validity_checker
  end

  def check_balance
    puts "Your balance is: #{@bank.my_balance}"
    @bank.my_balance
  end

  def deposit(amount)
    @validity_checker.valid_amount(amount)
    amount = @validity_checker.converting_from_string_to_amount(amount)
    @bank.make_deposit(amount)
    @printer.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || #{amount} || || #{@bank.my_balance}")
  end

  def withdraw(amount)
    @validity_checker.valid_amount(amount)
    amount = @validity_checker.converting_from_string_to_amount(amount)
    @bank.valid_withdrawal(amount)
    @bank.make_withdrawal(amount)
    @printer.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || || #{amount} || #{@bank.my_balance}")
  end

  def print_transaction_history
    @printer.print_transaction_history
  end
end
