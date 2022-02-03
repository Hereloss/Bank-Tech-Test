# frozen_string_literal: true

require 'date'
require_relative 'bank_printer'
require_relative 'bank_validity'

# Processes withdrawals and deposits, and has details of the current account balance
class Bank
  def initialize(bank_printer = BankPrinter.new, validity_checker = BankValidity.new)
    @my_balance = 0
    @printer = bank_printer
    @validity_checker = validity_checker
  end

  def deposit(amount)
    @validity_checker.valid_amount(amount)
    amount = @validity_checker.converting_from_string_to_amount(amount)
    @my_balance += amount
    @printer.update_account_history(amount, @my_balance, 'Deposit')
  end

  def withdraw(amount)
    @validity_checker.valid_amount(amount)
    amount = @validity_checker.converting_from_string_to_amount(amount)
    valid_withdrawal(amount)
    @my_balance -= amount
    @printer.update_account_history(amount, @my_balance, 'Withdrawal')
  end

  def print_transaction_history
    @printer.print_transaction_history
  end

  private

  def valid_withdrawal(amount)
    raise 'Error - Not enough money!' if (@my_balance - amount).negative?
  end
end
