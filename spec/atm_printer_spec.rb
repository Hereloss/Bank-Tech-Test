# frozen_string_literal: true

require './lib/atm_printer'

describe Atm_Printer do
  context 'Account history General' do
    it 'A customer can ask for their account history' do
      expect(subject.print_transaction_history).to eq("date || credit || debit || balance \n")
    end

    it 'The date should be in day-month-year order' do
      allow(Date).to receive(:today).and_return Date.new(2023, 1, 10)
      subject.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5")
      expect(subject.print_transaction_history).to eq("date || credit || debit || balance \n10-01-2023 || 5 || || 5 \n")
    end

    it 'The account history should be from the oldest to the newest' do
      subject.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5")
      subject.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || || 5 || 0")
      expect(subject.print_transaction_history).to eq("date || credit || debit || balance \n#{Date.today.strftime('%d-%m-%Y')} || || 5 || 0 \n#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5 \n")
    end
  end

  context 'Deposits' do
    it 'After a deposit, it should show this in the account history in the correct format' do
      subject.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5")
      expect(subject.print_transaction_history).to eq("date || credit || debit || balance \n#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5 \n")
    end
  end

  context 'Withdrawals' do
    it 'After a withdrawal, it should show this in the account history in the correct format' do
      subject.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5")
      subject.update_account_history("#{Date.today.strftime('%d-%m-%Y')} || || 5 || 0")
      expect(subject.print_transaction_history).to eq("date || credit || debit || balance \n#{Date.today.strftime('%d-%m-%Y')} || || 5 || 0 \n#{Date.today.strftime('%d-%m-%Y')} || 5 || || 5 \n")
    end
  end
end
