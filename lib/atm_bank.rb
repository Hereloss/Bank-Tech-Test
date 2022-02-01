# frozen_string_literal: true

require 'date'

# Processes withdrawals and deposits, and has details of the current account balance
class AtmBank
  attr_reader :my_balance

  def initialize
    @my_balance = 0
  end

  def make_withdrawal(amount)
    @my_balance -= amount
  end

  def make_deposit(amount)
    @my_balance += amount
  end

  def valid_withdrawal(amount)
    if (@my_balance - amount).negative?
      raise 'Error - Not enough money!'
    end
    true
  end
end
