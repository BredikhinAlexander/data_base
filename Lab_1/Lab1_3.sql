--3)������� ������������ �������� ��� ������ �������--
SELECT 
	last_name,
	max(salary) AS Max_salary
FROM EMPLOYEE
where first_name like 'A%'
GROUP BY last_name
