

--Удалить капитанов - женщин, родившихся до 1970

DELETE CAPTAIN FROM CAPTAIN
JOIN GENDER on CAPTAIN.Gender_ID = GENDER.Gender_ID
WHERE CAPTAIN.Date_birth < CAST('1971-01-01' as date)
	and GENDER.Descreption = 'Ж'
