USE Lab10
GO

--создаем новую таблицу и вставляем в нее результирующие строки запроса
SELECT * INTO Customers_without_index FROM Customers
SELECT * INTO Customers_with_clustered FROM Customers
SELECT * INTO Orders_without_index FROM Orders
SELECT * INTO Orders_with_clustered FROM Orders
GO

--создание индексов
CREATE CLUSTERED INDEX Customer_clustered ON Customers_with_clustered (city, CustomerID)
CREATE CLUSTERED INDEX Orders_clustered ON Orders_with_clustered (shipcity, orderdate, CustomerID)
CREATE NONCLUSTERED INDEX Customer_nonclustered ON Customers(city, CustomerID) INCLUDE (companyname);
CREATE NONCLUSTERED INDEX Orders_nonclustered ON Orders(shipcity, orderdate, CustomerID) INCLUDE (freight);

--Статистика
SET STATISTICS IO ON    --позволяет отображать  сведения об активности диска, связанной с выполнением инструкций
SET STATISTICS TIME ON  --Отображает время в миллисекундах, необходимое для синтаксического анализа, компиляции и выполнения каждой инструкции.


--Построить SQL-запрос к связанным таблицам Customers и Orders с фильтрациями по нескольким полям этих таблиц.

--БЕЗ ИНДЕКСА
SELECT C.companyname, O.orderdate, O.freight
FROM Customers_without_index C JOIN Orders_without_index O ON O.customerid = C.customerid
WHERE C.city = 'Strasbourg'
	AND O.ShipCity = 'Strasbourg'
	AND O.orderdate BETWEEN '1997-01-01' AND '1998-01-01'


--С КЛАСТЕРИЗОВАННЫМ ИНДЕКСОМ
SELECT Cust.companyname, Ord.orderdate, Ord.freight
FROM Customers_with_clustered Cust JOIN Orders_with_clustered Ord ON Ord.customerid = Cust.customerid
WHERE Cust.city = 'Strasbourg'
	AND Ord.ShipCity = 'Strasbourg'
	AND Ord.orderdate BETWEEN '1997-01-01' AND '1998-01-01'


--С НЕКЛАСТЕРИЗОВАННЫМ ИНДЕКСОМ
SELECT Customers.companyname, Orders.orderdate, Orders.freight
FROM Customers JOIN Orders ON Orders.customerid = Customers.customerid
WHERE Customers.city = 'Strasbourg'
	AND Orders.ShipCity = 'Strasbourg'
	AND Orders.orderdate BETWEEN '1997-01-01' AND '1998-01-01'


SET STATISTICS IO OFF
SET STATISTICS TIME OFF

DROP INDEX Customer_clustered ON Customers_with_clustered
DROP INDEX Orders_clustered ON Orders_with_clustered
DROP INDEX Customer_nonclustered ON Customers
DROP INDEX Orders_nonclustered ON Orders

DROP TABLE Customers_without_index
DROP TABLE Customers_with_clustered
DROP TABLE Orders_without_index
DROP TABLE Orders_with_clustered