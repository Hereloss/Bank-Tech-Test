# Bank

## Specification

### Requirements
You should be able to interact with your code via a REPL like IRB or Node. (You don't need to implement a command line interface that takes input from STDIN.)
Deposits, withdrawal.
Account statement (date, amount, balance) printing.
Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria
Given a client makes a deposit of 1000 on 10-01-2023
And a deposit of 2000 on 13-01-2023
And a withdrawal of 500 on 14-01-2023
When she prints her bank statement
Then she would see

date || credit || debit || balance  
14/01/2023 || || 500.00 || 2500.00  
13/01/2023 || 2000.00 || || 3000.00  
10/01/2023 || 1000.00 || || 1000.00

## Planning

### User Stories

As a customer,  
So I can manage my finances,  
I would like to have a bank account

As a customer,  
So I can check my finances,   
I would like to be able to see my account balance

As a customer,  
So I can add money to my account,  
I would like to be able to deposit money

As a customer,  
So I can use my money,  
I would like to be able to withdraw my money

As a customer,  
So I can keep track of my actvity,  
I would like to be able to see a timestamp with each transaction

As a customer,  
So I don't go into debt,  
I would like to only to be able to withdraw money that is in my account

As a customer,  
So I can see full details of my finances,  
I would like to be able to see the history of my account

As a customer,  
So I don't deposit a wrong amount or nothing,  
I would like the deposit feature to only accept deposits in numbers or pounds

### Process

## How to use
### Set up
Load up IRB or a REPL of your choice
Require the ATM.rb file: If using PRY: load './lib/atm.rb' If using IRB: require './lib/atm.rb'  
Instantiate a new ATM class in your REPL using the following line of code: atm = ATM.new  
Make a deposit using the deposit command listed in the 'Commands' section below!
### Commands
To make a deposit: atm.deposit(500)  
To make a withdrawal: atm.withdraw(500)  
To see your current balance: atm.check_balance  
To print your transaction history: atm.print_transaction_history
### Feature Test
Set up the application as stated above, and input the following into your terminal:

atm.deposit(1000)  
atm.withdraw(5)  
atm.deposit(10)  
atm.print_transaction_history  
You will see a table similar to the one stated in the acceptance criteria.
