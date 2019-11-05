

--Порт приписки, количество корблей у этого порта, количество посещений этими кораблями порта Сингапура в 2017 году, 
--суммарный доход, полученный с этих кораблей.
USE Shipping

if (object_id ('View_2') IS NOT NULL)
	DROP VIEW View_2
GO

CREATE VIEW View_2 AS (
SELECT h_p.Name_port as [Port]
	,COUNT(h_p.Name_port) as [count_ships_of_this_port]
	,SUM(CASE WHEN [PORT].Name_port = 'Порт Сингапура' THEN 1 ELSE 0 end) as [count_visit_port]
	,SUM(CASE WHEN [PORT].Name_port = 'Порт Сингапура' THEN PRICE.Price_of_one_day ELSE 0 end) as [income]

FROM SHIP
JOIN BERTH as h_b on SHIP.Home_berth_ID = h_b.Berth_ID
JOIN [PORT] as h_p on h_p.Port_ID = h_b.Port_ID
JOIN TRIP on TRIP.Ship_ID = SHIP.Ship_ID
JOIN ITINERARY on TRIP.Itinerary_ID = ITINERARY.Itinerary_ID
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID
JOIN [PORT] on [PORT].Port_ID = BERTH.Port_ID

JOIN PRICE on PRICE.Berth_type_ID = BERTH.Berth_type_ID and PRICE.Ship_type_ID = SHIP.Ship_type_ID

WHERE TRIP.Date_arrival BETWEEN '2017/01/01'  and '2018/01/01'
 
GROUP BY h_p.Name_port)

GO
SELECT * FROM View_2


--какой расход у портов КНР от посещения их короблями порта Сингапура в 2017 году

SELECT SUM(View_2.income) as sum_expense
FROM View_2
JOIN [PORT] on View_2.[Port] = [PORT].Name_port
JOIN CITY on [PORT].City_ID = CITY.City_ID
JOIN COUNTRY on COUNTRY.Country_ID = CITY.Country_ID
WHERE COUNTRY.Country = 'КНР'

