📊 Banking Transaction Analysis using SQL

A data-driven SQL project designed to identify suspicious banking activities, detect fraud patterns, and analyze customer behavior using structured relational data.

🚀 Project Overview

This project aims to support the bank’s fraud detection and risk management teams by analyzing customer, account, and transactional datasets using SQL.
Over 10+ specialized SQL queries were developed to identify financial anomalies such as structuring, dormant accounts, rapid transactions, and other suspicious patterns.

🏗️ Database Schema
Table Name	Description	Columns
Customers	Customer profile information	customer_id, name, address, account_open_date
Accounts	Customer bank accounts	account_id, customer_id, account_type, balance, open_date
Transactions	All financial transactions	transaction_id, account_id, transaction_date, amount, transaction_type, recipient_account
🛠️ Technical Skills Demonstrated

Advanced SQL Joins, GROUP BY, window functions

Time-based & pattern-based transaction analysis

Multi-table relational data integration

Detecting fraud indicators using data aggregation

Identifying behavioral anomalies through transaction insights

📌 Key SQL Tasks & Solutions
1. High-Value Transactions

Query: Retrieve transactions above $10,000 from the past month

Purpose: Identify large transfers requiring investigation

2. Customers with Multiple Accounts

Detect customers holding more than 5 accounts

Useful for flagging complex customer profiles

3. Average Daily Balance

Calculate monthly average balance for each account

Helps assess liquidity and activity

4. Dormant Accounts

Identify accounts with no transactions for 12+ months

Useful for detecting abandoned or risky accounts

5. Negative Balances

List accounts with negative balances

Helps detect overdrafts or fraudulent withdrawals

6. Top Customers by Total Balance

Rank top 10 customers by balance

Useful for prioritizing high-value clients

7. New Accounts with Large Initial Deposits

Accounts opened within 30 days with > $5,000 initial deposit

Helps identify unusual funding behavior

8. Customers with Multiple Account Types

Detect customers holding both checking & savings accounts

9. Structuring Detection

Transactions of exactly $9,999 to avoid the $10k threshold

Helps identify possible money-laundering

10. Rapid-Fire Transactions

Accounts with 3+ transactions in under 5 minutes

Detects layering or fraud activity

11. Late-Night ATM Withdrawals

Withdrawals between 12 AM – 5 AM

12. Frequent Transfers to Same Recipient

Accounts repeatedly sending funds to the same recipient

13. Round-Number Transactions

Detect accounts with transactions divisible by 1,000

Helps identify suspicious structured deposits

🎯 Impact & Benefits

✔ Enhanced fraud-detection accuracy
✔ Identified high-risk activities across accounts
✔ Supported regulatory compliance (e.g., threshold reporting)
✔ Provided actionable insights for banking risk & compliance teams

🧠 Conclusion

This project demonstrates strong capability in SQL analytics, fraud detection, data modeling, and financial pattern recognition—making it ideal for banking, fintech, and analytics-oriented portfolios.
