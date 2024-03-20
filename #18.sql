USE `#30daysqlquerychallenge`

/*
PROBLEM STATEMENT: 
Find out the employees who attended all the company events.								
*/
CREATE TABLE EMPLOYEE
(
    ID INT,
    NAME VARCHAR(100)
);
INSERT INTO EMPLOYEE
VALUES
(1	,"Lewis"),(2	,"Max"),(3	,"Charles"),(4	,"Sainz");

CREATE TABLE EVENTS
(
    EVENT_NAME VARCHAR(100),
    EMP_ID INT,
    DATES DATE
);
INSERT INTO EVENTS
VALUES
("Product launch"	,1	,"2024-03-01"),("Product launch"	,3	,"2024-03-01"),
("Product launch"	,4	,"2024-03-01"),("Conference"	    ,2	,"2024-03-02"),
("Conference"	    ,2	,"2024-03-03"),("Conference"	    ,3	,"2024-03-02"),
("Conference"	    ,4	,"2024-03-02"),("Training"	        ,3	,"2024-03-04"),
("Training"	        ,2	,"2024-03-04"),("Training"	        ,4	,"2024-03-04"),
("Training"	        ,4	,"2024-03-05");

-- Solution
SELECT 
    EMPLOYEE.NAME AS EMPLOYEE_NAME, 
    COUNT(DISTINCT EVENTS.EVENT_NAME) AS NO_OF_EVENTS
FROM EVENTS LEFT JOIN EMPLOYEE
    ON EVENTS.EMP_ID = EMPLOYEE.ID
GROUP BY EMPLOYEE.NAME
HAVING NO_OF_EVENTS >= (SELECT COUNT(DISTINCT EVENT_NAME) FROM EVENTS)