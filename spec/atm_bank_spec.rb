# frozen_string_literal: true

require './lib/atm_bank'

describe AtmBank do
  it 'The bank can return the current balance and it is a number' do
    expect(subject.my_balance).to eq(0)
  end

  context 'Deposits' do
    it 'A customer can make a deposit to their account' do
      subject.make_deposit(5)
      expect(subject.my_balance).to eq(5)
    end

    it 'A customer can make multiple deposits to their account' do
      subject.make_deposit(5)
      subject.make_deposit(6)
      expect(subject.my_balance).to eq(11)
    end
  end

  context 'Withdrawals' do
    it 'A customer can make a withdrawal' do
      subject.make_deposit(5)
      subject.make_withdrawal(5)
      expect(subject.my_balance).to eq(0)
    end

    it 'A customer can make multiple withdrawals' do
      subject.make_deposit(5)
      subject.make_withdrawal(1)
      subject.make_withdrawal(1)
      expect(subject.my_balance).to eq(3)
    end

    it 'A customer cannot withdraw more money than they have in their account' do
      expect{subject.valid_withdrawal(10)}.to raise_error('Error - Not enough money!')
    end
  end
end
