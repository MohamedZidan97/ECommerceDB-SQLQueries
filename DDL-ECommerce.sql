CREATE database ECommerce

/*Create Customer Table*/
CREATE TABLE Customers (
    CustomerId INT PRIMARY KEY,
    FullName NVARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    Phone VARCHAR(15) NOT NULL CHECK (Phone LIKE '[0-9]%'),
    Address NVARCHAR(50),
    CreatedAt DATE NOT NULL DEFAULT GETDATE()

);

/*Create Categories Table*/
CREATE TABLE Categories (
   CategoryId INT PRIMARY KEY,
   CategoryName NVARCHAR(20) Not NULL,
   Description NVARCHAR(50)
);


/*Create Products Table*/
CREATE TABLE Products (
    ProductId INT PRIMARY KEY,
    CategoryId INT NOT NULL,
    ProductName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL CHECK (Price >= 0),
    Description NVARCHAR(250),
    StockQuantity INT NOT NULL CHECK (StockQuantity >= 0),
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);



/*Create Orders Table*/
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY,
    CustomerId INT NOT NULL,
    OrderDate DATE NOT NULL DEFAULT GETDATE(),
    TotalAmount INT NOT NULL CHECK (TotalAmount >= 0),
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerId) REFERENCES Customers(CustomerId)
);

/*Create OrderDetails Table*/
CREATE TABLE OrderDetails (
    OrderDetailId INT PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10, 2) NOT NULL CHECK (UnitPrice >= 0),
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductId) REFERENCES Products(ProductId),
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);


/*Create Payments Table*/
CREATE TABLE Payments (
    PaymentId INT PRIMARY KEY,
    OrderId INT NOT NULL,
    PaymentDate DATE NOT NULL DEFAULT GETDATE(),
    Amount INT NOT NULL CHECK (Amount >= 0),
    PaymentMethod VARCHAR(20) NOT NULL CHECK (PaymentMethod IN ('Cash', 'Card', 'BankTransfer')),
    IsPaid BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);




/*Create Shipping Table*/
CREATE TABLE Shipping (
    ShippingId INT PRIMARY KEY,
    OrderId INT NOT NULL,
    ShippingDate DATE NOT NULL DEFAULT GETDATE(),
    ShippingAddress NVARCHAR(100) NOT NULL,
    DeliveryStatus VARCHAR(20) NOT NULL CHECK (DeliveryStatus IN ('Pending', 'Shipped', 'Delivered', 'Returned')),
    CONSTRAINT FK_Shipping_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)
);




/*Drop*/
DROP TABLE Payments;
DROP DATABASE ECommerce


/*Alter*/
-- إضافة عمود جديد في جدول Customers
ALTER TABLE Customers
ADD DateOfBirth DATE;

-- تعديل نوع البيانات في عمود Price في جدول Products
ALTER TABLE Products
ALTER COLUMN Price DECIMAL(12, 2);

-- حذف عمود من جدول Orders
ALTER TABLE Orders
DROP COLUMN Status;

/*Truncate*/

-- مسح كل البيانات من جدول Orders بدون حذف الجدول
TRUNCATE TABLE Orders;

-- مسح بيانات جدول Products
TRUNCATE TABLE Products;

