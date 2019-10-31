 -- подсчитать суммарный вес грузов перевезённый в поездке на корабле Наутилус по маршруту, который отправлялся из порта Сингапура 2015-07-12

 SET DATEFORMAT YMD

 SELECT SUM(INVOICE_CARGO.Tonnage) as [Sum_tonnage]
 FROM OPERATION
 JOIN INVOICE_CARGO on INVOICE_CARGO.Cargo_ID = OPERATION.Cargo_ID
 JOIN TRIP on TRIP.Trip_ID = OPERATION.Trip_ID
 JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID
 JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
 JOIN BERTH on ITINERARY.Berth_from_ID = BERTH.Berth_ID
 JOIN [PORT] on [PORT].Port_ID = BERTH.Port_ID
 WHERE SHIP.Name_ship = 'Наутилус'
	and [PORT].Name_port = 'Порт Сингапура'
	and CAST(TRIP.Date_departure as date) ='2015-07-12'