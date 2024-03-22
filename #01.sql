USE `#30daysqlquerychallenge`;

/*
Problem Statement:
- For pairs of brands in the same year (e.g. apple/samsung/2020 and samsung/apple/2020) 
    - if custom1 = custom3 and custom2 = custom4 
        - then keep only one pair

- For pairs of brands in the same year 
    - if custom1 != custom3 OR custom2 != custom4 
        - then keep both pairs

- For brands that do not have pairs in the same year 
        -   keep those rows as well
*/

CREATE TABLE brands 
(
    brand1      VARCHAR(20),
    brand2      VARCHAR(20),
    year        INT,
    custom1     INT,
    custom2     INT,
    custom3     INT,
    custom4     INT 
);

INSERT INTO brands 
VALUES
('apple',   'samsung', 2020, 1, 2, 1,       2),
('samsung', 'apple',   2020, 1, 2, 1,       2),
('apple',   'samsung', 2021, 1, 2, 5,       3),
('samsung', 'apple',   2021, 5, 3, 1,       2),
('google',   NULL,     2020, 5, 9, NULL, NULL),
('oneplus', 'nothing', 2020, 5, 9, 6,       3);

--Solution:
WITH PAIRS_OF_BRANDS AS
(
    SELECT 
        *,
        CASE
            WHEN brand1 < brand2 THEN CONCAT(brand1, brand2, year) 
            ELSE CONCAT(brand2, brand1, year)
        END AS brand_pair_id
    FROM brands
) ,PAIRS_OF_BRANDS_WITH_RN AS
(
    SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY brand_pair_id ORDER BY brand_pair_id) AS RN
    FROM PAIRS_OF_BRANDS
)
SELECT
    brand1, brand2, year, custom1, custom2, custom3, custom4 
FROM PAIRS_OF_BRANDS_WITH_RN
WHERE RN = 1 OR (custom1 != custom3 OR custom2 != custom4)
ORDER BY brand1, brand2, year; 