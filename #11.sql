USE `#30daysqlquerychallenge`;
/*
"PROBLEM STATEMENT:
In the given input table, there are hotel ratings which are either too high or too low compared to the standard ratings the hotel receives each year.
Write a query to identify and exclude these outlier records as shown in expected output below. 		
*/
create table `day#11`
(
    Hotel      VARCHAR(30),
    Year     INT,
    Rating       FLOAT
);

insert into `day#11` 
values 
('Radisson Blu' , 2020, 4.8)
,('Radisson Blu', 2021, 3.5)
,('Radisson Blu' , 2022, 3.2)
,('Radisson Blu' , 2023, 3.4)
,('InterContinental' , 2020, 4.2)
,('InterContinental', 2021, 4.5)
,('InterContinental', 2022, 1.5)
,('InterContinental' , 2023, 3.8);

-- Solution

WITH CTE AS(
SELECT *, ROUND(AVG(Rating) OVER(PARTITION BY Hotel ORDER BY Year RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING),2) AS Avg_Rating
FROM `day#11`) 

SELECT Hotel, Year, Rating 
FROM(
	SELECT *, RANK() OVER(PARTITION BY Hotel ORDER BY ROUND(ABS(Rating - Avg_Rating),2) DESC) AS X FROM CTE
	) TAB
WHERE X > 1
ORDER BY Hotel DESC, Year ASC