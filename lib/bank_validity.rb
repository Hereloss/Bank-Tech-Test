# frozen_string_literal: true

# This class just checks if an amount is valid and converts said amount to an integer value from a value like "£500"
class BankValidity
  def valid_amount(amount)
    raise 'Not a valid amount' unless (amount[0] == '£' && amount[1..-1].to_i != 0) || (amount.is_a? Integer)
  end

  def converting_from_string_to_amount(amount)
    if amount.is_a? Integer
      amount
    else
      amount[1..-1].to_i
    end
  end
end
