USE Shipping

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRANSACTION 

SELECT Trip_ID, Ship_ID, Date_departure, Date_arrival, Itinerary_ID
FROM TRIP
WHERE Delivery_ID = 1

--транзакция 2 не изменяет данные, пока не завершится эта транзакция 
SELECT Trip_ID, Ship_ID, Date_departure, Date_arrival, Itinerary_ID
FROM TRIP
WHERE Delivery_ID = 1

COMMIT 