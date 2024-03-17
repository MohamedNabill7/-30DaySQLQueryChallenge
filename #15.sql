USE `#30daysqlquerychallenge`

/*
Problem Statement:
For a given friends, find the no.of mutual friends
*/
CREATE TABLE `Day#15`
(
Friend1 VARCHAR(30),
Friend2 VARCHAR(30)
);

INSERT INTO `Day#15`
VALUES
    ("Jason","Mary"),
    ("Mike","Mary"),
    ("Mike","Jason"),
    ("Susan","Jason"),
    ("John","Mary"),
    ("Susan","Mary");
WITH ALL_FRIENDS AS
(
    SELECT `Friend1`, `Friend2` FROM `Day#15` 
    UNION  ALL 
    SELECT `Friend2` ,`Friend1` FROM `Day#15` 
)
SELECT 
    F.`Friend1`, F.`Friend2`, COUNT(AF.`Friend2`) AS No_Of_Mutual_Friends
FROM `Day#15` F LEFT JOIN ALL_FRIENDS AF
    ON F.`Friend1` = AF.`Friend1`
        AND AF.`Friend2` IN (
            SELECT AF2.`Friend2` FROM ALL_FRIENDS AF2
            WHERE AF2.`Friend1` = F.`Friend2`
        )
GROUP BY 1,2;

