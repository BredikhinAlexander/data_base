USE Lab10
GO
--создаем новую таблицу и вставляем в нее результирующие строки запроса
SELECT * INTO Customers_without_index FROM Customers
SELECT * INTO Customers_with_clustered FROM Customers
SELECT * INTO Orders_without_index FROM Orders
SELECT * INTO Orders_with_clustered FROM Orders
SELECT * INTO Products_without_index FROM Products
SELECT * INTO Products_with_clustered FROM Products
SELECT * INTO OrderDetails_without_index FROM OrderDetails
SELECT * INTO OrderDetails_with_clustered FROM OrderDetails
GO

--создание индексов
CREATE CLUSTERED INDEX Customers_cl ON Customers_with_clustered(City, CustomerID)
CREATE CLUSTERED INDEX Orders_cl ON Orders_with_clustered(EmployeeID,  OrderID ,CustomerID)
CREATE CLUSTERED INDEX OrderDetails_cl ON OrderDetails_with_clustered (Discount, OrderID, ProductID)
CREATE CLUSTERED INDEX Products_cl ON Products_with_clustered (UnitsInStock, ProductID)

CREATE NONCLUSTERED INDEX Customers_noncl ON Customers(City, CustomerID)
CREATE NONCLUSTERED INDEX Orders_noncl ON Orders(EmployeeID, CustomerID, OrderID)
CREATE NONCLUSTERED INDEX OrderDetails_noncl ON OrderDetails(Discount, OrderID, ProductID)
CREATE NONCLUSTERED INDEX Products_noncl ON Products(UnitsInStock, ProductID) INCLUDE (ProductName)
GO

--Статистика
SET STATISTICS IO ON
SET STATISTICS TIME ON
GO

--Построить SQL-запрос ко всем 4-м связанным таблицам Customers, Orders, OrderDetails и Products
--с фильтрациями по нескольким полям этих таблиц.

--БЕЗ ИНДЕКСА
SELECT Cust.CustomerID, Ord.EmployeeID, Cust.City, Prod.ProductName, Prod.UnitsInStock, OrdDet.Discount
	FROM Customers_without_index Cust
		JOIN Orders_without_index Ord ON Cust.CustomerID = Ord.CustomerID
		JOIN OrderDetails_without_index OrdDet ON Ord.OrderID = OrdDet.OrderID
		JOIN Products_without_index Prod ON OrdDet.ProductID = Prod.ProductID
	WHERE
		Ord.EmployeeID = 7 AND
		Cust.City = 'Buenos Aires' AND
		OrdDet.Discount = 0 AND
		Prod.UnitsInStock < 30

---С КЛАСТЕРИЗОВАННЫМ ИНДЕСОМ
SELECT Cust.CustomerID, Ord.EmployeeID, Cust.City, Prod.ProductName, Prod.UnitsInStock, OrdDet.Discount
	FROM Customers_with_clustered Cust
		JOIN Orders_with_clustered Ord ON Cust.CustomerID = Ord.CustomerID
		JOIN OrderDetails_with_clustered OrdDet ON Ord.OrderID = OrdDet.OrderID
		JOIN Products_with_clustered Prod ON OrdDet.ProductID = Prod.ProductID
	WHERE
		Ord.EmployeeID = 7 AND
		Cust.City = 'Buenos Aires' AND
		OrdDet.Discount = 0 AND
		Prod.UnitsInStock < 30


--С НЕКЛАСТЕРИЗОВАННЫМ ИНДЕКСОМ
SELECT Customers.CustomerID, Orders.EmployeeID, Customers.City, Products.ProductName, Products.UnitsInStock, OrderDetails.Discount
	FROM Customers 
		JOIN Orders ON Customers.CustomerID = Orders.CustomerID
		JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
		JOIN Products ON OrderDetails.ProductID = Products.ProductID
	WHERE
		Orders.EmployeeID = 7 AND
		Customers.City = 'Buenos Aires' AND
		OrderDetails.Discount = 0 AND
		Products.UnitsInStock < 30

SET STATISTICS IO OFF
SET STATISTICS TIME OFF

DROP INDEX Customers_cl ON Customers_with_clustered
DROP INDEX Orders_cl ON Orders_with_clustered
DROP INDEX Products_cl ON Products_with_clustered
DROP INDEX OrderDetails_cl ON OrderDetails_with_clustered
DROP INDEX Customers_noncl ON Customers
DROP INDEX Orders_noncl ON Orders
DROP INDEX Products_noncl ON Products
DROP INDEX OrderDetails_noncl ON OrderDetails


DROP TABLE Customers_without_index
DROP TABLE Customers_with_clustered
DROP TABLE Orders_without_index
DROP TABLE Orders_with_clustered
DROP TABLE Products_with_clustered
DROP TABLE Products_without_index
DROP TABLE OrderDetails_with_clustered
DROP TABLE OrderDetails_without_index