## Sample Queries

Below are some example queries demonstrating how to retrieve data from this banking database.
> ⚠️ **Note:** All data used in this project is entirely fictional and generated for demonstration purposes only. Any resemblance to real persons, companies, or events is purely coincidental.

### 1. Total Loans Issued
Calculates the total amount of money loaned across all customers.

```sql
SELECT SUM(AMOUNT) AS Loans_By_All_Cust 
FROM Loans;
```

### 2. Average Salary by Department
Groups employees by their department name to find the average salary within each department.

```sql
SELECT D.DEPT_NAME, AVG(E.EMP_SALARY) AS Average_Salary
FROM Employee E 
JOIN Department D ON E.DEPT_NUM = D.DEPT_NUM
GROUP BY D.DEPT_NAME;
```

### 3. Customers with Overdrawn Accounts
Identifies accounts with a negative balance and returns the customer's full name, account number, and current balance.

```sql
SELECT P.FName, P.LName, A.Account_Number, A.Balance
FROM Account A 
JOIN Person P ON A.PERSON_ID = P.PERSON_ID
WHERE A.Balance < 0;
```

### 4. Approved Transactions Log
Retrieves details for all transactions that required administrative approval, joining the relevant tables to show both the customer's name and the approving accountant's name.

```sql
SELECT T.TRANS_ID, T.Amount, T.Date_Created, A.Account_Number,
    Cust.FName AS Customer_FName,
    Cust.LName AS Customer_LName,
    Appr.FName AS Approver_FName,
    Appr.LName AS Approver_LName
FROM Transactions T JOIN Account A 
ON T.ACCOUNT_ID = A.ACCOUNT_ID JOIN Person Cust 
ON A.PERSON_ID = Cust.PERSON_ID
JOIN Person Appr 
ON T.APPROVER_PERSON_ID = Appr.PERSON_ID
WHERE T.APPROVER_PERSON_ID IS NOT NULL;
```