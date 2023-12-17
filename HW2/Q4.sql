-- DB application used = SQLite | GUI used = DB Browser for SQLite
--Q4 (1 point). The management would like stats, for a given period (between start, end dates), on the following: number of scans, number of tests, number of employees who self-reported symptoms, number of positive cases. Write queries to output these.

SELECT (
	SELECT COUNT(*)
	FROM Scan
    WHERE Scan_date  BETWEEN "2023-08-01" AND "2023-08-20"
) AS Total_Scan_Count, (
	SELECT COUNT(*)
	FROM Test
    WHERE Test_date BETWEEN  "2023-08-01" AND "2023-08-20"
) AS Total_Test_Count, (
	SELECT COUNT( DISTINCT employee_id)
	FROM Symptom
    WHERE Date_reported BETWEEN  "2023-08-01" AND "2023-08-20"
) AS Total_Self_Report, (
	SELECT COUNT(*)
	FROM Test
    WHERE Test_result="Positive" AND Test_date BETWEEN "2023-08-01" AND "2023-08-20"
) AS Total_Covid_Cases;