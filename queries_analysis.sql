-- List all transactions above $10,000 in the last month, ordered by amount descending. 
select * from transactions where amount>10000 and transaction_date >='2025-07-30' order by amount desc;

--  Find customers with more than 5 accounts at the bank
select  c.customer_id, c.name,
 count(a.account_id) as Account_count  from customers c inner join accounts a
on c.customer_id=a.customer_id group by c.customer_id,c.name having count(a.account_id)>5;

--  Calculate the average daily balance for each account in the current month
SELECT a.account_id, a.customer_id, a.balance AS current_balance,
    ROUND(a.balance / DAY(LAST_DAY(CURDATE())), 2) AS approx_avg_daily_balance
FROM Accounts a;

-- List dormant accounts (no transactions in the last 12 months)
SELECT  a.account_id, a.customer_id, a.account_type, a.balance, a.open_date
FROM Accounts a WHERE a.account_id NOT IN (SELECT DISTINCT t.account_id  FROM Transactions t
WHERE t.transaction_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)) order by a.account_id;

-- Find accounts with negative balances
select * from accounts where balance<0;


-- List the top 10 customers by total account balance
select c.customer_id ,c.name, sum(a.balance) as total_balance  from customers c inner join accounts a 
on c.customer_id =a.customer_id group by  c.customer_id ,c.name order by total_balance desc  limit 10;

--  Find accounts opened in the last 30 days with initial deposits over $5,000
SELECT a.account_id, a.account_type ,t.transaction_id,t.transaction_date from accounts a inner join transactions t 
on a.account_id=t.account_id where t.transaction_type = 'deposit' and t.amount>5000 and a.open_date>=curdate()-interval 30 day;

-- Find customers who have both checking and savings accounts
SELECT a.customer_id , c.name FROM accounts a left join customers c on a.customer_id=c.customer_id 
 WHERE account_type IN ('checking', 'savings')GROUP BY customer_id HAVING COUNT(DISTINCT account_type) = 2;

--  Identify transactions that are exactly $9,999 (just below reporting threshold)
select transaction_id, account_id, amount , transaction_type from transactions where amount=9999;
select * from transactions where amount=9999;

--  Find accounts with multiple rapid-fire transactions (3+ in 5 minutes)
select distinct a.account_id, a.account_type
from accounts a join transactions t1 on a.account_id = t1.account_id
JOIN transactions t2  ON t1.account_id = t2.account_id 
AND t2.transaction_date BETWEEN t1.transaction_date AND DATE_ADD(t1.transaction_date, INTERVAL 5 MINUTE)
GROUP BY t1.account_id, t1.transaction_date HAVING COUNT(t2.transaction_id) >= 3;


--  Find accounts with unusual ATM withdrawal patterns (late night withdrawals)
select transaction_id,account_id,transaction_date, time(transaction_date) as time_only from transactions 
where transaction_type='withdrawal' and time(transaction_date) between '00:00:00' and'05:00:00';


--  Find accounts making transactions to the same recipient frequently
select account_Id, recipient_account, count(*) as transaction_count,
min(transaction_date) as first_transaction, max(transaction_date) as last_transaction from transactions
where transaction_type='transfer' and recipient_account is not null group by account_Id, recipient_account
having transaction_count>=2 order by transaction_count desc;


-- Detect accounts with round-number transactions (e.g., 5,000,5,000,10,000)
select account_id, count(*) as round_transaction_count,
min(transaction_date) as first_round_transaction, max(transaction_date) as last_round_transaction from transactions
where amount % 1000=0 group by account_id order by round_transaction_count desc;


-- Calculate the cumulative running total of transaction amounts for each account, ordered chronologically.
SELECT
    transaction_id,
    account_id,
    transaction_date,
    amount,
    transaction_type
FROM (SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY account_id
            ORDER BY transaction_date DESC ) AS rn
FROM  transactions
) AS ranked_transactions
WHERE rn = 1;

-- Identify the most recent transaction (based on transaction_date) for every single bank account.

SELECT
    transaction_id,
    account_id,
    transaction_date,
    amount,
    SUM(CASE
            WHEN transaction_type IN ('Deposit', 'Transfer') THEN amount ELSE -amount
        END) OVER (
        PARTITION BY account_id
        ORDER BY transaction_date ASC
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_balance
FROM transactions
ORDER BY account_id, transaction_date;
    