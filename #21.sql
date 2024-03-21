USE `#30daysqlquerychallenge`;

/*
Popular Posts
PROBLEM STATEMENT: The column 'perc_viewed' in the table 'post_views' denotes the percentage of the session duration time the user spent 
viewing a post.Using it, calculate the total time that each post was viewed by users.Output post ID and the total viewing time in seconds, 
but only for posts with a total viewing time of over 5 seconds.											
*/

CREATE TABLE user_sessions
(
    session_id INT,
    user_id VARCHAR(10),
    session_starttime DATETIME,
    session_endtime DATETIME,
    platform VARCHAR(10)
);
CREATE TABLE post_views
(
    session_id INT,
    post_id INT,
    perc_viewed FLOAT
);
INSERT INTO user_sessions
VALUES
(1	,"U1",	"2020-01-01 12:14:28",	"2020-01-01 12:16:08",	"Windows"),
(2	,"U1",	"2020-01-01 18:23:50",	"2020-01-01 18:24:00",	"Windows"),
(3	,"U1",	"2020-01-01 08:15:00",	"2020-01-01 08:20:00",	"IPhone"),
(4	,"U2",	"2020-01-01 10:53:10",	"2020-01-01 10:53:30",	"IPhone"),
(5	,"U2",	"2020-01-01 18:25:14",	"2020-01-01 18:27:53",	"IPhone"),
(6	,"U2",	"2020-01-01 11:28:13",	"2020-01-01 11:31:33",	"Windows"),
(7	,"U3",	"2020-01-01 06:46:20",	"2020-01-01 06:58:13",	"Android"),
(8	,"U3",	"2020-01-01 10:53:10",	"2020-01-01 10:53:50",	"Android"),
(9	,"U3",	"2020-01-01 13:13:13",	"2020-01-01 13:34:34",	"Windows"),
(10	,"U4",	"2020-01-01 08:12:00",	"2020-01-01 12:23:11",	"Windows"),
(11	,"U4",	"2020-01-01 21:54:03",	"2020-01-01 21:54:04",	"IPad");

INSERT INTO post_views
VALUES
(1	,1	,2),(1	,2	,4),(1	,3	,1),(2	,1	,20),(2	,2	,10),(2	,3	,10),(2	,4	,21),(3	,2	,1),(3	,4	,1),
(4	,2	,50),(4	,3	,10),(6	,2	,2),(8	,2	,5),(8	,3	,2.5);

--Solution
WITH SESSION_TIME AS
(
    SELECT 
        post_views.post_id,
        post_views.perc_viewed,
        TIMESTAMPDIFF(SECOND,user_sessions.session_starttime,user_sessions.session_endtime) AS Time_Diff 
    FROM user_sessions RIGHT JOIN post_views 
        ON user_sessions.session_id = post_views.session_id
)
SELECT
    post_id,
    SUM((Time_Diff * perc_viewed) / 100.0) AS totalviewtime
FROM SESSION_TIME
GROUP BY post_id
HAVING totalviewtime > 5;