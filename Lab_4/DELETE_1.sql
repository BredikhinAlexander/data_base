begin tran
-- ������� ��� �������(�����) ������� �����, ������� ���� ��������� �� ���� 2015 ����
SET DATEFORMAT YMD

DELETE OPERATION FROM OPERATION
JOIN TRIP on TRIP.Trip_ID = OPERATION.Trip_ID
JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID
WHERE SHIP.Name_ship = '�����'
  and (TRIP.Date_departure BETWEEN '2015/12/01'  and '2016/03/01')
  and (TRIP.Date_arrival BETWEEN '2015/12/01'  and '2016/03/01')


DELETE TRIP FROM TRIP
JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID
WHERE SHIP.Name_ship = '�����'
  and (TRIP.Date_departure BETWEEN '2015/12/01'  and '2016/03/01')
  and (TRIP.Date_arrival BETWEEN '2015/12/01'  and '2016/03/01')

  rollback