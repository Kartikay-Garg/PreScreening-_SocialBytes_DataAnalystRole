/*
11. Create Student Table with ID as Primary Key and NOT NULL , Name as 20 Characters ,
Age as Int value both are NOT NULL and Address have  25 charter And Insert Any 5 Records?  
*/
CREATE TABLE Student (
    ID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(20) NOT NULL,
    Age INT NOT NULL,
    Address VARCHAR(25)
);
INSERT INTO Student (ID, Name, Age, Address)
VALUES
    (1, 'Kartikay', 25, 'Meerut'),
    (2, 'Avinash', 22, 'Sultanpur'),
    (3, 'astha', 26, 'Lucknow'),
    (4, 'vinay', 24, 'Faridabad'),
    (5, 'vikas', 28, 'Patna');
    
    
/*
12. Write an SQL query to find the youngest student in the "student" table ?
*/

SELECT *
FROM Student
ORDER BY Age ASC
LIMIT 1;

/*
13.  Write an SQL query to retrieve the names and addresses of all persons from the "Person" table
 along with their corresponding addresses from the "Address" table.
*/
SELECT p.Name, a.Address
FROM Person p
JOIN Address a ON p.PersonID = a.PersonID;

/*
 14. Write an SQL query to fetch the second highest number from the "student" table.?
*/

SELECT DISTINCT Age
FROM Student
ORDER BY Age DESC
LIMIT 1 OFFSET 1;


/*
15.  SQL Quary to get the nth highest salary from Employee table
*/
SELECT DISTINCT Salary
FROM Employee
ORDER BY Salary DESC
LIMIT 1 OFFSET 4;


/*
16.  Write a SQL query to find the median salary of each company.?
*/

WITH RankedSalaries AS (
    SELECT
        Company,
        Salary,
        ROW_NUMBER() OVER (PARTITION BY Company ORDER BY Salary) AS RowAsc,
        ROW_NUMBER() OVER (PARTITION BY Company ORDER BY Salary DESC) AS RowDesc
    FROM Employee
)
SELECT
    Company,
    AVG(Salary) AS MedianSalary
FROM RankedSalaries
WHERE RowAsc = RowDesc
    OR RowAsc + 1 = RowDesc
    OR RowAsc = RowDesc + 1
GROUP BY Company;

/*
17. Write a SQL to get the cumulative sum of an employee’s salary over a period of 3 month but exclude the most recent month?
 The result should be display by id ascending and then by month decending ?
*/
WITH SalaryMonths AS (
    SELECT
        EmployeeID,
        DATE_TRUNC('month', SalaryDate) AS SalaryMonth,
        Salary
    FROM SalaryTable
)
SELECT
    s.EmployeeID,
    s.SalaryMonth,
    SUM(s.Salary) OVER (PARTITION BY s.EmployeeID ORDER BY s.SalaryMonth DESC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS CumulativeSum
FROM SalaryMonths s
ORDER BY s.EmployeeID ASC, s.SalaryMonth DESC;

/*
18.  Write the Query to find the Shortest Distance in Plane.
*/
SELECT 
    ST_Distance(
        ST_MakePoint(-1, -1), 
        ST_MakePoint(0, 0)
    ) AS shortest_distance;

-- Or, with all points
SELECT 
    LEAST(
        ST_Distance(ST_MakePoint(-1, -1), ST_MakePoint(0, 0)),
        ST_Distance(ST_MakePoint(-1, -1), ST_MakePoint(-1, -2)),
        ST_Distance(ST_MakePoint(0, 0), ST_MakePoint(-1, -2))
    ) AS shortest_distance;


/*
19.  Consider a database with two tables: "Orders" and "Customers."
 Write an SQL query to retrieve the top 5 customers who have made the most orders,
 along with the total count of their orders.
 Display the results in descending order of the order count and ascending order of customer names.
*/

SELECT
    c.CustomerName,
    COUNT(o.OrderID) AS OrderCount
FROM
    Customers c
JOIN
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID, c.CustomerName
ORDER BY
    OrderCount DESC, CustomerName ASC
LIMIT 5;


/*
20.  Consider a database schema that represents an online bookstore with two tables: books and orders.
 The books table has columns: book_id, title, author, price, and stock_quantity.
 The orders table has columns: order_id, book_id, quantity, and order_date.
 Write an SQL query to find the top 3 bestselling products in terms of total quantity sold, along with their names and total quantities sold.
*/

SELECT
    b.title AS ProductName,
    SUM(o.quantity) AS TotalQuantitySold
FROM
    books b
JOIN
    orders o ON b.book_id = o.book_id
GROUP BY
    b.book_id, b.title
ORDER BY
    TotalQuantitySold DESC
LIMIT 3;






