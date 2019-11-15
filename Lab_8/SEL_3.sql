/*3. Выбрать название ограничения целостности (первичные и внешние ключи), имя таблицы, в которой оно находится, 
	признак того, что это за ограничение ('PK' для первичного ключа и 'F' для внешнего) - для всех ограничений целостности */


Use Shipping
GO

SELECT  KEYS.[name] as [Constraint]
		,OBJ.[name] as [Table]
		,KEYS.[type] as [Flag]
FROM sys.objects KEYS 
JOIN sys.objects OBJ ON KEYS.[parent_object_id] = OBJ.[object_id]
WHERE OBJ.[type] = 'U' 
ORDER BY OBJ.[name]