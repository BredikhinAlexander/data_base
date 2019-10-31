--1
--Выбрать имена капитанов, приводивших корабли в 'Хедленд' зимой 2017-18 г.

SET DATEFORMAT YMD

SELECT First_name, Last_name, TRIP.Date_arrival, CITY.City_ID
FROM CAPTAIN
JOIN SHIP on SHIP.Captain_ID = CAPTAIN.Captain_ID
JOIN TRIP on TRIP.Ship_ID = SHIP.Ship_ID
JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
JOIN BERTH on BERTH.Berth_ID = ITINERARY.Berth_to_ID
JOIN [PORT] on [PORT].Port_ID = BERTH.Berth_ID
JOIN CITY on CITY.City_ID = [PORT].Port_ID
WHERE (CITY.City = 'Хедленд' and TRIP.Date_arrival BETWEEN '2018/12/01'  and '2019/03/01')
  
