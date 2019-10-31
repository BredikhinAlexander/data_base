USE Shipping
GO

-- Удаление связей --

ALTER TABLE OPERATION
DROP CONSTRAINT OPERATION_INVOICE_CARGO

ALTER TABLE OPERATION
DROP CONSTRAINT OPERATION_TRIP

ALTER TABLE INVOICE_CARGO 
DROP CONSTRAINT CARGO_CARGO_TYPE
GO
ALTER TABLE TRIP 
DROP CONSTRAINT TRIP_DELIVERY
GO
ALTER TABLE TRIP 
DROP CONSTRAINT TRIP_SHIP
GO
ALTER TABLE TRIP 
DROP CONSTRAINT TRIP_ITINERARY
GO
ALTER TABLE ITINERARY 
DROP CONSTRAINT ITINERARY_BERTH_to
GO
ALTER TABLE ITINERARY 
DROP CONSTRAINT ITINERARY_BERTH_from
GO
ALTER TABLE BERTH 
DROP CONSTRAINT BERTH_PORT
GO
ALTER TABLE PORT 
DROP CONSTRAINT PORT_CITY
GO
ALTER TABLE CITY 
DROP CONSTRAINT CITY_COUNTRY
GO
ALTER TABLE BERTH 
DROP CONSTRAINT BERTH_BERTH_TYPE
GO
ALTER TABLE VEHICLE_MANUFACTURER 
DROP CONSTRAINT VEHICLE_MANUFACTURER_CITY
GO
ALTER TABLE VEHICLE_MANUFACTURER 
DROP CONSTRAINT VEHICLE_MANUFACTURER_TYPE_MANUFACTURER
GO
ALTER TABLE VEHICLE_MANUFACTURER 
DROP CONSTRAINT VEHICLE_MANUFACTURER_LICENCE
GO
ALTER TABLE SHIP 
DROP CONSTRAINT SHIP_CAPTAIN
GO
ALTER TABLE SHIP 
DROP CONSTRAINT SHIP_VEHICLE_MANUFACTURER
GO
ALTER TABLE SHIP 
DROP CONSTRAINT SHIP_SHIP_TYPE
GO
ALTER TABLE CAPTAIN
DROP CONSTRAINT GENDER_CAPTAIN
GO
ALTER TABLE PRICE
DROP CONSTRAINT PRICE_BERTH_TYPE
GO
ALTER TABLE PRICE
DROP CONSTRAINT PRICE_SHIP_TYPE
GO

-- Удаление таблиц --

DROP TABLE IF EXISTS [STOP_x_CARGO]

GO
DROP TABLE IF EXISTS [CARGO_STATUS]

GO
DROP TABLE IF EXISTS [STOP_LIST]

GO
DROP TABLE IF EXISTS [INVOICE_CARGO]

GO
DROP TABLE IF EXISTS [CARGO_TYPE]

GO
DROP TABLE IF EXISTS [DELIVERY]

GO
DROP TABLE IF EXISTS [TRIP]

GO
DROP TABLE IF EXISTS [SHIP]

GO
DROP TABLE IF EXISTS [ITINERARY]

GO
DROP TABLE IF EXISTS [SHIP_TYPE]

GO
DROP TABLE IF EXISTS [CAPTAIN]

GO
DROP TABLE IF EXISTS [BERTH]

GO
DROP TABLE IF EXISTS [CITY]

GO
DROP TABLE IF EXISTS [COUNTRY]

GO
DROP TABLE IF EXISTS [BERTH_TYPE]

GO
DROP TABLE IF EXISTS [TYPE_MANUFACTURER]

GO
DROP TABLE IF EXISTS [LICENCE]

GO
DROP TABLE IF EXISTS [VEHICLE_MANUFACTURER]

GO
DROP TABLE IF EXISTS [PORT]

GO
 DROP TABLE IF EXISTS [GENDER]

GO
DROP TABLE IF EXISTS [PRICE]

GO
DROP TABLE IF EXISTS [OPERATION]

GO



-- Создание таблиц --

CREATE TABLE OPERATION (
   Operation_ID int  NOT NULL IDENTITY(1,1),
   Trip_ID int  NOT NULL,
   Cargo_ID int  NOT NULL,
   CONSTRAINT OPERATION_pk PRIMARY KEY  (Trip_ID,Cargo_ID)
)



GO

CREATE TABLE INVOICE_CARGO (
   Cargo_ID int  NOT NULL,
   Cargo_Type_ID int ,
   Descreption nvarchar(1000)  NOT NULL,
   Tonnage int NOT NULL,
   Size int,
   Basic_charact_of_units nvarchar(10)  NOT NULL,
   CONSTRAINT INVOICE_CARGO_pk PRIMARY KEY  (Cargo_ID)
)


ALTER TABLE INVOICE_CARGO ALTER COLUMN Tonnage bigint
ALTER TABLE INVOICE_CARGO ALTER COLUMN Size bigint

GO


CREATE TABLE CARGO_TYPE (
   Cargo_Type_ID int  NOT NULL,
   Cargo_type nvarchar(100) ,
   CONSTRAINT CARGO_TYPE_pk PRIMARY KEY  (Cargo_Type_ID)
)

GO

CREATE TABLE DELIVERY (
   Delivery_ID int  NOT NULL,
   Descreption nvarchar(1000)  NOT NULL,
   CONSTRAINT DELIVERY_pk PRIMARY KEY  (Delivery_ID)
)

GO

CREATE TABLE TRIP (
   Trip_ID int  NOT NULL IDENTITY(1,1),
   Ship_ID int  NOT NULL,
   Date_departure datetime  NOT NULL,
   Date_arrival datetime  NOT NULL,
   Itinerary_ID int  NOT NULL,
   Delivery_ID int  NOT NULL,
   Distance int,
   CONSTRAINT TRIP_pk PRIMARY KEY  (Trip_ID)
)

GO

CREATE TABLE SHIP (
   Ship_ID int  NOT NULL IDENTITY(1,1),
   Name_ship nvarchar(50) NOT NULL,
   Ship_type_ID int  NOT NULL,
   Vehicle_manufacturer_ID int,
   Captain_ID int,
   Home_berth_ID int,
   Last_repair date,
   CONSTRAINT SHIP_pk PRIMARY KEY  (Ship_ID)
)

GO

CREATE TABLE ITINERARY (
   Itinerary_ID int  NOT NULL,
   Berth_to_ID int  NOT NULL,
   Berth_from_ID int  NOT NULL,
   CONSTRAINT ITINERARY_pk PRIMARY KEY  (Itinerary_ID)
)

GO

CREATE TABLE SHIP_TYPE (
   Ship_type_ID int  NOT NULL,
   Name_ship nvarchar(50)  NOT NULL,
   Speed_avg int  NOT NULL,
   Tonnage int  NOT NULL,
   CONSTRAINT SHIP_TYPE_pk PRIMARY KEY  (Ship_type_ID)
)

GO

CREATE TABLE CAPTAIN (
   Captain_ID int IDENTITY(1,1) NOT NULL,
   First_name nvarchar(50)  NOT NULL,
   Last_name nvarchar(50)  NOT NULL,
   Gender_ID int  NOT NULL,
   Date_birth date  NOT NULL,
   Qualification_ID int  NOT NULL,
   CONSTRAINT CAPTAIN_pk PRIMARY KEY  (Captain_ID)
)

GO

CREATE TABLE BERTH (
   Berth_ID int  NOT NULL IDENTITY(1,1),
   Berth_type_ID int  NOT NULL,
   Port_ID int  NOT NULL,
   CONSTRAINT BERTH_pk PRIMARY KEY  (Berth_ID)
)

GO

CREATE TABLE CITY (
   City_ID int  NOT NULL IDENTITY(1,1),
   City nvarchar(50)  NOT NULL,
   Country_ID int  NOT NULL,
   CONSTRAINT CITY_pk PRIMARY KEY  (City_ID)
)

