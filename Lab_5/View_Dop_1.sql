USE Shipping



if (object_id ('View_Dop_1') IS NOT NULL)
	DROP VIEW View_Dop_1
GO

CREATE VIEW View_Dop_1 AS (
SELECT ITINERARY.Itinerary_ID as [Num_itinerary]
	, SUM(INVOICE_CARGO.Tonnage) as [sum_tonnage]
	, SUM(PRICE.Price_of_one_day) as [Cost]
	
FROM ITINERARY
JOIN TRIP on TRIP.Itinerary_ID = ITINERARY.Itinerary_ID
JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID
JOIN OPERATION on OPERATION.Trip_ID = TRIP.Trip_ID
JOIN INVOICE_CARGO on INVOICE_CARGO.Cargo_ID = OPERATION.Cargo_ID
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID 

JOIN PRICE on PRICE.Berth_type_ID = BERTH.Berth_type_ID and PRICE.Ship_type_ID = SHIP.Ship_ID

GROUP BY ITINERARY.Itinerary_ID)

GO

SELECT * FROM View_Dop_1