--Потеря изменений 2
USE Shipping

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

BEGIN TRANSACTION 
DECLARE @delivery INT
SELECT @delivery = [Delivery_ID] FROM TRIP
WHERE Trip_ID = 4

SELECT [Delivery_ID] as [DeliveryID_beforeUPDATE] FROM TRIP
WHERE Trip_ID = 4

UPDATE TRIP
SET [Delivery_ID] = @delivery + 2
WHERE Trip_ID = 4

COMMIT

SELECT [Delivery_ID] as [DeliveryID_afterUPDATE] FROM TRIP
WHERE Trip_ID = 4