GO

CREATE TABLE COUNTRY (
   Country_ID int  NOT NULL IDENTITY(1,1),
   Country nvarchar(50)  NOT NULL,
   CONSTRAINT COUNTRY_pk PRIMARY KEY  (Country_ID)
)

GO

CREATE TABLE BERTH_TYPE (
   Berth_type_ID int  NOT NULL IDENTITY(1,1),
   Category nvarchar(100),
   Max_tonnage int  NOT NULL,
   CONSTRAINT BERTH_TYPE_pk PRIMARY KEY  (Berth_type_ID)
)

GO

CREATE TABLE TYPE_MANUFACTURER (
   Type_manufacturer int  NOT NULL IDENTITY(1,1),
   Description nvarchar(100)  NOT NULL,
   CONSTRAINT TYPE_MANUFACTURER_pk PRIMARY KEY  (Type_manufacturer)
)

GO

CREATE TABLE LICENCE (
   Licence_ID int  NOT NULL IDENTITY(1,1),
   Licence_type nvarchar(50)  NOT NULL,
   Date_start datetime  NOT NULL,
   Date_end datetime  NOT NULL,
   CONSTRAINT LICENCE_pk PRIMARY KEY  (Licence_ID)
)

GO

CREATE TABLE VEHICLE_MANUFACTURER (
   Vehicle_manufacturer_ID int  NOT NULL IDENTITY(1,1),
   Name_manufacturer nvarchar(50)  NOT NULL,
   Job_email varchar(25),
   Type_manufacturer int,
   City_ID int  NOT NULL,
   License_ID int ,
   CONSTRAINT VEHICLE_MANUFACTURER_pk PRIMARY KEY  (Vehicle_manufacturer_ID)
)

GO

CREATE TABLE [PORT] (
   Port_ID int  NOT NULL IDENTITY(1,1),
   Name_port nvarchar(50),
   City_ID int  NOT NULL,
   CONSTRAINT PORT_pk PRIMARY KEY  (Port_ID)
)
GO

 CREATE TABLE GENDER(
   Gender_ID int NOT NULL,
   Descreption char(1) NOT NULL,
   CONSTRAINT GENDER_pk PRIMARY KEY (Gender_ID)
)

GO

CREATE TABLE PRICE (
   Berth_type_ID int  NOT NULL,
   Ship_type_ID int  NOT NULL,
   Price_of_one_day int  NOT NULL,
   CONSTRAINT PRICE_pk PRIMARY KEY  (Berth_type_ID,Ship_type_ID)
)

GO


-- Создание связей --


ALTER TABLE OPERATION ADD CONSTRAINT OPERATION_INVOICE_CARGO
   FOREIGN KEY (Cargo_ID)
   REFERENCES INVOICE_CARGO (Cargo_ID)

GO

ALTER TABLE OPERATION ADD CONSTRAINT OPERATION_TRIP
   FOREIGN KEY (Trip_ID)
   REFERENCES TRIP (Trip_ID)

GO

ALTER TABLE INVOICE_CARGO ADD CONSTRAINT CARGO_CARGO_TYPE
   FOREIGN KEY (Cargo_Type_ID)
   REFERENCES CARGO_TYPE (Cargo_Type_ID)
ON UPDATE CASCADE

GO


ALTER TABLE TRIP ADD CONSTRAINT TRIP_DELIVERY
   FOREIGN KEY (Delivery_ID)
   REFERENCES DELIVERY (Delivery_ID)
ON UPDATE CASCADE


GO

ALTER TABLE TRIP ADD CONSTRAINT TRIP_SHIP
   FOREIGN KEY (Ship_ID)
   REFERENCES SHIP (Ship_ID)
ON UPDATE CASCADE

GO

ALTER TABLE TRIP ADD CONSTRAINT TRIP_ITINERARY
   FOREIGN KEY (Itinerary_ID)
   REFERENCES ITINERARY (Itinerary_ID)
ON UPDATE CASCADE

GO

ALTER TABLE ITINERARY ADD CONSTRAINT ITINERARY_BERTH_to
	FOREIGN KEY(Berth_to_ID)
	REFERENCES BERTH (Berth_ID)

GO

ALTER TABLE ITINERARY ADD CONSTRAINT ITINERARY_BERTH_from
	FOREIGN KEY(Berth_from_ID)
	REFERENCES BERTH (Berth_ID)
ON UPDATE CASCADE	
GO

ALTER TABLE BERTH ADD CONSTRAINT BERTH_PORT
   FOREIGN KEY (Port_ID)
   REFERENCES PORT (Port_ID)
ON UPDATE CASCADE

GO

ALTER TABLE [PORT] ADD CONSTRAINT PORT_CITY
   FOREIGN KEY (City_ID)
   REFERENCES CITY (City_ID)

GO

ALTER TABLE CITY ADD CONSTRAINT CITY_COUNTRY
   FOREIGN KEY (Country_ID)
   REFERENCES COUNTRY (Country_ID)

GO

ALTER TABLE BERTH ADD CONSTRAINT BERTH_BERTH_TYPE
   FOREIGN KEY (Berth_type_ID)
   REFERENCES BERTH_TYPE (Berth_type_ID)
ON UPDATE CASCADE

GO

ALTER TABLE VEHICLE_MANUFACTURER ADD CONSTRAINT VEHICLE_MANUFACTURER_CITY
   FOREIGN KEY (City_ID)
   REFERENCES CITY (City_ID)
ON UPDATE CASCADE

GO

ALTER TABLE VEHICLE_MANUFACTURER ADD CONSTRAINT VEHICLE_MANUFACTURER_TYPE_MANUFACTURER
   FOREIGN KEY (Type_manufacturer)
   REFERENCES TYPE_MANUFACTURER (Type_manufacturer)

GO

ALTER TABLE VEHICLE_MANUFACTURER ADD CONSTRAINT VEHICLE_MANUFACTURER_LICENCE
   FOREIGN KEY (License_ID)
   REFERENCES LICENCE (Licence_ID)

GO

ALTER TABLE SHIP ADD CONSTRAINT SHIP_CAPTAIN
   FOREIGN KEY (Captain_ID)
   REFERENCES CAPTAIN (Captain_ID)
   ON DELETE CASCADE

GO

ALTER TABLE SHIP ADD CONSTRAINT SHIP_VEHICLE_MANUFACTURER
   FOREIGN KEY (Vehicle_manufacturer_ID)
   REFERENCES VEHICLE_MANUFACTURER (Vehicle_manufacturer_ID)

GO

ALTER TABLE SHIP ADD CONSTRAINT SHIP_SHIP_TYPE
   FOREIGN KEY (Ship_type_ID)
   REFERENCES SHIP_TYPE (Ship_type_ID)
ON UPDATE CASCADE

GO

ALTER TABLE CAPTAIN ADD CONSTRAINT GENDER_CAPTAIN
   FOREIGN KEY (Gender_ID)
   REFERENCES GENDER (Gender_ID)

GO

ALTER TABLE PRICE ADD CONSTRAINT PRICE_BERTH_TYPE
   FOREIGN KEY (Berth_type_ID)
   REFERENCES BERTH_TYPE (Berth_type_ID);

GO

ALTER TABLE PRICE ADD CONSTRAINT PRICE_SHIP_TYPE
   FOREIGN KEY (Ship_type_ID)
   REFERENCES SHIP_TYPE (Ship_type_ID);

GO







-- COUNTRY --

INSERT INTO [COUNTRY] ([Country]) VALUES ( N'КНР');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Сингапур');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Нидерланды');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Австралия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Республика Корея');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'США');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Япония');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Малайзия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Бельгия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'ОАЭ');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Германия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Бразилия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Канада');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Китайская Республика');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Вьетнам');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'ЮАР');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Испания');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Франция');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Россия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Иран');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Индия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Таиланд');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Великобритания');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Индия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Турция');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Саудовская Аравия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'ЮАР');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Индонезия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Италия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Румыния');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Шри-Ланка');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Норвегия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Италия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Индонезия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Египет');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Филиппины');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Бангладеш');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Франция');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Великобритания');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Бельгия');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Вьетнам');
INSERT INTO [COUNTRY] ([Country]) VALUES ( N'Китайская Республика');

