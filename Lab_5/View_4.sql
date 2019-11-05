--Страна, количестов портов, количество посещений страны за год, общий доход от посещений портов иностранными кораблями, 
--общая стоимость посещения кораблями этой страны иностранных портов, сальдо между доходами и расходами.

USE Shipping

-- количество посещений страны за год
if (object_id ('View_num_visits') IS NOT NULL)
	DROP VIEW View_num_visits
GO

CREATE VIEW View_num_visits AS (
SELECT COUNTRY.Country as [Country], COUNT(TRIP.Trip_ID) as [number_of_visits]
FROM TRIP
JOIN ITINERARY on TRIP.Itinerary_ID = ITINERARY.Itinerary_ID
JOIN BERTH on ITINERARY.Berth_to_ID = BERTH.Berth_ID
JOIN [PORT] on BERTH.Port_ID = [PORT].Port_ID
JOIN CITY on [PORT].City_ID = CITY.City_ID
JOIN COUNTRY on CITY.Country_ID = COUNTRY.Country_ID

GROUP BY COUNTRY.Country)

GO

-- количестов портов
if (object_id ('View_country_ports') IS NOT NULL)
	DROP VIEW View_country_ports
GO

CREATE VIEW View_country_ports AS (
SELECT COUNTRY.Country as [Country], COUNT([PORT].Name_port) as [Count_ports]
FROM COUNTRY 
JOIN CITY on CITY.Country_ID = COUNTRY.Country_ID
JOIN [PORT] on [PORT].City_ID = CITY.City_ID

GROUP BY COUNTRY.Country)

GO


-- общая стоимость посещения кораблями этой страны иностранных портов
if (object_id ('View_expense') IS NOT NULL)
	DROP VIEW View_expense
GO

CREATE VIEW View_expense AS (
SELECT Home_country.Country
	, SUM(PRICE.Price_of_one_day) AS Amount_of_money
FROM TRIP
JOIN SHIP on TRIP.Ship_ID = SHIP.Ship_ID
JOIN BERTH as Home_berth on Home_berth.Berth_ID = SHIP.Home_berth_ID
JOIN [PORT] as Home_port on Home_port.Port_ID = Home_berth.Port_ID
JOIN CITY as Home_city on Home_city.City_ID = Home_port.City_ID
JOIN COUNTRY as Home_country on Home_country.Country_ID = Home_city.Country_ID
JOIN ITINERARY on TRIP.Itinerary_ID = ITINERARY.Itinerary_ID
JOIN BERTH on ITINERARY.Berth_to_ID = BERTH.Berth_ID
JOIN [PORT] on [PORT].Port_ID = BERTH.Port_ID
JOIN CITY on [PORT].City_ID = CITY.City_ID
JOIN COUNTRY on CITY.Country_ID = COUNTRY.Country_ID and COUNTRY.Country_ID != Home_country.Country_ID
join PRICE on PRICE.Berth_type_ID = BERTH.Berth_type_ID and PRICE.Ship_type_ID = SHIP.Ship_type_ID
GROUP BY
	Home_country.Country)

GO

--SELECT * FROM View_expense
-- общий доход от посещений портов иностранными кораблями
if (object_id ('View_income') IS NOT NULL)
	DROP VIEW View_income
GO

CREATE VIEW View_income AS (
SELECT COUNTRY.Country
	, SUM(PRICE.Price_of_one_day) AS Amount_of_money
FROM TRIP
JOIN SHIP on TRIP.Ship_ID = SHIP.Ship_ID
JOIN BERTH as Home_berth on Home_berth.Berth_ID = SHIP.Home_berth_ID
JOIN [PORT] as Home_port on Home_port.Port_ID = Home_berth.Port_ID
JOIN CITY as Home_city on Home_city.City_ID = Home_port.City_ID
JOIN COUNTRY as Home_country on Home_country.Country_ID = Home_city.Country_ID
JOIN ITINERARY on TRIP.Itinerary_ID = ITINERARY.Itinerary_ID
JOIN BERTH on ITINERARY.Berth_to_ID = BERTH.Berth_ID
JOIN [PORT] on [PORT].Port_ID = BERTH.Port_ID
JOIN CITY on [PORT].City_ID = CITY.City_ID
JOIN COUNTRY on CITY.Country_ID = COUNTRY.Country_ID and COUNTRY.Country_ID != Home_country.Country_ID
join PRICE on PRICE.Berth_type_ID = BERTH.Berth_type_ID and PRICE.Ship_type_ID = SHIP.Ship_type_ID
GROUP BY
	COUNTRY.Country)

GO


--Страна, количестов портов, количество посещений страны за год, общий доход от посещений портов иностранными кораблями, 
--общая стоимость посещения кораблями этой страны иностранных портов, сальдо между доходами и расходами.
if (object_id ('View_4') IS NOT NULL)
	DROP VIEW View_4
GO

CREATE VIEW View_4 AS (
SELECT View_country_ports.Country as [Country]
	,View_country_ports.Count_ports as [Number_of_ports]
	,View_income.Amount_of_money as [Income_of_port]
	,View_expense.Amount_of_money as [Expense_of_port]
	,View_income.Amount_of_money - View_expense.Amount_of_money as [Saldo]
FROM View_country_ports
LEFT JOIN View_num_visits on View_num_visits.Country = View_country_ports.Country
LEFT JOIN View_income on View_income.Country = View_country_ports.Country
LEFT JOIN View_expense on View_expense.Country = View_country_ports.Country)

GO

SELECT * FROM View_4


--какие страны заработали больше всех
SELECT TOP(1) WITH TIES View_4.Country, View_4.Saldo as [earnings]
FROM View_4
WHERE View_4.Saldo IS NOT NULL
ORDER BY View_4.Saldo DESC
