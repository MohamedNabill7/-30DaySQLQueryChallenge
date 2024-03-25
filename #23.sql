USE `#30daysqlquerychallenge`;

/*
Table: Buses
`bus_id` contains unique values. Each row of this table contains information about the `arrival time` of a bus at the LeetCode station and 
its `capacity` (the number of empty seats it has).

No two buses will arrive at the same time and all bus capacities will be positive integers.

Table: Passengers
`passenger_id` contains unique values. Each row of this table contains information about the `arrival time` of a passenger at the LeetCode
station.

Buses and passengers arrive at the LeetCode station. If a bus arrives at the station at a time tbus and a passenger arrived at a time 
tpassenger where **tpassenger <= tbus** and the passenger did not catch any bus, the passenger will use that bus. In addition, each bus has 
a capacity. If at the moment the bus arrives at the station there are more passengers waiting than its capacity capacity, only capacity 
passengers will use the bus.

Write a solution to report the number of users that used each bus. Return the result table ordered by bus_id in ascending order.
*/

CREATE TABLE buses
(
	bus_id			int unique,
	arrival_time	int,
	capacity		int
);

CREATE TABLE Passengers
(
	passenger_id	int unique,
	arrival_time	int
);


-- Dataset for Test case 1
INSERT INTO buses 
VALUES
(1,2,1),(2,4,10),(3,7,2);

INSERT INTO Passengers
VALUES
(11,1), (12,1), (13,5), (14,6), (15,7);



WITH RECURSIVE hierarchy AS
(
	WITH CTE AS 
	(
	SELECT 
		ROW_NUMBER() OVER(ORDER BY arrival_time) AS Ordered_Buses, bus_id, capacity, 
		(SELECT COUNT(*) FROM Passengers WHERE Passengers.arrival_time <= b.arrival_time) AS Passengers
	FROM buses b
	)
	SELECT
		Ordered_Buses, bus_id, capacity, Passengers, 
		LEAST(Passengers, capacity) AS Available,
		LEAST(Passengers, capacity) AS Total_Available
	FROM CTE
	WHERE Ordered_Buses = 1
	UNION ALL
	SELECT 
		CTE.Ordered_Buses, CTE.bus_id, CTE.capacity, CTE.Passengers, 
		LEAST(CTE.Passengers - hierarchy.Total_Available, CTE.capacity) AS Available,
		hierarchy.Total_Available + LEAST(CTE.Passengers - hierarchy.Total_Available, CTE.capacity) AS Total_Available
	FROM hierarchy JOIN CTE ON CTE.Ordered_Buses = hierarchy.Ordered_Buses + 1
)
SELECT  
	Ordered_Buses AS bus_id , 
	Available AS passengers_cnt 
FROM hierarchy
ORDER BY bus_id;





/*
 bus_id   passengers_cnt 
    1      1             
    2      1             
    3      2              
*/




