CREATE DATABASE BusinessAnalytics;

USE BusinessAnalytics;

Select *
From business_customers

Select *
From business_employees

Select *
From business_orders

Select *
From business_products


-------------------------. SALES PERFORMANCE ANALYSIS
--TOTAL REVENUE
SELECT SUM(TotalPrice) AS Total_Revenue
FROM business_orders;

--Monthly Revenue Trend
SELECT  FORMAT(OrderDate, 'yyyy-MM') AS [Year & Month], SUM(TotalPrice) AS Monthly_Revenue
FROM    business_orders
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
ORDER BY [Year & Month];

--Revenue by Product Category
SELECT     p.Category, SUM(o.TotalPrice) AS Revenue
FROM	   business_orders o
JOIN business_products p ON o.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY Revenue DESC;

-- Top 10 Products by Revenue
SELECT Top 10 P.ProductName, SUM(O.TotalPrice) as TotalRevenuePerProductName
FROM business_orders O
JOIN business_products P ON O.ProductID = P.ProductID
GROUP BY P.ProductName
Order by TotalRevenuePerProductName


----------------------------CUSTOMER ANALYSIS
--Customer Lifetime Value
SELECT c.CustomerID,c.CustomerName,SUM(o.TotalPrice) AS CLTV
FROM business_orders o
JOIN business_customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY CLTV DESC;

--Customer Segmentation by Segment
SELECT Segment,COUNT(*) AS Number_of_Customers
FROM   business_customers
GROUP BY Segment;


--Repeat Customers
SELECT O.CustomerID,C.CustomerName, COUNT(OrderID) AS OrderCount
FROM   business_orders O
JOIN  business_customers C ON O.CustomerID = C.CustomerID
GROUP BY o.CustomerID,C.CustomerName
HAVING COUNT(OrderID) > 1
Order by OrderCount Desc;


----------------------------Employee & Sales Rep Performance
--Total Revenue per Employee
SELECT Top 10 e.EmployeeID,e.EmployeeName,SUM(o.TotalPrice) AS Revenue
FROM   business_orders o
JOIN   business_employees e ON o.EmployeeID = e.EmployeeID
GROUP BY e.EmployeeID, e.EmployeeName
ORDER BY Revenue DESC;


--Orders handled by Department
SELECT E.Department,COUNT(o.OrderID) As TotalOrders
FROM business_orders O
JOIN business_employees E ON O.EmployeeID = E.EmployeeID
Group by E.Department


-----------------------------------Regional & Product Analysis
--Sales by Region
SELECT E.Region,SUM(O.TotalPrice) AS Revenue
FROM business_orders O
JOIN business_employees E ON O.EmployeeID = E.EmployeeID
GROUP BY E.Region;


--Top Cities by Revenue
SELECT TOP 10 C.Location,SUM(O.TotalPrice) AS Revenue
FROM business_orders o
JOIN business_customers C ON O.CustomerID = O.CustomerID
GROUP BY C.Location
ORDER BY Revenue DESC;


-----------------Operational Metrics
--Average Order Value
SELECT AVG(TotalPrice) AS AverageOrderValue
FROM business_orders;


--Order value over time
SELECT FORMAT(OrderDate, 'yyyy-MM') AS [Year & Month],COUNT(OrderID) AS Orders
FROM business_orders
GROUP BY FORMAT(OrderDate, 'yyyy-MM')
ORDER BY [Year & Month];


----------------Customer Segment Revenue by Region
SELECT c.Segment,e.Region,SUM(o.TotalPrice) AS Revenue
FROM business_orders o
JOIN business_customers c ON o.CustomerID = c.CustomerID
JOIN business_employees e ON o.EmployeeID = e.EmployeeID
GROUP BY c.Segment, e.Region
ORDER BY Revenue DESC;
