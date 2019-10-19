SELECT 
	TOP 1
	sal.order_date,
	pr.description,
	job.[function]
	FROM SALES_ORDER sal
inner join 
	ITEM it on it.order_id = sal.order_id
inner join
	PRODUCT pr on pr.product_id = it.product_id
inner join
	CUSTOMER cust on cust.customer_id = sal.customer_id
inner join
	EMPlOYEE emp on cust.salesperson_id = emp.employee_id
inner join
	JOB on job.job_id = emp.job_id
WHERE job.[function] = 'PRESIDENT'
ORDER BY order_date