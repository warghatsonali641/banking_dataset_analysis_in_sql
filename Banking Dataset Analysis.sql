create database mybank;
use mybankdb;

select*from Customers;
select*from Accounts;
select*from Transactions;
select*from Loans;
select*from Credit cards;
select*from Branches;
select*from ATMs;

#calculate total numbers of customers
select count(*) as TotalCustomers from Customers;

#calculate total numbers of accounts
select count(*) as TotalCustomers from Accounts;

#calculate total loarns amount
select sum(Amount) as TotalLoansAmount from Loans;

#calculate toal credit limit all credit cards
select sum(CreditLimit) as TotalCreditLimit from Credit;

#find all active accounts
select*from Accounts where status='Active';

#find all acounts made on 15th jan 2023
select*from Transactions where tranactionDate > '2023-01-15';

#find loans with intrest rates above 5.0
select*from Loans where InterestRate >5.0;

select c.CustomerId, c.Name, c.Age, a.AccountNumber, a.AccountType, a.Balance
from Customers c
join Account a on c.CustomerID= a.CustomerID;

select t.TrancationID, t.TrancationDate, t.Amount, t.Typr, t.Description, a.AccountNumber, a.AccountType, c.Name as CustomerName
from Transactions t
join accounts a on t.AccountNumber = a.AccountNumber
join customers c on a.CustomerID = c.CustomerId;

select c.Name, l.Amount as LoanAmount 
from customers c
join Loans l on c.CustomerID= l.customerID
order by l.Amount desc
limit 10;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM Accounts
WHERE Status = 'Inactive';

#find customers with multiple accounts
select c.CustomerID, c.Name, count(a.AccountNumber) as NumAccounts
from Customers c
join Accounts a on c.CustomerId= a.CustomerId
group by c.CustomerID, c.Name
having count(a.AccountNumber)>1;

#print the first chacter of name from customers table
select substring(Name, 1, 3) as FirstThreeCharactersOfName
from Customers;

select 
substring_index(name, '',1) as firstname,
substring_index(name,'',-1) as lastname
from customers;

SELECT * 
FROM Customers
WHERE MOD(CustomerID, 2) <> 0;

#sql query to detemint the 5th highest Loan amount without using limuit keyword 
SELECT DISTINCT Amount
FROM Loans L1
WHERE 5 = (
    SELECT COUNT(DISTINCT Amount)
    FROM Loans L2
    WHERE L2.Amount >= L1.Amount
);

#sql query to show the second highest loan from the loan table using sub query
select max(Amount) as secondhighestloan
from loans
where Amount <(
      SELECT MAX(Amount)
      from Loans
);

#sql query to list customerId whose account is inactive
select CustomerID
from Accounts
where Status ='Inactive';

#sql query to fetch the first row of the custiomers table 
select *
from Customers
LIMIT 1;

#sql query to show the current date and time 
select now() as CurrentDateTime;

#sql query to create a new table which consist of data and structure copied from the customers
create table CustomersClone LIKE Customers;
INSERT INTO CustomersClone SELECT * FROM Customers;

SELECT
    CustomerID,
    DATEDIFF(EndDate, CURDATE()) AS DaysRemaining
FROM Loans
WHERE EndDate > CURDATE();

#query to find the latest transaaction date for each account 
select AccountNumber, Max(TransactionDate) as LatestTransactionDate 
from Transactions 
group by AccountNumber;

#Query to find the latest tranaction date for each account
select AccountNumber, max(TransactionDate) as LatestTransactionDate
from Transactions 
group by AccountNumber;

#find the avaerage age of customers
select avg(Age) as AverageAge 
from Customers;

#find account with less than minimum amount for account opend before 1st jan 2022
select AccountNumber, Balance
from Accounts 
where Balance < 25000
and OpenDate <= '2022-01-01';

#find loans that are currently active 
select *
from Loans 
Where EndDate >= CURDATE()
And Status = 'Active';

SELECT AccountNumber, SUM(Amount) AS TotalAmount
FROM Transactions
WHERE MONTH(TransactionDate) = 6
AND YEAR(TransactionDate) = 2023
GROUP BY AccountNumber;

SELECT CustomerID, AVG(Balance) AS AverageCreditCardBalance
FROM CreditCard
GROUP BY CustomerID;

select location, count(*) as NumberOfActiveATMs
from ATMs
where Status= 'Out of Service'
group by Location;

select 
   name, 
   age,
   CASE
   when age < 30 then 'Below 30'
    when age between 30 and 60 then '30 to 60' 
    else 'Above 60'
    end as age_group 
    From customers;