-- CITY --

INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 1 , N'Шанхай' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 2 , N'Сингапур' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 1 , N'Тяньцзинь' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 1 , N'Гуанчжоу' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 1 , N'Циндао' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 3 , N'Роттердам' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 1 , N'Нинбо' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 4 , N'Хедленд' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 1 , N'Далянь' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 5 , N'Пусан' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 1 , N'Гонконг' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 1 , N'Циньхуандао' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 6 , N'Южная Луизиана' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 7 , N'Нагоя' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 6 , N'Хьюстон' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 1 , N'Шэньчжэнь' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 8 , N'Кланг' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 9 , N'Антверпен' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 4 , N'Дампир' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 1 , N'Сямынь' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 5 , N'Ульсан' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 10 ,N'Дубай' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 4 , N'Ньюкасл' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 7 , N'Тиба' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 11 ,N'Гамбург' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 12 ,N'Итаки' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 13 ,N'Метро-Ванкувер' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 12 ,N'Тубаран' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 5 , N'Кванъян' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 8 , N'Танджунг-Пелепас' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 7 , N'Иокогама' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 14 ,N'Гаосюн' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 5 , N'Инчхон' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 6 , N'Нью-Йорк' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 12 ,N'Сантус' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 4 , N'Хей-Пойнт' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 1 , N'Яньтянь' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 12 ,N'Сепетиба' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 7 , N'Китакюсю' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 4 , N'Гладстона' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 3 , N'Амстердам' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 15 , N'Сайгон' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 16 , N'Ричардс-Бей' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 7 , N'Кобе' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 7 , N'Осаки' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 7 , N'Токио' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 6 ,  N'Бомонта' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 17 , N'Альхесираса' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 11 , N'Бремена' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 6 ,  N'Лонг-Бич' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 18 , N'Марсель' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 19 , N'Новороссийск' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 20 , N'Бендер-Аббаса' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 6 ,  N'Хэмптон-Роудс' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 14 , N'Тайчжун' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 6 ,  N'Новый Орлеан' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 21 , N'Парадип' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 18 , N'Гавр' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 22 , N'Лемчабанг' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 17 , N'Валенсия' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 19 , N'Приморск' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 23 , N'Гримсби' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 24 , N'Нава-Шева' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 25 , N'Измит' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 26 , N'Джидда' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 27 , N'Салданья-Бей' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 5 ,  N'Дэсан' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 21 , N'Бомбеи' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 28 , N'Танджунг-Приок' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 19 , N'Санкт-Петербург' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 6 ,  N'Батон-Ружа' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 29 , N'Триеста' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 26 , N'Эль-Джубайль' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 25 , N'Боташ' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 30 , N'Констанцы' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 31 , N'Коломбо' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 12 , N'Сан-Себастьян' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 6 ,  N'Лос-Анджелес' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 6 ,  N'Плакеминз' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 6 ,  N'Лейк-Чарльз' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 21 , N'Мадрас' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 5 ,  N'Пхохан' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 32 , N'Берген' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 33 , N'Генуя' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 6 ,  N'Мобила' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 34 , N'Котабару' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 35 , N'Александрия' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 16 , N'Дурбан' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 37 , N'Манила' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 6 ,  N'Техас-Сити' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 38 , N'Читтагонг' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 12 , N'Паранагуа' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 39 , N'Дюнкерк' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 40 , N'Лондон' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 26 , N'Янбу' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 41 , N'Зебрюгг' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 17 , N'Барселона' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 21 , N'Калькутта' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 23 , N'Милфорд-Хейвен' );
INSERT INTO [CITY] ([Country_ID], [City]) VALUES ( 25 , N'Алиаги' );


-- LICENSE --
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Международная', CAST(N'2008-01-01' AS Date), CAST(N'2018-12-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Международная', CAST(N'2009-01-01' AS Date), CAST(N'2018-12-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Международная', CAST(N'2010-01-01' AS Date), CAST(N'2019-12-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Международная', CAST(N'2011-01-01' AS Date), CAST(N'2019-12-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Международная', CAST(N'2012-01-01' AS Date), CAST(N'2020-12-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Международная', CAST(N'2013-01-01' AS Date), CAST(N'2021-12-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Международная', CAST(N'2014-01-01' AS Date), CAST(N'2022-12-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Международная', CAST(N'2015-01-01' AS Date), CAST(N'2023-12-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Международная', CAST(N'2016-01-01' AS Date), CAST(N'2024-12-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Международная', CAST(N'2017-01-01' AS Date), CAST(N'2025-12-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Международная', CAST(N'2018-01-01' AS Date), CAST(N'2026-12-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Внутренняя', CAST(N'2011-01-01' AS Date), CAST(N'2018-10-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Внутренняя', CAST(N'2012-01-01' AS Date), CAST(N'2020-10-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Внутренняя', CAST(N'2013-01-01' AS Date), CAST(N'2022-10-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Внутренняя', CAST(N'2014-01-01' AS Date), CAST(N'2023-10-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Внутренняя', CAST(N'2016-01-01' AS Date), CAST(N'2024-10-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Внутренняя', CAST(N'2017-01-01' AS Date), CAST(N'2026-10-31' AS Date))
INSERT [LICENCE] ( [Licence_type], [Date_start], [Date_end]) VALUES ( N'Внутренняя', CAST(N'2018-01-01' AS Date), CAST(N'2024-10-31' AS Date))



-- VEHICLE_MANUFACTURER -- 
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Китобой', 1, 10)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Атлант', 2, 2)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Атлант', 2, 2)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Фоксон', 1, 5)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Сан Хан', 1, 7)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Софтбэнк', 5, 8)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Тата', 3, 6)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Фоксон', 34, 5)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Сан Хан', 40, 7)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Анхаусер', 2, 8)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Уолмарт', 3, 6)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Рохш', 7, 6)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Новартис', 18, 5)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'СанТак', 40, 7)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Крайер', 11, 8)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Уоусон', 13, 5)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Росмака', 15, 6)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Артис', 19, 3)
INSERT [VEHICLE_MANUFACTURER] ( [Name_manufacturer], [City_ID], [License_ID]) VALUES (N'Росмакс', 70, 9)


-- SHIP_TYPE --
INSERT [SHIP_TYPE] ([Ship_type_ID], [Name_ship], [Speed_avg], [Tonnage]) VALUES (1, N'сухогрузный', CAST(21.0 AS Decimal(5, 1)), 800)
INSERT [SHIP_TYPE] ([Ship_type_ID], [Name_ship], [Speed_avg], [Tonnage]) VALUES (2, N'рефрижераторный', CAST(13.0 AS Decimal(5, 1)), 120000)
INSERT [SHIP_TYPE] ([Ship_type_ID], [Name_ship], [Speed_avg], [Tonnage]) VALUES (3, N'трейлерный', CAST(15.0 AS Decimal(5, 1)), 130000)
INSERT [SHIP_TYPE] ([Ship_type_ID], [Name_ship], [Speed_avg], [Tonnage]) VALUES (4, N'лесной', CAST(18.5 AS Decimal(5, 1)), 1000)
INSERT [SHIP_TYPE] ([Ship_type_ID], [Name_ship], [Speed_avg], [Tonnage]) VALUES (5, N'навалочный', CAST(14.0 AS Decimal(5, 1)), 516900)
INSERT [SHIP_TYPE] ([Ship_type_ID], [Name_ship], [Speed_avg], [Tonnage]) VALUES (6, N'наливной', CAST(15.0 AS Decimal(5, 1)), 516900)
INSERT [SHIP_TYPE] ([Ship_type_ID], [Name_ship], [Speed_avg], [Tonnage]) VALUES (7, N'контейнерный', CAST(23.0 AS Decimal(5, 1)), 210000)
INSERT [SHIP_TYPE] ([Ship_type_ID], [Name_ship], [Speed_avg], [Tonnage]) VALUES (8, N'газовозный', CAST(11.0 AS Decimal(5, 1)), 516900)
INSERT [SHIP_TYPE] ([Ship_type_ID], [Name_ship], [Speed_avg], [Tonnage]) VALUES (9, N'скотовозный', CAST(10.0 AS Decimal(5, 1)), 96900)


