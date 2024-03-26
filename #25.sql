USE `#30daysqlquerychallenge`;

/*
PROBLEM STATEMENT: 
Analyse the given input table and come up with output as shown.		
STORE_ID	PRODUCT_1	PRODUCT_2
    1	        2	        1
    2	        1	        3
    3	        0	        0
*/				
CREATE TABLE products
(
	store_id	int,
	product_1	varchar(50),
	product_2	varchar(50)
);
INSERT INTO products 
VALUES 
(1, 'Apple - IPhone', 'Apple - MacBook Pro'),(1, 'Apple - AirPods', 'Samsung - Galaxy Phone'),(2, 'Apple_IPhone', 'Apple: Phone'),
(2, 'Google Pixel', 'apple: Laptop'),(2, 'Sony: Camera', 'Apple Vision Pro'),(3, 'samsung - Galaxy Phone', 'mapple MacBook Pro');

--SOLUTION
SELECT 
    store_id,
    SUM(CASE 
        WHEN product_1 LIKE 'Apple%' THEN 1  
        ELSE  0
    END) AS PRODUCT_1,
    SUM(CASE 
        WHEN product_2 LIKE 'Apple%' THEN 1  
        ELSE  0
    END) AS PRODUCT_2
FROM products
GROUP BY store_id;


