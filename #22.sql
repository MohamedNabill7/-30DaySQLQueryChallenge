USE `#30daysqlquerychallenge`,

/* 
IPL Winning Streak
Problem Statement: Given table has details of every IPL 2023 matches. Identify the maximum winning streak for each team. 
Additional test cases: 
1) Update the dataset such that when Chennai Super Kings win match no 17, your query shows the updated streak.
2) Update the dataset such that Royal Challengers Bangalore loose all match and your query should populate the winning streak as 0
*/

CREATE TABLE ipl_results
(
	match_no		int,
	round_number	varchar(50),
	dates			date,
	location		varchar(50),
	home_team		varchar(50),
	away_team		varchar(50),
	result			varchar(50)
);

INSERT INTO ipl_results 
VALUES
(1 , '1', '2023-03-31', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Chennai Super Kings','Gujarat Titans'),
(2 , '1', '2023-04-01', 'Punjab Cricket Association IS Bindra Stadium, Moha','Punjab Kings','Kolkata Knight Riders','Punjab Kings'),
(3 , '1', '2023-04-01', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Delhi Capitals','Lucknow Super Giants'),
(4 , '1', '2023-04-02', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Rajasthan Royals','Rajasthan Royals'),
(5 , '1', '2023-04-02', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Mumbai Indians','Royal Challengers Bangalore'),
(6 , '1', '2023-04-03', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Lucknow Super Giants','Chennai Super Kings'),
(7 , '1', '2023-04-04', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Gujarat Titans','Gujarat Titans'),
(8 , '1', '2023-04-05', 'Barsapara Cricket Stadium, Guwahati','Rajasthan Royals','Punjab Kings','Punjab Kings'),
(9 , '1', '2023-04-06', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Royal Challengers Bangalore','Kolkata Knight Riders'),
(10 , '1', '2023-04-07', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Sunrisers Hyderabad','Lucknow Super Giants'),
(11 , '2', '2023-04-08', 'Barsapara Cricket Stadium, Guwahati','Rajasthan Royals','Delhi Capitals','Rajasthan Royals'),
(12 , '2', '2023-04-08', 'Wankhede Stadium, Mumbai','Mumbai Indians','Chennai Super Kings','Chennai Super Kings'),
(13 , '2', '2023-04-09', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Kolkata Knight Riders','Kolkata Knight Riders'),
(14 , '2', '2023-04-09', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Punjab Kings','Sunrisers Hyderabad'),
(15 , '2', '2023-04-10', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Lucknow Super Giants','Lucknow Super Giants'),
(16 , '2', '2023-04-11', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Mumbai Indians','Mumbai Indians'),
(17 , '2', '2023-04-12', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Rajasthan Royals','Rajasthan Royals'),
(18 , '2', '2023-04-13', 'Punjab Cricket Association IS Bindra Stadium, Moha','Punjab Kings','Gujarat Titans','Gujarat Titans'),
(19 , '2', '2023-04-14', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Sunrisers Hyderabad','Sunrisers Hyderabad'),
(20 , '3', '2023-04-15', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Delhi Capitals','Royal Challengers Bangalore'),
(21 , '3', '2023-04-15', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Punjab Kings','Punjab Kings'),
(22 , '3', '2023-04-16', 'Wankhede Stadium, Mumbai','Mumbai Indians','Kolkata Knight Riders','Mumbai Indians'),
(23 , '3', '2023-04-16', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Rajasthan Royals','Rajasthan Royals'),
(24 , '3', '2023-04-17', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Chennai Super Kings','Chennai Super Kings'),
(25 , '3', '2023-04-18', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Mumbai Indians','Mumbai Indians'),
(26 , '3', '2023-04-19', 'Sawai Mansingh Stadium, Jaipur','Rajasthan Royals','Lucknow Super Giants','Lucknow Super Giants'),
(27 , '3', '2023-04-20', 'Punjab Cricket Association IS Bindra Stadium, Moha','Punjab Kings','Royal Challengers Bangalore','Royal Challengers Bangalore'),
(28 , '3', '2023-04-20', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Kolkata Knight Riders','Delhi Capitals'),
(29 , '3', '2023-04-21', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Sunrisers Hyderabad','Chennai Super Kings'),
(30 , '4', '2023-04-22', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Gujarat Titans','Gujarat Titans'),
(31 , '4', '2023-04-22', 'Wankhede Stadium, Mumbai','Mumbai Indians','Punjab Kings','Punjab Kings'),
(32 , '4', '2023-04-23', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Rajasthan Royals','Royal Challengers Bangalore'),
(33 , '4', '2023-04-23', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Chennai Super Kings','Chennai Super Kings'),
(34 , '4', '2023-04-24', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Delhi Capitals','Delhi Capitals'),
(35 , '4', '2023-04-25', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Mumbai Indians','Gujarat Titans'),
(36 , '4', '2023-04-26', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Kolkata Knight Riders','Kolkata Knight Riders'),
(37 , '4', '2023-04-27', 'Sawai Mansingh Stadium, Jaipur','Rajasthan Royals','Chennai Super Kings','Rajasthan Royals'),
(38 , '4', '2023-04-28', 'Punjab Cricket Association IS Bindra Stadium, Moha','Punjab Kings','Lucknow Super Giants','Lucknow Super Giants'),
(39 , '4', '2023-04-29', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Gujarat Titans','Gujarat Titans'),
(40 , '4', '2023-04-29', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Sunrisers Hyderabad','Sunrisers Hyderabad'),
(41 , '5', '2023-04-30', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Punjab Kings','Punjab Kings'),
(42 , '5', '2023-04-30', 'Wankhede Stadium, Mumbai','Mumbai Indians','Rajasthan Royals','Mumbai Indians'),
(43 , '5', '2023-05-01', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Royal Challengers Bangalore','Royal Challengers Bangalore'),
(44 , '5', '2023-05-02', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Delhi Capitals','Delhi Capitals'),
(46 , '5', '2023-05-03', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Chennai Super Kings','No Result'),
(45 , '5', '2023-05-03', 'Punjab Cricket Association IS Bindra Stadium, Moha','Punjab Kings','Mumbai Indians','Mumbai Indians'),
(47 , '5', '2023-05-04', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Kolkata Knight Riders','Kolkata Knight Riders'),
(48 , '5', '2023-05-05', 'Sawai Mansingh Stadium, Jaipur','Rajasthan Royals','Gujarat Titans','Gujarat Titans'),
(49 , '5', '2023-05-06', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Mumbai Indians','Chennai Super Kings'),
(50 , '5', '2023-05-06', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Royal Challengers Bangalore','Delhi Capitals'),
(51 , '6', '2023-05-07', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Lucknow Super Giants','Gujarat Titans'),
(52 , '6', '2023-05-07', 'Sawai Mansingh Stadium, Jaipur','Rajasthan Royals','Sunrisers Hyderabad','Sunrisers Hyderabad'),
(53 , '6', '2023-05-08', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Punjab Kings','Kolkata Knight Riders'),
(54 , '6', '2023-05-09', 'Wankhede Stadium, Mumbai','Mumbai Indians','Royal Challengers Bangalore','Mumbai Indians'),
(55 , '6', '2023-05-10', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Delhi Capitals','Chennai Super Kings'),
(56 , '6', '2023-05-11', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Rajasthan Royals','Rajasthan Royals'),
(57 , '6', '2023-05-12', 'Wankhede Stadium, Mumbai','Mumbai Indians','Gujarat Titans','Mumbai Indians'),
(58 , '6', '2023-05-13', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Lucknow Super Giants','Lucknow Super Giants'),
(59 , '6', '2023-05-13', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Punjab Kings','Punjab Kings'),
(60 , '7', '2023-05-14', 'Sawai Mansingh Stadium, Jaipur','Rajasthan Royals','Royal Challengers Bangalore','Royal Challengers Bangalore'),
(61 , '7', '2023-05-14', 'MA Chidambaram Stadium, Chennai','Chennai Super Kings','Kolkata Knight Riders','Kolkata Knight Riders'),
(62 , '7', '2023-05-15', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Sunrisers Hyderabad','Gujarat Titans'),
(63 , '7', '2023-05-16', 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Crick','Lucknow Super Giants','Mumbai Indians','Lucknow Super Giants'),
(64 , '7', '2023-05-17', 'Himachal Pradesh Cricket Association Stadium, Dhar','Punjab Kings','Delhi Capitals','Delhi Capitals'),
(65 , '7', '2023-05-18', 'Rajiv Gandhi International Stadium, Hyderabad','Sunrisers Hyderabad','Royal Challengers Bangalore','Royal Challengers Bangalore'),
(66 , '7', '2023-05-19', 'Himachal Pradesh Cricket Association Stadium, Dhar','Punjab Kings','Rajasthan Royals','Rajasthan Royals'),
(67 , '7', '2023-05-20', 'Arun Jaitley Stadium, Delhi','Delhi Capitals','Chennai Super Kings','Chennai Super Kings'),
(68 , '7', '2023-05-20', 'Eden Gardens, Kolkata','Kolkata Knight Riders','Lucknow Super Giants','Lucknow Super Giants'),
(69 , '7', '2023-05-21', 'Wankhede Stadium, Mumbai','Mumbai Indians','Sunrisers Hyderabad','Mumbai Indians'),
(70 , '7', '2023-05-21', 'M Chinnaswamy Stadium, Bengaluru','Royal Challengers Bangalore','Gujarat Titans','Gujarat Titans'),
(71 , 'Qualifier 1' ,'2023-05-23', 'MA Chidambaram Stadium, Chennai','Gujarat Titans','Chennai Super Kings','Chennai Super Kings'),
(72 , 'Eliminator' ,'2023-05-24', 'MA Chidambaram Stadium, Chennai','Lucknow Super Giants','Mumbai Indians','Mumbai Indians'),
(73 , 'Qualifier2' ,'2023-05-26', 'Narendra Modi Stadium, Ahmedabad','Gujarat Titans','Mumbai Indians','Gujarat Titans'),
(74 , 'Final' ,'2023-05-29', 'Narendra Modi Stadium, Ahmedabad','Chennai Super Kings','Gujarat Titans','Chennai Super Kings');

--Solution
WITH ALL_TEAMS AS
(
    SELECT  home_team AS TEAM FROM ipl_results
    UNION
    SELECT away_team AS TEAM FROM ipl_results
), Matches AS
(
    SELECT 
        IPL.dates, CONCAT(IPL.HOME_TEAM, ' vs ', IPL.AWAY_TEAM) AS `Match`, ALL_TEAMS.TEAM, IPL.result,
        ROW_NUMBER() OVER(PARTITION BY ALL_TEAMS.TEAM ORDER BY IPL.dates, ALL_TEAMS.TEAM) AS id
    FROM ALL_TEAMS JOIN ipl_results IPL 
        ON ALL_TEAMS.TEAM = IPL.HOME_TEAM OR ALL_TEAMS.TEAM = IPL.AWAY_TEAM
), Matches_With_Diff AS
(
    SELECT *,id - ROW_NUMBER() OVER(PARTITION BY TEAM ORDER BY dates, TEAM) AS diff 
    FROM Matches 
    WHERE TEAM = result
), Final_Result AS 
(
    SELECT *, ROW_NUMBER() OVER(PARTITION BY TEAM,diff ORDER BY dates, TEAM) AS STREAK FROM Matches_With_Diff
)
SELECT TEAM, MAX(STREAK) AS MAX_WINNING_STREAK
FROM Final_Result
GROUP BY TEAM 
ORDER BY MAX_WINNING_STREAK DESC;

-- Test Cases
UPDATE ipl_results
SET home_team = 'Chennai Super Kings'
WHERE match_no = 17;

SELECT * FROM ipl_results
WHERE result = 'Royal Challengers Bangalore';

UPDATE ipl_results
SET result = CASE WHEN away_team <> 'Royal Challengers Bangalore' THEN away_team ELSE home_team END
WHERE result = 'Royal Challengers Bangalore';

