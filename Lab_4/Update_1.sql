--��������� � ������� '��������' ����  � �������� '���� ���������� - ���� ����'

begin tran

 SELECT SHIP.Name_ship, Port_from.Name_port, Port_to.Name_port, DELIVERY.Delivery_ID, DELIVERY.Descreption
 FROM TRIP
 JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
 JOIN BERTH as Berth_from on Berth_from.Berth_ID = ITINERARY.Berth_from_ID
 JOIN BERTH as Berth_to on Berth_to.Berth_ID = ITINERARY.Berth_to_ID
 JOIN [PORT] as Port_from on Port_from.Port_ID = Berth_from.Berth_ID
 JOIN [PORT] as Port_to on Port_to.Port_ID = Berth_to.Berth_ID
 JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID
 JOIN DELIVERY on DELIVERY.Delivery_ID = TRIP.Delivery_ID
 WHERE Port_from.Name_port = '���� ����������' and 
	   Port_to.Name_port = '���� ����' and
	   SHIP.Name_ship = '��������'


 UPDATE TRIP 
 SET Delivery_ID = (SELECT Delivery_ID FROM DELIVERY WHERE Descreption = '��������')
 FROM TRIP
 JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
 JOIN BERTH as Berth_from on Berth_from.Berth_ID = ITINERARY.Berth_from_ID
 JOIN BERTH as Berth_to on Berth_to.Berth_ID = ITINERARY.Berth_to_ID
 JOIN [PORT] as Port_from on Port_from.Port_ID = Berth_from.Berth_ID
 JOIN [PORT] as Port_to on Port_to.Port_ID = Berth_to.Berth_ID
 JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID
 WHERE Port_from.Name_port = '���� ����������' and 
	   Port_to.Name_port = '���� ����' and
	   SHIP.Name_ship = '��������'


 SELECT SHIP.Name_ship, Port_from.Name_port, Port_to.Name_port, DELIVERY.Delivery_ID, DELIVERY.Descreption
 FROM TRIP
 JOIN ITINERARY on ITINERARY.Itinerary_ID = TRIP.Itinerary_ID
 JOIN BERTH as Berth_from on Berth_from.Berth_ID = ITINERARY.Berth_from_ID
 JOIN BERTH as Berth_to on Berth_to.Berth_ID = ITINERARY.Berth_to_ID
 JOIN [PORT] as Port_from on Port_from.Port_ID = Berth_from.Berth_ID
 JOIN [PORT] as Port_to on Port_to.Port_ID = Berth_to.Berth_ID
 JOIN SHIP on SHIP.Ship_ID = TRIP.Ship_ID
 JOIN DELIVERY on DELIVERY.Delivery_ID = TRIP.Delivery_ID
 WHERE Port_from.Name_port = '���� ����������' and 
	   Port_to.Name_port = '���� ����' and
	   SHIP.Name_ship = '��������'

	   rollback