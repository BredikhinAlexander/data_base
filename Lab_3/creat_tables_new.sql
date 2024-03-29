USE Shipping
GO

-- �������� ������ --

ALTER TABLE STOP_x_CARGO 
DROP CONSTRAINT STOP_x_CARGO_CARGO_STATUS
GO
ALTER TABLE STOP_x_CARGO 
DROP CONSTRAINT STOP_x_CARGO_CARGO
GO
ALTER TABLE STOP_x_CARGO 
DROP CONSTRAINT STOP_x_CARGO_STOP_LIST
GO
ALTER TABLE INVOICE_CARGO 
DROP CONSTRAINT CARGO_CARGO_TYPE
GO
ALTER TABLE STOP_LIST 
DROP CONSTRAINT STOP_LIST_TRIP
GO
ALTER TABLE TRIP 
DROP CONSTRAINT TRIP_DELIVERY
GO
ALTER TABLE STOP_LIST 
DROP CONSTRAINT STOP_LIST_BERTH
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

-- �������� ������ --

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


-- �������� ������ --

CREATE TABLE STOP_x_CARGO (
   Cargo_ID int  NOT NULL,
   Stop_list_ID int  NOT NULL,
   Cargo_status_ID int  NOT NULL,
   CONSTRAINT STOP_x_CARGO_pk PRIMARY KEY  (Cargo_ID,Stop_list_ID)
)

GO

CREATE TABLE CARGO_STATUS (
   Cargo_status_ID int  NOT NULL,
   Status_description nvarchar(100)  NOT NULL,
   CONSTRAINT CARGO_STATUS_pk PRIMARY KEY  (Cargo_status_ID)
)

GO


CREATE TABLE STOP_LIST (
   Stop_list_ID int  NOT NULL IDENTITY(1,1),
   Trip_ID int  NOT NULL,
   Stop_num int  NOT NULL,
   Stop_berth int  NOT NULL,
   Date_stop_departure datetime  NOT NULL,
   Date_stop_arrival datetime  NOT NULL,
   CONSTRAINT STOP_LIST_pk PRIMARY KEY  (Stop_list_ID),

)

-- 1
ALTER TABLE STOP_LIST ADD CONSTRAINT STOP_LIST_ch CHECK(Stop_num > 0)

-- 2
ALTER TABLE STOP_LIST ADD Fact_departure datetime2(0) NULL
ALTER TABLE STOP_LIST ADD Fact_arrival datetime2(0) NULL

-- 3
ALTER TABLE STOP_LIST ALTER COLUMN Stop_berth int NULL

-- 4
ALTER TABLE STOP_LIST ADD CONSTRAINT STOP_LIST_uk UNIQUE(Trip_ID, Stop_num)

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

CREATE TABLE PORT (
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


-- �������� ������ --

ALTER TABLE STOP_x_CARGO ADD CONSTRAINT STOP_x_CARGO_CARGO_STATUS
   FOREIGN KEY (Cargo_status_ID)
   REFERENCES CARGO_STATUS (Cargo_status_ID)
ON UPDATE CASCADE

GO

ALTER TABLE STOP_x_CARGO ADD CONSTRAINT STOP_x_CARGO_CARGO
   FOREIGN KEY (Cargo_ID)
   REFERENCES INVOICE_CARGO (Cargo_ID)


GO

ALTER TABLE STOP_x_CARGO ADD CONSTRAINT STOP_x_CARGO_STOP_LIST
   FOREIGN KEY (Stop_list_ID)
   REFERENCES STOP_LIST (Stop_list_ID)
ON UPDATE CASCADE

GO

ALTER TABLE INVOICE_CARGO ADD CONSTRAINT CARGO_CARGO_TYPE
   FOREIGN KEY (Cargo_Type_ID)
   REFERENCES CARGO_TYPE (Cargo_Type_ID)
ON UPDATE CASCADE

GO

ALTER TABLE STOP_LIST ADD CONSTRAINT STOP_LIST_TRIP
   FOREIGN KEY (Trip_ID)
   REFERENCES TRIP (Trip_ID)

GO

ALTER TABLE TRIP ADD CONSTRAINT TRIP_DELIVERY
   FOREIGN KEY (Delivery_ID)
   REFERENCES DELIVERY (Delivery_ID)
ON UPDATE CASCADE

GO

ALTER TABLE STOP_LIST ADD CONSTRAINT STOP_LIST_BERTH
   FOREIGN KEY (Stop_berth)
   REFERENCES BERTH (Berth_ID)
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

ALTER TABLE PORT ADD CONSTRAINT PORT_CITY
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