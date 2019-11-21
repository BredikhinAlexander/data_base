USE Shipping

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION 

SELECT Trip_ID, Ship_ID, Date_departure, Date_arrival, Itinerary_ID
FROM TRIP
WHERE Delivery_ID = 1

--после UPDATE в транзакции 2 в выборке изменится одна строка
SELECT Trip_ID, Ship_ID, Date_departure, Date_arrival, Itinerary_ID
FROM TRIP
WHERE Delivery_ID = 1


--снова произуйдут изменения
SELECT Trip_ID, Ship_ID, Date_departure, Date_arrival, Itinerary_ID
FROM TRIP
WHERE Delivery_ID = 1

COMMIT 