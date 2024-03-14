USE `#30DaySQLQueryChallenge`;

/*
PROBLEM STATEMENT:
In the given input table DAY_INDICATOR field indicates the day of the week with the first character being Monday, followed by Tuesday and so on.
Write a query to filter the dates column to showcase only those days where day_indicator character for that day of the week is 1
*/


CREATE TABLE `DAY#7`
(
Product_ID VARCHAR(30),
Day_Indicator VARCHAR(30),
Dates DATE
);

INSERT INTO `DAY#7`(Product_ID, Day_Indicator, Dates) 
VALUES
("AP755",   "1010101",  "2024-03-04"),
("AP755",   "1010101",  "2024-03-05"),
("AP755",	"1010101",	"2024-03-06"),
("AP755",	"1010101",	"2024-03-07"),
("AP755",	"1010101",	"2024-03-08"),
("AP755",	"1010101",	"2024-03-09"),
("AP755",	"1010101",	"2024-03-10"),
("XQ802",	"1000110",	"2024-03-04"),
("XQ802",	"1000110",	"2024-03-05"),
("XQ802",	"1000110",	"2024-03-06"),
("XQ802",	"1000110",	"2024-03-07"),
("XQ802",	"1000110",	"2024-03-08"),
("XQ802",	"1000110",	"2024-03-09"),
("XQ802",	"1000110",	"2024-03-10");


-- Solution
SELECT Product_ID, Day_Indicator, Dates
FROM(
SELECT
	*,
    weekday(Dates)+1 AS Day_Index,
    substring(Day_Indicator,weekday(Dates)+1,1) AS Flag
FROM `DAY#7`)TAB
WHERE Flag = 1
