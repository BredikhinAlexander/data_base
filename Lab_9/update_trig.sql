-- Суда, водоизмещением более 1000т не могут входить в порты, принимающие не более 100 т

USE Shipping
GO

IF (OBJECT_ID('TR_update') IS NOT NULL)
	DROP TRIGGER TR_update
GO

CREATE TRIGGER TR_update
ON TRIP
INSTEAD OF UPDATE
AS

BEGIN

SELECT * FROM inserted

UPDATE TRIP 
SET TRIP.Date_departure = (inserted.Date_departure),
	TRIP.Date_arrival = (inserted.Date_arrival),
	TRIP.Itinerary_ID = (inserted.Itinerary_ID),
	TRIP.Delivery_ID = (inserted.Delivery_ID)
FROM TRIP
JOIN inserted on inserted.Trip_ID = TRIP.Trip_ID
JOIN SHIP on SHIP.Ship_ID = inserted.Ship_ID
JOIN SHIP_TYPE on SHIP_TYPE.Ship_type_ID = SHIP.Ship_type_ID
JOIN ITINERARY on ITINERARY.Itinerary_ID = inserted.Itinerary_ID
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID
JOIN BERTH_TYPE on BERTH_TYPE.Berth_type_ID = BERTH.Berth_type_ID
WHERE (SHIP_TYPE.Tonnage < 1000) or (BERTH_TYPE.Max_tonnage > 100)
		and (inserted.Trip_ID = TRIP.Trip_ID)



END

GO


begin tran

SELECT * FROM TRIP

UPDATE TRIP 
SET Date_departure = getdate()-Trip_ID , Itinerary_ID = 2615+trip_id
--WHERE Trip_ID in (4,5)

SELECT * FROM TRIP

rollback