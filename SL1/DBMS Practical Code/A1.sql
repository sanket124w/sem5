-- SQL Queries from dbms A1 .pdf

-- Design and Develop SQL DDL statements which demonstrate the use of SQL objects
-- such as Table, View, Index, Sequence, Synonym, different constraints etc.

-- Create Table with Constraints:
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    dept_id INT,
    salary DECIMAL(10,2) CHECK(salary > 0),
    hire_date DATE DEFAULT SYSDATE
);
-- Notes:
-- Primary Key constraint on emp_id
-- NOT NULL constraint on emp_name
-- CHECK constraint on salary
-- Default value for hire_date

-- Create View: View to show employee name, salary, and department name:
CREATE VIEW EmployeeDeptView AS
SELECT e.emp_name, e.salary, d.dept_name
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id;

-- Create Index: Index on salary to speed up queries:
CREATE INDEX idx_salary ON Employees(salary);

-- Create Sequence: Sequence to auto-generate employee IDs:
CREATE SEQUENCE emp_seq
START WITH 101
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Create Synonym: Synonym to simplify object name access:
CREATE SYNONYM emp FOR Employees;

-- Add Foreign Key:
ALTER TABLE Employees
ADD CONSTRAINT fk_dept
FOREIGN KEY (dept_id)
REFERENCES Departments(dept_id);


-- Write at least 10 SQL queries on the suitable database application using SQL DML statements.

-- Create Employees Table:
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    salary DECIMAL(10,2),
    hire_date DATE
);

-- Create Departments Table:
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

-- Create Projects Table:
CREATE TABLE Projects (
    proj_id INT PRIMARY KEY,
    proj_name VARCHAR(50),
    dept_id INT
);

-- Inserting data into tables:
INSERT INTO Departments VALUES (1, 'HR', 'New York');
INSERT INTO Departments VALUES (2, 'IT', 'San Francisco');
INSERT INTO Departments VALUES (3, 'Finance', 'Chicago');

INSERT INTO Employees VALUES (101, 'Alice', 2, 50000, '2023-01-15');
INSERT INTO Employees VALUES (102, 'Bob', 2, 60000, '2022-03-10');
INSERT INTO Employees VALUES (103, 'Charlie', 1, 45000, '2021-05-20');
INSERT INTO Employees VALUES (104, 'Eve', 3, 70000, '2020-11-05');
INSERT INTO Employees VALUES (105, 'Frank', 3, 72000, '2019-08-25');

INSERT INTO Projects VALUES (201, 'ProjectA', 2);
INSERT INTO Projects VALUES (202, 'ProjectB', 3);
INSERT INTO Projects VALUES (203, 'ProjectC', 1);

-- SQL DML Queries:

-- 1. Insert a new employee
INSERT INTO Employees (emp_id, emp_name, dept_id, salary, hire_date)
VALUES (106, 'Grace', 1, 48000, '2023-08-01');

-- 2. Select all employees
SELECT * FROM Employees;

-- 3. Select employees with salary > 50000 (Using operator)
SELECT emp_name, salary
FROM Employees
WHERE salary > 50000;

-- 4. Select employees whose name starts with 'A' (Using function)
SELECT emp_name
FROM Employees
WHERE emp_name LIKE 'A%';

-- 5. Update salary for IT department employees (Using operator)
-- Note: The original PDF had 'dept_id = 2', assuming 2 is IT.
UPDATE Employees
SET salary = salary + 5000
WHERE dept_id = 2;

-- 6. Delete employees with salary < 50000
DELETE FROM Employees
WHERE salary < 50000;

-- 7. Select employees with maximum salary (Using aggregate function / subquery)
SELECT emp_name, salary
FROM Employees
WHERE salary = (SELECT MAX(salary) FROM Employees);

-- 8. Use UNION to combine employees from HR (dept_id 1) and IT (dept_id 2)
SELECT emp_name FROM Employees WHERE dept_id = 1
UNION
SELECT emp_name FROM Employees WHERE dept_id = 2;

-- 9. Use IN operator to select employees working in Finance (dept_id 3) or HR (dept_id 1)
SELECT emp_name, dept_id
FROM Employees
WHERE dept_id IN (1, 3);