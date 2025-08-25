-- 1- Simple Store Procedure

CREATE PROCEDURE GetProducts
AS
BEGIN
  SELECT * FROM Products
END;

EXEC GetProducts;

Go;
-- 2- retrieve product by id

CREATE PROCEDURE ShowProduct
         @ProductId INT
 AS
 BEGIN
     SELECT *  FROM Products P
     WHERE P.ProductId = @ProductId 
 END;

EXEC ShowProduct @ProductId = 1;
go;
-- 3- Add product

CREATE PROCEDURE AddNewProduct
    @Name NVARCHAR(100),
    @Price DECIMAL(10, 2),
    @Stock INT,
    @Category INT
AS
BEGIN
    INSERT INTO Products (ProductName, Price, StockQuantity,CategoryId)
    VALUES (@Name, @Price, @Stock,@Category);
END;
GO

EXEC AddNewProduct @Category=1, @Name='Smartphone', @Price=12000, @Stock=50;
DROP PROCEDURE AddNewProduct


