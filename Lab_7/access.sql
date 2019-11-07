USE Shipping
GO


CREATE LOGIN TEST1
	WITH PASSWORD = 'aaa'
	--DEFAULT_DATABASE = Shipping

	ALTER LOGIN TEST1
	WITH DEFAULT_DATABASE = Shipping

	CREATE USER Test_name FOR LOGIN TEST1

	--по крайней мере дл€ одной таблицы новому пользователю присваиваютс€ права SELECT, INSERT, UPDATE в полном объеме
	GRANT SELECT, INSERT, UPDATE ON CAPTAIN to Test_name
	GO
	GRANT SELECT /*/,INSERT*/ ,UPDATE ON CITY to Test_name
	GO
	GRANT SELECT, INSERT ON TRIP to Test_name
	GRANT SELECT ON DELIVERY to Test_name

	--по крайней мере дл€ одной таблицы новому пользователю присваиваютс€ права SELECT и UPDATE только избранных столбцов.
	GRANT SELECT ON SHIP (Ship_id, Captain_ID, Name_ship, Ship_type_ID) TO Test_name
    GRANT UPDATE ON SHIP (Name_ship) TO Test_name

	--по крайней мере дл€ одной таблицы новому пользователю присваиваетс€ только право SELECT
	GRANT SELECT ON  VEHICLE_MANUFACTURER(Vehicle_manufacturer_ID, Name_manufacturer, Job_email, Type_manufacturer) TO Test_name
	GRANT SELECT ON COUNTRY TO Test_name

	--присвоить новому пользователю право доступа (SELECT) к представлению
	GRANT SELECT ON View_2 TO Test_name
	GRANT SELECT ON View_4 TO Test_name

	--создать стандартную роль уровн€ базы данных, присвоить ей право доступа 
	--(UPDATE на некоторые столбцы) к представлению, назначить новому пользователю созданную роль.
	CREATE ROLE ROLETEST

	GRANT SELECT, UPDATE ON View_0 ([Name_port]) TO ROLETEST
	ALTER ROLE ROLETEST
	ADD MEMBER Test_name

	--соединитьс€ с локальной базой данных под именем нового пользовател€
	EXECUTE AS USER = 'Test_name';
	--выполнить от имени нового пользовател€ некоторые выборки из таблиц и представлени€

		----------------------------------------------------------------------------------------------------------------------------------------
	-- нет прав доступа к некоторым столбцам
	SELECT * FROM SHIP
    SELECT * FROM VEHICLE_MANUFACTURER

	--может делать выборки
    SELECT City_ID, City FROM CITY

	--нет доступа к полю [Vehicle_manufacturer_ID]
	UPDATE SHIP SET Name_ship = 'ѕул€' 
	WHERE Vehicle_manufacturer_ID = 7

	--может обновл€ть
	UPDATE SHIP SET Name_ship = 'ѕул€' 
	WHERE Ship_ID = 7

	--нет прав на INSERT
	INSERT INTO [CITY] ([Country_ID], [City]) 
	VALUES ( 26 , N'ёжноуральск' );

	--может делать выборки
    SELECT * FROM CAPTAIN

	--может вставл€ть данные
	INSERT CAPTAIN ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) 
	VALUES ( N' лимов', N'¬ладислав', 3 , CAST(N'1962-09-13' AS Date) , 2 )

	--может обновл€ть
	UPDATE CAPTAIN SET Last_name = '‘илипов' WHERE Captain_ID = 2;

	-- может делать выборки из представлени€
	SELECT * FROM View_2
	SELECT * FROM View_4

	--может обновл€ть определенные столбцы в представлении
	UPDATE View_0
	SET [Name_port] = 'ѕорт ѕорт_ ланга'
	WHERE Name_port = 'ѕорт ѕорт- ланга' 

	-- нет прав на обновление некоторых столбцов
	UPDATE View_0
	SET port_category = 'до 1000'
		WHERE Name_port = 'ѕорт Ќинбо'

	--¬ыбрать названи€ кораблей, которые совершали поездки с целью 'выгрузка'

	SELECT Name_ship 
	FROM SHIP
	JOIN TRIP on TRIP.Ship_ID = SHIP.Ship_ID
	JOIN DELIVERY on DELIVERY.Delivery_ID = TRIP.Delivery_ID
	WHERE DELIVERY.Descreption = 'выгрузка'

	--вывести страны, которые заработали больше всех 
	SELECT TOP(1) WITH TIES View_4.Country, View_4.Saldo as [earnings]
	FROM View_4
	WHERE View_4.Saldo IS NOT NULL
	ORDER BY View_4.Saldo DESC

	-----------------------------------------------------------------------------------------------------------------------------------------
	REVERT;
 
	DROP USER Test_name;
	DROP LOGIN TEST1;
	DROP ROLE ROLETEST;