/*6. Выбрать название триггера, имя таблицы, для которой определен триггер - 
	для всех триггеров, созданных назначенным пользователем базы данных */

SELECT  TR.[name] as [Trigger_Name]
		,TABL.[name] as [Table_Name]
FROM sys.objects TABL 
JOIN sys.objects TR ON TR.parent_object_id = TABL.[object_id] 
JOIN sys.schemas sch ON sch.[schema_id] = TR.[schema_id]
WHERE TR.[type] = 'TR' 




