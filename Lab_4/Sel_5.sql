--вывести страну, в которой было произведено больше всего кораблей

SELECT TOP(1) WITH TIES COUNTRY.Country, COUNT(*) as [Number_of_ships]
FROM SHIP 
JOIN VEHICLE_MANUFACTURER on SHIP.Vehicle_manufacturer_ID = VEHICLE_MANUFACTURER.Vehicle_manufacturer_ID
JOIN CITY on VEHICLE_MANUFACTURER.City_ID = CITY.City_ID
JOIN COUNTRY on CITY.Country_ID = COUNTRY.Country_ID

GROUP BY COUNTRY.Country
ORDER BY [Number_of_ships] DESC
