USE Shipping

--грузы, которые вывозил корабль ... из порта Нинбо


 SELECT INVOICE_CARGO.Descreption, SUM(INVOICE_CARGO.Tonnage) as [Tonnage_of_cargo]
 FROM OPERATION 
 JOIN INVOICE_CARGO on OPERATION.Cargo_ID = INVOICE_CARGO.Cargo_ID
 JOIN TRIP on OPERATION.Trip_ID = TRIP.Trip_ID
 JOIN SHIP on TRIP.Ship_ID = SHIP.Ship_ID
 JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
 JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_from_ID
 JOIN [PORT] on BERTH.Port_ID = [PORT].Port_ID
 JOIN CITY on CITY.City_ID =  [PORT].City_ID
 JOIN DELIVERY on TRIP.Delivery_ID = DELIVERY.Delivery_ID
 
 WHERE DELIVERY.Descreption = 'загрузка'
	and [PORT].Name_port = 'Порт Нинбо'
	and SHIP.Name_ship = 'Дункан'

GROUP BY INVOICE_CARGO.Descreption

 