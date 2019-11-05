
--Порт, категория, месяц, количество кораблей, посетивших порт в данный месяц для 2017 года
if (object_id ('View_3') IS NOT NULL)
	DROP VIEW View_3
GO

CREATE VIEW View_3 AS (
SELECT [PORT].Name_port as Name_port, BERTH_TYPE.Category as port_category
		,MONTH(TRIP.Date_departure) as [Month]
		,COUNT(*) as Num_ships
FROM TRIP
JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID
JOIN [PORT] on [PORT].Port_ID = BERTH.Port_ID
JOIN BERTH_TYPE on BERTH_TYPE.Berth_type_ID = BERTH.Berth_type_ID
WHERE TRIP.Date_departure BETWEEN CAST('2017-01-01' AS DATE) AND CAST('2017-12-31' AS DATE)

GROUP BY [PORT].Name_port, BERTH_TYPE.Category, MONTH(TRIP.Date_departure)) 

GO
SELECT * FROM View_3

-- определить порты которые посетили чаще одного раза в месяц в 2017 году
SELECT View_3.[Name_port] as [Port], View_3.[Month], View_3.Num_ships as Number_of_visits
FROM View_3
WHERE View_3.Num_ships >= 2