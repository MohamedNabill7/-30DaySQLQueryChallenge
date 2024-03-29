USE `#30daysqlquerychallenge`;

/* Login Duration
PROBLEM STATEMENT: Given table provides login and logoff details of one user.
Generate a report to represent the different periods (in mins) when user was logged in.
*/
CREATE TABLE login_details
(
	times	time,
	status	varchar(3)
);

INSERT INTO login_details 
VALUES
('10:00:00', 'on'),('10:01:00', 'on'),('10:02:00', 'on'),('10:03:00', 'off'),('10:04:00', 'on'),
('10:05:00', 'on'),('10:06:00', 'off'),('10:07:00', 'off'),('10:08:00', 'off'),('10:09:00', 'on'),
('10:10:00', 'on'),('10:11:00', 'on'),('10:12:00', 'on'),('10:13:00', 'off'),('10:14:00', 'off'),
('10:15:00', 'on'),('10:16:00', 'off'),('10:17:00', 'off');

--Solution
WITH CTE AS
(
    SELECT 
        * , RN1 - ROW_NUMBER() OVER(ORDER BY times) AS X
    FROM 
    (
        SELECT 
            *,ROW_NUMBER() OVER(ORDER BY times) AS RN1
        FROM login_details
    ) AS T1
    WHERE status = 'on'
)
SELECT 
    DISTINCT MIN (times) OVER(PARTITION BY X) AS LOG_ON,
    ADDTIME(MAX (times) OVER(PARTITION BY X), '00:01:00') AS LOG_OFF,
    TIMESTAMPDIFF(MINUTE, MIN(times) OVER(PARTITION BY X), ADDTIME(MAX (times) OVER(PARTITION BY X), '00:01:00')) AS DURATION
FROM CTE 
