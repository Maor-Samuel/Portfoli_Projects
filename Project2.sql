------------------------------------------------Maor Samuel Project 2------------------------------------------------------------------


USE AdventureWorks2019

--Question 1

SELECT pp.ProductID, pp.Name , pp.Color , pp.ListPrice , pp.Size
FROM Production.Product as pp LEFT JOIN Sales.SalesOrderDetail as ssd
ON pp.ProductID = ssd.ProductID
WHERE ssd.ProductID IS NULL


--Question 2
SELECT sc.CustomerID, ISNULL(pp.LastName, 'Unknown') AS LastName , ISNULL(pp.FirstName, 'Unknown') AS FirstName
FROM Sales.Customer AS sc
LEFT JOIN Person.Person AS pp  ON pp.BusinessEntityID = sc.CustomerID
LEFT JOIN Sales.SalesOrderHeader AS soh ON sc.CustomerID = soh.CustomerID
WHERE soh.SalesOrderID IS NULL
ORDER BY sc.CustomerID ASC;


--Question 3
SELECT TOP 10 sc.CustomerID, pp.FirstName, pp.LastName, COUNT(soh.SalesOrderID) AS CountOfOrders
FROM Sales.Customer AS sc
JOIN Sales.SalesOrderHeader AS soh ON sc.CustomerID = soh.CustomerID
JOIN Person.Person AS pp ON pp.BusinessEntityID = sc.PersonID
GROUP BY sc.CustomerID, pp.FirstName, pp.LastName	
ORDER BY CountOfOrders DESC


--Question 4
WITH CTE_RankedEmployees AS
( 
SELECT pp.FirstName, pp.LastName, e.JobTitle, e.HireDate,
DENSE_RANK() OVER(PARTITION BY e.JobTitle ORDER BY e.HireDate) AS CountOfTitle
FROM Person.Person AS pp INNER JOIN HumanResources.Employee AS e 
ON e.BusinessEntityID = pp.BusinessEntityID
)
SELECT re.FirstName, re.LastName, re.JobTitle, re.HireDate, 
(
SELECT MAX(CountOfTitle) 
FROM CTE_RankedEmployees 
WHERE JobTitle = re.JobTitle) AS CountOfTitle
  FROM CTE_RankedEmployees re
  ORDER BY re.JobTitle;

--Question 5
GO
WITH CTE_Orders AS 
(
SELECT s.SalesOrderID , s.CustomerID , pp.FirstName , pp.LastName , s.OrderDate ,
       ROW_NUMBER() OVER (PARTITION BY s.CustomerID ORDER BY s.OrderDate DESC) AS OrderRank
FROM Sales.SalesOrderHeader AS s 
     INNER JOIN Sales.Customer AS c ON s.CustomerID = c.CustomerID 
     INNER JOIN Person.Person AS pp ON c.PersonID = pp.BusinessEntityID
),
CTE_LastOrders AS 
(
SELECT CustomerID , FirstName , LastName , SalesOrderID AS LastOrderID , OrderDate AS LastOrderDate
FROM CTE_Orders
WHERE OrderRank = 1
),
CTE_PreviousOrders AS 
(
SELECT CustomerID , OrderDate AS PreviousOrderDate
FROM CTE_Orders
WHERE OrderRank = 2
)
SELECT lo.LastOrderID AS SalesOrderID , lo.CustomerID , lo.FirstName , 
       lo.LastName , lo.LastOrderDate AS LastOrder , po.PreviousOrderDate AS PreviousOrder
FROM CTE_LastOrders AS lo
     LEFT JOIN CTE_PreviousOrders po ON lo.CustomerID = po.CustomerID
ORDER BY lo.CustomerID

