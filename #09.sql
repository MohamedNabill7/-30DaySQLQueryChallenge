USE `#30daysqlquerychallenge`;

/*
Merge products						
PROBLEM STATEMENT: Write an sql query to merge products per customer for each day as shown in expected output.					
DATES       PRODUCTS
18/02/2024	101
18/02/2024	101,102
18/02/2024	102
18/02/2024	104
18/02/2024	104,105
18/02/2024	105
19/02/2024	101
19/02/2024	101,103
19/02/2024	101,106
19/02/2024	103
19/02/2024	106
*/

CREATE TABLE orders 
(
	customer_id 	INT,
	dates 			DATE,
	product_id 		INT
);
INSERT INTO orders 
VALUES
(1, '2024-02-18', 101),(1, '2024-02-18', 102),(1, '2024-02-19', 101),(1, '2024-02-19', 103),
(2, '2024-02-18', 104),(2, '2024-02-18', 105),(2, '2024-02-19', 101),(2, '2024-02-19', 106); 

--Solution
WITH CTE AS
(
    SELECT 
        customer_id, dates, product_id AS PRODUCTS 
    FROM orders
    UNION ALL
    SELECT 
        customer_id, dates, GROUP_CONCAT(product_id) AS PRODUCTS 
    FROM orders
    GROUP BY customer_id, dates
    ORDER BY dates, customer_id
)
SELECT 
    DISTINCT DATES,       
    PRODUCTS
FROM CTE;
