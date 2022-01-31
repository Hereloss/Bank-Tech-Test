require './atm.rb'

describe Atm do

  it 'A customer has a bank account balance' do
    expect(subject.balance).not_to eq(nil)
  end

  it 'When a customer asks for their balance, it returns a number' do
    expect(subject.balance).to eq(0)
  end

  it 'A customer can make a deposit to their account' do
    subject.deposit(5)
    expect(subject.balance).to eq(0)
  end

end