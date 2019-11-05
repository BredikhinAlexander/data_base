USE Shipping


if (object_id ('View_Dop_2') IS NOT NULL)
	DROP VIEW View_Dop_2
GO

CREATE VIEW View_Dop_2 AS (
SELECT ITINERARY.Itinerary_ID as [num_itinerary], SHIP.Ship_type_ID as [ship_type]
	,COUNT(SHIP.Ship_type_ID) as [count]
FROM TRIP
JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID

GROUP BY SHIP.Ship_type_ID, ITINERARY.Itinerary_ID)


GO

SELECT TOP(1) WITH TIES 
	View_Dop_2.num_itinerary, View_Dop_2.ship_type, View_Dop_2.[count]
FROM View_Dop_2
ORDER BY View_Dop_2.[count] DESC