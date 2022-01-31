# frozen_string_literal: true

require './lib/atm'

describe Atm do
  before (:each) do
    @bank_double = double()
    @printer_double = double()
    @atm = Atm.new(@bank_double,@printer_double)
  end
  context 'Balance' do
    it 'A customer has a bank account balance' do
      expect(@bank_double).to receive(:my_balance).and_return(0).twice
      expect(@atm.check_balance).not_to eq(nil)
    end

    it 'When a customer asks for their balance, it returns a number' do
      expect(@bank_double).to receive(:my_balance).and_return(0).twice
      expect(@atm.check_balance).to eq(0)
    end
  end

  context 'Deposits' do
    it 'A customer can make a deposit to their account' do
      allow(@bank_double).to receive(:my_balance).and_return(5)
      expect(@bank_double).to receive(:make_deposit).and_return("5, 31-01-2022")
      expect(@printer_double).to receive(:update_account_history).and_return(['5, 31-01-2022'])
      @atm.deposit(5)
      expect(@atm.check_balance).to eq(5)
    end

    it 'A customer can make multiple deposits to their account' do
      allow(@bank_double).to receive(:my_balance).and_return(11)
      expect(@bank_double).to receive(:make_deposit).and_return("5, 31-01-2022")
      allow(@printer_double).to receive(:update_account_history).and_return(['5, 31-01-2022'])
      @atm.deposit(5)
      expect(@bank_double).to receive(:make_deposit).and_return("6, 31-01-2022")
      allow(@printer_double).to receive(:update_account_history).and_return(['6, 31-01-2022'])
      @atm.deposit(6)
      expect(@atm.check_balance).to eq(11)
    end

    it 'Each deposit has a timestamp on it stating the date it was made on' do
      allow(@bank_double).to receive(:my_balance).and_return(11)
      expect(@bank_double).to receive(:make_deposit).and_return("5, 31-01-2022")
      expect(@printer_double).to receive(:update_account_history).and_return(["date || credit || debit || balance","#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5]"])
      expect(@atm.deposit(5)[1]).to include(Date.today.strftime('%d-%m-%Y').to_s)
    end

    it 'A deposit that is not a number or currency amount is not a valid input' do
      allow(@bank_double).to receive(:my_balance).and_return(5)
      allow(@bank_double).to receive(:make_deposit).and_return("5, 31-01-2022")
      allow(@printer_double).to receive(:update_account_history).and_return(["date || credit || debit || balance","#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5]"])
      expect(@atm.deposit('£5')).not_to eq('Not a valid amount')
      expect(@atm.deposit('£5.00')).not_to eq('Not a valid amount')
      expect(@atm.deposit('Five')).to eq('Not a valid amount')
      expect(@atm.deposit('££5')).to eq('Not a valid amount')
    end
  end

  context 'Withdrawals' do
    it 'A customer can make a withdrawal' do
      allow(@bank_double).to receive(:my_balance).and_return(0)
      expect(@bank_double).to receive(:make_deposit).and_return("5, 31-01-2022")
      expect(@bank_double).to receive(:make_withdrawal).and_return("5, 31-01-2022")
      expect(@bank_double).to receive(:valid_withdrawal).and_return(true)
      allow(@printer_double).to receive(:update_account_history).and_return(["date || credit || debit || balance","#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5]"])
      @atm.deposit(5)
      @atm.withdraw(5)
      expect(@atm.check_balance).to eq(0)
    end

    it 'A customer can make multiple withdrawals' do
      allow(@bank_double).to receive(:my_balance).and_return(3)
      expect(@bank_double).to receive(:make_deposit).and_return("5, 31-01-2022")
      expect(@bank_double).to receive(:make_withdrawal).and_return("1, 31-01-2022").twice
      expect(@bank_double).to receive(:valid_withdrawal).and_return(true).twice
      allow(@printer_double).to receive(:update_account_history).and_return(["date || credit || debit || balance","#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5]"])
      @atm.deposit(5)
      @atm.withdraw(1)
      @atm.withdraw(1)
      expect(@atm.check_balance).to eq(3)
    end

    it 'A customer cannot withdraw more money than they have in their account' do
      allow(@bank_double).to receive(:my_balance).and_return(5)
      expect(@bank_double).to receive(:make_deposit).and_return("5, 31-01-2022")
      expect(@bank_double).to receive(:valid_withdrawal).and_return(false)
      allow(@printer_double).to receive(:update_account_history).and_return(["date || credit || debit || balance","#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5]"])
      @atm.deposit(5)
      expect(@atm.withdraw(10)).to eq 'Error - Not enough money!'
    end

    it 'Each withdrawal has a timestamp on it stating the date it was made on' do
      allow(@bank_double).to receive(:my_balance).and_return(3)
      expect(@bank_double).to receive(:make_deposit).and_return("5, 31-01-2022")
      expect(@bank_double).to receive(:make_withdrawal).and_return("1, 31-01-2022")
      expect(@bank_double).to receive(:valid_withdrawal).and_return(true)
      allow(@printer_double).to receive(:update_account_history).and_return(["date || credit || debit || balance","#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5]"])
      @atm.deposit(5)
      expect(@atm.withdraw(5)[1]).to include(Date.today.strftime('%d-%m-%Y').to_s)
    end

    it 'A withdrawal that is not a number or currency amount is not a valid input' do
      allow(@bank_double).to receive(:my_balance).and_return(5)
      allow(@bank_double).to receive(:make_deposit).and_return("5, 31-01-2022")
      allow(@bank_double).to receive(:valid_withdrawal).and_return(false)
      allow(@printer_double).to receive(:update_account_history).and_return(["date || credit || debit || balance","#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5]"])
      expect(@atm.withdraw('£5')).not_to eq('Not a valid amount')
      expect(@atm.withdraw('£5.00')).not_to eq('Not a valid amount')
      expect(@atm.withdraw('Five')).to eq('Not a valid amount')
      expect(@atm.withdraw('££5')).to eq('Not a valid amount')
    end
  end

  context 'Account history' do
    it 'A customer can ask for their account history' do
      allow(@printer_double).to receive(:print_transaction_history).and_return("date || credit || debit || balance \n")
      expect(@atm.print_transaction_history).to eq("date || credit || debit || balance \n")
    end
  end
end
