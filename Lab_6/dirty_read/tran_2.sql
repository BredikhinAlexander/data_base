USE Shipping

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRANSACTION

UPDATE TRIP
SET Date_arrival = '20/05/2018 17:17:30'
WHERE Trip_ID = 1 and Ship_ID = 1

ROLLBACK

SELECT * FROM TRIP
WHERE Trip_ID = 1 and Ship_ID = 1