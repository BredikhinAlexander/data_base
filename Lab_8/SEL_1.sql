Use Shipping
GO

--1. Выбрать имена всех таблиц, созданных назначенным пользователем базы данных


SELECT [Tables], USER_NAME([user]) as [user]
FROM 
(SELECT  OBJ.[name] as [Tables] 
		--, USER_NAME(OBJ.principal_id)
		, ISNULL(OBJ.principal_id, 1) as [user]
FROM sys.objects OBJ 
JOIN sys.schemas sch ON sch.[schema_id] = obj.[schema_id]
WHERE OBJ.[type] = 'U' 
AND OBJ.[object_id] NOT IN 
	(SELECT PROP.major_id FROM sys.extended_properties PROP 
	WHERE PROP.[class] = 1 AND PROP.[name] = N'microsoft_database_tools_support') ) as S1

	--AND OBJ.[name] <> 'sysdiagrams'

SELECT * FROM sys.database_principals

--SELECT * FROM sys.sysusers