-- DELIVERY -- 
INSERT [DELIVERY] ([Delivery_ID], [Descreption]) VALUES (1, N'выгрузка-загрузка')
INSERT [DELIVERY] ([Delivery_ID], [Descreption]) VALUES (2, N'выгрузка')
INSERT [DELIVERY] ([Delivery_ID], [Descreption]) VALUES (3, N'ремонт')
INSERT [DELIVERY] ([Delivery_ID], [Descreption]) VALUES (4, N'заправка')
INSERT [DELIVERY] ([Delivery_ID], [Descreption]) VALUES (5, N'ожидание')
INSERT [DELIVERY] ([Delivery_ID], [Descreption]) VALUES (6, N'загрузка')


-- BERTH_TYPE --
INSERT [BERTH_TYPE] ([Category], [Max_tonnage]) VALUES(N'Любой', 1000000000)
INSERT [BERTH_TYPE] ([Category], [Max_tonnage]) VALUES(N'до 100000000', 100000000)
INSERT [BERTH_TYPE] ([Category], [Max_tonnage]) VALUES(N'до 10000000', 10000000)
INSERT [BERTH_TYPE] ([Category], [Max_tonnage]) VALUES(N'до 1000000', 1000000)
INSERT [BERTH_TYPE] ([Category], [Max_tonnage]) VALUES(N'до 10000', 10000)
INSERT [BERTH_TYPE] ([Category], [Max_tonnage]) VALUES(N'до 1000', 1000)
INSERT [BERTH_TYPE] ([Category], [Max_tonnage]) VALUES(N'до 100', 100) 



-- CARGO_TYPE --
INSERT [CARGO_TYPE] ([Cargo_type_ID], [Cargo_type]) VALUES (0, N'пустой')
INSERT [CARGO_TYPE] ([Cargo_type_ID], [Cargo_type]) VALUES (1, N'скоропортящие')
INSERT [CARGO_TYPE] ([Cargo_type_ID], [Cargo_type]) VALUES (2, N'навалочные')
INSERT [CARGO_TYPE] ([Cargo_type_ID], [Cargo_type]) VALUES (3, N'зерновые')
INSERT [CARGO_TYPE] ([Cargo_type_ID], [Cargo_type]) VALUES (4, N'лесные')
INSERT [CARGO_TYPE] ([Cargo_type_ID], [Cargo_type]) VALUES (5, N'наливные')
INSERT [CARGO_TYPE] ([Cargo_type_ID], [Cargo_type]) VALUES (6, N'контейнерные')
INSERT [CARGO_TYPE] ([Cargo_type_ID], [Cargo_type]) VALUES (7, N'насыпные')
INSERT [CARGO_TYPE] ([Cargo_type_ID], [Cargo_type]) VALUES (8, N'бьющиеся')
INSERT [CARGO_TYPE] ([Cargo_type_ID], [Cargo_type]) VALUES (9, N'взрывоопасные')
INSERT [CARGO_TYPE] ([Cargo_type_ID], [Cargo_type]) VALUES (10, N'животные')


-- PRICE --
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 1, 1, 11100)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 1, 2, 1110000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 1, 3, 100000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 1, 4, 1500)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 1, 5, 121000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 1, 6, 1115000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 1, 7, 1115000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 1, 8, 1015000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES (1, 9, 115000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 2, 1, 1105)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 2, 2, 150000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 2, 3, 170000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 2, 4, 1000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 2, 5, 12100)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 2, 6, 1915000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 2, 7, 1615000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 2, 8, 109500)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 2, 9, 1100)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 3, 1, 1100)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 3, 2, 171000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 3, 3, 120000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 3, 4, 1900)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 3, 5, 10100)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 3, 6, 115000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 3, 7, 125000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 3, 8, 11900)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 3, 9, 1100)
				  
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 4, 1, 900)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 4, 2, 14000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 4, 3, 16000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 4, 4, 900)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 4, 5, 9100)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 4, 6, 95000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 4, 7, 105000)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 4, 8, 9950)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 4, 9, 900)
				  
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 5, 1, 705)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 5, 2, 1400)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 5, 3, 1800)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 5, 4, 800)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 5, 5, 900)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 5, 6, 9500)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 5, 7, 16500)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 5, 8, 960)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 5, 9, 600)
				  
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 6, 1, 900)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 6, 2, 140)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 6, 3, 100)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 6, 4, 940)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 6, 5, 9100)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 6, 6, 950)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 6, 7, 100)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 6, 8, 990)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 6, 9, 950)
				  
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 7, 1, 900)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 7, 2, 890)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 7, 3, 600)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 7, 4, 910)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 7, 5, 900)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 7, 6, 900)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 7, 7, 1500)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 7, 8, 5500)
INSERT [PRICE] ( [Berth_type_ID], [Ship_type_ID], [Price_of_one_day]) VALUES ( 7, 9, 2000)



-- INVOICE_CARGO --

INSERT [INVOICE_CARGO] ([Cargo_ID], [Descreption], [Tonnage], [Size], [Cargo_Type_ID], [Basic_charact_of_units]) VALUES (0, N'пустой', 0, NULL, 0, N'кг')
INSERT [INVOICE_CARGO] ([Cargo_ID], [Descreption], [Tonnage], [Size], [Cargo_Type_ID], [Basic_charact_of_units]) VALUES (1, N'пшено', 1000, NULL, 3, N'кг')
INSERT [INVOICE_CARGO] ([Cargo_ID], [Descreption], [Tonnage], [Size], [Cargo_Type_ID], [Basic_charact_of_units]) VALUES (2, N'берёзовые дрова', 988, 200, 4, N'м^3')
INSERT [INVOICE_CARGO] ([Cargo_ID], [Descreption], [Tonnage], [Size], [Cargo_Type_ID], [Basic_charact_of_units]) VALUES (3, N'коровы', 6000, 33, 10, N'шт')
INSERT [INVOICE_CARGO] ([Cargo_ID], [Descreption], [Tonnage], [Size], [Cargo_Type_ID], [Basic_charact_of_units]) VALUES (4, N'лосось', 50, NULL, 1, N'кг')
INSERT [INVOICE_CARGO] ([Cargo_ID], [Descreption], [Tonnage], [Size], [Cargo_Type_ID], [Basic_charact_of_units]) VALUES (5, N'стекло', 1000, NULL, 8, N'кг')
INSERT [INVOICE_CARGO] ([Cargo_ID], [Descreption], [Tonnage], [Size], [Cargo_Type_ID], [Basic_charact_of_units]) VALUES (6, N'трубы', 5000, 200, 2, N'шт')
INSERT [INVOICE_CARGO] ([Cargo_ID], [Descreption], [Tonnage], [Size], [Cargo_Type_ID], [Basic_charact_of_units]) VALUES (7, N'предметы роскоши', 1, 200, 8, N'шт')
INSERT [INVOICE_CARGO] ([Cargo_ID], [Descreption], [Tonnage], [Size], [Cargo_Type_ID], [Basic_charact_of_units]) VALUES (8, N'мясо', 200, NULL, 1, N'кг')
INSERT [INVOICE_CARGO] ([Cargo_ID], [Descreption], [Tonnage], [Size], [Cargo_Type_ID], [Basic_charact_of_units]) VALUES (9, N'бензин', 40000, 35000, 9, N'л')
INSERT [INVOICE_CARGO] ([Cargo_ID], [Descreption], [Tonnage], [Size], [Cargo_Type_ID], [Basic_charact_of_units]) VALUES (10, N'coca-cola', 100, 50, 5, N'шт')


																	 
-- GENDER --
INSERT [GENDER] ([Gender_ID], [Descreption]) VALUES (1, N'Ж')
INSERT [GENDER] ([Gender_ID], [Descreption]) VALUES (2, N'М')


