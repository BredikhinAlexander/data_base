
-- Суда, водоизмещением более 1000т не могут входить в порты, принимающие не более 100 т

USE Shipping
GO

IF (OBJECT_ID('TR_1') IS NOT NULL)
	DROP TRIGGER TR_1
GO

CREATE TRIGGER TR_1
ON TRIP
INSTEAD OF INSERT
AS

BEGIN

INSERT INTO TRIP 
([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID])

SELECT  inserted.Ship_ID
		,inserted.Date_departure
		,inserted.Date_arrival
		,inserted.Itinerary_ID
		,inserted.Delivery_ID

FROM inserted
JOIN SHIP on SHIP.Ship_ID = inserted.Ship_ID
JOIN SHIP_TYPE on SHIP_TYPE.Ship_type_ID = SHIP.Ship_type_ID
JOIN ITINERARY on ITINERARY.Itinerary_ID = inserted.Itinerary_ID
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID
JOIN BERTH_TYPE on BERTH_TYPE.Berth_type_ID = BERTH.Berth_type_ID
WHERE (SHIP_TYPE.Tonnage < 1000) or (BERTH_TYPE.Max_tonnage > 100)

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
	RAISERROR('не все вставляемые строки допустимы',16,1)
END

END

GO




