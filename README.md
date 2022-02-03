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
My approach was relatively simple. Firstly, I worked through the user stories (adding puts statements to print to the console any required details for usage), and then extracted them into the following additional classes:

bankPrinter  
Bank  

While under other circumstances (such as with a much larger project), I would outline my potential classes beforehand and consider how they interact before writing tests, because this project is comparatively small and the methodology I used to split out the classes, I decided that taking a complete test-driven approach to its design would be the most beneficial. During this I also ensured all the tests were set up independently, using Doubles and Mocks in the bank_spec file for this purpose.

I then realised the bank and bank classes were very similar, and had very similar functionality and so I combined these two classes, also removing the ability to see balance using a command as this is covered in the show account history command.

I typically would not document easily readable classes/methods, however have done so in this case as Rubocop recommended to do so.

## How to use
### Set up
Load up IRB or a REPL of your choice
Require the bank.rb file: If using PRY: load './lib/bank.rb' If using IRB: require './lib/bank.rb'  
Instantiate a new bank class in your REPL using the following line of code: bank = bank.new  
Make a deposit using the deposit command listed in the 'Commands' section below!
### Commands
To make a deposit: bank.deposit(500)  
To make a withdrawal: bank.withdraw(500)  
To print your transaction history: bank.print_transaction_history  

This program will accept money added in any integer form, or in the form "£500". It will not accept pence,  
$,¢, € or any other currency type. I have also assumed any integer value entered will not have more than 2 decimal places (this would not break the program however )

### Feature Test
Set up the application as stated above, and input the following into your terminal:

bank.deposit(1000)  
bank.withdraw(5)  
bank.deposit(10)  
bank.print_transaction_history  
You will see a table similar to the one stated in the acceptance criteria. 