-- CAPTAIN --
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Иванов', N'Пётр', 1, CAST(N'1962-01-13' AS Date), 2)
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Петров', N'Аркадий', 2, CAST(N'1980-01-01' AS Date), 2)
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Бaшаров', N'Иван', 3, CAST(N'1988-06-04' AS Date), 2)
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Скунтин', N'Николай', 4, CAST(N'1986-09-10' AS Date), 2)
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Коптарь', N'Александр', 4, CAST(N'1979-09-13' AS Date), 2)
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Панова', N'Наталия', 2, CAST(N'1980-01-01' AS Date), 2)
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Венцелов', N'Артемий',3, CAST(N'1988-06-04' AS Date), 2)
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Вегражнский', N'Максим', 4, CAST(N'1986-09-10' AS Date), 2)
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Праницкий', N'Никта', 4, CAST(N'1979-09-13' AS Date), 2)
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Панин', N'Тимур',2, CAST(N'1980-01-01' AS Date), 2)
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Аркадьев', N'Илья',1 , CAST(N'1962-01-13' AS Date) , 1 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Аддерливанский', N'Френк', 1 , CAST(N'1952-01-18' AS Date) , 1 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Аддингтон', N'Критиану', 1 , CAST(N'1963-08-13' AS Date) , 1)
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Аттвуд', N'Леонель',3 , CAST(N'1968-03-13' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Болдуин', N'Джон', 3 , CAST(N'1962-11-13' AS Date) , 1)

INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Беррингтон', N'Ватсон', 3 , CAST(N'1962-09-13' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Берч', N'Джон',3 , CAST(N'1962-01-13' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Бишоп', N'Френк',3 , CAST(N'1962-07-13' AS Date) , 1)
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Камбелл', N'Джим',2 , CAST(N'1965-07-13' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Кэри', N'Джон',2 , CAST(N'1978-01-23' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Дейвидсон', N'Шерлок',2 , CAST(N'1962-01-13' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Данкан', N'Френк',1 , CAST(N'1962-01-13' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Дане', N'Джон', 1 , CAST(N'1962-01-13' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Эллингтон', N'Марк',1 , CAST(N'1962-01-13' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Элмерз', N'Джон', 1 , CAST(N'1962-01-13' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Фармер', N'Бенсон',1 , CAST(N'1962-01-13' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Фаррелл', N'Фрэнк',1 , CAST(N'1962-01-13' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Форд', N'Леонель',1 , CAST(N'1962-01-13' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Форман', N'Ромелу',1 , CAST(N'1962-01-13' AS Date) , 2 )
INSERT [CAPTAIN] ([Last_name], [First_name], [Qualification_ID], [Date_birth], [Gender_ID]) VALUES ( N'Форстер', N'Форест',1 , CAST(N'1962-01-13' AS Date) , 2 )



-- Port --
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Шанхая', 1)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Сингапура', 2)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Тяньцзиня', 4)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Гуанчжоу', 4)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Циндао',5)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Роттердама',6)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Нинбо',7)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Хедленда',8)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Даляня', 9)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Пусана', 10)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Гонконга', 11)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Циньхуандао',12)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Южной Луизианы',13)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Нагои', 14)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Хьюстона', 15)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Шэньчжэня', 16)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Порт-Кланга', 17)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Антверпена', 13)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Дампира', 19)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Сямыня', 20)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Ульсана', 21)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Дубая', 22)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Ньюкасла', 23)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Тибы', 24)
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Гамбурга', 25 )
INSERT [PORT] ([Name_port], [City_ID]) VALUES( N'Порт Санкт-Петербурга', 70  )






-- BERTH --
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 1, 1)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 1, 1)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 1, 2)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 1, 3)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 1, 4)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 2, 10)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 3, 17)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 2, 13)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 2, 12)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 1, 13)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 1, 3)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 3, 20)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 2, 19)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 3, 2)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 3, 16)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 3, 9)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 1, 8)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 2, 6)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 3, 4)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 3, 8)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 1, 9)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 1, 1)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 2, 3)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 3, 8)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 1, 10)
INSERT [BERTH] ( [Berth_type_ID], [Port_ID] ) VALUES( 3, 7)



-- SHIP --
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Любовь', 1 , 12 , 25 , 25 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Крым', 4 , 2 , 10 , 1 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Вера', 1 , 1 , 15 , 21 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Линкольн', 1, 12 , 17 , 22 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Аризона', 8 , 1 , 3 , 5 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Южный', 2 , 17 , 13 , 24 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Беда', 8 , 6 , 25 , 18 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Победа', 8 , 5 , 18 , 16 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Забытый', 1 , 9 , 17 , 14 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Вингилот', 5 , 14 , 19 , 16 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Надежда', 2 , 10 , 14 , 22 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Дункан', 2 , 8 , 11 , 12 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Испаньола', 6 , 15 , 21 , 21 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Клеймор', 6 , 13 , 1 , 15 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Кутузов', 6 , 1 , 19 , 5 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Людмила', 2 , 16 , 16 , 10 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Медуза', 6 , 5 , 5 , 19 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Квант', 7 , 5 , 22 , 13 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Акула', 3 , 1 , 14 , 10 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Наутилус', 2 , 11 , 18 , 24 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Пекод', 2 , 16 , 15 , 14 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Осминог', 1 , 12 , 12 , 11 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Арктика', 2 , 16 , 12 , 2 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Святая дева', 2 , 13 , 11 , 13 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Сифанта', 3 , 10 , 21 , 5 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Стратфорд', 5 , 11 , 9 , 8 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Суорд', 6 , 17 , 16 , 12 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Атом', 7 , 10 , 18 , 2 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Зевс', 3 , 6 , 7 , 9 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Форвард', 3 , 16 , 17 , 7 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Эмма', 5 , 17 , 19 , 14 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Молния', 5 , 18 , 26 , 11 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Елизавета', 5 , 17 , 19 , 1 )
INSERT [SHIP] ( [Name_ship], [Ship_type_ID], [Vehicle_manufacturer_ID], [Home_berth_ID], [Captain_ID]) VALUES ( N'Костенавр', 5 , 18 , 26 , 11 )
										 



