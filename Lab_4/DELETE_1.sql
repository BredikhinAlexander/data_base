begin tran
-- удалить все поездки(трипы) корабл€  вант, которые были совершены за зиму 2015 года
SET DATEFORMAT YMD

DELETE OPERATION FROM OPERATION
JOIN TRIP on TRIP.Trip_ID = OPERATION.Trip_ID
JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID
WHERE SHIP.Name_ship = ' вант'
  and (TRIP.Date_departure BETWEEN '2015/12/01'  and '2016/03/01')
  and (TRIP.Date_arrival BETWEEN '2015/12/01'  and '2016/03/01')


DELETE TRIP FROM TRIP
JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID
WHERE SHIP.Name_ship = ' вант'
  and (TRIP.Date_departure BETWEEN '2015/12/01'  and '2016/03/01')
  and (TRIP.Date_arrival BETWEEN '2015/12/01'  and '2016/03/01')

  rollback