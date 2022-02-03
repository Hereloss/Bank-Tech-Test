# frozen_string_literal: true

require 'date'
require_relative 'atm_printer'
require_relative 'atm_validity'

# Processes withdrawals and deposits, and has details of the current account balance
class Atm
  def initialize(atm_printer = AtmPrinter.new, validity_checker = AtmValidity.new)
    @my_balance = 0
    @printer = atm_printer
    @validity_checker = validity_checker
  end

  def deposit(amount)
    @validity_checker.valid_amount(amount)
    amount = @validity_checker.converting_from_string_to_amount(amount)
    @my_balance += amount
    @printer.update_account_history(amount, @my_balance, 'Deposit')
    @my_balance
  end

  def withdraw(amount)
    @validity_checker.valid_amount(amount)
    amount = @validity_checker.converting_from_string_to_amount(amount)
    valid_withdrawal(amount)
    @my_balance -= amount
    @printer.update_account_history(amount, @my_balance, 'Withdrawal')
    @my_balance
  end

  def print_transaction_history
    @printer.print_transaction_history
  end

  private

  def valid_withdrawal(amount)
    raise 'Error - Not enough money!' if (@my_balance - amount).negative?
  end
end
