

UPDATE CAPTAIN 
SET CAPTAIN.Qualification_ID = (TAb.New_Qualification)

FROM 
(SELECT CAPTAIN.Last_name, CAP.Num_trip, Num_trip / 5 + 1 as [New_Qualification] FROM CAPTAIN
JOIN 
(SELECT CAPTAIN.Last_name, COUNT(*) as [Num_trip]
FROM TRIP 
JOIN SHIP on TRIP.Ship_ID = SHIP.Ship_ID
JOIN CAPTAIN on SHIP.Captain_ID = CAPTAIN.Captain_ID
GROUP BY CAPTAIN.Last_name) as CAP
on CAP.Last_name = CAPTAIN.Last_name) as TAb
WHERE TAb.Last_name = CAPTAIN.Last_name

SELECT * FROM CAPTAIN 