-- ITINERARY --
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	102	,	1	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	103	,	1	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	104	,	1	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	105	,	1	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	106	,	1	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	107	,	1	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	108	,	1	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	109	,	1	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	110	,	1	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	111	,	1	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	112	,	1	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	113	,	1	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	114	,	1	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	115	,	1	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	116	,	1	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	117	,	1	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	118	,	1	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	119	,	1	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	120	,	1	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	121	,	1	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	122	,	1	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	123	,	1	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	124	,	1	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	125	,	1	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	126	,	1	,	26	)			
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	201	,	2	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	203	,	2	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	204	,	2	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	205	,	2	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	206	,	2	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	207	,	2	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	208	,	2	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	209	,	2	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	210	,	2	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	211	,	2	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	212	,	2	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	213	,	2	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	214	,	2	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	215	,	2	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	216	,	2	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	217	,	2	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	218	,	2	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	219	,	2	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	220	,	2	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	221	,	2	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	222	,	2	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	223	,	2	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	224	,	2	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	225	,	2	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	226	,	2	,	26	)			
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	301	,	3	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	302	,	3	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	304	,	3	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	305	,	3	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	306	,	3	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	307	,	3	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	308	,	3	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	309	,	3	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	310	,	3	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	311	,	3	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	312	,	3	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	313	,	3	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	314	,	3	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	315	,	3	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	316	,	3	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	317	,	3	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	318	,	3	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	319	,	3	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	320	,	3	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	321	,	3	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	322	,	3	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	323	,	3	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	324	,	3	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	325	,	3	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	326	,	3	,	26	)			
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	401	,	4	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	402	,	4	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	403	,	4	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	405	,	4	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	406	,	4	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	407	,	4	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	408	,	4	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	409	,	4	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	410	,	4	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	411	,	4	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	412	,	4	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	413	,	4	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	414	,	4	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	415	,	4	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	416	,	4	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	417	,	4	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	418	,	4	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	419	,	4	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	420	,	4	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	421	,	4	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	422	,	4	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	423	,	4	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	424	,	4	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	425	,	4	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	426	,	4	,	26	)			
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	501	,	5	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	502	,	5	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	503	,	5	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	504	,	5	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	506	,	5	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	507	,	5	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	508	,	5	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	509	,	5	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	510	,	5	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	511	,	5	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	512	,	5	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	513	,	5	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	514	,	5	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	515	,	5	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	516	,	5	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	517	,	5	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	518	,	5	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	519	,	5	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	520	,	5	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	521	,	5	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	522	,	5	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	523	,	5	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	524	,	5	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	525	,	5	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	526	,	5	,	26	)			
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	601	,	6	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	602	,	6	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	603	,	6	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	604	,	6	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	605	,	6	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	607	,	6	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	608	,	6	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	609	,	6	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	610	,	6	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	611	,	6	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	612	,	6	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	613	,	6	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	614	,	6	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	615	,	6	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	616	,	6	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	617	,	6	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	618	,	6	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	619	,	6	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	620	,	6	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	621	,	6	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	622	,	6	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	623	,	6	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	624	,	6	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	625	,	6	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	626	,	6	,	26	)	------		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	701	,	7	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	702	,	7	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	703	,	7	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	704	,	7	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	705	,	7	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	706	,	7	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	708	,	7	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	709	,	7	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	710	,	7	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	711	,	7	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	712	,	7	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	713	,	7	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	714	,	7	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	715	,	7	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	716	,	7	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	717	,	7	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	718	,	7	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	719	,	7	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	720	,	7	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	721	,	7	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	722	,	7	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	723	,	7	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	724	,	7	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	725	,	7	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	726	,	7	,	26	)			
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	801	,	8	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	802	,	8	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	803	,	8	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	804	,	8	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	805	,	8	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	806	,	8	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	807	,	8	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	809	,	8	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	810	,	8	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	811	,	8	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	812	,	8	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	813	,	8	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	814	,	8	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	815	,	8	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	816	,	8	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	817	,	8	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	818	,	8	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	819	,	8	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	820	,	8	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	821	,	8	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	822	,	8	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	823	,	8	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	824	,	8	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	825	,	8	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	826	,	8	,	26	)			
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	901	,	9	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	902	,	9	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	903	,	9	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	904	,	9	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	905	,	9	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	906	,	9	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	907	,	9	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	908	,	9	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	910	,	9	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	911	,	9	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	912	,	9	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	913	,	9	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	914	,	9	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	915	,	9	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	916	,	9	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	917	,	9	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	918	,	9	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	919	,	9	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	920	,	9	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	921	,	9	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	922	,	9	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	923	,	9	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	924	,	9	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	925	,	9	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	926	,	9	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1001	,	10	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1002	,	10	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1003	,	10	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1004	,	10	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1005	,	10	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1006	,	10	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1007	,	10	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1008	,	10	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1009	,	10	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1011	,	10	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1012	,	10	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1013	,	10	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1014	,	10	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1015	,	10	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1016	,	10	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1017	,	10	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1018	,	10	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1019	,	10	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1020	,	10	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1021	,	10	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1022	,	10	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1023	,	10	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1024	,	10	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1025	,	10	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1026	,	10	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1101	,	11	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1102	,	11	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1103	,	11	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1104	,	11	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1105	,	11	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1106	,	11	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1107	,	11	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1108	,	11	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1109	,	11	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1110	,	11	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1112	,	11	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1113	,	11	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1114	,	11	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1115	,	11	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1116	,	11	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1117	,	11	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1118	,	11	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1119	,	11	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1120	,	11	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1121	,	11	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1122	,	11	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1123	,	11	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1124	,	11	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1125	,	11	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1126	,	11	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1201	,	12	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1202	,	12	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1203	,	12	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1204	,	12	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1205	,	12	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1206	,	12	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1207	,	12	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1208	,	12	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1209	,	12	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1210	,	12	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1211	,	12	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1213	,	12	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1214	,	12	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1215	,	12	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1216	,	12	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1217	,	12	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1218	,	12	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1219	,	12	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1220	,	12	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1221	,	12	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1222	,	12	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1223	,	12	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1224	,	12	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1225	,	12	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1226	,	12	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1301	,	13	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1302	,	13	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1303	,	13	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1304	,	13	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1305	,	13	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1306	,	13	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1307	,	13	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1308	,	13	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1309	,	13	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1310	,	13	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1311	,	13	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1312	,	13	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1314	,	13	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1315	,	13	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1316	,	13	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1317	,	13	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1318	,	13	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1319	,	13	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1320	,	13	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1321	,	13	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1322	,	13	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1323	,	13	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1324	,	13	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1325	,	13	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1326	,	13	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1401	,	14	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1402	,	14	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1403	,	14	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1404	,	14	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1405	,	14	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1406	,	14	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1407	,	14	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1408	,	14	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1409	,	14	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1410	,	14	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1411	,	14	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1412	,	14	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1413	,	14	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1415	,	14	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1416	,	14	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1417	,	14	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1418	,	14	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1419	,	14	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1420	,	14	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1421	,	14	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1422	,	14	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1423	,	14	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1424	,	14	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1425	,	14	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1426	,	14	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1501	,	15	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1502	,	15	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1503	,	15	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1504	,	15	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1505	,	15	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1506	,	15	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1507	,	15	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1508	,	15	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1509	,	15	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1510	,	15	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1511	,	15	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1512	,	15	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1513	,	15	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1514	,	15	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1516	,	15	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1517	,	15	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1518	,	15	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1519	,	15	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1520	,	15	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1521	,	15	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1522	,	15	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1523	,	15	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1524	,	15	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1525	,	15	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1526	,	15	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1601	,	16	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1602	,	16	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1603	,	16	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1604	,	16	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1605	,	16	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1606	,	16	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1607	,	16	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1608	,	16	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1609	,	16	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1610	,	16	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1611	,	16	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1612	,	16	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1613	,	16	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1614	,	16	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1615	,	16	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1617	,	16	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1618	,	16	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1619	,	16	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1620	,	16	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1621	,	16	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1622	,	16	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1623	,	16	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1624	,	16	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1625	,	16	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1626	,	16	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1701	,	17	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1702	,	17	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1703	,	17	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1704	,	17	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1705	,	17	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1706	,	17	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1707	,	17	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1708	,	17	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1709	,	17	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1710	,	17	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1711	,	17	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1712	,	17	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1713	,	17	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1714	,	17	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1715	,	17	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1716	,	17	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1718	,	17	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1719	,	17	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1720	,	17	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1721	,	17	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1722	,	17	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1723	,	17	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1724	,	17	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1725	,	17	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1726	,	17	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1801	,	18	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1802	,	18	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1803	,	18	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1804	,	18	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1805	,	18	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1806	,	18	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1807	,	18	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1808	,	18	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1809	,	18	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1810	,	18	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1811	,	18	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1812	,	18	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1813	,	18	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1814	,	18	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1815	,	18	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1816	,	18	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1817	,	18	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1819	,	18	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1820	,	18	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1821	,	18	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1822	,	18	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1823	,	18	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1824	,	18	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1825	,	18	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1826	,	18	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1901	,	19	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1902	,	19	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1903	,	19	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1904	,	19	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1905	,	19	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1906	,	19	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1907	,	19	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1908	,	19	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1909	,	19	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1910	,	19	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1911	,	19	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1912	,	19	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1913	,	19	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1914	,	19	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1915	,	19	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1916	,	19	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1917	,	19	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1918	,	19	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1920	,	19	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1921	,	19	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1922	,	19	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1923	,	19	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1924	,	19	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1925	,	19	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	1926	,	19	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2001	,	20	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2002	,	20	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2003	,	20	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2004	,	20	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2005	,	20	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2006	,	20	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2007	,	20	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2008	,	20	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2009	,	20	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2010	,	20	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2011	,	20	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2012	,	20	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2013	,	20	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2014	,	20	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2015	,	20	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2016	,	20	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2017	,	20	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2018	,	20	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2019	,	20	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2021	,	20	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2022	,	20	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2023	,	20	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2024	,	20	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2025	,	20	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2026	,	20	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2101	,	21	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2102	,	21	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2103	,	21	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2104	,	21	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2105	,	21	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2106	,	21	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2107	,	21	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2108	,	21	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2109	,	21	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2110	,	21	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2111	,	21	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2112	,	21	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2113	,	21	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2114	,	21	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2115	,	21	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2116	,	21	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2117	,	21	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2118	,	21	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2119	,	21	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2120	,	21	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2122	,	21	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2123	,	21	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2124	,	21	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2125	,	21	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2126	,	21	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2201	,	22	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2202	,	22	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2203	,	22	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2204	,	22	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2205	,	22	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2206	,	22	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2207	,	22	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2208	,	22	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2209	,	22	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2210	,	22	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2211	,	22	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2212	,	22	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2213	,	22	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2214	,	22	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2215	,	22	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2216	,	22	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2217	,	22	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2218	,	22	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2219	,	22	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2220	,	22	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2221	,	22	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2223	,	22	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2224	,	22	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2225	,	22	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2226	,	22	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2301	,	23	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2302	,	23	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2303	,	23	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2304	,	23	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2305	,	23	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2306	,	23	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2307	,	23	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2308	,	23	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2309	,	23	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2310	,	23	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2311	,	23	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2312	,	23	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2313	,	23	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2314	,	23	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2315	,	23	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2316	,	23	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2317	,	23	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2318	,	23	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2319	,	23	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2320	,	23	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2321	,	23	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2322	,	23	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2324	,	23	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2325	,	23	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2326	,	23	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2401	,	24	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2402	,	24	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2403	,	24	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2404	,	24	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2405	,	24	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2406	,	24	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2407	,	24	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2408	,	24	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2409	,	24	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2410	,	24	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2411	,	24	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2412	,	24	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2413	,	24	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2414	,	24	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2415	,	24	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2416	,	24	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2417	,	24	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2418	,	24	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2419	,	24	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2420	,	24	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2421	,	24	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2422	,	24	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2423	,	24	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2425	,	24	,	25	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2426	,	24	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2501	,	25	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2502	,	25	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2503	,	25	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2504	,	25	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2505	,	25	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2506	,	25	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2507	,	25	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2508	,	25	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2509	,	25	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2510	,	25	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2511	,	25	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2512	,	25	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2513	,	25	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2514	,	25	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2515	,	25	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2516	,	25	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2517	,	25	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2518	,	25	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2519	,	25	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2520	,	25	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2521	,	25	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2522	,	25	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2523	,	25	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2524	,	25	,	24	)
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2526	,	25	,	26	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2601	,	26	,	1	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2602	,	26	,	2	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2603	,	26	,	3	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2604	,	26	,	4	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2605	,	26	,	5	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2606	,	26	,	6	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2607	,	26	,	7	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2608	,	26	,	8	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2609	,	26	,	9	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2610	,	26	,	10	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2611	,	26	,	11	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2612	,	26	,	12	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2613	,	26	,	13	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2614	,	26	,	14	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2615	,	26	,	15	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2616	,	26	,	16	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2617	,	26	,	17	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2618	,	26	,	18	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2619	,	26	,	19	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2620	,	26	,	20	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2621	,	26	,	21	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2622	,	26	,	22	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2623	,	26	,	23	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2624	,	26	,	24	)		
INSERT [ITINERARY] ([Itinerary_ID],[Berth_from_ID], [Berth_to_ID]) VALUES (	2625	,	26	,	25	)



