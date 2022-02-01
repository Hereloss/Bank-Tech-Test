# frozen_string_literal: true

require './lib/atm_printer'

describe AtmPrinter do
  context 'Account history General' do
    it 'A customer can ask for their account history' do
      expect(subject.print_transaction_history).to eq("date || credit || debit || balance \n")
    end

    it 'The date should be in day-month-year order' do
      allow(Date).to receive(:today).and_return Date.new(2023, 1, 10)
      subject.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5")
      output = "date || credit || debit || balance \n10-01-2023 || 5 || || 5 \n"
      expect(subject.print_transaction_history).to eq(output)
    end

    it 'The account history should be from the oldest to the newest' do
      subject.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5")
      subject.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || || 5 || 0")
      output = "date || credit || debit || balance \n#{Date.today.strftime('%d-%m-%Y')} || || 5 || 0 \n"
      output2 = "#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5 \n"
      final_output = output + output2
      expect(subject.print_transaction_history).to eq(final_output)
    end
  end
end

describe AtmPrinter do
  context 'Deposits' do
    it 'After a deposit, it should show this in the account history in the correct format with a timestamp of date' do
      subject.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5")
      output = "date || credit || debit || balance \n#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5 \n"
      expect(subject.print_transaction_history).to eq(output)
    end
  end

  context 'Withdrawals' do
    it 'After a withdrawal, it should show this in the account history with correct format with a timestamp of date' do
      subject.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5")
      subject.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || || 5 || 0")
      output = "date || credit || debit || balance \n#{Date.today.strftime('%d-%m-%Y')} || || 5 || 0 \n"
      output2 = "#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5 \n"
      final_output = output + output2
      expect(subject.print_transaction_history).to eq(final_output)
    end
  end
end
