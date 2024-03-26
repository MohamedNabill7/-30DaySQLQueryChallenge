USE `#30daysqlquerychallenge`;

/*
PROBLEM STATEMENT:
Given table contains tokens taken by different customers in a tax office.
Write a SQL query to return the lowest token number which is unique to a customer (meaning token should be allocated to just a single customer).
*/

CREATE TABLE tokens
(
	token_num	int,
	customer	varchar(20)
);
INSERT INTO tokens 
values
(1, 'Maryam'),(2, 'Rocky'),(3, 'John'),(3, 'John'),(2, 'Arya'),(1, 'Pascal'),(9, 'Kate'),(9, 'Ibrahim'),(8, 'Lilly'),(8, 'Lilly'),(5, 'Shane');

WITH CTE AS
(
    SELECT 
        token_num,
        COUNT(DISTINCT customer) AS Customers
    FROM tokens
    GROUP BY token_num
    ORDER BY Customers ASC , token_num ASC
    LIMIT 1
)
SELECT token_num 
FROM CTE


