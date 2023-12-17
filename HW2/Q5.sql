-- DB application used = SQLite | GUI used = DB Browser for SQLite
--Q5 (1 point). Create your own query! What else would you like to learn, from the data?
--Note: I have created a query for getting the names and ID's of employees who have self-reported for all the 5 symptoms and I have used the Division for that

Select DISTINCT e1.Employee_id,e1.Employee_name
From Symptom as s1 JOIN Employee e1
ON e1.Employee_id=s1.Employee_id
WHERE NOT EXISTS
(
    SELECT sym.Symptom_id
	FROM 
	(SELECT DISTINCT Symptom_id FROM Symptom) sym
	WHERE NOT EXISTS
	(
	   SELECT s2.Symptom_id
	   FROM Symptom as s2
	   WHERE s2.Employee_id=s1.Employee_id
	   AND s2.Symptom_id=sym.Symptom_id
	)
)
