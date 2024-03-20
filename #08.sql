USE `#30DaySQLQueryChallenge`;

/*
PROBLEM STATEMENT: 
In the given input table, there are rows with missing JOB_ROLE values. Write a query to fill in those blank fields with appropriate values.
Assume row_id is always in sequence and job_role field is populated only for the first skill.
*/						

CREATE TABLE `DAY#8`
(
ROW_ID INT,
JOB_ROLE VARCHAR(30),
SKILLS VARCHAR(30)
);

INSERT INTO `DAY#8`
VALUES
(1 , "Data Engineer",  "SQL"),
(2 ,NULL,  "Python"),
(3 ,NULL,	"AWS"),
(4 ,NULL,	"Snowflake"),
(5 ,NULL,	"Apache Spark"),
(6 , "Web Developer",	"Java"),
(7 ,NULL,	"HTML"),
(8 ,NULL,	"CSS"),
(9 ,"Data Scientist",	"Python"),
(10,NULL,	"Machine Learning"),
(11,NULL,	"Deep Learning"),
(12,NULL,	"Tableau");

SELECT
	 ROW_ID,
     CASE 
		WHEN JOB_ROLE IS NULL THEN FIRST_VALUE(JOB_ROLE) OVER(PARTITION BY Flag)
        ELSE JOB_ROLE
	END AS JOB_ROLE,
    SKILLS
FROM(
	select 
		*,
		SUM(CASE WHEN JOB_ROLE IS NULL THEN 0 ELSE 1 END) OVER(ORDER BY ROW_ID) AS Flag
	from `day#8`
    )TAB
