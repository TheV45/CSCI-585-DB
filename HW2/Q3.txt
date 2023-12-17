-- DB application used = SQLite | GUI used = DB Browser for SQLite
--Q3 (1 point). Write a query to output the 'sickest' floor.

-- Query 1 : In this query for finding the sickest floor I have only considered employees whose current status is "sick"	
																			   
SELECT e.Employee_floor_no FROM Health_Status h INNER JOIN Employee e
ON h.Employee_id = e.Employee_id
WHERE h.Current_status = "sick"
GROUP BY e.Employee_floor_no
HAVING COUNT(*) =
            (SELECT MAX(sick_count) 
			  FROM(SELECT COUNT(*) as sick_count 
			                FROM Health_Status h1 INNER JOIN Employee e1
                            ON h1.Employee_id = e1.Employee_id
                            WHERE h1.Current_status = "sick"
                            GROUP BY e1.Employee_floor_no) );


-- Query 2 : In this query for finding the sickest floor I have considered that employees whose current status is "hospitalized" are also sick

SELECT emp1.Employee_floor_no
FROM Employee emp1
WHERE emp1.Employee_id IN 
(SELECT DISTINCT e1.Employee_id 
FROM Employee e1 JOIN Health_Status h1
ON e1.Employee_id=h1.Employee_id
WHERE h1.Current_status="sick" OR h1.Current_status="hospitalized")
GROUP BY emp1.Employee_floor_no
HAVING COUNT(emp1.Employee_id) = 
           (SELECT MAX(Employee_count) 
		   FROM(SELECT COUNT(emp.Employee_id) as Employee_count 
                          FROM Employee emp 
                          WHERE emp.Employee_id IN (SELECT DISTINCT e.Employee_id 
                                                                                       FROM Employee e JOIN Health_Status h
                                                                                       ON e.Employee_id=h.Employee_id
                                                                                       WHERE h.Current_status="sick" OR h.Current_status="hospitalized")
                                                                                       GROUP BY emp.Employee_floor_no));
																					   
																					   

