--Потеря изменений 1
USE Shipping

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

BEGIN TRANSACTION 
DECLARE @delivery INT
SELECT @delivery = [Delivery_ID] FROM TRIP
WHERE Trip_ID = 4

SELECT [Delivery_ID] as [DeliveryID_beforeUPDATE] FROM TRIP
WHERE Trip_ID = 4

WAITFOR DELAY '00:00:10'

UPDATE TRIP
SET [Delivery_ID] = @delivery + 1
WHERE Trip_ID = 4

COMMIT

SELECT [Delivery_ID] as [DeliveryID_afterUPDATE] FROM TRIP
WHERE Trip_ID = 4

--SELECT @@TRANCOUNT