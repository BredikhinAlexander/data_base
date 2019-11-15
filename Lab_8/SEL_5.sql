/*5. Выбрать название представления, SQL-запрос, создающий это представление - 
	для всех представлений, созданных назначенным пользователем базы данных */

Use Shipping
GO

SELECT  OBJ.[name] as [Name]
		,MODEL.[definition] as [SQL-request]
FROM sys.objects OBJ 
JOIN sys.sql_modules MODEL ON OBJ.[object_id] = MODEL.[object_id]
JOIN sys.schemas SCH ON SCH.[schema_id] = OBJ.[schema_id]
WHERE OBJ.[type] = 'V' 

