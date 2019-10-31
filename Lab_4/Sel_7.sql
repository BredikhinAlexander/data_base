--вывести первую поездку самого опытного капитана(больше всего поездок)


SELECT TOP(1) TRIP.Trip_ID, SHIP.Name_ship, TRIP.Date_departure
FROM TRIP 
JOIN SHIP on TRIP.Ship_ID = SHIP.Ship_ID
JOIN CAPTAIN on SHIP.Captain_ID = CAPTAIN.Captain_ID,

------- выбираем самого опытного капитана
(SELECT TOP(1) CAPTAIN.First_name, CAPTAIN.Last_name, COUNT(*) as [Number_trip]
FROM TRIP 
JOIN SHIP on TRIP.Ship_ID = SHIP.Ship_ID
JOIN CAPTAIN on SHIP.Captain_ID = CAPTAIN.Captain_ID

GROUP BY CAPTAIN.First_name, CAPTAIN.Last_name
ORDER BY Number_trip DESC) as CAP
------

WHERE CAP.First_name = CAPTAIN.First_name
	and CAP.Last_name = CAPTAIN.Last_name
ORDER BY TRIP.Date_departure