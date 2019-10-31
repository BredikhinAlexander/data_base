 
  --Определить, c какой целью чаще всего заходят корабли в порт 'Циньхуандао'.


SELECT TOP(1) WITH TIES DELIVERY.Descreption, COUNT(DELIVERY.Descreption) as Number_arrival
FROM TRIP
JOIN DELIVERY on DELIVERY.Delivery_ID = TRIP.Delivery_ID
JOIN ITINERARY on TRIP.Itinerary_ID = ITINERARY.Itinerary_ID
JOIN BERTH on ITINERARY.Berth_to_ID = BERTH.Berth_ID
JOIN [PORT] on BERTH.Port_ID = [PORT].Port_ID
JOIN CITY on CITY.City_ID = [PORT].City_ID
WHERE CITY.City = 'Циньхуандао'

GROUP BY DELIVERY.Descreption
ORDER BY Number_arrival



