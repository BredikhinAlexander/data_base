--1)������� ������� ��������+����������� ���������, ������� ����������� ����������� �� ����� 'MN' (���������)
SELECT 
	AVG(emp.salary + emp.commission) as average
	FROM EMPLOYEE emp
inner join 
	CUSTOMER cust
on 
	emp.employee_id = cust.salesperson_id 
	WHERE cust.state = 'MN'

