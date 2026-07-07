--CREATE A DATABASE 
CREATE DATABASE BankAnalytics ;

--USE THE DATABASE
USE BankAnalytics;

--DATA QUALITY CHECKS
--CHECK THE TOTAL ROWS

SELECT COUNT(*) AS TotalRows
FROM Banking_Customer_Data;

SELECT TOP 20 AccountBalance 
FROM Banking_Customer_Data
ORDER BY AccountBalance DESC;

-- TO CHECK HOW MANY IMPORTED ROWS HAVE NULL VALUES(AccountBlance)
SELECT *
FROM Banking_Customer_Data
WHERE AccountBalance IS NULL;

--TO CHECK MINIMUM ND MAXIMUM ACCOUNT BALANCES
SELECT
     MIN(AccountBalance) AS MinBalance,
	  MAX(AccountBalance) AS MaxBalance
	  FROM Banking_Customer_Data;

--MISSING ACCOUNT BALANCE
SELECT COUNT(*) AS AccountBalance
FROM Banking_Customer_Data
WHERE AccountBalance IS NULL;

--MISSING MOMTHLY INCOME
SELECT COUNT(*) AS NullIncome
FROM Banking_Customer_Data
WHERE  MonthlyIncome IS NULL;

--MISSING CREDIT SCORE
SELECT COUNT(*) AS NullCreditScore
FROM Banking_Customer_Data
WHERE  CreditScore IS NULL;

--DUPLICATE CUSTOMER IDs
SELECT 
    CustomerID,
	COUNT(*) AS DuplicateCount
FROM Banking_Customer_Data
GROUP BY CustomerID
HAVING COUNT(*) > 1;

--MISSING EDUCATION
SELECT COUNT(*) AS MissingEducation
FROM Banking_Customer_Data
WHERE Education IS NULL;

--Mising OCCUPATION
SELECT COUNT(*) AS MissingOccupation
FROM Banking_Customer_Data
WHERE Occupation IS NULL;

--GENDER DISTRIBUTION
SELECT
      Gender,
	  COUNT(*) AS CustomerCount
FROM  Banking_customer_Data
GROUP BY Gender;

--ACCOUNT TYPE DISTRIBUTION
SELECT
     AccountType,
	 COUNT(*) AS CustomerCount
FROM Banking_Customer_Data
GROUP BY AccountType;

--CUSTOMER CHURN DISTRIBUTION
SELECT
     CustomerChurn,
	 COUNT(*) AS CustomerCount
FROM Banking_Customer_Data
GROUP BY CustomerChurn;

--REPLACE NULL VALUES(EDUCATION) WITH 'UNKNOWN'
UPDATE Banking_customer_Data
SET Education = 'UNKNOWN'
WHERE Education is null;

--VERIFY
SELECT COUNT(*)
FROM Banking_Customer_Data
WHERE Education IS NULL;

--PHASE 2: BANKING KPI ANALYSIS

--KPI 1 TOTAL DEPOSITS
SELECT
    SUM(AccountBalance) AS TotalDeposits
FROM Banking_Customer_Data;

--KPI 2 AVERAGE ACCOUNT BALANCE
SELECT
    AVG(AccountBalance) AS AvgAccountBalance
FROM Banking_Customer_Data;

--KPI 3 AVERAGE MONTHLY INCOME
SELECT
    AVG(MonthlyIncome) AS AvgMonthlyIncome
FROM Banking_Customer_Data;

--KPI 4 AVERAGE CREDIT SCORE
SELECT
    AVG(CreditScore) AS AvgCreditScore
FROM Banking_Customer_Data;

--KPI 5 TOTAL LOAN AMOUNT
SELECT
    SUM(LoanAmount) AS TotalLoanAmount
FROM Banking_Customer_Data;

--CUSTOMER CHURN INVESTIGATION

--CHURN BY GENDER
SELECT
     Gender,
	 COUNT(*) AS ChurnedCustomers