--Question 6
GO
WITH CTE_YearTotal AS (
SELECT YEAR(soh.OrderDate) AS OrderYear,ssd.SalesOrderID,pp.FirstName, pp.LastName, 
       SUM(UnitPrice * (1 - UnitPriceDiscount) * OrderQty) AS Total
FROM Sales.Customer AS sc INNER JOIN Sales.SalesOrderHeader AS soh 
     ON sc.CustomerID = soh.CustomerID INNER JOIN Sales.SalesOrderDetail AS ssd 
     ON ssd.SalesOrderID = soh.SalesOrderID INNER JOIN Person.Person AS pp ON pp.BusinessEntityID = sc.PersonID
GROUP BY YEAR(soh.OrderDate), ssd.SalesOrderID, pp.FirstName, pp.LastName
),
CTE_RankedOrders AS 
(
SELECT OrderYear,SalesOrderID,FirstName,LastName,Total,
       ROW_NUMBER() OVER (PARTITION BY OrderYear ORDER BY Total DESC) AS OrderRank
FROM CTE_YearTotal
)
SELECT  OrderYear , SalesOrderID , FirstName , LastName , FORMAT(Total, '#,##0.0') AS Total
FROM CTE_RankedOrders
WHERE OrderRank = 1
ORDER BY  OrderYear


--Question 7
SELECT *
FROM (SELECT YEAR(ss.OrderDate) AS yy,MONTH(ss.OrderDate) AS Month ,
ss.SalesOrderID
FROM Sales.SalesOrderHeader AS ss) AS o
PIVOT (COUNT(SalesOrderID)FOR yy IN ([2011] , [2012] , [2013] ,[2014] )) AS PVT
ORDER BY Month 


--Question 8 -->>> 0 is the grand_total 
WITH CTE_MonthSum AS 
(
SELECT YEAR(soh.OrderDate) AS Year,
       MONTH(soh.OrderDate) AS Month,
       ROUND(SUM(sod.UnitPrice * sod.OrderQty * (1 - sod.UnitPriceDiscount)), 2) AS Sum_Price
FROM Sales.SalesOrderHeader AS soh INNER JOIN Sales.SalesOrderDetail AS sod ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY YEAR(soh.OrderDate), MONTH(soh.OrderDate)
)
SELECT Year , Month , Sum_Price , SUM(Sum_Price) OVER (PARTITION BY Year ORDER BY Month) AS CumSum
FROM CTE_MonthSum
UNION ALL
SELECT Year , 0 AS Month , SUM(Sum_Price) AS Sum_Price , SUM(Sum_Price) AS CumSum
FROM CTE_MonthSum
GROUP BY Year
ORDER BY Year, Month



--Question 9
SELECT hr.JobTitle AS DepartmentName , hr.BusinessEntityID AS Employeesid , CONCAT(pp.FirstName ,' ',pp.LastName ) AS EmployeesFullName ,
       hr.HireDate , DATEDIFF(MM , hr.HireDate , GETDATE()) AS Seniority ,
	   LAG(CONCAT(pp.FirstName, ' ', pp.LastName)) OVER (ORDER BY hr.JobTitle) AS PreviousEmpName,
       LAG(hr.HireDate) OVER (ORDER BY hr.JobTitle) AS PreviousEmpHDate,
	   DATEDIFF(DD, LAG(hr.HireDate) OVER (PARTITION BY hr.JobTitle ORDER BY hr.HireDate), hr.HireDate) AS DiffDays
FROM HumanResources.Employee AS hr INNER JOIN Person.Person AS pp
ON hr.BusinessEntityID = pp.BusinessEntityID
ORDER BY DepartmentName , HireDate 



--Question 10
SELECT hre.HireDate , hrd.DepartmentID ,
       STRING_AGG(CONCAT(pp.BusinessEntityID, ' ', pp.FirstName, ' ', pp.LastName), ', ') AS TeamEmployees
FROM HumanResources.Employee AS hre INNER JOIN Person.Person AS pp
     ON hre.BusinessEntityID = pp.BusinessEntityID INNER JOIN HumanResources.EmployeeDepartmentHistory AS edh 
	 ON pp.BusinessEntityID = edh.BusinessEntityID INNER JOIN HumanResources.Department AS hrd 
	 ON edh.DepartmentID = hrd.DepartmentID
GROUP BY  hre.HireDate, hrd.DepartmentID
ORDER BY  hre.HireDate DESC



------------------------------------------------Maor Samuel Project 2------------------------------------------------------------------