-- Optional datasets for verifying the solution
/* 
-- Dataset for Test case 2
INSERT INTO buses 
VALUES 
(326,412,3),(394,656,3),(430,701,1),(514,742,4),(765,867,9),(259,968,3);

INSERT INTO Passengers 
VALUES
(1145,84 ),(1466,146),(1446,317),(1092,420),(678,486),(1643,520),(253,615),(1106,656),(1309,699),(142,832),(431,880),(1405,963);
*/
/*
-- Dataset for Test case 3
INSERT INTO buses 
VALUES 
(717,27 ,6 ),(54 ,102,4 ),(270,116,4 ),(337,209,9 ),(346,309,7 ),(16 ,467,9 ),(189,484,1 ),(29 ,550,10),(771,627,1 ),(9  ,728,7 ),
(274,797,9 ),(217,799,1 ),(531,840,5 ),(684,858,6 ),(479,928,2 ),(101,931,5 );

INSERT INTO Passengers 
VALUE,
(1679,76 ),(667 ,86 ),(1552,132),(512 ,147),(1497,156),(907 ,158),(1537,206),(1535,219),(584 ,301),(16  ,318),(166 ,375),(1103,398),
(831 ,431),(659 ,447),(241 ,449),(695 ,495),(1702,517),(499 ,536),(685 ,541),(523 ,573),(1283,586),(1013,619),(256 ,680),(854 ,698),
(1077,702),(1684,779),(1715,800),(1772,804),(69  ,807),(261 ,919),(581 ,922),(1627,999);
*/
/*
-- Dataset for Test case 4
INSERT INTO buses
VALUES 
(238,4  ,4 ),(718,,2 ,5 ),(689,52 ,8 ),(324,55 ,3 ),(358,59 ,7 ),(550,86 ,2 ),(46 ,91 ,5 ),(60 ,110,3 ),(667,123,8 ),(47 ,146,9 ),
(671,158,2 ),(461,181,5 ),(399,183,9 ),(196,226,2 ),(549,227,7 ),(62 ,238,5 ),(251,269,6 ),(315,294,7 ),(243,305,4 ),(98 ,338,6 ),
(642,369,6 ),(191,380,3 ),(67 ,394,2 ),(303,397,1 ),(663,466,1,),(524,507,1,),(405,556,5,),(543,586,9,),(177,623,3,),(195,728,5,),
(573,747,6,),(390,769,1,),(661,785,9,),(494,798,5,),(114,804,6 ),(571,810,9 ),(26 ,813,10),(507,823,2 ),(739,829,4 ),(74 ,830,7 ),
(483,849,1 ),(758,877,9 ),(597,895,2 ),(255,969,6 ),(717,977,5 );

INSERT INTO Passengers 
VALUES
(1490,4  ),(1535,8  ),(1283,34 ),(1230,58 ),(821 ,102),(1388,104),(1207,127),(1110,144),(566 ,149),(1774,160),(47  ,166),(1099,167),
(1336,178),(1251,193),(572 ,194),(524 ,208),(1100,209),(1211,246),(885 ,249),(403 ,268),(538 ,274),(1397,287),(1303,301),(1293,313),
(1133,315),(216 ,324),(318 ,337),(373 ,345),(49  ,351),(998 ,358),(109 ,364),(245 ,383),(205 ,383),(410 ,395),(179 ,410),(1429,415),
(440 ,427),(388 ,429),(1470,453),(1067,459),(96  ,475),(1363,496),(229 ,498),(1298,503),(293 ,509),(683 ,524),(374 ,528),(9   ,539),
(966 ,540),(1275,552),(1221,553),(319 ,565),(1131,569),(1339,587),(18  ,598),(1024,653),(396 ,663),(409 ,677),(545 ,689),(999 ,699),
(1219,714),(1195,725),(957 ,738),(1717,750),(118 ,753),(873 ,758),(1706,759),(1570,765),(1469,772),(1417,776),(1773,809),(568 ,823),
(83  ,831),(804 ,835),(418 ,837),(1471,861),(816 ,880),(1673,881),(1158,882),(1466,910),(172 ,927),(1254,929),(1337,934),(1739,939),
(611 ,940),(415 ,945),(585 ,947),(1632,949),(1679,971),(332 ,976);
*/
/*
-- Dataset for Test case 5
INSERT INTO buses 
VALUES 
(81 ,57 ,10),(137,69 ,7 ),(132,103,1 ),(756,138,3 ),(553,139,9 ),(591,196,5 ),(254,205,1 ),(664,218,10),(440,234,4 ),(211,253,8 ),
(54 ,286,7 ),(621,334,9 ),(516,345,2 ),(616,416,2 ),(32 ,436,9 ),(336,462,5 ),(61 ,468,4 ),(233,501,3 ),(492,508,9 ),(628,526,3 ),
(93 ,563,1 ),(8  ,574,1 ),(76 ,586,3 ),(23 ,650,6 ),(147,669,7 ),(601,679,5 ),(179,696,10),(647,703,5 ),(148,711,10),(352,728,5 ),
(176,746,5 ),(26 ,770,3 ),(231,772,2 ),(434,798,9 ),(64 ,826,1 ),(641,829,6 ),(484,846,3 ),(337,896,3 );

INSERT INTO Passengers 
VALUES
(108 ,1  ),(646 ,54 ),(1656,55 ),(1762,91 ),(89  ,101),(427 ,150),(1357,156),(325 ,203),(847 ,206),(1036,211),(119 ,214),(1765,218),
(303 ,225),(466 ,237),(722 ,255),(1659,279),(1528,281),(628 ,283),(575 ,300),(1075,306),(743 ,309),(894 ,327),(190 ,388),(502 ,392),
(541 ,401),(1037,407),(1093,412),(1252,417),(632 ,430),(339 ,431),(735 ,433),(778 ,443),(877 ,446),(1137,473),(1076,488),(589 ,504),
(1763,509),(172 ,525),(1720,537),(612 ,546),(1588,550),(651 ,553),(363 ,567),(1440,584),(694 ,591),(1338,614),(652 ,631),(1646,632),
(369 ,650),(310 ,655),(1006,661),(1111,667),(1556,695),(1020,699),(232 ,734),(1017,785),(516 ,786),(1324,789),(1487,792),(5   ,809),
(173 ,847),(982 ,863),(455 ,872),(769 ,879),(260 ,893),(123 ,914),(1117,918),(170 ,929),(788 ,931),(32  ,935),(943 ,943),(532 ,943),
(1334,944),(866 ,954),(697 ,959),(255 ,964);
*/