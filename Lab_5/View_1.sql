
USE Shipping


--Порт, корабль, капитан, цель посещения, время нахождения в пути только для Японии
if (object_id ('View_1') IS NOT NULL)
	DROP VIEW View_1
GO

CREATE VIEW View_1 AS (
SELECT [PORT].Name_port as Port_to, SHIP.Name_ship as Ship, CAPTAIN.Last_name as Captain, DELIVERY.Descreption as Purpose, COUNTRY.Country as Country
		,DATEDIFF(DAY, TRIP.Date_departure, TRIP.Date_arrival) AS Travel_time
FROM TRIP
JOIN SHIP on SHIP.Ship_ID = TRIP.Trip_ID
JOIN CAPTAIN on CAPTAIN.Captain_ID = SHIP.Captain_ID
JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID
JOIN [PORT] on [PORT].Port_ID = BERTH.Port_ID
JOIN CITY on CITY.City_ID = [PORT].City_ID
JOIN COUNTRY on COUNTRY.Country_ID = CITY.City_ID
JOIN DELIVERY on DELIVERY.Delivery_ID = TRIP.Delivery_ID
WHERE COUNTRY.Country = 'Япония')

GO
SELECT * FROM View_1



-- корабль, производитель и капитан коробля, который находился дольше всего в пути до Японии

SELECT TOP(1) VEHICLE_MANUFACTURER.Name_manufacturer, View_1.Captain,  View_1.Ship
FROM View_1
JOIN SHIP on View_1.Ship = SHIP.Name_ship
JOIN VEHICLE_MANUFACTURER on VEHICLE_MANUFACTURER.Vehicle_manufacturer_ID = SHIP.Vehicle_manufacturer_ID

ORDER BY View_1.Travel_time DESC 