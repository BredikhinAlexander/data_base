USE Shipping

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION

SELECT * FROM TRIP
WHERE Trip_ID = 1 and Ship_ID = 1

COMMIT

SELECT @@TRANCOUNT