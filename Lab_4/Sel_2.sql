--2
--Определить, когда и с какой целью судно "Людмила" посещало порт Южная Луизиана.

SELECT SHIP.Name_ship, DELIVERY.Descreption, TRIP.Date_arrival, CITY.City 
FROM TRIP
JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID
JOIN DELIVERY on DELIVERY.Delivery_ID = TRIP.Delivery_ID
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID
JOIN [PORT] on [PORT].Port_ID = BERTH.Port_ID
JOIN CITY on CITY.City_ID = [PORT].City_ID
WHERE CITY.City = 'Южная Луизиана' and SHIP.Name_ship = 'Людмила'