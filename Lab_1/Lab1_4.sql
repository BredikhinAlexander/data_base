--Определить, сколько в среднем подчиненных приходится на одного менеджера
SELECT 
CAST (COUNT (DISTINCT Employee_ID) AS numeric) / COUNT (DISTINCT Manager_ID) 
AS average_number
FROM EMPLOYEE emp
inner join
	JOB on job.job_id = emp.job_id
WHERE job.[function] = 'MANAGER'
--WHERE Manager_ID is not NULL