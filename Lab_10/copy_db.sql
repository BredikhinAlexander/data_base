USE Lab10
GO

--Копирование таблиц Customers, Orders, Order Details и Products из демонстрационной базы данных Northwind в пользовательскую базу данных

SELECT * INTO Customers FROM Northwind..Customers
DECLARE @count INT
SELECT @count = 10000
WHILE @count >= 0
  BEGIN
    INSERT INTO Customers SELECT * FROM Northwind..Customers
    SELECT @count = @count - 1
  END

SELECT * INTO Orders FROM Northwind..Orders
SELECT * INTO OrderDetails FROM Northwind.."Order Details"

SELECT * INTO Products FROM Northwind..Products
SELECT @count = 10000
WHILE @count >= 0
  BEGIN
    INSERT INTO Products (ProductName,SupplierID,CategoryID,QuantityPerUnit,
                                          UnitPrice,UnitsInStock,UnitsOnOrder,
                                                       ReorderLevel,Discontinued)
    SELECT ProductName,SupplierID,CategoryID,
             QuantityPerUnit,UnitPrice,UnitsInStock,
                UnitsOnOrder,ReorderLevel,Discontinued 
    FROM Northwind..Products
    SELECT @count = @count - 1
  END

/*
  DROP TABLE Customers
  DROP TABLE Products
  DROP TABLE OrderDetails
  DROP TABLE Orders
  */