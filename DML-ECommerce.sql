/* insert Customer*/

INSERT INTO Customers (CustomerId, FullName, Email, Phone, Address)
VALUES (1, 'Mohamed Zidan', 'mohamed@gmail.com', '01007144974', 'Giza');

select * FROM Customers

/* insert Category*/

INSERT INTO Categories (CategoryId, CategoryName, Description)
VALUES (1, 'Clothes', 'Our Clothes are good, from the large companies');

select * FROM Categories

/* insert Products*/

INSERT INTO Products (ProductId,CategoryId, ProductName, Price, Description, StockQuantity)
VALUES (1,1, 'Shirts', 100, 'From Zara', 0);

UPDATE Products
Set StockQuantity = 2
WHERE StockQuantity = 0

select * FROM Products



/* insert Order*/

INSERT INTO Orders (OrderId ,CustomerId, TotalAmount, Status)
VALUES (1,1, 0, 'pending');

UPDATE Orders
Set [TotalAmount] = 50
-- WHERE Status = 'Pending'

select * FROM Orders


/* insert OrderDetails*/

INSERT INTO OrderDetails (OrderDetailId, OrderId ,ProductId, Quantity,UnitPrice)
VALUES (1, 1, 1, 2, 50);


select * FROM OrderDetails



/* insert Payments*/

INSERT INTO Payments (PaymentId, OrderId ,Amount , PaymentMethod,IsPaid)
VALUES (1, 1, 50, 'Card', 1);


select * FROM Payments


/* insert Shipping*/

INSERT INTO Shipping (ShippingId, OrderId ,ShippingAddress , DeliveryStatus)
VALUES (1, 1, 'Minia-BaniMazar', 'Pending');


select * FROM Shipping

