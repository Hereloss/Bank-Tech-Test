require './atm.rb'

describe Atm do

  it 'A customer has a bank account' do
    expect(subject.balance).not_to be_empty
  end

end