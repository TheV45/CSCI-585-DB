-- DB application used = SQLite | GUI used = DB Browser for SQLite
--Q2 (1 point). Write a query to output the most-self-reported symptom.

SELECT Symptom_id 
FROM Symptom 
GROUP BY Symptom_id
HAVING COUNT(Symptom_id)=
         (SELECT MAX(SymCount) 
		 FROM(SELECT  Count(Symptom_id) AS SymCount 
		               FROM Symptom 
					   GROUP BY (Symptom_id) ));