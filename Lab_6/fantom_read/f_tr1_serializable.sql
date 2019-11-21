USE Shipping

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION 

SELECT Trip_ID, Ship_ID, Date_departure, Date_arrival, Itinerary_ID
FROM TRIP
WHERE Delivery_ID = 1

-- в транзакции 2 не будет происходить добавление/удаление строк, пока не завершится эта транзакция
SELECT Trip_ID, Ship_ID, Date_departure, Date_arrival, Itinerary_ID
FROM TRIP
WHERE Delivery_ID = 1

COMMIT 