FROM Banking_Customer_Data
WHERE CustomerChurn = 1
GROUP BY Gender;

--CHURN BY ACCOUNT TYPE
SELECT
     AccountType,
	 COUNT(*) AS ChurnedCustomers
FROM Banking_Customer_Data
WHERE CustomerChurn = 1
GROUP BY AccountType;

--DIGITAL BANKING ADOPTION
SELECT
     DigitalBanking,
	 COUNT(*) AS ChurnedCustomers
FROM Banking_Customer_Data
GROUP BY DigitalBanking;

--AVERAGE BALANCE BY ACCOUT TYPE
SELECT
    AccountType,
	AVG(AccountBalance) AS AvgBalance
FROM Banking_Customer_Data
GROUP BY AccountType;

--AVERAGE CREDIT SCORE BY CHURN STATUS
SELECT
    CustomerChurn,
	AVG(CreditScore) AS AvgCreditScore
FROM Banking_Customer_Data
GROUP BY CustomerChurn;

--CUSTOMER SEGMENTATION ANALYSIS
--CUSTOMERS BY REGION
SELECT
     Region,
	 COUNT(*) AS CustomerCount
FROM Banking_Customer_Data
GROUP BY Region
ORDER BY CustomerCount DESC;

--AVERAGE ACCOUNT BALANCE BY REGION
SELECT
    Region,
	AVG(AccountBalance) AS AvgBalance
FROM Banking_Customer_Data
GROUP BY Region
ORDER BY AvgBalance DESC;

--AVERAGE MONTHLY INCOME BY EDUCATION
SELECT
    Education,
	AVG(MonthlyIncome) AS AvgIncome
FROM Banking_Customer_Data
GROUP BY Education
ORDER BY AvgIncome DESC;

--REAL CHURN DRIVERS
--REGION WITH MOST CHURNED CUSTOMERS IN DESCENDING ORDER
SELECT
     Region,
	 COUNT(*) AS ChurnedCustomers
FROM Banking_Customer_Data
WHERE CustomerChurn = 1
GROUP BY Region
ORDER BY ChurnedCustomers DESC;

SELECT
     Education,
	 COUNT(*) AS ChurnedCustomers
FROM Banking_Customer_Data
WHERE CustomerChurn = 1
GROUP BY Education
ORDER BY ChurnedCustomers DESC;

--AVERAGE ACCOUNT BALANCE BY CUSTOMER CHURN
SELECT
     CustomerChurn,
     AVG(AccountBalance) as AvgBalance
FROM Banking_Customer_Data
GROUP BY CustomerChurn
ORDER BY CustomerChurn;

--AVERAGE MONTHLY INCOME BY CUSTOMER CHURN
SELECT
     CustomerChurn,
     AVG(MonthlyIncome) as AvgBalance
FROM Banking_Customer_Data
GROUP BY CustomerChurn
ORDER BY CustomerChurn;

--AVERAGE CREDIT SCORE BY REGION
SELECT
     Region,
     AVG(CreditScore) AS AvgCreditScore
FROM Banking_Customer_Data
GROUP BY Region
ORDER BY AvgCreditScore DESC;

--TOP OCCUPATIONS BY CUSTOMER COUNT
SELECT
     Occupation,
     COUNT(*) AS CustomerCount
FROM Banking_Customer_Data
GROUP BY Occupation
ORDER BY CustomerCount DESC;

--CHURN RATE BY ACCOUNT TYPE

SELECT
     AccountType,
	 COUNT(*) AS TotalCustomers,
	 SUM(CAST(CustomerChurn AS INT)) AS ChurnedCustomers,
	 ROUND(
	     SUM(CAST(CustomerChurn AS INT)) * 100.0 /
 COUNT(*),
		 2
		 ) AS ChurnRate
FROM Banking_Customer_Data
GROUP BY AccountType
ORDER BY ChurnRate DESC;