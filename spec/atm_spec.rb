# frozen_string_literal: true

require './atm'

describe Atm do
  before (:each) do
    @bank_double = double()
    @printer_double = double()
    @atm = Atm.new(@bank_double,@printer_double)
  end
  context 'Balance' do
    it 'A customer has a bank account balance' do
      allow(@bank_double).to receive(:my_balance).and_return(0)
      expect(@atm.check_balance).not_to eq(nil)
    end

    it 'When a customer asks for their balance, it returns a number' do
      allow(@bank_double).to receive(:my_balance).and_return(0)
      expect(@atm.check_balance).to eq(0)
    end
  end

  context 'Deposits' do
    it 'A customer can make a deposit to their account' do
      allow(@bank_double).to receive(:my_balance).and_return(5)
      allow(@bank_double).to receive(:make_deposit).and_return("5, 31-01-2022")
      allow(@printer_double).to receive(:update_account_history).and_return(['5, 31-01-2022'])
      @atm.deposit(5)
      expect(@atm.check_balance).to eq(5)
    end

    it 'A customer can make multiple deposits to their account' do
      allow(@bank_double).to receive(:my_balance).and_return(11)
      allow(@bank_double).to receive(:make_deposit).and_return("5, 31-01-2022")
      allow(@printer_double).to receive(:update_account_history).and_return(['5, 31-01-2022'])
      subject.deposit(5)
      allow(@bank_double).to receive(:make_deposit).and_return("6, 31-01-2022")
      allow(@printer_double).to receive(:update_account_history).and_return(['6, 31-01-2022'])
      @atm.deposit(6)
      expect(@atm.check_balance).to eq(11)
    end

    it 'Each deposit has a timestamp on it stating the date it was made on' do
      allow(@bank_double).to receive(:my_balance).and_return(11)
      allow(@bank_double).to receive(:make_deposit).and_return("5, 31-01-2022")
      allow(@printer_double).to receive(:update_account_history).and_return(["date || credit || debit || balance","#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5]"])
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
      subject.deposit(5)
      subject.withdraw(5)
      expect(subject.check_balance).to eq(0)
    end

    it 'A customer can make multiple withdrawals' do
      subject.deposit(5)
      subject.withdraw(1)
      subject.withdraw(1)
      expect(subject.check_balance).to eq(3)
    end

    it 'A customer cannot withdraw more money than they have in their account' do
      subject.deposit(5)
      expect(subject.withdraw(10)).to eq 'Error - Not enough money!'
    end

    it 'Each withdrawal has a timestamp on it stating the date it was made on' do
      subject.deposit(5)
      expect(subject.withdraw(5)[2]).to include(Date.today.strftime('%d-%m-%Y').to_s)
    end

    it 'A withdrawal that is not a number or currency amount is not a valid input' do
      expect(subject.withdraw('£5')).not_to eq('Not a valid amount')
      expect(subject.withdraw('£5.00')).not_to eq('Not a valid amount')
      expect(subject.withdraw('Five')).to eq('Not a valid amount')
      expect(subject.withdraw('££5')).to eq('Not a valid amount')
    end
  end

  context 'Account history' do
    it 'A customer can ask for their account history' do
      expect(subject.print_transaction_history).to eq("date || credit || debit || balance \n")
    end

    it 'The account history should be from the oldest to the newest' do
      subject.deposit(5)
      subject.withdraw(5)
      expect(subject.print_transaction_history).to eq("date || credit || debit || balance \n#{Date.today.strftime('%d-%m-%Y')} || || 5 || 0 \n#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5 \n")
    end

    it 'After a deposit, it should show this in the account history in the correct format' do
      subject.deposit(5)
      expect(subject.print_transaction_history).to eq("date || credit || debit || balance \n#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5 \n")
    end

    it 'After a withdrawal, it should show this in the account history in the correct format' do
      subject.deposit(5)
      subject.withdraw(5)
      expect(subject.print_transaction_history).to eq("date || credit || debit || balance \n#{Date.today.strftime('%d-%m-%Y')} || || 5 || 0 \n#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5 \n")
    end

    it 'The date should be in day-month-year order' do
      allow(Date).to receive(:today).and_return Date.new(2023, 1, 10)
      subject.deposit(5)
      expect(subject.print_transaction_history).to eq("date || credit || debit || balance \n10-01-2023 || 5 || || 5 \n")
    end
  end
end
