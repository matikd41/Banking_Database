CREATE TABLE Person (
    PERSON_ID       INT PRIMARY KEY,
    Street          VARCHAR(100) NOT NULL,
    ZipCode         CHAR(10) NOT NULL,
    City            VARCHAR(50) NOT NULL,
    FName           VARCHAR(50) NOT NULL,
    LName           VARCHAR(50) NOT NULL,
    PhoneNumber     CHAR(15) NOT NULL,
    Email           VARCHAR(100) NOT NULL,
    Person_is_Cus   VARCHAR(1) NOT NULL,
    Person_is_Emp   VARCHAR(1) NOT NULL
);

INSERT INTO Person (PERSON_ID, Street, ZipCode, City, FName, LName, PhoneNumber, Email, Person_is_Cus, Person_is_Emp) VALUES
(101, '123 Maple St',      '10001', 'New York',      'Emma',     'Wilson',    '5550101', 'emma.w@gmail.com',      'Y', 'N'),
(102, '456 Oak Ave',       '90210', 'Beverly Hills', 'Liam',     'Garcia',    '5550102', 'liam.g@outlook.com',    'Y', 'N'),
(103, '789 Pine Rd',       '60601', 'Chicago',       'Sophia',   'Martinez',  '5550103', 'sophia.m@proton.me',    'Y', 'N'),
(201, '12 Elm Street',     '10005', 'New York',      'James',    'Brown',     '5550201', 'james.brown@bank.com',  'N', 'Y'),
(202, '88 Cedar Lane',     '10010', 'New York',      'Olivia',   'Davis',     '5550202', 'olivia.d@bank.com',     'N', 'Y'),
(203, '55 River Dr',       '10007', 'New York',      'Noah',     'Taylor',    '5550203', 'noah.t@bank.com',       'N', 'Y'),
(301, '321 Broadway',      '10003', 'New York',      'Ava',      'Johnson',   '5550301', 'ava.j@bank.com',        'Y', 'Y');

CREATE TABLE Customer (
    PERSON_ID INT PRIMARY KEY,
    Credit_Score INT NOT NULL,
    FOREIGN KEY (PERSON_ID) REFERENCES Person(PERSON_ID)
);

INSERT INTO Customer (PERSON_ID, Credit_Score) VALUES
(101, 782),
(102, 645),
(103, 810),
(301, 758);

CREATE TABLE Loans (
    LOAN_ID INT PRIMARY KEY,
    PERSON_ID INT NOT NULL,
    AMOUNT MONEY NOT NULL,
    Interest_Rate DECIMAL(5,3),
    Date_Created DATE,
    Loan_Status VARCHAR(20),
    FOREIGN KEY (PERSON_ID) REFERENCES Customer(PERSON_ID)
);

INSERT INTO Loans (LOAN_ID, PERSON_ID, AMOUNT, Interest_Rate, Date_Created, Loan_Status) VALUES
(5001, 101, 25000.00, 0.059, '2024-02-10', 'Active'),
(5002, 102, 15000.00, 0.072, '2024-06-15', 'Active'),
(5003, 103, 350000.00, 0.042, '2023-11-01', 'Active'),
(5004, 301, 18000.00, 0.065, '2025-01-20', 'Active');

CREATE TABLE Account (
    ACCOUNT_ID INT PRIMARY KEY,
    PERSON_ID INT NOT NULL,
    Account_Type VARCHAR(20),
    Account_Number VARCHAR(20) UNIQUE NOT NULL,
    Balance MONEY DEFAULT 0,
    FOREIGN KEY (PERSON_ID) REFERENCES Customer(PERSON_ID)
);

INSERT INTO Account (ACCOUNT_ID, PERSON_ID, Account_Type, Account_Number, Balance) VALUES
(1001, 101, 'Savings',   'SAV-001001', 12500.00),
(1002, 101, 'Checkings','CHK-001002', 3400.75),
(1003, 102, 'Savings',   'SAV-001003', 3200.00),
(1004, 102, 'Checkings','CHK-001004', -150.00),
(1005, 103, 'Savings',   'SAV-001005', 45890.50),
(1006, 301, 'Savings',   'SAV-003006', 21000.00),
(1007, 301, 'Checkings','CHK-003007', 8900.00);

