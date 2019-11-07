USE Shipping
GO


CREATE LOGIN TEST1
	WITH PASSWORD = 'aaa'
	--DEFAULT_DATABASE = Shipping

	ALTER LOGIN TEST1
	WITH DEFAULT_DATABASE = Shipping

	CREATE USER Test_name FOR LOGIN TEST1

	--�� ������� ���� ��� ����� ������� ������ ������������ ������������� ����� SELECT, INSERT, UPDATE � ������ ������
	GRANT SELECT, INSERT, UPDATE ON CAPTAIN to Test_name
	GO
	GRANT SELECT /*/,INSERT*/ ,UPDATE ON CITY to Test_name
	GO
	GRANT SELECT, INSERT ON TRIP to Test_name
	GRANT SELECT ON DELIVERY to Test_name

	--�� ������� ���� ��� ����� ������� ������ ������������ ������������� ����� SELECT � UPDATE ������ ��������� ��������.
	GRANT SELECT ON SHIP (Ship_id, Captain_ID, Name_ship, Ship_type_ID) TO Test_name
    GRANT UPDATE ON SHIP (Name_ship) TO Test_name

	--�� ������� ���� ��� ����� ������� ������ ������������ ������������� ������ ����� SELECT
	GRANT SELECT ON  VEHICLE_MANUFACTURER(Vehicle_manufacturer_ID, Name_manufacturer, Job_email, Type_manufacturer) TO Test_name
	GRANT SELECT ON COUNTRY TO Test_name

	--��������� ������ ������������ ����� ������� (SELECT) � �������������
	GRANT SELECT ON View_2 TO Test_name
	GRANT SELECT ON View_4 TO Test_name

	--������� ����������� ���� ������ ���� ������, ��������� �� ����� ������� 
	--(UPDATE �� ��������� �������) � �������������, ��������� ������ ������������ ��������� ����.
	CREATE ROLE ROLETEST

	GRANT SELECT, UPDATE ON View_0 ([Name_port]) TO ROLETEST
	ALTER ROLE ROLETEST
	ADD MEMBER Test_name

	--����������� � ��������� ����� ������ ��� ������ ������ ������������
	EXECUTE AS USER = 'Test_name';
	--��������� �� ����� ������ ������������ ��������� ������� �� ������ � �������������

		----------------------------------------------------------------------------------------------------------------------------------------
	-- ��� ���� ������� � ��������� ��������
	SELECT * FROM SHIP
    SELECT * FROM VEHICLE_MANUFACTURER

	--����� ������ �������
    SELECT City_ID, City FROM CITY

	--��� ������� � ���� [Vehicle_manufacturer_ID]
	UPDATE SHIP SET Name_ship = '����' 
	WHERE Vehicle_manufacturer_ID = 7

	--����� ���������
	UPDATE SHIP SET Name_ship = '����' 
	WHERE Ship_ID = 7

	--��� ���� �� INSERT
	INSERT INTO [CITY] ([Country_ID], [City]) 
	VALUES ( 26 , N'�����������' );

	--����� ������ �������
    SELECT * FROM CAPTAIN

	--����� ��������� ������
	INSERT CAPTAIN ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) 
	VALUES ( N'������', N'���������', 3 , CAST(N'1962-09-13' AS Date) , 2 )

	--����� ���������
	UPDATE CAPTAIN SET Last_name = '�������' WHERE Captain_ID = 2;

	-- ����� ������ ������� �� �������������
	SELECT * FROM View_2
	SELECT * FROM View_4

	--����� ��������� ������������ ������� � �������������
	UPDATE View_0
	SET [Name_port] = '���� ����_������'
	WHERE Name_port = '���� ����-������' 

	-- ��� ���� �� ���������� ��������� ��������
	UPDATE View_0
	SET port_category = '�� 1000'
		WHERE Name_port = '���� �����'

	--������� �������� ��������, ������� ��������� ������� � ����� '��������'

	SELECT Name_ship 
	FROM SHIP
	JOIN TRIP on TRIP.Ship_ID = SHIP.Ship_ID
	JOIN DELIVERY on DELIVERY.Delivery_ID = TRIP.Delivery_ID
	WHERE DELIVERY.Descreption = '��������'

	--������� ������, ������� ���������� ������ ���� 
	SELECT TOP(1) WITH TIES View_4.Country, View_4.Saldo as [earnings]
	FROM View_4
	WHERE View_4.Saldo IS NOT NULL
	ORDER BY View_4.Saldo DESC

	-----------------------------------------------------------------------------------------------------------------------------------------
	REVERT;
 
	DROP USER Test_name;
	DROP LOGIN TEST1;
	DROP ROLE ROLETEST;