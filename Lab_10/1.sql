USE Lab10
GO

-- ������� ����� ������� � ��������� � ��� �������������� ������ �������
SELECT * INTO Customers_without_index FROM Customers
SELECT * INTO Customers_with_clustered FROM Customers

GO

--�������� ��������
CREATE CLUSTERED INDEX Customer_clustered ON Customers_with_clustered(country, city, CustomerID);
CREATE NONCLUSTERED INDEX Customer_nonclustered ON Customers(country, city, CustomerID) INCLUDE (contactname, companyname, phone, fax);
GO

--����������
SET STATISTICS IO ON    --��������� ����������  �������� �� ���������� �����, ��������� � ����������� ����������
SET STATISTICS TIME ON  --���������� ����� � �������������, ����������� ��� ��������������� �������, ���������� � ���������� ������ ����������.


--��������� SQL-������ � ������� Customers � ������������ �� �������������� ��������� � ���������� ������ �����. 

--��� �������
SELECT contactname, companyname, phone, fax
FROM Customers_without_index
WHERE (Country = 'Germany')
AND (City BETWEEN 'A' AND 'K')
AND (CustomerID BETWEEN 'D' AND 'Y')


--� ���������������� �������
SELECT contactname, companyname, phone, fax
FROM Customers_with_clustered
WHERE (Country = 'Germany')
AND (City BETWEEN 'A' AND 'K')
AND (CustomerID BETWEEN 'D' AND 'Y')


--� ������������������ ��������
SELECT contactname, companyname, phone, fax
FROM Customers
WHERE (Country = 'Germany')
AND (City BETWEEN 'A' AND 'K')
AND (CustomerID BETWEEN 'D' AND 'Y')



SET STATISTICS IO OFF
SET STATISTICS TIME OFF


DROP INDEX Customer_clustered ON Customers_with_clustered
DROP INDEX Customer_nonclustered ON Customers

DROP TABLE Customers_without_index
DROP TABLE Customers_with_clustered