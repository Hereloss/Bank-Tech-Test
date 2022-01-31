require './atm.rb'

describe Atm do

  context 'Balance' do

    it 'A customer has a bank account balance' do
      expect(subject.balance).not_to eq(nil)
    end

    it 'When a customer asks for their balance, it returns a number' do
      expect(subject.balance).to eq(0)
    end
  end

  context 'Deposits' do
    it 'A customer can make a deposit to their account' do
      subject.deposit(5)
      expect(subject.balance).to eq(5)
    end

    it 'A customer can make multiple deposits to their account' do
      subject.deposit(5)
      subject.deposit(6)
      expect(subject.balance).to eq(11)
    end
  end

  context 'Withdrawals' do
    it 'A customer can make a withdrawal' do
      subject.deposit(5)
      subject.withdraw(5)
      expect(subject.balance).to eq(0)
    end

    it 'A customer can make multiple withdrawals' do
      subject.deposit(5)
      subject.withdraw(1)
      subject.withdraw(1)
      expect(subject.balance).to eq(3)
    end

    it 'A customer cannot withdraw more money than they have in their account' do
      subject.deposit(5)
      expect(subject.withdraw(10)).to eq 'Error - Not enough money!'
      expect { "Error - Not enough money!" }.to output.to_stdout
    end

  end

end