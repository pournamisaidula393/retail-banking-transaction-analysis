-- MY SQL Business analytics project 
-- Retail banking Transaction Analysis

-- sprint 1
-- Business Understanding and Data Understanding
-- 1.1 Company Background
-- Retail banking provides financial products and services such as bank accounts, cards, loans, and transaction facilities to individual customers. The bank maintains customer, account, branch, transaction, card, and loan data.
--  This data can be analyzed to understand customer behavior, product usage, transactions, and loan performance.

-- 1.2 Role:
-- As a Data Analyst supporting the Retail Banking team, the responsibility is to study the available banking data and provide useful insights for business decisions. 
-- The analysis focuses on customers, accounts, transactions, cards, loans, and branches.

-- 1.3 Understanding the ER Diagram:
-- The ER diagram shows the different tables in the retail banking database and how they are connected. 
-- Before writing SQL queries, we need to understand the tables, columns, primary keys, foreign keys, and relationships between them.

-- 1.4 Analytical Thinking from the ER Diagram:
-- 1.Customer Team Wants to Identify Customers and Their Customer Segment We need the Customers table. 
-- The important information includes Customer ID, customer details, and Customer Segment.
-- We would use the Customer ID to identify each customer and the Customer Segment to understand which segment each customer belongs to.

-- 2.Management Wants to Identify Customers Who Have More Than One Bank Account
-- We need the Customers and Accounts tables. The important columns are Customer ID and Account ID.
--  These tables are connected through Customer ID. We would check how many accounts are associated with each customer and identify customers having more than one account.

-- 3. Branch Team Wants to Compare the Accounts Associated with Different Branches
-- We need the Branches and Accounts tables. The important columns are Branch ID, Branch Name, Account ID, and Customer ID.
--  The tables are connected through Branch ID. We would compare the accounts associated with each branch.

-- 4.Bank Wants to Understand How Customers Are Using Their Accounts Through Transactions
-- We need the Customers, Accounts, and Transactions tables. We need Customer ID, Account ID, Transaction ID, Transaction Type, and Transaction Amount.
-- We connect Customer → Account → Transaction to understand customer transactions.

-- 5. Identify Common Transaction Types and Channels
-- We need the Transactions table. The important columns are Transaction Type, Channel, Transaction Date, and Transaction Amount. --
-- We would compare different transaction types and channels to identify the most common transaction types and the channels through which they occur.

-- 6. Identifying Customers with Loans and Loan Types
-- We need the Customers and Loans tables. The important columns are Customer ID, Loan ID, and Loan Type. These tables are connected through Customer ID.
--  We would identify customers who have loans and examine the different types of loans they have.

-- 7.Checking Whether Loan Customers Make Payments on Time
-- We need the Loans and payment/transaction information. We need Loan ID, Due Date, Payment Date, and Payment Amount.
--  We compare the payment date with the due date to check whether the payment was made on time.

-- 8.Compare Loan Performance Across Branches
--  We need the Branches and Loans tables. We need Branch ID, Branch Name, Loan ID, Loan Amount, and Loan Status. 
-- We compare loan information between different branches.

-- 9.Bank Wants to Understand Which Customers Have Cards Linked to Their Accounts
-- We need the Customers, Accounts, and Cards tables. We need Customer ID, Account ID, Card ID, and Card Type.
--  We connect Customer → Account → Card to find which customers have cards.

-- 10. Understand How Customers Use Different Banking Products
-- We need the Customers, Accounts, Cards, and Loans tables. We need information such as Customer ID, Account ID, Card ID, Card Type, Loan ID, and Loan Type. 
-- We connect these tables to understand which banking products each customer uses.


-- sprint 2 database setup 
-- 2.1 design database from ER daigram 
create database retail_banking;
use retail_banking;
select database();

create table customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    gender VARCHAR(20),
    city VARCHAR(50),
    state VARCHAR(50),
    customer_since DATE,
    kyc_status VARCHAR(20),
    segment VARCHAR(30),
    annual_income DECIMAL(15,2),
    credit_score INT,
    is_active VARCHAR(10)
);

create table branches (
    branch_id VARCHAR(20) PRIMARY KEY,
    branch_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    region VARCHAR(50),
    opening_date DATE,
    employee_count INT
);