-- TRIP --
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 1 , '01/10/2017 01:14:31', '05/12/2017 01:14:31' , 1326 , 4 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 1 , '14/01/2018 17:17:30', '20/05/2018 17:17:30' , 2619 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 1 , '30/05/2018 23:38:28', '08/04/2019 23:38:28' , 208 , 4 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 1 , '25/08/2018 10:53:29', '25/12/2018 16:56:00' , 208 , 1 )

INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 12 , '20/04/2015 14:04:14', '22/06/2015 14:04:14' , 604 , 4 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 12 , '29/08/2015 05:26:11', '02/11/2015 05:26:11' , 426 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 12 , '25/02/2016 18:34:12', '08/06/2016 18:34:12' , 2608 , 2 )
																			 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 8 , '06/05/2015 04:23:08', '16/07/2015 04:23:08' , 516 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 8 , '23/07/2016 11:37:33', '01/08/2016 11:37:33' , 1608 , 5 )
																			
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 6 , '04/06/2016 15:59:01', '15/09/2016 15:59:01' , 509 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 6 , '20/09/2016 12:55:44', '25/12/2016 12:55:44' , 926 , 2 )
																			 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 2 , '18/09/2015 09:24:29', '27/04/2016 09:24:29' , 426 , 4 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 2 , '09/05/2016 19:28:38', '10/08/2016 19:28:38' , 2624 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 2 , '02/09/2018 01:15:28', '11/02/2019 01:15:28' , 2406 , 1 )
																			
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 18 , '19/04/2014 18:14:46', '30/04/2014 18:14:46' , 403 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 18 , '02/08/2015 01:15:28', '11/09/2015 01:15:28' , 326 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 18 , '19/09/2015 18:14:46', '30/11/2015 18:14:46' , 2605 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 18 , '30/12/2015 13:37:23', '09/01/2016 13:37:23' , 506 , 4 )
																			 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 4 , '07/11/2014 05:23:09', '08/12/2014 05:23:09' , 1107 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 4 , '11/01/2015 08:38:38', '19/05/2015 08:38:38' , 718 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 4 , '26/06/2015 16:56:27', '27/09/2015 16:56:27' , 1824 , 1 )
																			 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 22 , '03/07/2016 09:53:01', '15/09/2016 09:53:01' , 906 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 22 , '19/10/2016 23:10:23', '23/12/2016 23:10:23' , 601 , 2 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 22 , '10/08/2017 11:28:41', '12/10/2017 11:28:41' , 706 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 22 , '07/11/2017 14:46:51', '10/12/2017 14:46:51' , 603 , 1 )
																			 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 21 , '20/02/2016 18:39:16', '02/03/2016 18:39:16' , 814 , 4 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 21 , '24/03/2016 05:59:44', '02/07/2016 05:59:44' , 1426, 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 21 , '12/07/2016 23:31:32', '21/09/2016 23:31:32' , 2601 , 2 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 21 , '07/10/2016 23:10:23', '19/11/2016 23:10:23' , 105 , 3 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 21 , '24/12/2016 17:41:51', '16/04/2017 17:41:51' , 516 , 4 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 21 , '15/05/2017 07:44:20', '22/12/2017 07:44:20' , 1609 , 6 )
																			 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 9 , '05/01/2016 13:54:04', '10/05/2016 13:54:04' , 208 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 9 , '01/06/2016 03:47:10', '12/07/2016 03:47:10' , 804 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 9 , '04/08/2016 18:13:37', '10/09/2016 18:13:37' , 412 , 5 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 9 , '01/10/2016 01:14:31', '05/12/2016 01:14:31' , 1226 , 2 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 9 , '14/01/2017 17:17:30', '20/05/2017 17:17:30' , 2609 , 4 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 9 , '30/05/2017 23:38:28', '08/07/2017 23:38:28' , 902 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 9 , '24/08/2017 10:53:29', '25/12/2017 10:53:29' , 208 , 2 )
																			 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 20 , '15/01/2015 20:48:13', '21/06/2015 20:48:13' , 2403 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 20 , '12/07/2015 20:10:05', '16/09/2015 20:10:05' , 302 , 3 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 20 , '14/10/2015 02:11:18', '25/12/2015 02:11:18' , 201 , 4 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 20 , '25/01/2016 02:21:00', '29/06/2016 02:21:00' , 122 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 20 , '25/07/2016 09:10:10', '07/08/2016 09:10:10' , 2205 , 5 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 20 , '28/09/2016 07:49:10', '06/11/2016 07:49:10' , 526 , 2 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 20 , '28/12/2017 13:28:59', '01/03/2017 13:28:59' , 2604 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 20 , '04/04/2017 00:07:16', '12/06/2017 00:07:16' , 413 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 20 , '12/06/2017 09:48:07', '21/08/2017 09:48:07' , 1310 , 3 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 20 , '16/09/2017 04:37:30', '18/11/2017 04:37:30' , 1009 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 20 , '20/11/2017 17:00:30', '27/12/2017 17:00:30' , 904 , 4 )
																			 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 7 , '28/07/2015 07:49:10', '06/08/2015 07:49:10' , 1426 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 7 , '11/08/2015 13:28:59', '01/09/2015 13:28:59' , 2604 , 2 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 7 , '06/09/2015 00:07:16', '12/12/2015 00:07:16' , 410 , 3 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 7 , '17/12/2015 09:24:29', '17/04/2016 09:24:29' , 1019 , 5 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 7 , '22/04/2016 09:24:29', '27/09/2016 09:24:29' , 1909 , 6 )
																			 														 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 32 , '16/10/2015 04:37:30', '29/11/2015 04:37:30' , 2523 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 32 , '03/12/2015 17:00:30', '07/01/2016 17:00:30' , 2311 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 32 , '12/02/2016 09:24:29', '25/03/2017 09:24:29' , 1101 , 4 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 32 , '20/04/2017 09:24:29', '20/05/2017 09:24:29' , 126 , 3 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 32 , '29/06/2017 09:24:29', '02/07/2017 09:24:29' , 2618 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 32 , '30/11/2017 09:24:29', '24/12/2017 09:24:29' , 1816 , 5 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 32 , '29/01/2018 09:24:29', '17/05/2018 09:24:29' , 1626 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 32 , '22/06/2018 09:24:29', '25/08/2018 09:24:29' , 2601 , 2 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 32 , '30/09/2018 09:24:29', '27/10/2018 09:24:29' , 123 , 4 )
																			 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 16 , '06/03/2016 17:44:44', '13/06/2016 17:44:44' , 102 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 16 , '18/06/2016 12:18:09', '09/10/2016 12:18:09' , 219 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 16 , '14/10/2016 21:35:34', '05/12/2016 20:35:00' , 1926 , 2 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 16 , '10/12/2016 18:40:44', '13/03/2017 17:44:44' , 2607 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 16 , '18/03/2017 12:18:09', '09/05/2017 12:18:09' , 710 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 16 , '14/05/2017 21:35:34', '05/10/2017 21:35:34' , 1008 , 2 )
																			 
														 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 30 , '14/07/2016 02:11:18', '25/08/2016 02:11:18' , 1718 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 30 , '25/09/2016 07:25:57', '26/12/2016 07:25:57' , 1826 , 5 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 30 , '25/01/2017 02:21:00', '29/04/2017 02:21:00' , 2607 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 30 , '15/05/2017 09:10:10', '27/07/2017 09:10:10' , 723 ,  2 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 30 , '30/07/2018 07:49:10', '17/09/2018 07:49:10' , 2308 , 3 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 30 , '28/09/2018 13:28:59', '01/10/2018 13:28:59' , 806 , 4 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 30 , '05/10/2018 00:07:16', '27/10/2018 00:07:16' , 626 , 6 )
																			 														 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 29 , '10/07/2016 02:11:18', '25/07/2016 02:11:18' , 318 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 29 , '15/08/2016 07:25:57', '06/02/2017 07:25:57' , 1814 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 29 , '15/04/2017 09:10:10', '17/11/2017 09:10:10' , 1423 , 2 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 29 , '28/02/2018 07:49:10', '06/05/2018 07:49:10' , 2308 , 3 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 29 , '18/06/2018 13:28:59', '17/08/2018 13:28:59' , 826 , 4 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 29 , '30/09/2018 00:07:16', '27/10/2018 00:07:16' , 2617 , 6 )
																			 														 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 31 , '23/07/2017 07:49:10', '06/08/2017 07:49:10' , 1408 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 31 , '09/08/2017 13:28:59', '11/09/2017 13:28:59' , 806 , 2 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 31 , '23/07/2017 07:49:10', '06/08/2017 07:49:10' , 607 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 31 , '09/08/2017 13:28:59', '11/09/2017 13:28:59' , 704 , 2 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 31 , '26/09/2017 00:07:16', '02/01/2018 00:07:16' , 426 , 3 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 31 , '17/02/2018 09:24:29', '27/05/2018 09:24:29' , 2609 , 5 )
																			 													 
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 28 , '05/01/2017 13:54:04', '10/05/2017 13:54:04' , 208 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 28 , '01/06/2017 03:47:10', '12/07/2017 03:47:10' , 814 , 2 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 28 , '04/08/2017 18:13:37', '10/09/2017 18:13:37' , 1413 , 3 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 28 , '01/10/2017 01:14:31', '05/12/2017 01:14:31' , 1326 , 4 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 28 , '14/01/2018 17:17:30', '20/05/2018 17:17:30' , 2619 , 6 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 28 , '30/05/2018 23:38:28', '08/07/2018 23:38:28' , 1902 , 1 )
INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 28 , '24/08/2018 10:53:29', '25/12/2018 10:53:29' , 208 , 1 )


