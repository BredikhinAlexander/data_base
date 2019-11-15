/*3. ������� �������� ����������� ����������� (��������� � ������� �����), ��� �������, � ������� ��� ���������, 
	������� ����, ��� ��� �� ����������� ('PK' ��� ���������� ����� � 'F' ��� ��������) - ��� ���� ����������� ����������� */


Use Shipping
GO

SELECT  KEYS.[name] as [Constraint]
		,OBJ.[name] as [Table]
		,KEYS.[type] as [Flag]
FROM sys.objects KEYS 
JOIN sys.objects OBJ ON KEYS.[parent_object_id] = OBJ.[object_id]
WHERE OBJ.[type] = 'U' 
ORDER BY OBJ.[name]