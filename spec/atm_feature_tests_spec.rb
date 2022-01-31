require './lib/atm'

describe Atm do
  
  it 'Feature test 1' do
    atm = Atm.new
    atm.deposit(1000)
    atm.withdraw(5)
    atm.deposit(10)
    expect(atm.print_transaction_history).to eq("date || credit || debit || balance \n#{Date.today.strftime('%d-%m-%Y')} || 10 || || 1005 \n#{Date.today.strftime('%d-%m-%Y')} || || 5 || 995 \n#{Date.today.strftime('%d-%m-%Y')} || 1000 || || 1000 \n")
  end

  it 'Feature test 2' do
    atm = Atm.new
    allow(Date).to receive(:today).and_return Date.new(2023, 1, 10)
    atm.deposit(1000)
    allow(Date).to receive(:today).and_return Date.new(2023, 1, 13)
    atm.deposit(2000)
    allow(Date).to receive(:today).and_return Date.new(2023, 1, 14)
    atm.withdraw(500)
    expect(atm.print_transaction_history).to eq("date || credit || debit || balance \n14-01-2023 || || 500 || 2500 \n13-01-2023 || 2000 || || 3000 \n10-01-2023 || 1000 || || 1000 \n")
  end

  it 'Feature test 3 with multiple invalid inputs' do
    atm = Atm.new
    atm.deposit(1000)
    atm.deposit('1million')
    atm.withdraw('£5')
    atm.withdraw('fiver')
    atm.deposit(10)
    expect(atm.print_transaction_history).to eq("date || credit || debit || balance \n#{Date.today.strftime('%d-%m-%Y')} || 10 || || 1005 \n#{Date.today.strftime('%d-%m-%Y')} || || 5 || 995 \n#{Date.today.strftime('%d-%m-%Y')} || 1000 || || 1000 \n")
  end
end