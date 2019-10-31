
-- вывести в порядке убывания колтчество отправлений с каждого порта за 2017 год

 SELECT  [PORT].Name_port, COUNT(*) as [Number_depature]
 FROM TRIP 
 JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
 JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_from_ID
 JOIN [PORT] on [PORT].Port_ID = BERTH.Port_ID
 WHERE TRIP.Date_departure BETWEEN '2017/01/01'  and '2018/01/01'
 GROUP BY [PORT].Name_port
 ORDER BY Number_depature DESC