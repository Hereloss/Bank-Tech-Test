# frozen_string_literal: true

require './lib/bank'

describe Bank do
  it 'Feature test 1' do
    allow(Date).to receive(:today).and_return Date.new(2023, 1, 31)
    bank = Bank.new
    bank.deposit(1000)
    bank.withdraw(5)
    bank.deposit(10)
    output = "date || credit || debit || balance \n"
    output2 = "31-01-2023 || 10 || || 1005 \n"
    output3 = "31-01-2023 || || 5 || 995 \n"
    output4 = "31-01-2023 || 1000 || || 1000 \n"
    final_output = output + output2 + output3 + output4
    expect(bank.print_transaction_history).to eq(final_output)
  end
end

describe Bank do
  it 'Feature test 2' do
    allow(Date).to receive(:today).and_return Date.new(2023, 1, 31)
    bank = Bank.new
    allow(Date).to receive(:today).and_return Date.new(2023, 1, 10)
    bank.deposit(1000)
    allow(Date).to receive(:today).and_return Date.new(2023, 1, 13)
    bank.deposit(2000)
    allow(Date).to receive(:today).and_return Date.new(2023, 1, 14)
    bank.withdraw(500)
    output = "date || credit || debit || balance \n14-01-2023 || || 500 || 2500 \n"
    output2 = "13-01-2023 || 2000 || || 3000 \n10-01-2023 || 1000 || || 1000 \n"
    final_output = output + output2
    expect(bank.print_transaction_history).to eq(final_output)
  end
end

describe Bank do
  it 'Feature test 3 with multiple invalid inputs' do
    allow(Date).to receive(:today).and_return Date.new(2023, 1, 31)
    bank = Bank.new
    bank.deposit(1000)
    expect { bank.deposit('1million') }.to raise_error('Not a valid amount')
    bank.withdraw('£5')
    expect { bank.withdraw('fiver') }.to raise_error('Not a valid amount')
    bank.deposit(10)
    expect { bank.withdraw(2000) }.to raise_error('Error - Not enough money!')
    output = "date || credit || debit || balance \n31-01-2023 || 10 || || 1005 \n"
    output2 = "31-01-2023 || || 5 || 995 \n"
    output3 = "31-01-2023 || 1000 || || 1000 \n"
    final_output = output + output2 + output3
    expect(bank.print_transaction_history).to eq(final_output)
  end
end
