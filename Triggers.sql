alter TRIGGER trg_CheckStockBeforeInsert
ON OrderDetails
AFTER INSERT
AS
BEGIN
    DECLARE @ProductId INT, @Quantity INT, @Stock INT;

    SELECT @ProductId = ProductId, @Quantity = Quantity
    FROM inserted;

    SELECT @Stock = StockQuantity
    FROM Products
    WHERE ProductId = @ProductId;

    IF @Quantity > @Stock
    BEGIN
        RAISERROR ('Not enough stock for this product.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;

GO

CREATE TRIGGER trg_CheckPaymentBeforeInsert
ON Payments
AFTER INSERT
AS
BEGIN
   SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Orders p ON i.OrderId = p.OrderId
        WHERE i.Amount != p.TotalAmount
    )
    BEGIN
        RAISERROR('Not enough stock for this product.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
