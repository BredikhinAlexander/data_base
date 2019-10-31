
-- изменить тоннаж у типов кораблей сухогрузный

UPDATE SHIP_TYPE
SET SHIP_TYPE.Tonnage = 9000
WHERE Ship_type_ID in 
(SELECT SHIP_TYPE.Ship_type_ID
 FROM SHIP_TYPE
 WHERE SHIP_TYPE.Name_ship = 'сухогрузный')