-- OPERATION --
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 40 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 49 , 6 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 41 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 30 , 3 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 39 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 18 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 28 , 6 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 40 , 5 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 7 , 9 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 48 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 9 , 6 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 9 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 7 , 5 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 32 , 9 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 26 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 22 , 5 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 27 , 9 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 16 , 8 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 27 , 8 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 40 , 8 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 16 , 9 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 4 , 3 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 5 , 8 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 46 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 41 , 6 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 29 , 7 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 37 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 31 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 31 , 9 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 20 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 25 , 9 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 24 , 8 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 44 , 8 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 13 , 7 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 26 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 16 , 7 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 7 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 27 , 6 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 36 , 3 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 23 , 9 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 17 , 9 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 9 , 7 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 50 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 29 , 9 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 11 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 51 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 52 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 53 , 0 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 54 , 0 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 55 , 0 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 56 , 5 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 57 , 5 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 58 , 5 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 59 , 5 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 66 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 67 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 68 , 5 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 69 , 5 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 70 , 0 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 71 , 0 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 72 , 4 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 73 , 4 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 74 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 75 , 5 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 76 , 0 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 77 , 0 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 78 , 3 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 79 , 4 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 80 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 81 , 5 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 82 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 83 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 84 , 0 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 85 , 3 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 86 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 87 , 0 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 88 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 89 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 90 , 5 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 2 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 2 , 5 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 3 , 1 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 92 , 3 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 93 , 4 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 94 , 2 )
INSERT [OPERATION] ([Trip_ID], [Cargo_ID]) VALUES ( 95 , 5 )
