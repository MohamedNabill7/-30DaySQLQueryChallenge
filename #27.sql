USE `#30daysqlquerychallenge`;

/*
PROBLEM STATEMENT: 
Given vacation_plans tables shows the vacations applied by each employee during the year 2024. Leave_balance table has the available leaves for each employee.
Write an SQL query to determine if the vacations applied by each employee can be approved or not based on the available leave balance. 
If an employee has enough available leaves then mention the status as "Approved" else mention "Insufficient Leave Balance".
Assume there are no public holidays during 2024. weekends (sat & sun) should be excluded while calculating vacation days. 
*/

CREATE TABLE vacation_plans
(
	id 			int primary key,
	emp_id		int,
	from_dt		date,
	to_dt		date
);

INSERT INTO vacation_plans 
VALUES
(1,1, '2024-02-12', '2024-02-16'),(2,2, '2024-02-20', '2024-02-29'),(3,3, '2024-03-01', '2024-03-31'),(4,1, '2024-04-11', '2024-04-23'),
(5,4, '2024-06-01', '2024-06-30'),(6,3, '2024-07-05', '2024-07-15'),(7,3, '2024-08-28', '2024-09-15');


CREATE TABLE leave_balance
(
	emp_id			int,
	balance			int
);

INSERT INTO leave_balance 
VALUES 
(1, 12),(2, 10),(3, 26),(4, 20),(5, 14);

--Solution:
WITH RECURSIVE Approved_Vacations AS
(
    WITH CTE AS
    (
        SELECT 
            vacation_plans.*,
            (DATEDIFF(to_dt, from_dt) + 1) -
            (WEEK(to_dt) - WEEK(from_dt)) * 2 -
            (CASE WHEN WEEKDAY(to_dt) IN (1,7) THEN 1 ELSE 0 END) AS Vacation_Days,
            balance,
            ROW_NUMBER() OVER(PARTITION BY emp_id ORDER BY from_dt) AS rn 
        FROM vacation_plans JOIN leave_balance
            ON  vacation_plans.emp_id = leave_balance.emp_id
    )
    SELECT *, balance - Vacation_Days AS Leave_Balance FROM CTE
    WHERE rn = 1
    UNION ALL
    SELECT
        CTE.*,Approved_Vacations.Leave_Balance - CTE.Vacation_Days AS Leave_Balance
    FROM Approved_Vacations JOIN CTE 
        ON  CTE.rn = Approved_Vacations.rn + 1 
            AND Approved_Vacations.emp_id = CTE.emp_id
) 
SELECT 
    id,emp_id,from_dt,to_dt,Vacation_Days,
    CASE WHEN Leave_Balance >= 0 THEN 'Approved' ELSE 'Insufficient Leave Balance' END AS STATUS
FROM Approved_Vacations;
 