create table accounts (
    account_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    branch_id VARCHAR(20),
    account_type VARCHAR(30),
    open_date DATE,
    close_date VARCHAR(50),
    current_balance DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    overdraft_limit DECIMAL(15,2),
    status VARCHAR(20),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

create table loans (
    loan_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20),
    branch_id VARCHAR(20),
    loan_type VARCHAR(30),
    principal_amount DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    tenure_months INT,
    disbursement_date DATE,
    maturity_date DATE,
    emi_amount DECIMAL(15,2),
    outstanding_balance DECIMAL(15,2),
    loan_status VARCHAR(30),
    purpose VARCHAR(50),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (branch_id)
        REFERENCES branches(branch_id)
);

CREATE TABLE loan_payments (
    payment_id VARCHAR(20) PRIMARY KEY,
    loan_id VARCHAR(20),
    payment_date DATE,
    scheduled_amount DECIMAL(15,2),
    paid_amount DECIMAL(15,2),
    principal_paid DECIMAL(15,2),
    interest_paid DECIMAL(15,2),
    penalty DECIMAL(15,2),
    days_late INT,
    payment_method VARCHAR(30),
    status VARCHAR(20),

    FOREIGN KEY (loan_id)
        REFERENCES loans(loan_id)
);

create table cards (
    card_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20),
    card_type VARCHAR(30),
    issue_date DATE,
    expiry_date DATE,
    credit_limit DECIMAL(15,2),
    outstanding_balance DECIMAL(15,2),
    reward_points INT,
    is_active VARCHAR(10),
    network VARCHAR(30),

    FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);

create table transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    account_id VARCHAR(20),
    transaction_date DATE,
    transaction_time TIME,
    transaction_type VARCHAR(30),
    amount DECIMAL(15,2),
    channel VARCHAR(30),
    description VARCHAR(100),
    balance_after DECIMAL(15,2),
    status VARCHAR(20),

    FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);

-- 2.2 Data Import 
select * from customers ;
select * from branches ;
select * from accounts ;
select * from loans ;
select * from loan_payments ;
select * from cards ;
select * from transactions ;


-- 2.2 data import 
select count(*) from customers;
select count(*) from branches;
select count(*) from accounts;
select count(*) from loans;
select count(*) from loan_payments;
select count(*) from cards;
select count(*) from transactions;

-- SPRINT 3
-- 11.	What is the total number of customers?
select count(*) as total_customers
from customers;

-- 12. What is the total number of accounts?
select count(*) as total_accounts 
from accounts;

-- 13 What are the different account types available?
select distinct account_type
from accounts;

-- 14.How many customers are currently active?
select count(*) as active_cutsomers
from customers
where is_active='yes';

-- 15.What are the different transaction types available
select distinct transaction_type
from transactions;

-- 16.What is the total amount of completed transactions?
select SUM(amount) AS total_amount
from  transactions
where status = 'Completed';

-- 17 What are the different loan types available?
select distinct loan_type from loans;

-- 18.What is the total number of loans
select count(*) as total_loans from loans;

-- 19. What are the different card types available?
select distinct card_type from cards;

-- 20.What is the total outstanding loan balance?
select sum(outstanding_balance) as total_outstanding_loan_balance from loans;

-- sprint 4 Objective-Based Analysis
-- 4.1 Understand Customer Profile and Segmentation

-- Business Objective: The bank wants to understand its customer base and identify differences between customer groups.

-- compare customers across different segments.
select  segment, COUNT(*) AS customer_count
from  customers
group by segment
order by customer_count DESC;

-- Look at customer demographics.
SELECT gender, COUNT(*) AS customer_count
FROM customers
GROUP BY gender
ORDER BY customer_count DESC;

-- Compare customers across cities and states.
select  city, COUNT(*) AS customer_count
from customers
group by  city
order by customer_count DESC;

select  state, COUNT(*) AS customer_count
from customers
group by  state
order by customer_count DESC;

-- Compare both city and state together

select  city,state, COUNT(*) AS customer_count
from customers
group by  city,state
order by customer_count DESC;

-- Examine income and credit-score differences.
SELECT segment, AVG(annual_income) AS average_income
FROM customers
GROUP BY segment
ORDER BY average_income DESC;

-- credit score
SELECT segment, AVG(credit_score) AS average_credit_score
FROM customers
GROUP BY segment
ORDER BY average_credit_score DESC;

-- both
SELECT segment, AVG(credit_score) AS average_credit_score,
	AVG(annual_income) AS average_income
FROM customers
GROUP BY segment;


-- Look at customer activity and KYC status.
SELECT is_active,COUNT(*) AS customer_count
FROM customers
GROUP BY is_active;

SELECT kyc_status,COUNT(*) AS customer_count
FROM customers
GROUP BY kyc_status;

-- both
SELECT is_active,kyc_status,COUNT(*) AS customer_count
FROM customers
GROUP BY is_active,kyc_status;