CREATE TABLE Savings (
    ACCOUNT_ID INT PRIMARY KEY,
    InterestRate DECIMAL(4,3),
    FOREIGN KEY (ACCOUNT_ID) REFERENCES Account(ACCOUNT_ID)
);

INSERT INTO Savings (ACCOUNT_ID, InterestRate) VALUES
(1001, 0.032),
(1003, 0.025),
(1005, 0.040),
(1006, 0.035);

CREATE TABLE Checkings (
    ACCOUNT_ID INT PRIMARY KEY,
    OverdraftLimit MONEY,
    FOREIGN KEY (ACCOUNT_ID) REFERENCES Account(ACCOUNT_ID)
);

INSERT INTO Checkings (ACCOUNT_ID, OverdraftLimit) VALUES
(1002, 1000.00),
(1004, 500.00),
(1007, 2000.00);

CREATE TABLE Job (
    JOB_ID INT PRIMARY KEY,
    Job_Name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO Job (JOB_ID, Job_Name) VALUES
(10, 'Teller'),
(20, 'Accountant'),
(30, 'Human Resource'),
(40, 'IT Support');

CREATE TABLE Department (
    DEPT_NUM INT PRIMARY KEY,
    DEPT_NAME VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO Department (DEPT_NUM, DEPT_NAME) VALUES
(1, 'IT'),
(2, 'Human Resources'),
(3, 'Accounting');

CREATE TABLE Employee (
    PERSON_ID INT PRIMARY KEY,
    JOB_ID INT NOT NULL,
    DEPT_NUM INT NOT NULL,   
    EMP_SALARY MONEY,
    EMP_HIRE_DATE DATE NOT NULL,
    FOREIGN KEY (PERSON_ID) REFERENCES Person(PERSON_ID),
    FOREIGN KEY (JOB_ID) REFERENCES Job(JOB_ID),
    FOREIGN KEY (DEPT_NUM) REFERENCES Department(DEPT_NUM)
);

INSERT INTO Employee (PERSON_ID, JOB_ID, DEPT_NUM, EMP_SALARY, EMP_HIRE_DATE) VALUES
(201, 10, 1, 52000.00, '2022-03-15'),
(202, 20, 3, 68000.00, '2021-07-01'),
(203, 30, 2, 85000.00, '2020-11-20'),
(301, 30, 2, 95000.00, '2019-05-10');

CREATE TABLE Accountant (
    PERSON_ID INT PRIMARY KEY,
    CERTIFICATE_TYPE VARCHAR(50),
    FOREIGN KEY (PERSON_ID) REFERENCES Employee(PERSON_ID)
);

INSERT INTO Accountant (PERSON_ID, CERTIFICATE_TYPE) VALUES
(203, 'CPA'),
(301, 'CPA');

CREATE TABLE Transactions (
    TRANS_ID INT PRIMARY KEY,
    ACCOUNT_ID INT NOT NULL,
    APPROVER_PERSON_ID INT,
    Amount MONEY NOT NULL,
    Date_Created DATE NOT NULL,
    Transaction_Type VARCHAR(20),
    FOREIGN KEY (ACCOUNT_ID) REFERENCES Account(ACCOUNT_ID),
    FOREIGN KEY (APPROVER_PERSON_ID) REFERENCES Accountant(PERSON_ID)
);


INSERT INTO Transactions (TRANS_ID, ACCOUNT_ID, APPROVER_PERSON_ID, Amount, Date_Created, Transaction_Type) VALUES
(9001, 1002, NULL,     1200.00,  '2025-11-01', 'Deposit'),
(9002, 1002, NULL,     -450.00,  '2025-11-03', 'Withdrawal'),
(9003, 1001, 203,      5000.00,  '2025-11-05', 'Deposit'),
(9004, 1004, NULL,     -800.00,  '2025-11-10', 'Withdrawal'),
(9005, 1007, 301,     -2000.00,  '2025-11-15', 'Deposit'),
(9006, 1006, 301,      2000.00,  '2025-11-15', 'Deposit'),
(9007, 1005, 203,     10000.00,  '2025-11-20', 'Deposit');

