/*2. Выбрать имя таблицы, имя столбца таблицы, признак того, допускает ли данный столбец null-значения, 
	название типа данных столбца таблицы, размер этого типа данных - для всех таблиц */

Use Shipping
GO

SELECT  OBJ.[name] as [Table]
		,COLUM.[name] as [Column]
		,COLUM.[is_nullable] as 'ISNULLABLE'
		,TYP.name as [Type]
		,COLUM.max_length AS [Length]
FROM sys.objects OBJ 
JOIN sys.columns COLUM ON COLUM.[object_id] = OBJ.[object_id]
JOIN sys.types TYP ON COLUM.user_type_id = TYP.user_type_id 
JOIN sys.schemas SCH ON SCH.[schema_id] = OBJ.[schema_id]
WHERE OBJ.[type] = 'U' 
AND OBJ.[object_id] NOT IN 
	(SELECT prop.major_id FROM sys.extended_properties PROP 
	WHERE PROP.[class] = 1 AND PROP.[name] = N'microsoft_database_tools_support') 
ORDER BY OBJ.[name], COLUM.[name]