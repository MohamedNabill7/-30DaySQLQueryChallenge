USE `#30daysqlquerychallenge`;

/*
Problem Statement:
Find length of comma seperated values in items field
*/

CREATE TABLE `Day#28`
(
    ID INT,
    ITEMS VARCHAR(30)
);

INSERT INTO `Day#28` 
VALUES
(1,'22,122,1022'),(2,',6,0,9999'),(3,'100,2000,2'),(4,'4,44,444,4444');

--Solution
WITH RECURSIVE CTE AS
(
    SELECT
        *,
        LENGTH(ITEMS) - LENGTH(REPLACE(ITEMS,',','')) + 1 AS COMMA_COUNT
    FROM `Day#28`
    UNION ALL
    SELECT
        ID,
        ITEMS,
        COMMA_COUNT - 1
    FROM CTE
    WHERE COMMA_COUNT > 1
), 
CTE2 AS
(
    SELECT
        *,
        LENGTH(SUBSTRING_INDEX(SUBSTRING_INDEX(ITEMS,',',COMMA_COUNT),',',-1)) AS WORD_LENGTH
    FROM CTE
)
SELECT ID,GROUP_CONCAT(WORD_LENGTH ORDER BY COMMA_COUNT) AS LENGTHS
FROM CTE2
GROUP BY ID