-- ●	Understand customer tenure with the bank.

SELECT customer_id,(DATEDIFF((SELECT MAX(transaction_date) FROM transactions) ,customer_since)/365.25)AS customer_tenure_years
from customers
group by customer_id;

select sum((DATEDIFF((select max(transaction_date) from transactions),customer_since) /365.25))/count(customer_id) AS avg_tenure_years from customers;

-- 4.2 Understand Account Usage and Branch Activity

-- Business Objective
-- The bank wants to understand how its accounts are being used and how account activity differs across account types and branches.

-- Compare different account types.
SELECT account_type, COUNT(*) AS account_count
FROM accounts
GROUP BY account_type;

-- Compare account activity across customers.
SELECT customer_id, COUNT(*) AS account_count
FROM accounts
GROUP BY customer_id
ORDER BY account_count DESC;

-- Examine account balances.
SELECT account_id, customer_id, current_balance
FROM accounts;

-- Compare account activity across branches.
SELECT branch_id, COUNT(*) AS account_count
FROM accounts
GROUP BY branch_id
ORDER BY account_count DESC;

-- Look at interest rates across account types.
SELECT account_type,AVG(interest_rate) AS average_interest_rate
FROM accounts
GROUP BY account_type;

-- Identify differences between active and closed accounts.
SELECT status,COUNT(*) AS account_count
FROM accounts
GROUP BY status;

-- 4.3 Analyze Transaction Patterns
-- Business Objective
-- The bank wants to understand how customers use their accounts and how money moves through the banking system.

-- Compare different transaction types.
SELECT transaction_type,COUNT(*) AS transaction_count
FROM transactions
GROUP BY transaction_type;

-- Compare transactions across different channels.
SELECT channel,COUNT(*) AS transaction_count
FROM transactions
GROUP BY channel
ORDER BY transaction_count DESC;

-- . Examine transaction amounts.
SELECT SUM(amount) AS total_amount,AVG(amount) AS average_amount
FROM transactions;

-- Look at common transaction descriptions.
SELECT description,COUNT(*) AS transaction_count
FROM transactions
GROUP BY description
ORDER BY transaction_count DESC;

-- Examine transaction activity over time.
SELECT YEAR(transaction_date) AS year,
       MONTH(transaction_date) AS month,
       COUNT(*) AS transaction_count
FROM transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date)
ORDER BY year, month;

--  Compare transaction activity across accounts.
SELECT account_id,COUNT(*) AS transaction_count
FROM transactions
GROUP BY account_id
ORDER BY transaction_count DESC;

-- -- Look at how transaction activity affects account balances.
SELECT transaction_type,AVG(balance_after) AS average_balance_after
FROM transactions
GROUP BY transaction_type;

-- 4.4 Evaluate Loan Performance and Repayment Behaviour

-- Business Objective: The bank wants to understand how its loans are performing and whether customers are repaying their loans as expected.
-- Compare different loan types.
SELECT loan_type,COUNT(*) AS loan_count
FROM loans
GROUP BY loan_type;

-- Compare loans based on their purpose.
SELECT purpose,COUNT(*) AS loan_count
FROM loans
GROUP BY purpose
ORDER BY loan_count DESC;

-- Examine loan amounts and outstanding balances.
SELECT loan_id,principal_amount,outstanding_balance
FROM loans;

-- Compare loan statuses.
SELECT loan_status,COUNT(*) AS loan_count
FROM loans
GROUP BY loan_status;

-- Identify loans with repayment delays.
SELECT loan_id,payment_date,days_late
FROM loan_payments
WHERE days_late>0;

-- Examine penalties and late payments.
SELECT loan_id,penalty
FROM loan_payments
WHERE penalty > 0;

-- Compare repayment behaviour across loan types.
SELECT l.loan_type,COUNT(p.payment_id) AS payment_count
FROM loans l
JOIN loan_payments p
ON l.loan_id = p.loan_id
GROUP BY l.loan_type;

-- Look at payment methods used by customers.
SELECT payment_method,COUNT(*) AS payment_count
FROM loan_payments
GROUP BY payment_method
ORDER BY payment_count DESC;

-- 4.5 Understand Card Usage and Product Engagement
-- Business Objective: The bank wants to understand how customers use its card products and how card usage relates to their broader banking relationship.

-- Compare different card types
SELECT card_type,COUNT(*) AS card_count
FROM cards
GROUP BY card_type
ORDER BY card_count DESC;

-- Examine credit limits and outstanding balances
 SELECT card_type,AVG(credit_limit)AS average_credit_limit,
    AVG(outstanding_balance)AS average_outstanding_balance
