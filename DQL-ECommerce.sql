-- implement some tasks of SQL Queries.

-- 1- basic select
SELECT ProductId, ProductName, Price, StockQuantity
FROM Products;

-- 2- Order By

SELECT ProductId, ProductName, Price, StockQuantity
FROM Products
ORDER BY Price DESC;

-- 3- Group By
-- retrieve sales amount of each product
select p.ProductName , SUM(o.Quantity)
From OrderDetails o
JOIN Products p
on p.ProductId = o.ProductId
GROUP BY p.ProductName

-- using Having

select p.ProductName , SUM(o.Quantity) as TotalAmount
From OrderDetails o
JOIN Products p
on p.ProductId = o.ProductId
GROUP BY p.ProductName
HAVING SUM(o.Quantity)>100

-- 4- SubQuery - Single Row
-- retrieve all products that are higher than the average product price
SELECT *
From Products P
WHERE P.Price > (select AVG(Price)FROM Products); 

-- 5- SubQuery - Multi-Row
-- retrieve all customers who ordered products that belong to the 'Clothes' category

-- by Join
select DISTINCT C.FullName
From Customers C
JOIN Orders O On C.CustomerId = O.CustomerId
JOIN OrderDetails OD ON O.OrderId = OD.OrderId
JOIN Products P ON OD.ProductId = P.ProductId
JOIN Categories CA ON P.CategoryId = CA.CategoryId
WHERE CA.CategoryName = 'Clothes'


-- by SubQuery

SELECT *
From Customers C 
join Orders O 
On C.CustomerId = O.CustomerId
WHERE O.OrderId in (select OD.OrderId from OrderDetails OD
WHERE OD.ProductId in (select P.ProductId from Products P
WHERE P.CategoryId in (select CA.CategoryId FROM Categories CA
WHERE CA.CategoryName = 'Clothes'
 )
)
)

-- 6 - Aggregation functions
-- retrieve the customer with the highest number of orders

select Top 1 C.FullName, COUNT(O.OrderId) as TotalOrders
From Customers C
JOIN Orders O On C.CustomerId = O.CustomerId
GROUP by C.CustomerId,C.FullName 
ORDER By TotalOrders DESC

-- 7- Retrieve each order with its customer and product, and order the results by order date

select C.FullName, O.OrderDate, P.ProductName from Customers C
JOIN Orders O On C.CustomerId = O.OrderId
JOIN OrderDetails OD ON O.OrderId = OD.OrderId
JOIN Products P ON OD.ProductId = P.ProductId
ORDER BY O.OrderDate

-- 8 - Retrieve the top three highest-selling products

select top 3  P.ProductName , SUM(OD.Quantity) AS TotalOrders from Products P
JOIN OrderDetails OD ON P.ProductId = OD.ProductId
GROUP By P.ProductName 
ORDER By TotalOrders DESC  

SELECT * FROM OrderDetails

-- 9 - Retrieve all products that no one has bought yet.

select p.ProductName from Products p
LEFT JOIN OrderDetails od on p.ProductId = od.ProductId
WHERE od.OrderDetailId is NULL

-- 10 - Retrieve all customers who bought the most expensive product

SELECT DISTINCT C.CustomerName
FROM Customers C
JOIN Orders O ON C.CustomerId = O.CustomerId
JOIN OrderDetails OD ON O.OrderId = OD.OrderId
WHERE OD.ProductId = (SELECT TOP 1 ProductId FROM Products ORDER BY Price DESC);

-- 11 - Retrieve each category name and the average price of its products

select CA.CategoryName,AVG(P.Price)  from Categories CA
join Products P on CA.CategoryId = P.CategoryId
GROUP BY CA.CategoryName

-- 12 - Retrieve the products that are priced below the average price of the 'Clothes' category


select P.ProductName  from Products P
WHERE P.Price < (select AVG(PP.Price)   from Products PP
 WHERE PP.CategoryId = (select CA.CategoryId From Categories CA
 WHERE CA.CategoryName = 'Clothes'
 )
)

-- other solution
select P.ProductName  from Products P
WHERE P.Price < (select AVG(PP.Price)   from Products PP
JOIN Categories CA ON PP.CategoryId =CA.CategoryId
GROUP By CA.CategoryName
HAVING CA.CategoryName = 'Clothes')

