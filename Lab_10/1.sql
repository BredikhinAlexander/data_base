USE Lab10
GO

-- создаем новую таблицу и вставляем в нее результирующие строки запроса
SELECT * INTO Customers_without_index FROM Customers
SELECT * INTO Customers_with_clustered FROM Customers

GO

--Создание индексов
CREATE CLUSTERED INDEX Customer_clustered ON Customers_with_clustered(country, city, CustomerID);
CREATE NONCLUSTERED INDEX Customer_nonclustered ON Customers(country, city, CustomerID) INCLUDE (contactname, companyname, phone, fax);
GO

--Статистика
SET STATISTICS IO ON    --позволяет отображать  сведения об активности диска, связанной с выполнением инструкций
SET STATISTICS TIME ON  --Отображает время в миллисекундах, необходимое для синтаксического анализа, компиляции и выполнения каждой инструкции.


--Построить SQL-запрос к таблице Customers с фильтрациями по идентификатору заказчика и нескольким другим полям. 

--БЕЗ ИНДЕКСА
SELECT contactname, companyname, phone, fax
FROM Customers_without_index
WHERE (Country = 'Germany')
AND (City BETWEEN 'A' AND 'K')
AND (CustomerID BETWEEN 'D' AND 'Y')


--С КЛАСТЕРИЗОВАННЫМ ИНДЕСОМ
SELECT contactname, companyname, phone, fax
FROM Customers_with_clustered
WHERE (Country = 'Germany')
AND (City BETWEEN 'A' AND 'K')
AND (CustomerID BETWEEN 'D' AND 'Y')


--С НЕКЛАСТЕРИЗОВАННЫМ ИНДЕКСОМ
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