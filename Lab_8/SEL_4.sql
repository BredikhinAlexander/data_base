/*4. Выбрать название внешнего ключа, имя таблицы, содержащей внешний ключ, имя таблицы, 
	содержащей его родительский ключ - для всех внешних ключей*/

Use Shipping
GO


SELECT  KEYS.[name] as [Foreign_Key]
		,TO_TABLE.[name] as [referenced table]
		,FROM_TABLE.[name] as [referencing table]
FROM sys.objects KEYS 
JOIN sys.sysreferences REF ON KEYS.[object_id] = REF.constid --Идентификатор ограничения FOREIGN KEY
JOIN sys.objects TO_TABLE ON TO_TABLE.[object_id] = REF.rkeyid --Идентификатор ссылаемой таблицы.
JOIN sys.objects FROM_TABLE ON FROM_TABLE.[object_id] = REF.[fkeyid] --Идентификатор ссылающейся таблицы.

WHERE FROM_TABLE.[type] = 'U' AND KEYS.[type] = 'F' 
ORDER BY FROM_TABLE.[name]