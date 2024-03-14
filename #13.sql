USE `#30daysqlquerychallenge`;

/*
PROBLEM STATEMENT: Find out the no of employees managed by each manager.		
*/
CREATE TABLE `Day#13`
(
    ID INT,
    NAME VARCHAR(30),
    MANAGER INT
);

INSERT INTO `Day#13` VALUES
(1,	'Sundar',	NULL),
(2,	'Kent',	1),
(3,	'Ruth',	1),
(4,	'Alison',	1),
(5,	'Clay',	2),
(6,	'Ana',	2),
(7,	'Philipp',	3),
(8,	'Prabhakar',	4),
(9 ,'Hiroshi',	4),
(10,'Jeff',	4),
(11,'Thomas',	1),
(12,'John',	15),
(13,'Susan',	15),
(14,'Lorraine',	15),
(15,'Larry',	1);

-- Solution
SELECT 
    `Day#13`.NAME AS MANAGER,
    TAB.NO_OF_EMPLOYEES
FROM
(
    SELECT 
        Y.`MANAGER` AS MANAGER_ID, COUNT(X.`ID`) AS NO_OF_EMPLOYEES
    FROM `Day#13` X JOIN `Day#13` Y
        ON Y.`MANAGER` = X.`ID`
    GROUP BY Y.`MANAGER`
    ORDER BY NO_OF_EMPLOYEES DESC
) TAB LEFT JOIN `Day#13` 
        ON TAB.MANAGER_ID = `Day#13`.`ID`