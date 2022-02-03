# frozen_string_literal: true

require './lib/atm'

describe Atm do
  before(:each) do
    @printer_double = double
    @validity_double = double
    allow(@validity_double).to receive(:valid_amount).and_return(true)
    @atm = Atm.new(@printer_double, @validity_double)
  end

  context 'Account history' do
    it 'A customer can ask for their account history' do
      expect(@printer_double).to receive(:print_transaction_history).and_return('Updated!')
      @atm.print_transaction_history
    end
  end
end

describe Atm do
  before(:each) do
    @printer_double = double
    @validity_double = double
    allow(@validity_double).to receive(:valid_amount).and_return(true)
    allow(@printer_double).to receive(:update_account_history) do |arg|
      arg
    end
    @atm = Atm.new(@printer_double, @validity_double)
  end

  context 'Deposits' do
    it 'A customer can make a deposit to their account' do
      allow(@validity_double).to receive(:converting_from_string_to_amount).and_return(5)
      expect(@atm.deposit(5)).to eq(5)
    end

    it 'A customer can make multiple deposits to their account' do
      allow(@validity_double).to receive(:converting_from_string_to_amount).and_return(5, 6)
      expect(@atm.deposit(5)).to eq(5)
      expect(@atm.deposit(6)).to eq(11)
    end
  end
end

describe Atm do
  before(:each) do
    @printer_double = double
    @validity_double = double
    allow(@validity_double).to receive(:valid_amount).and_return(true)
    allow(@printer_double).to receive(:update_account_history) do |arg|
      arg
    end
    @atm = Atm.new(@printer_double, @validity_double)
  end

  context 'Withdrawals' do
    it 'can make a withdrawal' do
      allow(@validity_double).to receive(:converting_from_string_to_amount).and_return(5)
      @atm.deposit(5)
      expect(@atm.withdraw(5)).to eq(0)
    end

    it 'can make multiple withdrawals' do
      allow(@validity_double).to receive(:converting_from_string_to_amount).and_return(5, 1, 1)
      @atm.deposit(5)
      expect(@atm.withdraw(1)).to eq(4)
      expect(@atm.withdraw(1)).to eq(3)
    end

    it 'A customer cannot withdraw more money than they have in their account' do
      allow(@validity_double).to receive(:converting_from_string_to_amount).and_return(10)
      expect { @atm.withdraw(10) }.to raise_error('Error - Not enough money!')
    end
  end
end
