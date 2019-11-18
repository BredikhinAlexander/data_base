BEGIN TRAN

INSERT [TRIP] ([Ship_ID], [Date_departure], [Date_arrival], [Itinerary_ID], [Delivery_ID]) 
VALUES ( 6 , '01/10/2017 01:14:31', '05/12/2017 01:14:31' , 99 , 4 ) -- не должно вставляться
	   ,( 1 , '01/11/2018 01:14:31', '05/12/2018 10:14:39' , 209 , 3 )  
	   ,( 5 , '01/10/2017 01:14:31', '05/12/2017 01:14:31' , 1902 , 2 )

GO



UPDATE TRIP -- не должен изменит, так как маршрут ведёт в неподходящий порт
SET Itinerary_ID = 99
WHERE Trip_ID = 5

GO
SELECT * FROM 
 ITINERARY 
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID
JOIN BERTH_TYPE on BERTH_TYPE.Berth_type_ID = BERTH.Berth_type_ID
WHERE ITINERARY.Itinerary_ID = 99

UPDATE TRIP --изменяет маршрут
SET Itinerary_ID = 2619
WHERE Trip_ID = 4



SELECT TOP 5 * 
FROM TRIP 
ORDER BY Trip_ID DESC
;

GO

SELECT TRIP.Trip_ID, SHIP.Ship_ID, ITINERARY.Itinerary_ID, SHIP_TYPE.Tonnage, BERTH_TYPE.Max_tonnage
FROM TRIP
JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID
JOIN SHIP_TYPE on SHIP_TYPE.Ship_type_ID = SHIP.Ship_type_ID
JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID
JOIN BERTH_TYPE on BERTH_TYPE.Berth_type_ID = BERTH.Berth_type_ID
--WHERE (SHIP_TYPE.Tonnage > 1000) and (BERTH_TYPE.Max_tonnage < 100)
ORDER BY TRIP.Trip_ID
;

ROLLBACK