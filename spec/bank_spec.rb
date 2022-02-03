# frozen_string_literal: true

require './lib/bank'

describe Bank do
  before(:each) do
    @printer_double = double
    @validity_double = double('Validity', valid_amount: true)
    @bank = Bank.new(@printer_double, @validity_double)
  end

  context 'Account history' do
    it 'A customer can ask for their account history' do
      expect(@printer_double).to receive(:print_transaction_history).and_return('Updated!')
      @bank.print_transaction_history
    end
  end
end

describe Bank do
  before(:each) do
    @printer_double = double
    @validity_double = double('Validity', valid_amount: true)
    allow(@printer_double).to receive(:update_account_history) do |arg1, arg2, arg3|
      "amount: #{arg1}, balance: #{arg2}, type: #{arg3}"
    end
    @bank = Bank.new(@printer_double, @validity_double)
  end

  context 'Deposits' do
    it 'A customer can make a deposit to their account' do
      allow(@validity_double).to receive(:converting_from_string_to_amount).and_return(5)
      expect(@bank.deposit(5)).to eq('amount: 5, balance: 5, type: Deposit')
    end

    it 'A customer can make multiple deposits to their account' do
      allow(@validity_double).to receive(:converting_from_string_to_amount).and_return(5, 6)
      expect(@bank.deposit(5)).to eq('amount: 5, balance: 5, type: Deposit')
      expect(@bank.deposit(6)).to eq('amount: 6, balance: 11, type: Deposit')
    end
  end
end

describe Bank do
  before(:each) do
    @printer_double = double
    @validity_double = double('Validity', valid_amount: true)
    allow(@printer_double).to receive(:update_account_history) do |arg1, arg2, arg3|
      "amount: #{arg1}, balance: #{arg2}, type: #{arg3}"
    end
    @bank = Bank.new(@printer_double, @validity_double)
  end

  context 'Withdrawals' do
    it 'can make a withdrawal' do
      allow(@validity_double).to receive(:converting_from_string_to_amount).and_return(5)
      @bank.deposit(5)
      expect(@bank.withdraw(5)).to eq('amount: 5, balance: 0, type: Withdrawal')
    end

    it 'can make multiple withdrawals' do
      allow(@validity_double).to receive(:converting_from_string_to_amount).and_return(5, 1, 1)
      @bank.deposit(5)
      expect(@bank.withdraw(1)).to eq('amount: 1, balance: 4, type: Withdrawal')
      expect(@bank.withdraw(1)).to eq('amount: 1, balance: 3, type: Withdrawal')
    end

    it 'A customer cannot withdraw more money than they have in their account' do
      allow(@validity_double).to receive(:converting_from_string_to_amount).and_return(10)
      expect { @bank.withdraw(10) }.to raise_error('Error - Not enough money!')
    end
  end
end
