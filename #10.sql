USE `#30daysqlquerychallenge`;

/*
Returns the data like the following
                      Level
Velocity    good        wrong        regular
50          0             1             0
70          0             1             0
80          1             0             1
90          2             0             0
*/

CREATE TABLE auto_repair
(
	client			varchar(20),
	auto			varchar(20),
	repair_date		int,
	indicator		varchar(20),
	value			varchar(20)
);

INSERT INTO auto_repair 
VALUES
('c1','a1',2022,'level','good'),('c1','a1',2022,'velocity','90'),('c1','a1',2023,'level','regular'),
('c1','a1',2023,'velocity','80'),('c1','a1',2024,'level','wrong'),('c1','a1',2024,'velocity','70'),
('c2','a1',2022,'level','good'),('c2','a1',2022,'velocity','90'),('c2','a1',2023,'level','wrong'),
('c2','a1',2023,'velocity','50'),('c2','a2',2024,'level','good'),('c2','a2',2024,'velocity','80');

--SOLUTION
WITH CTE_NUMBERS AS
(
    SELECT * FROM auto_repair
    WHERE value IN ('50', '70', '80', '90')
), CTE_Exp AS
(
    SELECT * FROM auto_repair
    WHERE value IN ('good', 'wrong', 'regular')
)
SELECT 
    CTE_NUMBERS.value AS Velocity, 
    SUM(CASE WHEN CTE_Exp.value = 'good' THEN 1 ELSE 0 END) AS good,
    SUM(CASE WHEN CTE_Exp.value = 'wrong' THEN 1 ELSE 0 END) AS wrong,
    SUM(CASE WHEN CTE_Exp.value = 'regular' THEN 1 ELSE 0 END) AS regular
FROM CTE_NUMBERS JOIN CTE_Exp
    ON CTE_NUMBERS.client = CTE_Exp.client AND CTE_NUMBERS.auto = CTE_Exp.auto AND CTE_NUMBERS.repair_date = CTE_Exp.repair_date
GROUP BY CTE_NUMBERS.value
ORDER BY CTE_NUMBERS.value ASC;
