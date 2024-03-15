USE `#30daysqlquerychallenge`;

/*
PROBLEM STATEMENT:
In the given input table, some of the invoice are missing, write a sql query to identify the missing serial no. 
As an assumption, consider the serial no with the lowest value to be the first generated invoice and the highest serial no value to be the last generated invoice			
*/

CREATE TABLE `Day#14` (
    SERIAL_NO INT,
    INVOICE_DATE DATE
);

INSERT INTO `Day#14` 
VALUES
(330115, '2024-03-01'),
(330120, '2024-03-01'),
(330121, '2024-03-01'),
(330122, '2024-03-02'),
(330125, '2024-03-02');

-- Solution
-- Generate a sequence numbers between min and max numbers in `SERIAL_NO` column
WITH RECURSIVE Numbers AS
(
    SELECT MIN(SERIAL_NO) AS Number 
    FROM `day#14`
    UNION ALL
    SELECT Number + 1 FROM Numbers
    WHERE Number < (SELECT MAX(SERIAL_NO) FROM `day#14`)
)
-- select a missing numbers 
SELECT Number AS Missing_Numbers FROM Numbers
WHERE NUMBER NOT IN (SELECT SERIAL_NO FROM `day#14`);

