
-- Суда, водоизмещением более 1000т не могут входить в порты, принимающие не более 100 т


USE Shipping
GO

IF (OBJECT_ID('TR_1') IS NOT NULL)
	DROP TRIGGER TR_1
GO

CREATE TRIGGER TR_1
ON TRIP
AFTER INSERT, UPDATE
AS

declare @count int
SET @count = (

SELECT COUNT(*)
FROM inserted
JOIN SHIP on SHIP.Ship_ID = inserted.Ship_ID
JOIN SHIP_TYPE on SHIP_TYPE.Ship_type_ID = SHIP.Ship_type_ID
JOIN ITINERARY on ITINERARY.Itinerary_ID = inserted.Itinerary_ID
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID
JOIN BERTH_TYPE on BERTH_TYPE.Berth_type_ID = BERTH.Berth_type_ID
WHERE (SHIP_TYPE.Tonnage > 1000) and (BERTH_TYPE.Max_tonnage < 100)
)

IF @count > 0
BEGIN 
	ROLLBACK TRAN
	RAISERROR('фиаско',16,1)
END

GO

--INSERT  TRIP VALUES (1, '01-11-2018', '10-12-2018', 2425, 3), (3, '01-11-2018', '10-12-2018', 2425, 3), (3, '01-11-2018', '10-12-2018', 2425, 3) --ОШИБКА
--INSERT TRIP VALUES (1, '01-11-2018', '10-12-2018', 2425, 3), (4, '01-11-2018', '10-12-2018', 2425, 3)

INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) VALUES ( 6 , '01/10/2017 01:14:31', '05/12/2017 01:14:31' , 99 , 4 ), ( 1 , '01/10/2017 01:14:31', '05/12/2017 01:14:31' , 209 , 3 )

GO

SELECT SHIP.Ship_ID, ITINERARY.Itinerary_ID, SHIP_TYPE.Tonnage, BERTH_TYPE.Max_tonnage
FROM TRIP
JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID
JOIN SHIP_TYPE on SHIP_TYPE.Ship_type_ID = SHIP.Ship_type_ID
JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID
JOIN BERTH_TYPE on BERTH_TYPE.Berth_type_ID = BERTH.Berth_type_ID
WHERE (SHIP_TYPE.Tonnage > 1000) and (BERTH_TYPE.Max_tonnage < 100)

