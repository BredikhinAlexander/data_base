USE Shipping

SET TRANSACTION ISOLATION LEVEL READ COMMITTED
BEGIN TRANSACTION 

SELECT Trip_ID, Ship_ID, Date_departure, Date_arrival, Itinerary_ID
FROM TRIP
WHERE Delivery_ID = 1

--����� UPDATE � ���������� 2 � ������� ��������� ���� ������
SELECT Trip_ID, Ship_ID, Date_departure, Date_arrival, Itinerary_ID
FROM TRIP
WHERE Delivery_ID = 1


--����� ���������� ���������
SELECT Trip_ID, Ship_ID, Date_departure, Date_arrival, Itinerary_ID
FROM TRIP
WHERE Delivery_ID = 1

COMMIT 