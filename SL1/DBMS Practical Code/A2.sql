-- SQL Queries - All types of Join, Sub-Query and View from dbms A2.pdf

-- Create Employees table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT
);

-- Insert sample data into Employees
INSERT INTO Employees (emp_id, emp_name, dept_id) VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 101),
(4, 'David', 103);

-- Create Departments table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Insert sample data into Departments
INSERT INTO Departments (dept_id, dept_name) VALUES
(101, 'HR'),
(102, 'Sales'),
(103, 'IT'),
(104, 'Marketing');

-- INNER JOIN - Employees with their Departments
SELECT e.emp_id, e.emp_name, d.dept_name
FROM Employees e
INNER JOIN Departments d
ON e.dept_id = d.dept_id;

-- LEFT JOIN - Show all employees, even if department is missing
SELECT e.emp_id, e.emp_name, d.dept_name
FROM Employees e
LEFT JOIN Departments d
ON e.dept_id = d.dept_id;

-- RIGHT JOIN - Show all departments, even if no employees are in them
SELECT e.emp_id, e.emp_name, d.dept_name
FROM Employees e
RIGHT JOIN Departments d
ON e.dept_id = d.dept_id;

-- FULL OUTER JOIN (If supported by your DB)
SELECT e.emp_id, e.emp_name, d.dept_name
FROM Employees e
FULL OUTER JOIN Departments d ON e.dept_id = d.dept_id;

-- FULL OUTER JOIN (by using UNION for DBs that don't support it directly)
SELECT e.emp_id, e.emp_name, d.dept_name
FROM Employees e
LEFT JOIN Departments d
ON e.dept_id = d.dept_id
UNION
SELECT e.emp_id, e.emp_name, d.dept_name
FROM Employees e
RIGHT JOIN Departments d
ON e.dept_id = d.dept_id;

-- Subquery - Employees in departments with "HR"
SELECT emp_name
FROM Employees
WHERE dept_id = (SELECT dept_id FROM Departments WHERE dept_name = 'HR');

-- Subquery with IN - Employees in HR or Sales
SELECT emp_name
FROM Employees
WHERE dept_id IN (SELECT dept_id FROM Departments WHERE dept_name IN ('HR', 'Sales'));

-- Subquery with EXISTS - Employees who belong to an existing department
SELECT emp_name
FROM Employees e
WHERE EXISTS (SELECT 1 FROM Departments d WHERE d.dept_id = e.dept_id);

-- View - Create a view of Employee details with Department
CREATE VIEW EmployeeDetails AS
SELECT e.emp_id, e.emp_name, d.dept_name
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id;

-- Query the view
SELECT * FROM EmployeeDetails;