FROM cards
GROUP BY card_type;

-- Compare active and inactive cards
SELECT is_active,COUNT(*) AS card_count
FROM cards
GROUP BY is_active;


--  Examine reward points
select card_type,avg(reward_points) as average_reward_points,sum(reward_points) as total_reward_points
from cards
group by card_type
order by average_reward_points desc;



-- Compare card usage across accounts and networks
select cd.network,a.account_type,count(cd.card_id) as card_count
from cards cd
join accounts a
on cd.account_id = a.account_id
group by cd.network, a.account_type
order by card_count desc;

-- Identify customers using multiple banking products
SELECT cu.customer_id, CONCAT(cu.first_name,' ',cu.last_name) AS customer_name,
COUNT(DISTINCT a.account_id) AS num_accounts,
COUNT(DISTINCT c.card_id) AS num_cards,
COUNT(DISTINCT l.loan_id) AS num_loans
FROM customers cu
LEFT JOIN accounts a ON cu.customer_id = a.customer_id
LEFT JOIN cards c ON a.account_id = c.account_id
LEFT JOIN loans l ON cu.customer_id = l.customer_id
GROUP BY cu.customer_id, customer_name
HAVING num_accounts > 0 AND num_cards > 0 AND num_loans > 0
ORDER BY num_cards DESC, num_loans DESC
LIMIT 15;

-- Look at relationships between cards, accounts, and loans
SELECT CASE WHEN c.card_id IS NOT NULL THEN 'Has Card' ELSE 'No Card' END AS card_ownership,
COUNT(DISTINCT cu.customer_id) AS num_customers,
ROUND(AVG(cu.annual_income),2) AS avg_annual_income,
ROUND(AVG(cu.credit_score),2) AS avg_credit_score
FROM customers cu
LEFT JOIN accounts a ON cu.customer_id = a.customer_id
LEFT JOIN cards c ON a.account_id = c.account_id
GROUP BY card_ownership;

-- SQL Deliverable

	-- ER diagram interpretation and Sprint 1.4 logical solutions.
    -- An ER (Entity Relationship) Diagram shows the tables in the database and how they are connected.
    -- We identify the primary keys, foreign keys, columns, and relationships between customers, accounts, branches, loans, payments, cards, and transactions.
    -- In Sprint 1.4, we study the ER diagram and decide which tables and columns are required to answer each business question before writing SQL queries.
    
	-- MySQL database created from the provided ER diagram.
    -- The database is created in MySQL based on the ER diagram. Tables are created with appropriate data types, primary keys, foreign keys, and constraints.
-- The tables include:
-- Customers
-- Accounts
-- Branches
-- Loans
-- Loan Payments
-- Cards
-- Transactions
    
    
-- Imported and verified project data.
-- The provided CSV files are imported into their respective 
-- MySQL tables. After importing, the data is checked using SELECT and COUNT() queries to make sure the correct number of records has been loaded.


-- SQL queries for Sprint 3.
-- sprint 3 contains basic SQL analysis to understand the database. 
-- It includes finding the number of customers, accounts, loans, transaction types, card types, and total amounts.

-- 	Your analytical questions for each Sprint 4 objective.
-- For Sprint 4, business requirements are converted into analytical questions. These questions help understand customer behaviour, account usage, transactions, loans, and card usage.

-- Supporting SQL queries for each objective.
-- SQL queries are written to answer the analytical questions.
-- Commands such as SELECT, WHERE, GROUP BY, ORDER BY, JOIN, COUNT, SUM, AVG, and HAVING are used to analyse the data.

-- 	Findings and business insights.
-- After executing the SQL queries, the results are interpreted to identify patterns, trends, differences, and important business information.
-- For example, the analysis may show which customer segment is largest, which branch has more accounts, or which loan type has more late payments.

-- Final conclusions and recommendations wherever appropriate.
-- The final results are summarized into conclusions and recommendations.
-- These help the bank make better decisions about customers, accounts, transactions, loans, and cards.

-- Final Outcome
-- The main outcome of this project is to convert a business problem into a data-driven solution.
-- By completing the project, we learn how to:
-- Understand the retail banking business problem.
-- Study the ER diagram and relationships between tables.
-- Design and create a relational database in MySQL.
-- Import and verify the banking dataset.
-- Formulate meaningful business and analytical questions.
-- Write SQL queries to analyse the data.
-- Interpret query results and identify patterns and trends.
-- Generate useful business insights.
-- Provide conclusions and recommendations to support better banking decisions.




