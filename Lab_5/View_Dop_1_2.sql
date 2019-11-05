USE Shipping


if (object_id ('View_Dop_1_2') IS NOT NULL)
	DROP VIEW View_Dop_1_2
GO

CREATE VIEW View_Dop_1_2 AS (
SELECT ITINERARY.Itinerary_ID as [num_itinerary], SHIP_TYPE.Name_ship as [ship_type]
	,COUNT(SHIP.Ship_type_ID) as [count]
	, SUM(INVOICE_CARGO.Tonnage) as [sum_tonnage]
	, SUM(PRICE.Price_of_one_day) as [Cost]
FROM TRIP
JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID
JOIN OPERATION on OPERATION.Trip_ID = TRIP.Trip_ID
JOIN INVOICE_CARGO on INVOICE_CARGO.Cargo_ID = OPERATION.Cargo_ID
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID 
JOIN SHIP_TYPE on SHIP_TYPE.Ship_type_ID = SHIP.Ship_type_ID

JOIN PRICE on PRICE.Berth_type_ID = BERTH.Berth_type_ID and PRICE.Ship_type_ID = SHIP.Ship_ID

GROUP BY SHIP_TYPE.Name_ship, ITINERARY.Itinerary_ID)

GO
/*
SELECT --TOP(1) WITH TIES 
	View_Dop_1_2.num_itinerary, View_Dop_1_2.ship_type, View_Dop_1_2.[count]
	,View_Dop_1_2.sum_tonnage
	,View_Dop_1_2.Cost
FROM View_Dop_1_2
ORDER BY View_Dop_1_2.[count] DESC
*/
GO


SELECT S.Itinerary
	,S.[Type]
	,MAX(S.[count]) as [max]
FROM
(SELECT ITINERARY.Itinerary_ID as [Itinerary]
	,SHIP.Ship_type_ID as [Type]
	,COUNT(Ship_type_ID) as [count]
FROM TRIP
JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID

GROUP BY SHIP.Ship_type_ID, ITINERARY.Itinerary_ID) as S

GROUP BY S.Itinerary, S.[Type]




