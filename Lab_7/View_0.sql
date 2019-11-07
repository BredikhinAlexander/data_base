USE Shipping

-- Название порта и его категория (для Lab_7)
if (object_id ('View_0') IS NOT NULL)
	DROP VIEW View_0
GO

CREATE VIEW View_0 AS (
SELECT [PORT].Name_port as Name_port, BERTH_TYPE.Category as port_category
FROM TRIP
JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID
JOIN [PORT] on [PORT].Port_ID = BERTH.Port_ID
JOIN BERTH_TYPE on BERTH_TYPE.Berth_type_ID = BERTH.Berth_type_ID)

GO

SELECT * FROM View_0