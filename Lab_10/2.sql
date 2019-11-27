USE Lab10
GO

--������� ����� ������� � ��������� � ��� �������������� ������ �������
SELECT * INTO Customers_without_index FROM Customers
SELECT * INTO Customers_with_clustered FROM Customers
SELECT * INTO Orders_without_index FROM Orders
SELECT * INTO Orders_with_clustered FROM Orders
GO

--�������� ��������
CREATE CLUSTERED INDEX Customer_clustered ON Customers_with_clustered (city, CustomerID)
CREATE CLUSTERED INDEX Orders_clustered ON Orders_with_clustered (shipcity, orderdate, CustomerID)
CREATE NONCLUSTERED INDEX Customer_nonclustered ON Customers(city, CustomerID) INCLUDE (companyname);
CREATE NONCLUSTERED INDEX Orders_nonclustered ON Orders(shipcity, orderdate, CustomerID) INCLUDE (freight);

--����������
SET STATISTICS IO ON    --��������� ����������  �������� �� ���������� �����, ��������� � ����������� ����������
SET STATISTICS TIME ON  --���������� ����� � �������������, ����������� ��� ��������������� �������, ���������� � ���������� ������ ����������.


--��������� SQL-������ � ��������� �������� Customers � Orders � ������������ �� ���������� ����� ���� ������.

--��� �������
SELECT C.companyname, O.orderdate, O.freight
FROM Customers_without_index C JOIN Orders_without_index O ON O.customerid = C.customerid
WHERE C.city = 'Strasbourg'
	AND O.ShipCity = 'Strasbourg'
	AND O.orderdate BETWEEN '1997-01-01' AND '1998-01-01'


--� ���������������� ��������
SELECT Cust.companyname, Ord.orderdate, Ord.freight
FROM Customers_with_clustered Cust JOIN Orders_with_clustered Ord ON Ord.customerid = Cust.customerid
WHERE Cust.city = 'Strasbourg'
	AND Ord.ShipCity = 'Strasbourg'
	AND Ord.orderdate BETWEEN '1997-01-01' AND '1998-01-01'


--� ������������������ ��������
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