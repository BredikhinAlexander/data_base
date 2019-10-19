--2)¬ывести цены всех продуктов, реализованных через п€ть лет, когда поступил на работу 'WEST'--
SELECT DISTINCT
	list_price
FROM PRICE price
inner join ITEM it on price.product_id = it.product_id
inner join SALES_ORDER sal on sal.order_id = it.order_id
inner join CUSTOMER cust on cust.customer_id = sal.customer_id
inner join EMPlOYEE emp on cust.salesperson_id = emp.employee_id
WHERE	emp.last_name = 'WEST' 
		and year(emp.hire_date) + 5 = year(sal.order_date)


select year('31-12-1990') - year('1-1-1991')