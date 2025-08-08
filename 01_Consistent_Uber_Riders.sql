USE practiceDB

--- Problem 1 - Identify Consistent Uber Riders in Chennai 

--- Problem Statement
--- The Uber operations team wants to identify loyal customers in Chennai
--- who have completed at least 30 rides in the last 3 months without any cancellations.
--- This information will help target these customers for loyalty rewards 



--- Table creation & Sample data

DROP TABLE IF EXISTS uber;

Create table uber(
    ride_id int primary key,
    customer_id int,
    customer_name varchar(50),
    city varchar(50),
    ride_date Date,
    cancelled BIT 
);

Insert into uber values
(1, 201, 'Mani', 'Chennai', '2025-05-01', 0),
(2, 201, 'Mani', 'Chennai', '2025-05-03', 0),
(3, 201, 'Mani', 'Chennai', '2025-05-04', 1),
(4, 201, 'Mani', 'Chennai', '2025-05-06', 0),
(5, 201, 'Mani', 'Chennai', '2025-05-07', 0),
(6, 201, 'Mani', 'Chennai', '2025-05-10', 0),
(7, 201, 'Mani', 'Chennai', '2025-05-12', 0),
(8, 201, 'Mani', 'Chennai', '2025-05-13', 1),
(9, 201, 'Mani', 'Chennai', '2025-05-15', 0),
(10, 201, 'Mani', 'Chennai', '2025-05-18', 0),
(11, 201, 'Mani', 'Chennai', '2025-05-20', 0),
(12, 201, 'Mani', 'Chennai', '2025-05-21', 0),
(13, 201, 'Mani', 'Chennai', '2025-05-23', 0),
(14, 201, 'Mani', 'Chennai', '2025-05-25', 0),
(15, 201, 'Mani', 'Chennai', '2025-05-26', 1),
(16, 201, 'Mani', 'Chennai', '2025-05-28', 0),
(17, 201, 'Mani', 'Chennai', '2025-05-30', 0),
(18, 201, 'Mani', 'Chennai', '2025-06-01', 0),
(19, 201, 'Mani', 'Chennai', '2025-06-03', 0),
(20, 201, 'Mani', 'Chennai', '2025-06-04', 1),
(21, 201, 'Mani', 'Chennai', '2025-06-06', 0),
(22, 201, 'Mani', 'Chennai', '2025-06-08', 0),
(23, 201, 'Mani', 'Chennai', '2025-06-09', 0),
(24, 201, 'Mani', 'Chennai', '2025-06-11', 0),
(25, 201, 'Mani', 'Chennai', '2025-06-13', 0),
(26, 201, 'Mani', 'Chennai', '2025-06-14', 0),
(27, 201, 'Mani', 'Chennai', '2025-06-16', 0),
(28, 201, 'Mani', 'Chennai', '2025-06-17', 0),
(29, 201, 'Mani', 'Chennai', '2025-06-18', 1),
(30, 201, 'Mani', 'Chennai', '2025-06-19', 0),
(31, 201, 'Mani', 'Chennai', '2025-06-21', 0),
(32, 201, 'Mani', 'Chennai', '2025-06-23', 0),
(33, 201, 'Mani', 'Chennai', '2025-06-25', 0),
(34, 201, 'Mani', 'Chennai', '2025-06-27', 0),
(35, 201, 'Mani', 'Chennai', '2025-06-29', 0),
(36, 201, 'Mani', 'Chennai', '2025-06-30', 0),
(37, 201, 'Mani', 'Chennai', '2025-07-01', 0),
(38, 201, 'Mani', 'Chennai', '2025-07-02', 0),
(39, 201, 'Mani', 'Chennai', '2025-07-03', 0),
(40, 201, 'Mani', 'Chennai', '2025-07-04', 1),
(41, 201, 'Mani', 'Chennai', '2025-07-05', 0),
(42, 201, 'Mani', 'Chennai', '2025-07-06', 0),
(43, 201, 'Mani', 'Chennai', '2025-07-07', 0),
(44, 201, 'Mani', 'Chennai', '2025-07-08', 0),
(45, 201, 'Mani', 'Chennai', '2025-07-09', 0),
(46, 201, 'Mani', 'Chennai', '2025-07-10', 0),
(47, 201, 'Mani', 'Chennai', '2025-07-11', 0),
(48, 201, 'Mani', 'Chennai', '2025-07-12', 0),
(49, 201, 'Mani', 'Chennai', '2025-07-13', 0),
(50, 201, 'Mani', 'Chennai', '2025-07-14', 0),
(51, 201, 'Mani', 'Chennai', '2025-07-15', 0),
(52, 201, 'Mani', 'Chennai', '2025-07-16', 1),
(53, 201, 'Mani', 'Chennai', '2025-07-17', 0),
(54, 201, 'Mani', 'Chennai', '2025-07-18', 0),
(55, 201, 'Mani', 'Chennai', '2025-07-19', 0),
(56, 201, 'Mani', 'Chennai', '2025-07-20', 0),
(57, 201, 'Mani', 'Chennai', '2025-07-21', 0),
(58, 201, 'Mani', 'Chennai', '2025-07-22', 0),
(59, 201, 'Mani', 'Chennai', '2025-07-23', 0),
(60, 201, 'Mani', 'Chennai', '2025-07-24', 0),
(61, 202, 'Arun', 'Chennai', '2025-05-01', 0),
(62, 202, 'Arun', 'Chennai', '2025-05-05', 1),
(63, 202, 'Arun', 'Chennai', '2025-05-09', 0),
(64, 202, 'Arun', 'Chennai', '2025-05-13', 0),
(65, 202, 'Arun', 'Chennai', '2025-05-17', 0),
(66, 202, 'Arun', 'Chennai', '2025-05-21', 0),
(67, 202, 'Arun', 'Chennai', '2025-05-25', 0),
(68, 202, 'Arun', 'Chennai', '2025-05-29', 0),
(69, 202, 'Arun', 'Chennai', '2025-06-02', 0),
(70, 202, 'Arun', 'Chennai', '2025-06-06', 0),
(71, 202, 'Arun', 'Chennai', '2025-06-10', 1),
(72, 202, 'Arun', 'Chennai', '2025-06-14', 0),
(73, 202, 'Arun', 'Chennai', '2025-06-18', 0),
(74, 202, 'Arun', 'Chennai', '2025-06-22', 0),
(75, 202, 'Arun', 'Chennai', '2025-06-26', 0),
(76, 202, 'Arun', 'Chennai', '2025-06-30', 0),
(77, 202, 'Arun', 'Chennai', '2025-07-04', 0),
(78, 202, 'Arun', 'Chennai', '2025-07-08', 0),
(79, 202, 'Arun', 'Chennai', '2025-07-12', 0),
(80, 202, 'Arun', 'Chennai', '2025-07-16', 0),
(81, 202, 'Arun', 'Chennai', '2025-07-20', 0),
(82, 202, 'Arun', 'Chennai', '2025-07-24', 0),
(83, 202, 'Arun', 'Chennai', '2025-07-28', 0),
(84, 202, 'Arun', 'Chennai', '2025-08-01', 0),
(85, 202, 'Arun', 'Chennai', '2025-08-05', 0),
(86, 202, 'Arun', 'Chennai', '2025-08-09', 0),
(87, 202, 'Arun', 'Chennai', '2025-08-13', 0),
(88, 202, 'Arun', 'Chennai', '2025-08-17', 0),
(89, 202, 'Arun', 'Chennai', '2025-08-21', 0),
(90, 202, 'Arun', 'Chennai', '2025-08-25', 0),
(91, 202, 'Arun', 'Chennai', '2025-08-29', 0),
(92, 202, 'Arun', 'Chennai', '2025-09-02', 0),
(93, 202, 'Arun', 'Chennai', '2025-09-06', 0),
(94, 202, 'Arun', 'Chennai', '2025-09-10', 1),
(95, 202, 'Arun', 'Chennai', '2025-09-14', 0),
(96, 202, 'Arun', 'Chennai', '2025-09-18', 0),
(97, 202, 'Arun', 'Chennai', '2025-09-22', 0),
(98, 202, 'Arun', 'Chennai', '2025-09-26', 0),
(99, 202, 'Arun', 'Chennai', '2025-09-30', 0),
(100, 203, 'Navin', 'Chennai', '2025-07-02', 0),
(101, 203, 'Navin', 'Chennai', '2025-07-05', 0),
(102, 203, 'Navin', 'Chennai', '2025-07-08', 0),
(103, 203, 'Navin', 'Chennai', '2025-07-11', 1),
(104, 203, 'Navin', 'Chennai', '2025-07-14', 0),
(105, 203, 'Navin', 'Chennai', '2025-07-18', 0),
(106, 203, 'Navin', 'Chennai', '2025-07-21', 0),
(107, 203, 'Navin', 'Chennai', '2025-07-25', 0),
(108, 203, 'Navin', 'Chennai', '2025-07-28', 0),
(109, 203, 'Navin', 'Chennai', '2025-08-02', 0),
(110, 203, 'Navin', 'Chennai', '2025-08-05', 0),
(111, 203, 'Navin', 'Chennai', '2025-08-10', 0),
(112, 204, 'Isai', 'Chennai', '2025-07-06', 0),
(113, 204, 'Isai', 'Chennai', '2025-07-10', 0),
(114, 204, 'Isai', 'Chennai', '2025-07-14', 0),
(115, 204, 'Isai', 'Chennai', '2025-07-18', 0),
(116, 204, 'Isai', 'Chennai', '2025-07-22', 0),
(117, 204, 'Isai', 'Chennai', '2025-07-26', 1),
(118, 204, 'Isai', 'Chennai', '2025-07-30', 0),
(119, 205, 'Hari', 'Chennai', '2025-06-01', 0),
(120, 205, 'Hari', 'Chennai', '2025-06-03', 0),
(121, 205, 'Hari', 'Chennai', '2025-06-05', 0),
(122, 205, 'Hari', 'Chennai', '2025-06-07', 0),
(123, 205, 'Hari', 'Chennai', '2025-06-09', 0),
(124, 205, 'Hari', 'Chennai', '2025-06-11', 0),
(125, 205, 'Hari', 'Chennai', '2025-06-13', 0),
(126, 205, 'Hari', 'Chennai', '2025-06-15', 0),
(127, 205, 'Hari', 'Chennai', '2025-06-17', 0),
(128, 205, 'Hari', 'Chennai', '2025-06-19', 0),
(129, 205, 'Hari', 'Chennai', '2025-06-21', 0),
(130, 205, 'Hari', 'Chennai', '2025-06-23', 0),
(131, 205, 'Hari', 'Chennai', '2025-06-25', 0),
(132, 205, 'Hari', 'Chennai', '2025-06-27', 0),
(133, 205, 'Hari', 'Chennai', '2025-06-29', 0),
(134, 205, 'Hari', 'Chennai', '2025-07-01', 0),
(135, 205, 'Hari', 'Chennai', '2025-07-03', 0),
(136, 205, 'Hari', 'Chennai', '2025-07-05', 0),
(137, 205, 'Hari', 'Chennai', '2025-07-07', 0),
(138, 205, 'Hari', 'Chennai', '2025-07-09', 0),
(139, 205, 'Hari', 'Chennai', '2025-07-11', 0),
(140, 205, 'Hari', 'Chennai', '2025-07-13', 0),
(141, 205, 'Hari', 'Chennai', '2025-07-15', 0),
(142, 205, 'Hari', 'Chennai', '2025-07-17', 0),
(143, 205, 'Hari', 'Chennai', '2025-07-19', 0),
(144, 205, 'Hari', 'Chennai', '2025-07-21', 0),
(145, 205, 'Hari', 'Chennai', '2025-07-23', 0),
(146, 205, 'Hari', 'Chennai', '2025-07-25', 1),
(147, 205, 'Hari', 'Chennai', '2025-07-27', 0),
(148, 205, 'Hari', 'Chennai', '2025-07-29', 0),
(149, 205, 'Hari', 'Chennai', '2025-07-31', 0),
(150, 205, 'Hari', 'Chennai', '2025-08-02', 0),
(151, 205, 'Hari', 'Chennai', '2025-08-04', 0),
(152, 205, 'Hari', 'Chennai', '2025-08-06', 0);

--- Solution Query

SELECT customer_id, customer_name, COUNT(*) AS total_rides
FROM uber
WHERE city = 'Chennai' 
  AND cancelled = 0
  AND ride_date >= DATEADD(MONTH, -3, GETDATE())
GROUP BY customer_id, customer_name
HAVING COUNT(*) >= 30;


-- Sample Output:
-- +-------------+----------------+-------------+
-- | customer_id | customer_name  | total_rides |
-- +-------------+----------------+-------------+
-- | 202         | Arun           | 35          |
-- | 205         | Hari           | 33          |
-- | 201         | Mani           | 49          |
-- +-------------+----------------+-------------+


--- Explanation

---Filters:
--    - City must be Chennai.
--    - cancelled = 0 means completed rides only.
--    - ride_date is within the last 3 months.
-- HAVING ensures only customers with 30+ completed rides are shown.


