require './atm.rb'

describe Atm do

  context 'Balance' do

    it 'A customer has a bank account balance' do
      expect(subject.my_balance).not_to eq(nil)
    end

    it 'When a customer asks for their balance, it returns a number' do
      expect(subject.my_balance).to eq(0)
    end
  end

  context 'Deposits' do
    it 'A customer can make a deposit to their account' do
      subject.deposit(5)
      expect(subject.my_balance).to eq(5)
    end

    it 'A customer can make multiple deposits to their account' do
      subject.deposit(5)
      subject.deposit(6)
      expect(subject.my_balance).to eq(11)
    end

    it 'Each deposit has a timestamp on it stating the date it was made on' do
      expect(subject.deposit(5)).to include(Date.today.to_s)
    end

    it 'A deposit that is not a number or currency amount is not a valid input' do
      expect(subject.deposit("£5")).not_to eq("Not a valid amount")
      expect(subject.deposit("£5.00")).not_to eq("Not a valid amount")
      expect(subject.deposit("Five")).to eq("Not a valid amount")
      expect(subject.deposit("££5")).to eq("Not a valid amount")
    end
  end

  context 'Withdrawals' do
    it 'A customer can make a withdrawal' do
      subject.deposit(5)
      subject.withdraw(5)
      expect(subject.my_balance).to eq(0)
    end

    it 'A customer can make multiple withdrawals' do
      subject.deposit(5)
      subject.withdraw(1)
      subject.withdraw(1)
      expect(subject.my_balance).to eq(3)
    end

    it 'A customer cannot withdraw more money than they have in their account' do
      subject.deposit(5)
      expect(subject.withdraw(10)).to eq 'Error - Not enough money!'
    end

    it 'Each withdrawal has a timestamp on it stating the date it was made on' do
      subject.deposit(5)
      expect(subject.withdraw(5)).to include(Date.today.to_s)
    end

    it 'A withdrawal that is not a number or currency amount is not a valid input' do
      expect(subject.withdraw("£5")).not_to eq("Not a valid amount")
      expect(subject.withdraw("£5.00")).not_to eq("Not a valid amount")
      expect(subject.withdraw("Five")).to eq("Not a valid amount")
      expect(subject.withdraw("££5")).to eq("Not a valid amount")
    end

  end

  context 'Account history' do
    it 'A customer can ask for their account history' do
      expect(subject.account_history).to eq('date || credit || debit || balance')
    end

    it 'After a deposit, it should show this in the account history in the correct format' do
      subject.deposit(5)
      expect(subject.account_history).to eq('date || credit || debit || balance #{Date.now} || 5 || || 5')
    end

    it 'After a withdrawal, it should show this in the account history in the correct format' do
      subject.deposit(5)
      subject.withdraw(5)
      expect(subject.account_history).to eq('date || credit || debit || balance 
      #{Date.now} || || 5 || 5 #{Date.now} || 5 || || 5 ')
    end
  end

end