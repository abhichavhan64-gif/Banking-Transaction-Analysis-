Create database Banking;
use Banking;

-- customers table
Create Table Customers (customer_id INT Primary Key,
name Varchar (100), address Varchar(200), account_open_date Date);

-- accounts table
Create Table Accounts (Account_id int primary key, Customer_ID int, Account_Type varchar(20), 
Balance decimal (10,2) , Open_Date date,  foreign key (customer_id) references customers (customer_id)); 

-- transcations table
Create Table Transcations (Transcation_ID INT Primary Key , Account_ID Int, Transcation_date Datetime, Amount decimal(15,2),
Transcation_Type varchar(20),Recipient_Account int, foreign key (Account_ID)references Accounts (Account_ID));

