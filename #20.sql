USE `#30daysqlquerychallenge`;

/*
PROBLEM STATEMENT:
Find the median ages of countries												
*/
CREATE TABLE `Day#20`
(
ID INT,
COUNTRY VARCHAR(20),
AGE INT
);

INSERT INTO `Day#20`
VALUES
(1,	"Poland",10),(2,"Poland",5),(3,"Poland",34),(4,"Poland",56),(5,"Poland",45),(6,"Poland",60),
(7,"India",18),(8,"India",15),(9,"India",33),(10,"India",38),(11,"India",40),(12,"India",50),
(13,"USA",20),(14,"USA",23),(15,"USA",32),(16,"USA",54),(17,"USA",55),(18,"Japan"	,65),
(19,"Japan"	,6),(20,"Japan"	,58),(21,"Germany"	,54),(22,"Germany"	,6),(23,"Malaysia"	,44);

--Solution:
WITH RankedData AS
(
    SELECT
        COUNTRY,
        AGE,
        ROW_NUMBER() OVER(PARTITION BY COUNTRY ORDER BY AGE) AS R,
        COUNT(*) OVER(PARTITION BY COUNTRY) AS TOT_ROWS
    FROM `Day#20`
    ORDER BY COUNTRY
)
SELECT 
    COUNTRY,
    AGE
FROM RankedData
WHERE R IN (CEILING(TOT_ROWS / 2.0), FLOOR(TOT_ROWS / 2.0) + 1);
