DECLARE @VAL INT
SET @VAL = (SELECT COUNT(*) FROM CAPTAIN)
WHILE @VAL > 0
	BEGIN
		UPDATE CAPTAIN
		SET Qualification_ID = (SELECT COUNT(*) / 5 + 1
FROM TRIP
JOIN SHIP on TRIP.Ship_ID = SHIP.Ship_ID
JOIN CAPTAIN  C on SHIP.Captain_ID = C.Captain_ID
WHERE C.Captain_ID = @VAL) WHERE CAPTAIN.Captain_ID = @VAL
	SET @VAL = @VAL - 1
	END;

SELECT * FROM CAPTAIN