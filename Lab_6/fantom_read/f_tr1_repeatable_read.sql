USE Shipping

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION 

SELECT Trip_ID, Ship_ID, Date_departure, Date_arrival, Itinerary_ID
FROM TRIP
WHERE Delivery_ID = 1

--после Insert в транзакции 2 появится ещё одна строка
SELECT Trip_ID, Ship_ID, Date_departure, Date_arrival, Itinerary_ID
FROM TRIP
WHERE Delivery_ID = 1


--после Delete в транзакции 2 уберётся добавленная строка
SELECT Trip_ID, Ship_ID, Date_departure, Date_arrival, Itinerary_ID
FROM TRIP
WHERE Delivery_ID = 1

COMMIT 