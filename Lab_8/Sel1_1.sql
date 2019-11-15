--1. Выбрать имена всех таблиц, созданных назначенным пользователем базы данных

SELECT obj.[name] [Tables]
FROM sys.objects obj 
JOIN sys.schemas sch ON sch.[schema_id] = obj.[schema_id]
JOIN sys.database_principals [User] ON COALESCE(obj.[principal_id], sch.principal_id) = [User].principal_id
WHERE obj.[type] = 'U' AND obj.[object_id] NOT IN 
	(SELECT prop.major_id FROM sys.extended_properties prop 
	WHERE prop.class = 1 AND prop.name = N'microsoft_database_tools_support') 
	AND COALESCE(obj.[principal_id], sch.principal_id) IN (
			SELECT users.principal_id
			FROM sys.fn_dblog(NULL,NULL) dblog								--журнал транзакций
			JOIN sys.database_principals users ON dblog.[Transaction SID] = users.[sid])
	AND [User].[name] = 'dbo'



									