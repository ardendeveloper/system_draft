-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 13, 2015 at 10:24 AM
-- Server version: 5.6.24
-- PHP Version: 5.5.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `system_draft`
--

DELIMITER $$
--
-- Functions
--
DROP FUNCTION IF EXISTS `fn_getTimeIn`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getTimeIn`(logdate varchar(12)) RETURNS varchar(10) CHARSET utf8 COLLATE utf8_unicode_ci
BEGIN
	DECLARE logtime varchar(10);
	SELECT DATE_FORMAT(MIN(tbl_attendance.datetimelog), '%h:%i %p') INTO logtime
    FROM `msi_system`.`tbl_attendance`
    WHERE DATE_FORMAT(`msi_system`.`tbl_attendance`.`datetimelog`,'%m/%d/%Y') = logdate AND tbl_attendance.`event` = 'IN';
    
RETURN logtime;
END$$

DROP FUNCTION IF EXISTS `fn_getTimeOut`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getTimeOut`(logdate varchar(12)) RETURNS varchar(10) CHARSET utf8 COLLATE utf8_unicode_ci
BEGIN
	DECLARE logtime varchar(10);

	SELECT DATE_FORMAT(MIN(tbl_attendance.datetimelog), '%h:%i %p') INTO logtime
    FROM `msi_system`.`tbl_attendance`
    WHERE DATE_FORMAT(`msi_system`.`tbl_attendance`.`datetimelog`,'%m/%d/%Y') = logdate AND tbl_attendance.`event` = 'OUT';
    
RETURN logtime;
END$$

DROP FUNCTION IF EXISTS `fn_getTotalManHours`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getTotalManHours`(id int, start_date datetime, end_date datetime) RETURNS decimal(10,2)
BEGIN
	DECLARE total DECIMAL(10,2);
    #Shift is from 8:00 AM to 5:00 PM
    #Modify shifts in view_attendance view if needed
    
    SELECT SUM(IFNULL(man_hours,0)) INTO total
    FROM view_attendance
    WHERE view_attendance.emp_id = id AND datelog BETWEEN start_date AND end_date;
    
RETURN total;
END$$

DROP FUNCTION IF EXISTS `fn_getTotalOvertime`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getTotalOvertime`(id int, start_date datetime, end_date datetime) RETURNS decimal(10,2)
BEGIN
	DECLARE total DECIMAL(10,2);
    #Shift is from 8:00 AM to 5:00 PM
    #Modify shifts in view_attendance view if needed
    
    SELECT SUM(IFNULL(overtime,0)) INTO total
    FROM view_attendance
    WHERE view_attendance.emp_id = id AND datelog BETWEEN start_date AND end_date;
    
RETURN total;
END$$

DROP FUNCTION IF EXISTS `fn_getTotalTardiness`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_getTotalTardiness`(id int, start_date datetime, end_date datetime) RETURNS decimal(10,2)
BEGIN
	DECLARE total DECIMAL(10,2);
    #Shift is from 8:00 AM to 5:00 PM
    #Modify shifts in view_attendance view if needed
    
    SELECT SUM(IFNULL(tardiness,0))/60 INTO total
    FROM view_attendance
    WHERE view_attendance.emp_id = id AND datelog BETWEEN start_date AND end_date;
    
RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `emp_id` int(5) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `leaves` int(5) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `marital_status` varchar(50) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `barangay` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip` int(50) NOT NULL,
  `country` varchar(100) NOT NULL,
  `mobile_number` int(20) DEFAULT NULL,
  `tel_number` int(20) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `contact_person` varchar(50) DEFAULT NULL,
  `contact_rel` varchar(50) DEFAULT NULL,
  `contact_num` int(20) DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`emp_id`, `first_name`, `middle_name`, `last_name`, `position`, `status`, `department`, `leaves`, `birthday`, `gender`, `marital_status`, `street`, `barangay`, `city`, `state`, `zip`, `country`, `mobile_number`, `tel_number`, `email_address`, `contact_person`, `contact_rel`, `contact_num`, `image`, `date_added`) VALUES
(1, 'Arden', 'Alcairo', 'Dela Cruz', 'CEOs', 'Regular', 'Executive', 22, '0000-00-00', 'male', 'Single', '12', 'qwqw', 'manda', 'manila', 999, 'Philippines', 123, 123, 'ardents02@gmail.com', 'ardents', 'asdasd', 123123, 'loader2.gif', '2015-06-30 07:00:00'),
(2, 'Yvonne', 'Franklin', 'Beach', 'Avye', 'Joy', 'Laoreet Posuere Enim PC', 3, '2015-12-26', 'female', 'Married', '1793 Nulla Rd.', 'Ada', 'Ceyhan', 'Diyarbak?r', 71652, 'Mali', 7624, 0, 'sapien@lectusquismassa.ca', 'Thor Y. Terry', 'Mr.', 278, '', '2016-02-08 08:00:00'),
(3, 'Ashely', 'Hensley', 'Delgado', 'Ross', 'Jenette', 'Ante Consulting', 4, '2015-06-09', 'female', 'Married', '375 Sagittis Road', 'SL', 'Sosnowiec', 'CV', 40205, 'Saint Pierre and Miquelon', 0, 0, 'Etiam.bibendum.fermentum@ullamcorperDuiscursus.org', 'Deacon K. Frye', 'Mrs.', 335, '', '2015-05-09 07:00:00'),
(4, 'Illana', 'Avery', 'Zamora', 'Pearl', 'Kelsie', 'Mi LLC', 6, '2016-06-14', 'female', 'Single', 'Ap #549-9677 Tortor Avenue', 'BA', 'Vitória da Conquista', 'North Island', 453128, 'Saint Vincent and The Grenadines', 500, 800, 'Duis.mi.enim@malesuadafamesac.org', 'Tallulah B. Levy', 'Ms.', 1, '', '2015-06-03 07:00:00'),
(5, 'Phillip', 'Peck', 'Cameron', 'Oliver', 'Isabella', 'Velit Quisque Foundation', 0, '2015-07-16', 'male', 'Widowed', 'P.O. Box 616, 5935 Vel, St.', '?z', 'Tire', 'AK', 35724, 'Saint Pierre and Miquelon', 0, 7624, 'lacus@adipiscinglobortis.net', 'Griffith W. Sawyer', 'Dr.', 1, '', '2014-10-23 07:00:00'),
(6, 'Virginia', 'Curry', 'Mendoza', 'Cameran', 'Ginger', 'Velit Justo Nec Inc.', 7, '2015-06-23', 'male', 'Single', '6319 Odio. St.', 'Hesse', 'Obertshausen', 'Luxemburg', 0, 'Gambia', 0, 0, 'molestie.sodales.Mauris@mauris.edu', 'Yardley K. Kennedy', 'Ms.', 978, '', '2015-06-14 07:00:00'),
(7, 'Abel', 'King', 'Ford', 'Todd', 'Thane', 'Ornare In Corp.', 10, '2016-06-04', 'male', 'Single', '637 Dui. St.', 'Aragón', 'Zaragoza', 'RJ', 14743, 'Niger', 800, 0, 'Nunc@ante.net', 'Hoyt F. Grimes', 'Dr.', 982, '', '2014-08-14 07:00:00'),
(8, 'Kendall', 'Bright', 'Cameron', 'Beau', 'Giacomo', 'Arcu Sed Et Consulting', 10, '2016-04-10', 'female', 'Single', '984-3608 Pede. Rd.', 'South Australia', 'Whyalla', 'YT', 1077, 'El Salvador', 76, 800, 'Nunc@tellusAenean.edu', 'Wanda L. Cain', '', 1, '', '2015-11-07 08:00:00'),
(9, 'Brittany', 'French', 'Gray', 'Imogene', 'Odysseus', 'Ac Arcu Institute', -4, '2014-09-21', 'female', 'Widowed', 'Ap #165-4162 Fusce Avenue', 'Ist', 'Istanbul', 'Bur', 82667, 'Micronesia', 800, 7624, 'imperdiet.ullamcorper@euismodin.com', 'Ulric V. Kidd', 'Ms.', 189, '', '2015-08-24 07:00:00'),
(10, 'Amir', 'Hernandez', 'Herrera', 'Nigel', 'Kellie', 'Sem Molestie Inc.', -1, '2015-06-09', 'female', 'Single', 'Ap #913-4290 Massa. Rd.', 'Istanbul', 'Istanbul', 'Leinster', 0, 'Liechtenstein', 7850, 76, 'tincidunt.orci@vulputatemauris.co.uk', 'Hamilton Q. Townsend', 'Dr.', 1, '', '2015-01-26 08:00:00'),
(11, 'q', 'q', '61300', 'Manager', 'Contractual', 'Marketing', 0, '2015-07-01', 'q', 'married', '12', 'qwqw', 'manda', 'manila', 999, 'Philippines', 123, 123, 'asdsadsadsad@gmail.com', 'PNoy', 'Kumpare', 12312321, '', '2015-07-12 14:39:19'),
(12, 'Sheldon', 'q', '61300', 'Manager', 'Contractual', 'Marketing', 0, '2015-10-14', 'Sheldon', 'single', 'w', 'qwqw', 'manda', 'manila', 999, 'Philippines', 123, 123, 'asdsadsadsad@gmail.com', 'PNoy', 'Kumpare', 12312321, '', '2015-07-13 11:41:09'),
(13, 'Neil', 'Crist', 'Resnera', 'Manager', 'Contractual', 'IT', 7, '0000-00-00', '', 'Single', '12', 'Kalentong', 'Mandaluyong', 'Metro Manila', 999, 'Philippines', 123, 123, 'asdsadsadsad@gmail.com', 'ERAP', 'Kumpare', 12312321, '', '2015-07-13 11:54:49');

-- --------------------------------------------------------

--
-- Table structure for table `emp_performance`
--

DROP TABLE IF EXISTS `emp_performance`;
CREATE TABLE IF NOT EXISTS `emp_performance` (
  `performance_id` int(5) NOT NULL,
  `employee_name` varchar(255) DEFAULT NULL,
  `evaluators` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `criteria1` varchar(100) DEFAULT NULL,
  `criteria2` varchar(100) DEFAULT NULL,
  `criteria3` varchar(100) DEFAULT NULL,
  `criteria4` varchar(100) DEFAULT NULL,
  `criteria5` varchar(100) DEFAULT NULL,
  `rate1` decimal(3,2) DEFAULT NULL,
  `rate2` decimal(3,2) DEFAULT NULL,
  `rate3` decimal(3,2) DEFAULT NULL,
  `rate4` decimal(3,2) DEFAULT NULL,
  `rate5` decimal(3,2) DEFAULT NULL,
  `final_rating` decimal(3,2) DEFAULT NULL,
  `date_evaluated` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emp_performance`
--

INSERT INTO `emp_performance` (`performance_id`, `employee_name`, `evaluators`, `description`, `criteria1`, `criteria2`, `criteria3`, `criteria4`, `criteria5`, `rate1`, `rate2`, `rate3`, `rate4`, `rate5`, `final_rating`, `date_evaluated`) VALUES
(1, 'Arden Alcairo Dela Cruz', 'Arden', '', '', '', '', '', '', '1.00', '1.00', '1.00', '1.00', '1.00', '1.00', '2015-06-30 04:38:40'),
(2, 'Yvonne Franklin Beach', 'Arden', 'Some Title', 'Are you hungry?', 'Are you pretty?', 'Are you satisfied with this company?', 'Do you want to build a snowman?', 'Do you wanna come out and play?', '5.00', '4.00', '2.00', '5.00', '4.00', '4.00', '2015-07-01 04:25:31'),
(3, 'Yvonne Franklin Beach', 'Arden', 'Some Title', 'Are you hungry?', 'Are you pretty?', 'Are you satisfied with this company?', 'Do you want to build a snowman?', 'Do you wanna come out and play?', '2.00', '4.00', '3.00', '3.00', '5.00', '3.40', '2015-07-01 11:51:03'),
(4, 'Arden Alcairo Dela Cruz', 'Arden', 'Some Title', 'q', 'q', 'q', 'q', 'q', '1.00', '2.00', '3.00', '4.00', '1.00', '2.20', '2015-07-03 19:50:20'),
(5, 'Arden Alcairo Dela Cruz', 'Arden', 'TitleFucker', 'q', 'q', 'q', 'q', 'q', '2.00', '3.00', '2.00', '4.00', '2.00', '2.60', '2015-07-03 19:55:19'),
(6, 'Arden Alcairo Dela Cruz', 'Arden', 'TitleFucker', 'e', 'e', 'e', 'e', 'e', '1.00', '1.00', '1.00', '1.00', '1.00', '1.00', '2015-07-03 20:00:30'),
(7, '  ', 'Arden', 'TitleFucker', 'e', 'e', 'e', 'e', 'e', '1.00', '1.00', '1.00', '1.00', '1.00', '1.00', '2015-07-03 20:02:11'),
(8, 'Arden Alcairo Dela Cruz', 'Arden', 'TitleFucker', 'w', 'w', 'w', 'w', 'w', '1.00', '1.00', '1.00', '1.00', '1.00', '1.00', '2015-07-03 20:02:53'),
(9, 'Ardenx Alcairo Dela Cruz', 'Ardenx', 'Some Title', 'qwe1', 'qwe2', 'qwe3', 'qwe4', 'qwe5', '2.00', '3.00', '3.00', '3.00', '4.00', '3.00', '2015-07-11 11:40:32'),
(10, 'Ardenx Alcairo Dela Cruz', 'Ardenx', 'TitleFucker', 'qwe1', 'qwe2', 'qwe3', 'qwe4', 'qwe5', '2.00', '2.00', '4.00', '5.00', '2.00', '3.00', '2015-07-11 11:45:58'),
(11, 'e e e', 'Arden', 'End of Project Evaluation', 'Lorem1', 'Lorem2', 'Lorem3', 'Lorem4', 'Lorem5', '1.00', '2.00', '3.00', '4.00', '5.00', '3.00', '2015-08-12 09:20:27');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `id` mediumint(8) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
(1, 'admin', 'Administrator'),
(2, 'members', 'General User');

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

DROP TABLE IF EXISTS `login_attempts`;
CREATE TABLE IF NOT EXISTS `login_attempts` (
  `id` int(11) unsigned NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_201_file`
--

DROP TABLE IF EXISTS `tbl_201_file`;
CREATE TABLE IF NOT EXISTS `tbl_201_file` (
  `file_id` varchar(10) NOT NULL,
  `file_name` varchar(50) DEFAULT NULL,
  `emp_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_address`
--

DROP TABLE IF EXISTS `tbl_address`;
CREATE TABLE IF NOT EXISTS `tbl_address` (
  `employee_id` int(5) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `barangay` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip` int(10) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_address`
--

INSERT INTO `tbl_address` (`employee_id`, `street`, `barangay`, `city`, `state`, `zip`, `country`) VALUES
(100, '577', 'Maybunga', 'PSG', 'Metro Manila', 1607, 'Philippines'),
(1, '577', 'Maybunga', 'Pasig City', 'Metro Manila', 1607, 'Philippines'),
(3, 'e', 'e', 'e', 'e', 2, 'e'),
(20, 'e', 'e', 'e', 'e', 0, 'e');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_allowances`
--

DROP TABLE IF EXISTS `tbl_allowances`;
CREATE TABLE IF NOT EXISTS `tbl_allowances` (
  `allowance_id` int(11) NOT NULL,
  `allowance_name` varchar(50) NOT NULL,
  `percentage` decimal(3,3) NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_allowances`
--

INSERT INTO `tbl_allowances` (`allowance_id`, `allowance_name`, `percentage`, `amount`, `active`) VALUES
(1, 'Communication Allowance', '0.000', '300.00', 1),
(2, 'Transportation Allowance', '0.000', '200.00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_assets`
--

DROP TABLE IF EXISTS `tbl_assets`;
CREATE TABLE IF NOT EXISTS `tbl_assets` (
  `asset_id` varchar(10) DEFAULT NULL,
  `employee_id` varchar(10) DEFAULT NULL,
  `asset_status` varchar(255) DEFAULT NULL,
  `assigned_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_assets`
--

INSERT INTO `tbl_assets` (`asset_id`, `employee_id`, `asset_status`, `assigned_date`) VALUES
('EQ1001', '2', 'Brand New', '2015-07-20 00:00:00'),
('EQ1002', '1', 'Damaged', '2015-07-14 00:00:00'),
('EQ1003', '3', '2nd Hand', '2015-07-12 20:46:13'),
('EQ1004', '4', 'Brand New', '2015-07-20 00:00:00'),
('EQ1005', '5', 'Damaged', '2015-07-21 00:00:00'),
('EQ1006', '6', 'Brand New', '2015-07-20 00:00:00'),
('EQ1007', '7', 'Damaged', '2015-07-14 00:00:00'),
('EQ1008', '8', '2nd Hand', '2015-07-12 20:46:13'),
('EQ1009', '9', 'Brand New', '2015-07-20 00:00:00'),
('EQ10010', '10', 'Damaged', '2015-07-21 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_asset_info`
--

DROP TABLE IF EXISTS `tbl_asset_info`;
CREATE TABLE IF NOT EXISTS `tbl_asset_info` (
  `asset_id` varchar(10) NOT NULL,
  `asset_name` varchar(50) DEFAULT NULL,
  `asset_description` varchar(100) DEFAULT NULL,
  `category_id` varchar(50) NOT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `serial_number` int(20) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `vendor_id` varchar(10) DEFAULT NULL,
  `warranty_end_date` date DEFAULT NULL,
  `date_acquired` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_asset_info`
--

INSERT INTO `tbl_asset_info` (`asset_id`, `asset_name`, `asset_description`, `category_id`, `brand`, `serial_number`, `model`, `vendor_id`, `warranty_end_date`, `date_acquired`) VALUES
('EQ1001', 'Toshiba Laptop', 'It is an awesome laptop.', 'COMP', 'Toshiba', 1231231, 'Satellite S10', 'VEN1001', '2015-07-25', '2015-07-18'),
('EQ1002', 'Office Table', 'It is a table. Duh!', 'WD', 'Unbranded', 1231231, '', 'VEN1001', '2015-08-29', '2015-07-18'),
('EQ1003', 'Zanpaktou', 'Sharp Sword', 'PLSTC', 'Unbranded', 1231231, 'N/A', 'VEN1001', '2015-07-21', '2015-07-13'),
('EQ1004', 'Steel Chair', 'Steel Chair for Wrestling', 'STL', 'Unbranded', 1231231, 'N/A', 'VEN1001', NULL, '2015-07-21'),
('EQ1005', 'Martilyo ni Thor!''', 'Sharp Sword', 'PLSTC', 'CD R-king', 1231231, 'Super Model', 'VEN1001', '2015-07-22', '2015-07-02'),
('EQ1006', 'Iron Man Suit', 'It is an awesome laptop.', 'COMP', 'Toshiba', 1111111111, 'Satellite S10', 'VEN1001', '2015-07-25', '2015-07-18'),
('EQ1007', 'Batman Mask', 'It is a table. Duh!', 'WD', 'Unbranded', 1231231, '', 'VEN1001', '2015-08-29', '2015-07-18'),
('EQ1008', 'Superman Cape', 'Sharp Sword', 'ELEC', 'Unbranded', 1231231, 'N/A', 'VEN1001', '2015-07-21', '2015-07-13'),
('EQ1009', 'Wolverine Claw', 'Steel Chair for Wrestling', 'SC', 'Unbranded', 1231231, 'N/A', 'VEN1001', '0000-00-00', '2015-07-21'),
('EQ1010', 'Hulk Formula', 'Sharp Sword', 'SC', 'CD R-king', 1231231, 'Super Model', 'VEN1001', '2015-07-22', '2015-07-02');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_attendance`
--

DROP TABLE IF EXISTS `tbl_attendance`;
CREATE TABLE IF NOT EXISTS `tbl_attendance` (
  `attendance_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `datelog` datetime DEFAULT NULL,
  `datetimelog` datetime NOT NULL,
  `event` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `datetimefetch` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_attendance`
--

INSERT INTO `tbl_attendance` (`attendance_id`, `emp_id`, `datelog`, `datetimelog`, `event`, `datetimefetch`) VALUES
(1, 1, '2015-06-05 00:00:00', '2015-06-05 06:28:36', 'IN', '2015-06-05 06:30:00'),
(2, 1, '2015-06-05 00:00:00', '2015-06-05 06:28:36', 'IN', '2015-06-05 06:30:00'),
(3, 1, '2015-06-01 00:00:00', '2015-06-01 07:28:36', 'IN', '2015-06-05 06:30:00'),
(4, 1, '2015-06-01 00:00:00', '2015-06-01 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(5, 1, '2015-06-02 00:00:00', '2015-06-02 07:28:36', 'IN', '2015-06-05 06:30:00'),
(6, 1, '2015-06-02 00:00:00', '2015-06-02 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(7, 1, '2015-06-03 00:00:00', '2015-06-03 07:28:36', 'IN', '2015-06-05 06:30:00'),
(8, 1, '2015-06-03 00:00:00', '2015-06-03 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(9, 1, '2015-06-04 00:00:00', '2015-06-04 07:28:36', 'IN', '2015-06-05 06:30:00'),
(10, 1, '2015-06-04 00:00:00', '2015-06-04 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(11, 1, '2015-06-05 00:00:00', '2015-06-05 07:28:36', 'IN', '2015-06-05 06:30:00'),
(12, 1, '2015-06-05 00:00:00', '2015-06-05 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(13, 1, '2015-06-08 00:00:00', '2015-06-08 07:28:36', 'IN', '2015-06-05 06:30:00'),
(14, 1, '2015-06-08 00:00:00', '2015-06-08 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(17, 1, '2015-06-10 00:00:00', '2015-06-10 07:28:36', 'IN', '2015-06-05 06:30:00'),
(18, 1, '2015-06-10 00:00:00', '2015-06-10 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(19, 1, '2015-06-11 00:00:00', '2015-06-11 07:28:36', 'IN', '2015-06-05 06:30:00'),
(20, 1, '2015-06-11 00:00:00', '2015-06-11 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(21, 1, '2015-06-12 00:00:00', '2015-06-12 07:28:36', 'IN', '2015-06-05 06:30:00'),
(22, 1, '2015-06-12 00:00:00', '2015-06-12 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(23, 7, '2015-06-01 00:00:00', '2015-06-01 07:28:36', 'IN', '2015-06-05 06:30:00'),
(24, 7, '2015-06-01 00:00:00', '2015-06-01 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(25, 7, '2015-06-02 00:00:00', '2015-06-02 07:28:36', 'IN', '2015-06-05 06:30:00'),
(26, 7, '2015-06-02 00:00:00', '2015-06-02 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(27, 7, '2015-06-03 00:00:00', '2015-06-03 07:28:36', 'IN', '2015-06-05 06:30:00'),
(28, 7, '2015-06-03 00:00:00', '2015-06-03 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(29, 7, '2015-06-04 00:00:00', '2015-06-04 07:28:36', 'IN', '2015-06-05 06:30:00'),
(30, 7, '2015-06-04 00:00:00', '2015-06-04 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(31, 7, '2015-06-05 00:00:00', '2015-06-05 07:28:36', 'IN', '2015-06-05 06:30:00'),
(32, 7, '2015-06-05 00:00:00', '2015-06-05 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(33, 7, '2015-06-08 00:00:00', '2015-06-08 07:28:36', 'IN', '2015-06-05 06:30:00'),
(34, 7, '2015-06-08 00:00:00', '2015-06-08 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(35, 7, '2015-06-09 00:00:00', '2015-06-09 07:28:36', 'IN', '2015-06-05 06:30:00'),
(36, 7, '2015-06-09 00:00:00', '2015-06-09 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(37, 7, '2015-06-10 00:00:00', '2015-06-10 07:28:36', 'IN', '2015-06-05 06:30:00'),
(38, 7, '2015-06-10 00:00:00', '2015-06-10 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(39, 7, '2015-06-11 00:00:00', '2015-06-11 07:28:36', 'IN', '2015-06-05 06:30:00'),
(40, 7, '2015-06-11 00:00:00', '2015-06-11 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(41, 7, '2015-06-12 00:00:00', '2015-06-12 07:28:36', 'IN', '2015-06-05 06:30:00'),
(42, 7, '2015-06-12 00:00:00', '2015-06-12 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(43, 8, '2015-06-01 00:00:00', '2015-06-01 07:28:36', 'IN', '2015-06-05 06:30:00'),
(44, 8, '2015-06-01 00:00:00', '2015-06-01 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(45, 8, '2015-06-02 00:00:00', '2015-06-02 07:28:36', 'IN', '2015-06-05 06:30:00'),
(46, 8, '2015-06-02 00:00:00', '2015-06-02 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(47, 8, '2015-06-03 00:00:00', '2015-06-03 07:28:36', 'IN', '2015-06-05 06:30:00'),
(48, 8, '2015-06-03 00:00:00', '2015-06-03 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(49, 8, '2015-06-04 00:00:00', '2015-06-04 07:28:36', 'IN', '2015-06-05 06:30:00'),
(50, 8, '2015-06-04 00:00:00', '2015-06-04 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(51, 8, '2015-06-05 00:00:00', '2015-06-05 07:28:36', 'IN', '2015-06-05 06:30:00'),
(52, 8, '2015-06-05 00:00:00', '2015-06-05 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(53, 8, '2015-06-08 00:00:00', '2015-06-08 07:28:36', 'IN', '2015-06-05 06:30:00'),
(54, 8, '2015-06-08 00:00:00', '2015-06-08 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(55, 8, '2015-06-09 00:00:00', '2015-06-09 07:28:36', 'IN', '2015-06-05 06:30:00'),
(56, 8, '2015-06-09 00:00:00', '2015-06-09 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(57, 8, '2015-06-10 00:00:00', '2015-06-10 07:28:36', 'IN', '2015-06-05 06:30:00'),
(58, 8, '2015-06-10 00:00:00', '2015-06-10 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(59, 8, '2015-06-11 00:00:00', '2015-06-11 07:28:36', 'IN', '2015-06-05 06:30:00'),
(60, 8, '2015-06-11 00:00:00', '2015-06-11 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(61, 8, '2015-06-12 00:00:00', '2015-06-12 07:28:36', 'IN', '2015-06-05 06:30:00'),
(62, 8, '2015-06-12 00:00:00', '2015-06-12 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(63, 9, '2015-06-01 00:00:00', '2015-06-01 07:28:36', 'IN', '2015-06-05 06:30:00'),
(64, 9, '2015-06-01 00:00:00', '2015-06-01 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(65, 9, '2015-06-02 00:00:00', '2015-06-02 07:28:36', 'IN', '2015-06-05 06:30:00'),
(66, 9, '2015-06-02 00:00:00', '2015-06-02 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(67, 9, '2015-06-03 00:00:00', '2015-06-03 07:28:36', 'IN', '2015-06-05 06:30:00'),
(68, 9, '2015-06-03 00:00:00', '2015-06-03 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(69, 9, '2015-06-04 00:00:00', '2015-06-04 07:28:36', 'IN', '2015-06-05 06:30:00'),
(70, 9, '2015-06-04 00:00:00', '2015-06-04 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(71, 9, '2015-06-05 00:00:00', '2015-06-05 07:28:36', 'IN', '2015-06-05 06:30:00'),
(72, 9, '2015-06-05 00:00:00', '2015-06-05 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(73, 9, '2015-06-08 00:00:00', '2015-06-08 07:28:36', 'IN', '2015-06-05 06:30:00'),
(74, 9, '2015-06-08 00:00:00', '2015-06-08 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(75, 9, '2015-06-09 00:00:00', '2015-06-09 07:28:36', 'IN', '2015-06-05 06:30:00'),
(76, 9, '2015-06-09 00:00:00', '2015-06-09 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(77, 9, '2015-06-10 00:00:00', '2015-06-10 07:28:36', 'IN', '2015-06-05 06:30:00'),
(78, 9, '2015-06-10 00:00:00', '2015-06-10 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(79, 9, '2015-06-11 00:00:00', '2015-06-11 07:28:36', 'IN', '2015-06-05 06:30:00'),
(80, 9, '2015-06-11 00:00:00', '2015-06-11 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(81, 9, '2015-06-12 00:00:00', '2015-06-12 07:28:36', 'IN', '2015-06-05 06:30:00'),
(82, 9, '2015-06-12 00:00:00', '2015-06-12 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(83, 10, '2015-06-01 00:00:00', '2015-06-01 07:28:36', 'IN', '2015-06-05 06:30:00'),
(84, 10, '2015-06-01 00:00:00', '2015-06-01 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(85, 10, '2015-06-02 00:00:00', '2015-06-02 07:28:36', 'IN', '2015-06-05 06:30:00'),
(86, 10, '2015-06-02 00:00:00', '2015-06-02 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(87, 10, '2015-06-03 00:00:00', '2015-06-03 07:28:36', 'IN', '2015-06-05 06:30:00'),
(88, 10, '2015-06-03 00:00:00', '2015-06-03 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(89, 10, '2015-06-04 00:00:00', '2015-06-04 07:28:36', 'IN', '2015-06-05 06:30:00'),
(90, 10, '2015-06-04 00:00:00', '2015-06-04 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(91, 10, '2015-06-05 00:00:00', '2015-06-05 07:28:36', 'IN', '2015-06-05 06:30:00'),
(92, 10, '2015-06-05 00:00:00', '2015-06-05 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(93, 10, '2015-06-08 00:00:00', '2015-06-08 07:28:36', 'IN', '2015-06-05 06:30:00'),
(94, 10, '2015-06-08 00:00:00', '2015-06-08 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(95, 10, '2015-06-09 00:00:00', '2015-06-09 07:28:36', 'IN', '2015-06-05 06:30:00'),
(96, 10, '2015-06-09 00:00:00', '2015-06-09 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(97, 10, '2015-06-10 00:00:00', '2015-06-10 07:28:36', 'IN', '2015-06-05 06:30:00'),
(98, 10, '2015-06-10 00:00:00', '2015-06-10 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(99, 10, '2015-06-11 00:00:00', '2015-06-11 07:28:36', 'IN', '2015-06-05 06:30:00'),
(100, 10, '2015-06-11 00:00:00', '2015-06-11 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(101, 10, '2015-06-12 00:00:00', '2015-06-12 07:28:36', 'IN', '2015-06-05 06:30:00'),
(102, 10, '2015-06-12 00:00:00', '2015-06-12 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(103, 11, '2015-06-01 00:00:00', '2015-06-01 07:28:36', 'IN', '2015-06-05 06:30:00'),
(104, 11, '2015-06-01 00:00:00', '2015-06-01 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(105, 11, '2015-06-02 00:00:00', '2015-06-02 07:28:36', 'IN', '2015-06-05 06:30:00'),
(106, 11, '2015-06-02 00:00:00', '2015-06-02 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(107, 11, '2015-06-03 00:00:00', '2015-06-03 07:28:36', 'IN', '2015-06-05 06:30:00'),
(108, 11, '2015-06-03 00:00:00', '2015-06-03 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(109, 11, '2015-06-04 00:00:00', '2015-06-04 07:28:36', 'IN', '2015-06-05 06:30:00'),
(110, 11, '2015-06-04 00:00:00', '2015-06-04 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(111, 11, '2015-06-05 00:00:00', '2015-06-05 07:28:36', 'IN', '2015-06-05 06:30:00'),
(112, 11, '2015-06-05 00:00:00', '2015-06-05 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(113, 11, '2015-06-08 00:00:00', '2015-06-08 07:28:36', 'IN', '2015-06-05 06:30:00'),
(114, 11, '2015-06-08 00:00:00', '2015-06-08 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(115, 11, '2015-06-09 00:00:00', '2015-06-09 07:28:36', 'IN', '2015-06-05 06:30:00'),
(116, 11, '2015-06-09 00:00:00', '2015-06-09 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(117, 11, '2015-06-10 00:00:00', '2015-06-10 07:28:36', 'IN', '2015-06-05 06:30:00'),
(118, 11, '2015-06-10 00:00:00', '2015-06-10 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(119, 11, '2015-06-11 00:00:00', '2015-06-11 07:28:36', 'IN', '2015-06-05 06:30:00'),
(120, 11, '2015-06-11 00:00:00', '2015-06-11 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(121, 11, '2015-06-12 00:00:00', '2015-06-12 07:28:36', 'IN', '2015-06-05 06:30:00'),
(122, 11, '2015-06-12 00:00:00', '2015-06-12 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(123, 1, '2015-06-01 00:00:00', '2015-06-01 07:28:36', 'IN', '2015-06-05 06:30:00'),
(124, 1, '2015-06-01 00:00:00', '2015-06-01 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(125, 1, '2015-06-02 00:00:00', '2015-06-02 07:28:36', 'IN', '2015-06-05 06:30:00'),
(126, 1, '2015-06-02 00:00:00', '2015-06-02 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(127, 1, '2015-06-03 00:00:00', '2015-06-03 07:28:36', 'IN', '2015-06-05 06:30:00'),
(128, 1, '2015-06-03 00:00:00', '2015-06-03 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(129, 1, '2015-06-04 00:00:00', '2015-06-04 07:28:36', 'IN', '2015-06-05 06:30:00'),
(130, 1, '2015-06-04 00:00:00', '2015-06-04 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(131, 1, '2015-06-05 00:00:00', '2015-06-05 07:28:36', 'IN', '2015-06-05 06:30:00'),
(132, 1, '2015-06-05 00:00:00', '2015-06-05 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(133, 1, '2015-06-08 00:00:00', '2015-06-08 07:28:36', 'IN', '2015-06-05 06:30:00'),
(134, 1, '2015-06-08 00:00:00', '2015-06-08 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(137, 1, '2015-06-10 00:00:00', '2015-06-10 07:28:36', 'IN', '2015-06-05 06:30:00'),
(138, 1, '2015-06-10 00:00:00', '2015-06-10 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(139, 1, '2015-06-11 00:00:00', '2015-06-11 07:28:36', 'IN', '2015-06-05 06:30:00'),
(140, 1, '2015-06-11 00:00:00', '2015-06-11 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(141, 1, '2015-06-12 00:00:00', '2015-06-12 07:28:36', 'IN', '2015-06-05 06:30:00'),
(142, 1, '2015-06-12 00:00:00', '2015-06-12 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(143, 7, '2015-06-01 00:00:00', '2015-06-01 07:28:36', 'IN', '2015-06-05 06:30:00'),
(144, 7, '2015-06-01 00:00:00', '2015-06-01 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(145, 7, '2015-06-02 00:00:00', '2015-06-02 07:28:36', 'IN', '2015-06-05 06:30:00'),
(146, 7, '2015-06-02 00:00:00', '2015-06-02 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(147, 7, '2015-06-03 00:00:00', '2015-06-03 07:28:36', 'IN', '2015-06-05 06:30:00'),
(148, 7, '2015-06-03 00:00:00', '2015-06-03 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(149, 7, '2015-06-04 00:00:00', '2015-06-04 07:28:36', 'IN', '2015-06-05 06:30:00'),
(150, 7, '2015-06-04 00:00:00', '2015-06-04 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(151, 7, '2015-06-05 00:00:00', '2015-06-05 07:28:36', 'IN', '2015-06-05 06:30:00'),
(152, 7, '2015-06-05 00:00:00', '2015-06-05 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(153, 7, '2015-06-08 00:00:00', '2015-06-08 07:28:36', 'IN', '2015-06-05 06:30:00'),
(154, 7, '2015-06-08 00:00:00', '2015-06-08 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(155, 7, '2015-06-09 00:00:00', '2015-06-09 07:28:36', 'IN', '2015-06-05 06:30:00'),
(156, 7, '2015-06-09 00:00:00', '2015-06-09 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(157, 7, '2015-06-10 00:00:00', '2015-06-10 07:28:36', 'IN', '2015-06-05 06:30:00'),
(158, 7, '2015-06-10 00:00:00', '2015-06-10 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(159, 7, '2015-06-11 00:00:00', '2015-06-11 07:28:36', 'IN', '2015-06-05 06:30:00'),
(160, 7, '2015-06-11 00:00:00', '2015-06-11 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(161, 7, '2015-06-12 00:00:00', '2015-06-12 07:28:36', 'IN', '2015-06-05 06:30:00'),
(162, 7, '2015-06-12 00:00:00', '2015-06-12 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(163, 8, '2015-06-01 00:00:00', '2015-06-01 07:28:36', 'IN', '2015-06-05 06:30:00'),
(164, 8, '2015-06-01 00:00:00', '2015-06-01 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(165, 8, '2015-06-02 00:00:00', '2015-06-02 07:28:36', 'IN', '2015-06-05 06:30:00'),
(166, 8, '2015-06-02 00:00:00', '2015-06-02 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(167, 8, '2015-06-03 00:00:00', '2015-06-03 07:28:36', 'IN', '2015-06-05 06:30:00'),
(168, 8, '2015-06-03 00:00:00', '2015-06-03 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(169, 8, '2015-06-04 00:00:00', '2015-06-04 07:28:36', 'IN', '2015-06-05 06:30:00'),
(170, 8, '2015-06-04 00:00:00', '2015-06-04 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(171, 8, '2015-06-05 00:00:00', '2015-06-05 07:28:36', 'IN', '2015-06-05 06:30:00'),
(172, 8, '2015-06-05 00:00:00', '2015-06-05 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(173, 8, '2015-06-08 00:00:00', '2015-06-08 07:28:36', 'IN', '2015-06-05 06:30:00'),
(174, 8, '2015-06-08 00:00:00', '2015-06-08 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(175, 8, '2015-06-09 00:00:00', '2015-06-09 07:28:36', 'IN', '2015-06-05 06:30:00'),
(176, 8, '2015-06-09 00:00:00', '2015-06-09 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(177, 8, '2015-06-10 00:00:00', '2015-06-10 07:28:36', 'IN', '2015-06-05 06:30:00'),
(178, 8, '2015-06-10 00:00:00', '2015-06-10 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(179, 8, '2015-06-11 00:00:00', '2015-06-11 07:28:36', 'IN', '2015-06-05 06:30:00'),
(180, 8, '2015-06-11 00:00:00', '2015-06-11 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(181, 8, '2015-06-12 00:00:00', '2015-06-12 07:28:36', 'IN', '2015-06-05 06:30:00'),
(182, 8, '2015-06-12 00:00:00', '2015-06-12 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(183, 9, '2015-06-01 00:00:00', '2015-06-01 07:28:36', 'IN', '2015-06-05 06:30:00'),
(184, 9, '2015-06-01 00:00:00', '2015-06-01 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(185, 9, '2015-06-02 00:00:00', '2015-06-02 07:28:36', 'IN', '2015-06-05 06:30:00'),
(186, 9, '2015-06-02 00:00:00', '2015-06-02 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(187, 9, '2015-06-03 00:00:00', '2015-06-03 07:28:36', 'IN', '2015-06-05 06:30:00'),
(188, 9, '2015-06-03 00:00:00', '2015-06-03 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(189, 9, '2015-06-04 00:00:00', '2015-06-04 07:28:36', 'IN', '2015-06-05 06:30:00'),
(190, 9, '2015-06-04 00:00:00', '2015-06-04 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(191, 9, '2015-06-05 00:00:00', '2015-06-05 07:28:36', 'IN', '2015-06-05 06:30:00'),
(192, 9, '2015-06-05 00:00:00', '2015-06-05 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(193, 9, '2015-06-08 00:00:00', '2015-06-08 07:28:36', 'IN', '2015-06-05 06:30:00'),
(194, 9, '2015-06-08 00:00:00', '2015-06-08 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(195, 9, '2015-06-09 00:00:00', '2015-06-09 07:28:36', 'IN', '2015-06-05 06:30:00'),
(196, 9, '2015-06-09 00:00:00', '2015-06-09 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(197, 9, '2015-06-10 00:00:00', '2015-06-10 07:28:36', 'IN', '2015-06-05 06:30:00'),
(198, 9, '2015-06-10 00:00:00', '2015-06-10 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(199, 9, '2015-06-11 00:00:00', '2015-06-11 07:28:36', 'IN', '2015-06-05 06:30:00'),
(200, 9, '2015-06-11 00:00:00', '2015-06-11 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(201, 9, '2015-06-12 00:00:00', '2015-06-12 07:28:36', 'IN', '2015-06-05 06:30:00'),
(202, 9, '2015-06-12 00:00:00', '2015-06-12 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(203, 10, '2015-06-01 00:00:00', '2015-06-01 07:28:36', 'IN', '2015-06-05 06:30:00'),
(204, 10, '2015-06-01 00:00:00', '2015-06-01 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(205, 10, '2015-06-02 00:00:00', '2015-06-02 07:28:36', 'IN', '2015-06-05 06:30:00'),
(206, 10, '2015-06-02 00:00:00', '2015-06-02 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(207, 10, '2015-06-03 00:00:00', '2015-06-03 07:28:36', 'IN', '2015-06-05 06:30:00'),
(208, 10, '2015-06-03 00:00:00', '2015-06-03 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(209, 10, '2015-06-04 00:00:00', '2015-06-04 07:28:36', 'IN', '2015-06-05 06:30:00'),
(210, 10, '2015-06-04 00:00:00', '2015-06-04 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(211, 10, '2015-06-05 00:00:00', '2015-06-05 07:28:36', 'IN', '2015-06-05 06:30:00'),
(212, 10, '2015-06-05 00:00:00', '2015-06-05 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(213, 10, '2015-06-08 00:00:00', '2015-06-08 07:28:36', 'IN', '2015-06-05 06:30:00'),
(214, 10, '2015-06-08 00:00:00', '2015-06-08 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(215, 10, '2015-06-09 00:00:00', '2015-06-09 07:28:36', 'IN', '2015-06-05 06:30:00'),
(216, 10, '2015-06-09 00:00:00', '2015-06-09 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(217, 10, '2015-06-10 00:00:00', '2015-06-10 07:28:36', 'IN', '2015-06-05 06:30:00'),
(218, 10, '2015-06-10 00:00:00', '2015-06-10 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(219, 10, '2015-06-11 00:00:00', '2015-06-11 07:28:36', 'IN', '2015-06-05 06:30:00'),
(220, 10, '2015-06-11 00:00:00', '2015-06-11 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(221, 10, '2015-06-12 00:00:00', '2015-06-12 07:28:36', 'IN', '2015-06-05 06:30:00'),
(222, 10, '2015-06-12 00:00:00', '2015-06-12 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(223, 11, '2015-06-01 00:00:00', '2015-06-01 07:28:36', 'IN', '2015-06-05 06:30:00'),
(224, 11, '2015-06-01 00:00:00', '2015-06-01 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(225, 11, '2015-06-02 00:00:00', '2015-06-02 07:28:36', 'IN', '2015-06-05 06:30:00'),
(226, 11, '2015-06-02 00:00:00', '2015-06-02 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(227, 11, '2015-06-03 00:00:00', '2015-06-03 07:28:36', 'IN', '2015-06-05 06:30:00'),
(228, 11, '2015-06-03 00:00:00', '2015-06-03 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(229, 11, '2015-06-04 00:00:00', '2015-06-04 07:28:36', 'IN', '2015-06-05 06:30:00'),
(230, 11, '2015-06-04 00:00:00', '2015-06-04 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(231, 11, '2015-06-05 00:00:00', '2015-06-05 07:28:36', 'IN', '2015-06-05 06:30:00'),
(232, 11, '2015-06-05 00:00:00', '2015-06-05 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(233, 11, '2015-06-08 00:00:00', '2015-06-08 07:28:36', 'IN', '2015-06-05 06:30:00'),
(234, 11, '2015-06-08 00:00:00', '2015-06-08 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(235, 11, '2015-06-09 00:00:00', '2015-06-09 07:28:36', 'IN', '2015-06-05 06:30:00'),
(236, 11, '2015-06-09 00:00:00', '2015-06-09 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(237, 11, '2015-06-10 00:00:00', '2015-06-10 07:28:36', 'IN', '2015-06-05 06:30:00'),
(238, 11, '2015-06-10 00:00:00', '2015-06-10 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(239, 11, '2015-06-11 00:00:00', '2015-06-11 07:28:36', 'IN', '2015-06-05 06:30:00'),
(240, 11, '2015-06-11 00:00:00', '2015-06-11 17:28:36', 'OUT', '2015-06-05 06:30:00'),
(241, 11, '2015-06-12 00:00:00', '2015-06-12 07:28:36', 'IN', '2015-06-05 06:30:00'),
(242, 11, '2015-06-12 00:00:00', '2015-06-12 17:28:36', 'OUT', '2015-06-05 06:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_city`
--

DROP TABLE IF EXISTS `tbl_city`;
CREATE TABLE IF NOT EXISTS `tbl_city` (
  `city_code` varchar(5) NOT NULL,
  `city_name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_city`
--

INSERT INTO `tbl_city` (`city_code`, `city_name`) VALUES
('CAL', 'Caloocan City'),
('MKN', 'Marikina  City'),
('MKT', 'Makati City'),
('MLB', 'Malabon City'),
('MND', 'Mandaluyong City'),
('MNL', 'Manila City'),
('MUN', 'Muntinlupa City\r\n'),
('NAV', 'Navotas City'),
('PAT', 'Pateros City'),
('PNQ', 'Parañaque City'),
('PSG', 'Pasig City'),
('PSY', 'Pasay City'),
('QZN', 'Quezon City'),
('SJN', 'San Juan City'),
('TGG', 'Taguig City'),
('VAL', 'Valenzuela City');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_client`
--

DROP TABLE IF EXISTS `tbl_client`;
CREATE TABLE IF NOT EXISTS `tbl_client` (
  `client_id` varchar(10) DEFAULT NULL,
  `client_name` varchar(50) DEFAULT NULL,
  `client_address` varchar(50) DEFAULT NULL,
  `client_contact_no` int(20) DEFAULT NULL,
  `client_email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_client`
--

INSERT INTO `tbl_client` (`client_id`, `client_name`, `client_address`, `client_contact_no`, `client_email`) VALUES
('CL1001', 'Skyjet Airlines', 'Tokyo, Japan', 1232323213, 'skyjet@gmail.com'),
('CL1002', 'Lucio Tan', 'Fujian, China', 232323232, 'lucio@gmail.com'),
('CL1003', 'Tan Yu', 'wewee', 313131, 'tanyu@gmail.com'),
('CL1004', 'Coring Ramos', 'Escolta, Manila', 231232132, 'coring@gmail.com'),
('CL1005', 'Sandy Javier', 'Leyte', 32323232, 'sandy@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_contact_number`
--

DROP TABLE IF EXISTS `tbl_contact_number`;
CREATE TABLE IF NOT EXISTS `tbl_contact_number` (
  `employee_id` int(5) DEFAULT NULL,
  `mobile_number` int(20) DEFAULT NULL,
  `tel_number` int(20) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_contact_number`
--

INSERT INTO `tbl_contact_number` (`employee_id`, `mobile_number`, `tel_number`, `email_address`) VALUES
(100, 32132132, 65656565, 'ardents02@gmail.com'),
(1, 2147483647, 3691753, 'ardents02@gmail.com'),
(3, 1, 1, 'ee@gmail.com'),
(20, 1, 1, 'qweqwe@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_contact_person`
--

DROP TABLE IF EXISTS `tbl_contact_person`;
CREATE TABLE IF NOT EXISTS `tbl_contact_person` (
  `contact_person` varchar(100) DEFAULT NULL,
  `contact_rel` varchar(30) DEFAULT NULL,
  `contact_num` int(20) DEFAULT NULL,
  `employee_id` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_contact_person`
--

INSERT INTO `tbl_contact_person` (`contact_person`, `contact_rel`, `contact_num`, `employee_id`) VALUES
('Pareng Erap', 'Kainuman', 162012, 100),
('Obama', 'Godfather', 12345, 1),
('', '', 0, 3),
('', '', 0, 20);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_countries`
--

DROP TABLE IF EXISTS `tbl_countries`;
CREATE TABLE IF NOT EXISTS `tbl_countries` (
  `id` int(11) NOT NULL,
  `country_code` varchar(2) NOT NULL DEFAULT '',
  `country_name` varchar(100) NOT NULL DEFAULT ''
) ENGINE=MyISAM AUTO_INCREMENT=243 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tbl_countries`
--

INSERT INTO `tbl_countries` (`id`, `country_code`, `country_name`) VALUES
(1, 'US', 'United States'),
(2, 'CA', 'Canada'),
(3, 'AF', 'Afghanistan'),
(4, 'AL', 'Albania'),
(5, 'DZ', 'Algeria'),
(6, 'DS', 'American Samoa'),
(7, 'AD', 'Andorra'),
(8, 'AO', 'Angola'),
(9, 'AI', 'Anguilla'),
(10, 'AQ', 'Antarctica'),
(11, 'AG', 'Antigua and/or Barbuda'),
(12, 'AR', 'Argentina'),
(13, 'AM', 'Armenia'),
(14, 'AW', 'Aruba'),
(15, 'AU', 'Australia'),
(16, 'AT', 'Austria'),
(17, 'AZ', 'Azerbaijan'),
(18, 'BS', 'Bahamas'),
(19, 'BH', 'Bahrain'),
(20, 'BD', 'Bangladesh'),
(21, 'BB', 'Barbados'),
(22, 'BY', 'Belarus'),
(23, 'BE', 'Belgium'),
(24, 'BZ', 'Belize'),
(25, 'BJ', 'Benin'),
(26, 'BM', 'Bermuda'),
(27, 'BT', 'Bhutan'),
(28, 'BO', 'Bolivia'),
(29, 'BA', 'Bosnia and Herzegovina'),
(30, 'BW', 'Botswana'),
(31, 'BV', 'Bouvet Island'),
(32, 'BR', 'Brazil'),
(33, 'IO', 'British lndian Ocean Territory'),
(34, 'BN', 'Brunei Darussalam'),
(35, 'BG', 'Bulgaria'),
(36, 'BF', 'Burkina Faso'),
(37, 'BI', 'Burundi'),
(38, 'KH', 'Cambodia'),
(39, 'CM', 'Cameroon'),
(40, 'CV', 'Cape Verde'),
(41, 'KY', 'Cayman Islands'),
(42, 'CF', 'Central African Republic'),
(43, 'TD', 'Chad'),
(44, 'CL', 'Chile'),
(45, 'CN', 'China'),
(46, 'CX', 'Christmas Island'),
(47, 'CC', 'Cocos (Keeling) Islands'),
(48, 'CO', 'Colombia'),
(49, 'KM', 'Comoros'),
(50, 'CG', 'Congo'),
(51, 'CK', 'Cook Islands'),
(52, 'CR', 'Costa Rica'),
(53, 'HR', 'Croatia (Hrvatska)'),
(54, 'CU', 'Cuba'),
(55, 'CY', 'Cyprus'),
(56, 'CZ', 'Czech Republic'),
(57, 'DK', 'Denmark'),
(58, 'DJ', 'Djibouti'),
(59, 'DM', 'Dominica'),
(60, 'DO', 'Dominican Republic'),
(61, 'TP', 'East Timor'),
(62, 'EC', 'Ecuador'),
(63, 'EG', 'Egypt'),
(64, 'SV', 'El Salvador'),
(65, 'GQ', 'Equatorial Guinea'),
(66, 'ER', 'Eritrea'),
(67, 'EE', 'Estonia'),
(68, 'ET', 'Ethiopia'),
(69, 'FK', 'Falkland Islands (Malvinas)'),
(70, 'FO', 'Faroe Islands'),
(71, 'FJ', 'Fiji'),
(72, 'FI', 'Finland'),
(73, 'FR', 'France'),
(74, 'FX', 'France, Metropolitan'),
(75, 'GF', 'French Guiana'),
(76, 'PF', 'French Polynesia'),
(77, 'TF', 'French Southern Territories'),
(78, 'GA', 'Gabon'),
(79, 'GM', 'Gambia'),
(80, 'GE', 'Georgia'),
(81, 'DE', 'Germany'),
(82, 'GH', 'Ghana'),
(83, 'GI', 'Gibraltar'),
(84, 'GR', 'Greece'),
(85, 'GL', 'Greenland'),
(86, 'GD', 'Grenada'),
(87, 'GP', 'Guadeloupe'),
(88, 'GU', 'Guam'),
(89, 'GT', 'Guatemala'),
(90, 'GN', 'Guinea'),
(91, 'GW', 'Guinea-Bissau'),
(92, 'GY', 'Guyana'),
(93, 'HT', 'Haiti'),
(94, 'HM', 'Heard and Mc Donald Islands'),
(95, 'HN', 'Honduras'),
(96, 'HK', 'Hong Kong'),
(97, 'HU', 'Hungary'),
(98, 'IS', 'Iceland'),
(99, 'IN', 'India'),
(100, 'ID', 'Indonesia'),
(101, 'IR', 'Iran (Islamic Republic of)'),
(102, 'IQ', 'Iraq'),
(103, 'IE', 'Ireland'),
(104, 'IL', 'Israel'),
(105, 'IT', 'Italy'),
(106, 'CI', 'Ivory Coast'),
(107, 'JM', 'Jamaica'),
(108, 'JP', 'Japan'),
(109, 'JO', 'Jordan'),
(110, 'KZ', 'Kazakhstan'),
(111, 'KE', 'Kenya'),
(112, 'KI', 'Kiribati'),
(113, 'KP', 'Korea, Democratic People''s Republic of'),
(114, 'KR', 'Korea, Republic of'),
(115, 'XK', 'Kosovo'),
(116, 'KW', 'Kuwait'),
(117, 'KG', 'Kyrgyzstan'),
(118, 'LA', 'Lao People''s Democratic Republic'),
(119, 'LV', 'Latvia'),
(120, 'LB', 'Lebanon'),
(121, 'LS', 'Lesotho'),
(122, 'LR', 'Liberia'),
(123, 'LY', 'Libyan Arab Jamahiriya'),
(124, 'LI', 'Liechtenstein'),
(125, 'LT', 'Lithuania'),
(126, 'LU', 'Luxembourg'),
(127, 'MO', 'Macau'),
(128, 'MK', 'Macedonia'),
(129, 'MG', 'Madagascar'),
(130, 'MW', 'Malawi'),
(131, 'MY', 'Malaysia'),
(132, 'MV', 'Maldives'),
(133, 'ML', 'Mali'),
(134, 'MT', 'Malta'),
(135, 'MH', 'Marshall Islands'),
(136, 'MQ', 'Martinique'),
(137, 'MR', 'Mauritania'),
(138, 'MU', 'Mauritius'),
(139, 'TY', 'Mayotte'),
(140, 'MX', 'Mexico'),
(141, 'FM', 'Micronesia, Federated States of'),
(142, 'MD', 'Moldova, Republic of'),
(143, 'MC', 'Monaco'),
(144, 'MN', 'Mongolia'),
(145, 'ME', 'Montenegro'),
(146, 'MS', 'Montserrat'),
(147, 'MA', 'Morocco'),
(148, 'MZ', 'Mozambique'),
(149, 'MM', 'Myanmar'),
(150, 'NA', 'Namibia'),
(151, 'NR', 'Nauru'),
(152, 'NP', 'Nepal'),
(153, 'NL', 'Netherlands'),
(154, 'AN', 'Netherlands Antilles'),
(155, 'NC', 'New Caledonia'),
(156, 'NZ', 'New Zealand'),
(157, 'NI', 'Nicaragua'),
(158, 'NE', 'Niger'),
(159, 'NG', 'Nigeria'),
(160, 'NU', 'Niue'),
(161, 'NF', 'Norfork Island'),
(162, 'MP', 'Northern Mariana Islands'),
(163, 'NO', 'Norway'),
(164, 'OM', 'Oman'),
(165, 'PK', 'Pakistan'),
(166, 'PW', 'Palau'),
(167, 'PA', 'Panama'),
(168, 'PG', 'Papua New Guinea'),
(169, 'PY', 'Paraguay'),
(170, 'PE', 'Peru'),
(171, 'PH', 'Philippines'),
(172, 'PN', 'Pitcairn'),
(173, 'PL', 'Poland'),
(174, 'PT', 'Portugal'),
(175, 'PR', 'Puerto Rico'),
(176, 'QA', 'Qatar'),
(177, 'RE', 'Reunion'),
(178, 'RO', 'Romania'),
(179, 'RU', 'Russian Federation'),
(180, 'RW', 'Rwanda'),
(181, 'KN', 'Saint Kitts and Nevis'),
(182, 'LC', 'Saint Lucia'),
(183, 'VC', 'Saint Vincent and the Grenadines'),
(184, 'WS', 'Samoa'),
(185, 'SM', 'San Marino'),
(186, 'ST', 'Sao Tome and Principe'),
(187, 'SA', 'Saudi Arabia'),
(188, 'SN', 'Senegal'),
(189, 'RS', 'Serbia'),
(190, 'SC', 'Seychelles'),
(191, 'SL', 'Sierra Leone'),
(192, 'SG', 'Singapore'),
(193, 'SK', 'Slovakia'),
(194, 'SI', 'Slovenia'),
(195, 'SB', 'Solomon Islands'),
(196, 'SO', 'Somalia'),
(197, 'ZA', 'South Africa'),
(198, 'GS', 'South Georgia South Sandwich Islands'),
(199, 'ES', 'Spain'),
(200, 'LK', 'Sri Lanka'),
(201, 'SH', 'St. Helena'),
(202, 'PM', 'St. Pierre and Miquelon'),
(203, 'SD', 'Sudan'),
(204, 'SR', 'Suriname'),
(205, 'SJ', 'Svalbarn and Jan Mayen Islands'),
(206, 'SZ', 'Swaziland'),
(207, 'SE', 'Sweden'),
(208, 'CH', 'Switzerland'),
(209, 'SY', 'Syrian Arab Republic'),
(210, 'TW', 'Taiwan'),
(211, 'TJ', 'Tajikistan'),
(212, 'TZ', 'Tanzania, United Republic of'),
(213, 'TH', 'Thailand'),
(214, 'TG', 'Togo'),
(215, 'TK', 'Tokelau'),
(216, 'TO', 'Tonga'),
(217, 'TT', 'Trinidad and Tobago'),
(218, 'TN', 'Tunisia'),
(219, 'TR', 'Turkey'),
(220, 'TM', 'Turkmenistan'),
(221, 'TC', 'Turks and Caicos Islands'),
(222, 'TV', 'Tuvalu'),
(223, 'UG', 'Uganda'),
(224, 'UA', 'Ukraine'),
(225, 'AE', 'United Arab Emirates'),
(226, 'GB', 'United Kingdom'),
(227, 'UM', 'United States minor outlying islands'),
(228, 'UY', 'Uruguay'),
(229, 'UZ', 'Uzbekistan'),
(230, 'VU', 'Vanuatu'),
(231, 'VA', 'Vatican City State'),
(232, 'VE', 'Venezuela'),
(233, 'VN', 'Vietnam'),
(234, 'VG', 'Virgin Islands (British)'),
(235, 'VI', 'Virgin Islands (U.S.)'),
(236, 'WF', 'Wallis and Futuna Islands'),
(237, 'EH', 'Western Sahara'),
(238, 'YE', 'Yemen'),
(239, 'YU', 'Yugoslavia'),
(240, 'ZR', 'Zaire'),
(241, 'ZM', 'Zambia'),
(242, 'ZW', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_departments`
--

DROP TABLE IF EXISTS `tbl_departments`;
CREATE TABLE IF NOT EXISTS `tbl_departments` (
  `department_id` varchar(10) DEFAULT NULL,
  `department_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_departments`
--

INSERT INTO `tbl_departments` (`department_id`, `department_name`) VALUES
('DE1001', 'Sales'),
('DE1002', 'Marketing'),
('DE1003', 'Finance'),
('DE1004', 'Human Resource'),
('DE1005', 'Purchasing'),
('DE1006', 'I.T.'),
('DE1007', 'Operations');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_dependent`
--

DROP TABLE IF EXISTS `tbl_dependent`;
CREATE TABLE IF NOT EXISTS `tbl_dependent` (
  `employee_id` varchar(10) DEFAULT NULL,
  `dependent_fname` varchar(50) DEFAULT NULL,
  `dependent_lname` varchar(50) DEFAULT NULL,
  `relationship` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_dependent`
--

INSERT INTO `tbl_dependent` (`employee_id`, `dependent_fname`, `dependent_lname`, `relationship`) VALUES
('10', 'Aria', 'Stark', 'Daughter'),
('2', 'Sansa', 'Stark', 'Daughter'),
('3', 'Bran', 'Stark', 'Son'),
('4', 'Tony', 'Stark', 'Son'),
('1', 'Juan', 'Nyebe', 'Guard'),
('1', 'Sansa', 'Stark', 'Daughter'),
('1', 'Jolly', 'Bee', 'Mascot'),
('3', 'Sansa', 'Nyebe', 'Daughter');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_employment_history`
--

DROP TABLE IF EXISTS `tbl_employment_history`;
CREATE TABLE IF NOT EXISTS `tbl_employment_history` (
  `company_name` varchar(50) DEFAULT NULL,
  `company_address` varchar(50) DEFAULT NULL,
  `years_stayed` tinyint(2) DEFAULT NULL,
  `job_title` varchar(255) DEFAULT NULL,
  `employee_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_employment_history`
--

INSERT INTO `tbl_employment_history` (`company_name`, `company_address`, `years_stayed`, `job_title`, `employee_id`) VALUES
('JRU', 'Mandaluyong City', 2, 'Programmer', '100'),
('IBM', 'Eastwood', 1, 'Programmer', '1'),
('IBM', 'Eastwood', 1, 'Programmer', '3');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_employment_type`
--

DROP TABLE IF EXISTS `tbl_employment_type`;
CREATE TABLE IF NOT EXISTS `tbl_employment_type` (
  `employment_type_id` varchar(10) DEFAULT NULL,
  `employment_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_employment_type`
--

INSERT INTO `tbl_employment_type` (`employment_type_id`, `employment_type`) VALUES
('ET1001', 'Regular'),
('ET1002', 'Project-based'),
('ET1003', 'Contractual'),
('ET1004', 'Probitionary'),
('ET1005', 'Consultant');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_emp_history`
--

DROP TABLE IF EXISTS `tbl_emp_history`;
CREATE TABLE IF NOT EXISTS `tbl_emp_history` (
  `emp_id` int(4) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `employment_type_id` varchar(255) DEFAULT NULL,
  `job_title_id` varchar(50) DEFAULT NULL,
  `department_id` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `probationary_date` date DEFAULT NULL,
  `permanency_date` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `pay_grade` varchar(5) DEFAULT NULL,
  `date_modified` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_emp_history`
--

INSERT INTO `tbl_emp_history` (`emp_id`, `status`, `employment_type_id`, `job_title_id`, `department_id`, `start_date`, `end_date`, `probationary_date`, `permanency_date`, `salary`, `pay_grade`, `date_modified`) VALUES
(100, 'Resigned', 'ET1001', 'JT1001', 'DE1001', '2015-08-11', '2015-08-11', '2015-08-11', '2015-08-11', '300002.00', 'AB', '2015-07-08 05:11:34'),
(1, 'Existing', 'ET1001', 'JT1001', 'DE1001', '2015-08-11', '2015-08-11', '2015-08-11', '2015-08-11', '25000.00', 'A', '2015-08-11 20:53:11'),
(3, 'Existing', 'ET1001', 'JT1001', 'DE1001', '2015-08-11', '2015-08-11', '2015-08-11', '2015-08-11', '0.00', '', '2015-08-12 02:11:24'),
(20, 'Existing', 'ET1001', 'JT1001', 'DE1001', '2015-08-12', '2015-08-12', '2015-08-12', '2015-08-12', '0.00', '', '2015-08-12 17:09:26');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_emp_info`
--

DROP TABLE IF EXISTS `tbl_emp_info`;
CREATE TABLE IF NOT EXISTS `tbl_emp_info` (
  `emp_id` int(5) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `marital_status` varchar(50) DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_emp_info`
--

INSERT INTO `tbl_emp_info` (`emp_id`, `first_name`, `middle_name`, `last_name`, `birthday`, `gender`, `marital_status`, `date_added`) VALUES
(1, 'Arden', 'Jay', 'Dela Cruz', '1993-12-16', 'male', 'Single', '2015-08-11 12:53:11'),
(3, 'e', 'e', 'e', '2015-08-01', 'male', 'Single', '2015-08-11 18:11:24'),
(20, 'e', 'e', 'e', '2015-08-12', 'male', 'Single', '2015-08-12 09:09:26'),
(100, 'Arden', 'Alcairo', 'Dela Cruz', '1993-12-16', 'male', 'Single', '2015-06-30 07:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_emp_supervisions`
--

DROP TABLE IF EXISTS `tbl_emp_supervisions`;
CREATE TABLE IF NOT EXISTS `tbl_emp_supervisions` (
  `supervisor_id` varchar(10) DEFAULT NULL,
  `employee_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_emp_supervisions`
--

INSERT INTO `tbl_emp_supervisions` (`supervisor_id`, `employee_id`) VALUES
('S1002', '2'),
('S1001', '1'),
('S1001', '3'),
('S1004', '4'),
('S1004', '5'),
('S1003', '6'),
('S1005', '7'),
('S1003', '8'),
('S1004', '9');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_governmentid`
--

DROP TABLE IF EXISTS `tbl_governmentid`;
CREATE TABLE IF NOT EXISTS `tbl_governmentid` (
  `employee_id` varchar(10) DEFAULT NULL,
  `sss_no` int(10) DEFAULT NULL,
  `pagibig_no` int(12) DEFAULT NULL,
  `philhealth_no` int(12) DEFAULT NULL,
  `tin` int(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_governmentid`
--

INSERT INTO `tbl_governmentid` (`employee_id`, `sss_no`, `pagibig_no`, `philhealth_no`, `tin`) VALUES
('100', 1, 2, 3, 4),
('1', 11, 22, 33, 44),
('3', 0, 0, 0, 0),
('20', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_job_title`
--

DROP TABLE IF EXISTS `tbl_job_title`;
CREATE TABLE IF NOT EXISTS `tbl_job_title` (
  `job_title_id` varchar(10) DEFAULT NULL,
  `job_title_name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_job_title`
--

INSERT INTO `tbl_job_title` (`job_title_id`, `job_title_name`) VALUES
('JT1001', 'Sales Manager'),
('JT1002', 'Marketing Manager'),
('JT1003', 'Finance Manager'),
('JT1004', 'Accounting Staff'),
('JT1005', 'HR Manager'),
('JT1006', 'HR Assistant'),
('JT1007', 'Purchasing Manager'),
('JT1008', 'I.T. Manager'),
('JT1009', 'Operation Manager');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_leave_left`
--

DROP TABLE IF EXISTS `tbl_leave_left`;
CREATE TABLE IF NOT EXISTS `tbl_leave_left` (
  `employee_id` varchar(10) DEFAULT NULL,
  `leave_type_id` varchar(10) DEFAULT NULL,
  `days` smallint(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_leave_left`
--

INSERT INTO `tbl_leave_left` (`employee_id`, `leave_type_id`, `days`) VALUES
('1', 'BL', 20),
('1', 'EL', 20),
('1', 'MNL', 15),
('1', 'MTL', 20),
('1', 'PL', 20),
('1', 'SL', 20),
('1', 'VL', 18);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_leave_remaining`
--

DROP TABLE IF EXISTS `tbl_leave_remaining`;
CREATE TABLE IF NOT EXISTS `tbl_leave_remaining` (
  `employee_id` varchar(10) DEFAULT NULL,
  `birthday_leave` tinyint(2) DEFAULT NULL,
  `mandatory_leave` tinyint(2) DEFAULT NULL,
  `maternity_leave` tinyint(2) DEFAULT NULL,
  `paternity_leave` tinyint(2) DEFAULT NULL,
  `vacation_leave` tinyint(2) DEFAULT NULL,
  `sick_leave` tinyint(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_leave_remaining`
--

INSERT INTO `tbl_leave_remaining` (`employee_id`, `birthday_leave`, `mandatory_leave`, `maternity_leave`, `paternity_leave`, `vacation_leave`, `sick_leave`) VALUES
('1', 0, 1, 2, 3, 5, 4),
('2', 5, 5, 4, 5, 5, 5),
('3', 0, 5, 3, 0, 4, 5),
('4', 5, 5, 2, 5, 3, 5),
('5', 4, 4, 1, 5, 2, 5),
('6', 3, 3, 0, 0, 1, 4),
('7', 2, 2, 5, 5, 0, 3),
('8', 1, 1, 4, 5, 5, 2),
('9', 0, 0, 3, 4, 5, 1),
('10', 5, 5, 2, 3, 4, 0),
('11', 5, 5, 1, 2, 3, 5),
('12', 5, 5, 5, 1, 2, 5),
('13', 5, 5, 4, 0, 5, 5),
('14', 5, 5, 3, 5, 5, 5);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_leave_request`
--

DROP TABLE IF EXISTS `tbl_leave_request`;
CREATE TABLE IF NOT EXISTS `tbl_leave_request` (
  `id` int(5) unsigned zerofill NOT NULL,
  `prefix` varchar(3) NOT NULL DEFAULT 'LVR',
  `leave_type` varchar(50) DEFAULT NULL,
  `leave_reason` varchar(100) DEFAULT NULL,
  `leave_start` date DEFAULT NULL,
  `leave_end` date DEFAULT NULL,
  `leave_left` smallint(2) DEFAULT NULL,
  `leave_status` varchar(20) DEFAULT NULL,
  `approved_by` varchar(255) DEFAULT NULL,
  `date_approved` date DEFAULT NULL,
  `date_requested` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `employee_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_leave_request`
--

INSERT INTO `tbl_leave_request` (`id`, `prefix`, `leave_type`, `leave_reason`, `leave_start`, `leave_end`, `leave_left`, `leave_status`, `approved_by`, `date_approved`, `date_requested`, `employee_id`) VALUES
(00002, 'LVR', 'BL', 'It is my birthday!', '2015-08-06', '2015-08-08', 20, 'Denied', 'Administrator Arden', '2015-08-08', '2015-08-10 16:00:00', '1'),
(00003, 'LVR', 'EL', '23', '2015-08-04', '2015-08-06', 20, 'Pending', NULL, NULL, NULL, '1');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_leave_type`
--

DROP TABLE IF EXISTS `tbl_leave_type`;
CREATE TABLE IF NOT EXISTS `tbl_leave_type` (
  `leave_type_id` varchar(10) DEFAULT '',
  `leave_type_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_leave_type`
--

INSERT INTO `tbl_leave_type` (`leave_type_id`, `leave_type_name`) VALUES
('BL', 'Birthday Leave'),
('EL', 'Emergency Leave'),
('MNL', 'Mandatory Leave'),
('MTL', 'Maternity Leave'),
('PL', 'Paternity Leave'),
('SL', 'Sick Leave'),
('VL', 'Vacation Leave');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_materials`
--

DROP TABLE IF EXISTS `tbl_materials`;
CREATE TABLE IF NOT EXISTS `tbl_materials` (
  `item_id` varchar(10) NOT NULL,
  `quantity` int(10) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `project_id` varchar(10) NOT NULL,
  `date_issued` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_materials`
--

INSERT INTO `tbl_materials` (`item_id`, `quantity`, `price`, `project_id`, `date_issued`) VALUES
('STK1001', 20, '20000.00', 'P1001', '2015-07-08'),
('STK1002', 2, '100.00', 'P1003', '2015-07-09'),
('STK1003', 20, '500.00', 'P1001', '2015-07-30'),
('STK1004', 100, '500.00', 'P1001', '2015-07-21'),
('STK1005', 100, '7000.00', 'P1003', '2015-07-21'),
('STK1001', 100, '200.00', 'P1005', '2015-07-28'),
('STK1004', 2, '4000.00', 'P1004', '2015-07-08'),
('STK1006', 2, '4000.00', 'P1005', '2015-07-08'),
('STK1006', 2, '4000.00', 'P1006', '2015-07-19'),
('STK1001', 2, '2000.00', 'P1005', '2015-07-20'),
('STK1002', 10, '30000.00', 'P1002', '2015-07-20'),
('STK1001', 20, '1000.00', 'P1002', '2015-07-21'),
('STK1001', 20, '1000.00', 'P1007', '2015-07-20'),
('STK1002', 50, '10000.00', 'P1001', '2015-07-22'),
('STK1003', 10, '1000.00', 'P1003', '2015-07-23'),
('STK1004', 60, '1000.00', 'P1002', '2015-07-22');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_payslip`
--

DROP TABLE IF EXISTS `tbl_payslip`;
CREATE TABLE IF NOT EXISTS `tbl_payslip` (
  `payslip_id` int(4) NOT NULL,
  `emp_id` int(4) NOT NULL,
  `payslip_date` datetime NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `monthly_rate` decimal(8,2) NOT NULL,
  `basic_salary` decimal(8,2) NOT NULL,
  `total_overtime` decimal(8,2) NOT NULL,
  `total_tardiness` decimal(8,2) NOT NULL,
  `total_absent_amount` decimal(8,2) NOT NULL,
  `total_allowances` decimal(8,2) NOT NULL,
  `total_taxes` decimal(8,2) NOT NULL,
  `gross_pay` decimal(8,2) NOT NULL,
  `net_pay` decimal(8,2) NOT NULL,
  `remarks` varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_payslip`
--

INSERT INTO `tbl_payslip` (`payslip_id`, `emp_id`, `payslip_date`, `start_date`, `end_date`, `monthly_rate`, `basic_salary`, `total_overtime`, `total_tardiness`, `total_absent_amount`, `total_allowances`, `total_taxes`, `gross_pay`, `net_pay`, `remarks`) VALUES
(8, 1, '2015-06-20 00:00:00', '2015-06-01 00:00:00', '2015-06-15 00:00:00', '40000.00', '20000.00', '1215.52', '0.00', '1841.08', '500.00', '3776.14', '19874.44', '16098.29', ''),
(9, 7, '2015-06-20 00:00:00', '2015-06-01 00:00:00', '2015-06-15 00:00:00', '15000.00', '7500.00', '455.82', '0.00', '690.66', '500.00', '1475.38', '7765.16', '6289.78', ''),
(10, 8, '2015-06-20 00:00:00', '2015-06-01 00:00:00', '2015-06-15 00:00:00', '15000.00', '7500.00', '455.82', '0.00', '690.66', '500.00', '1475.38', '7765.16', '6289.78', ''),
(11, 9, '2015-06-20 00:00:00', '2015-06-01 00:00:00', '2015-06-15 00:00:00', '15000.00', '7500.00', '455.82', '0.00', '690.66', '500.00', '1475.38', '7765.16', '6289.78', ''),
(12, 10, '2015-06-20 00:00:00', '2015-06-01 00:00:00', '2015-06-15 00:00:00', '15000.00', '7500.00', '455.82', '0.00', '690.66', '500.00', '1475.38', '7765.16', '6289.78', ''),
(13, 11, '2015-06-20 00:00:00', '2015-06-01 00:00:00', '2015-06-15 00:00:00', '15000.00', '7500.00', '455.82', '0.00', '690.66', '500.00', '1475.38', '7765.16', '6289.78', '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_payslip_allowances`
--

DROP TABLE IF EXISTS `tbl_payslip_allowances`;
CREATE TABLE IF NOT EXISTS `tbl_payslip_allowances` (
  `payslip_allowance_id` int(11) NOT NULL,
  `payslip_id` int(11) NOT NULL,
  `allowance_id` int(11) NOT NULL,
  `percentage` decimal(3,3) NOT NULL,
  `percentage_amount` decimal(8,2) NOT NULL,
  `fixed_amount` decimal(8,2) NOT NULL,
  `total` decimal(8,2) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_payslip_allowances`
--

INSERT INTO `tbl_payslip_allowances` (`payslip_allowance_id`, `payslip_id`, `allowance_id`, `percentage`, `percentage_amount`, `fixed_amount`, `total`) VALUES
(3, 7, 1, '0.000', '0.00', '300.00', '300.00'),
(4, 7, 2, '0.000', '0.00', '200.00', '200.00'),
(5, 8, 1, '0.000', '0.00', '300.00', '300.00'),
(6, 8, 2, '0.000', '0.00', '200.00', '200.00'),
(7, 9, 1, '0.000', '0.00', '300.00', '300.00'),
(8, 9, 2, '0.000', '0.00', '200.00', '200.00'),
(9, 10, 1, '0.000', '0.00', '300.00', '300.00'),
(10, 10, 2, '0.000', '0.00', '200.00', '200.00'),
(11, 11, 1, '0.000', '0.00', '300.00', '300.00'),
(12, 11, 2, '0.000', '0.00', '200.00', '200.00'),
(13, 12, 1, '0.000', '0.00', '300.00', '300.00'),
(14, 12, 2, '0.000', '0.00', '200.00', '200.00'),
(15, 13, 1, '0.000', '0.00', '300.00', '300.00'),
(16, 13, 2, '0.000', '0.00', '200.00', '200.00'),
(17, 14, 1, '0.000', '0.00', '300.00', '300.00'),
(18, 14, 2, '0.000', '0.00', '200.00', '200.00'),
(19, 15, 1, '0.000', '0.00', '300.00', '300.00'),
(20, 15, 2, '0.000', '0.00', '200.00', '200.00'),
(21, 16, 1, '0.000', '0.00', '300.00', '300.00'),
(22, 16, 2, '0.000', '0.00', '200.00', '200.00'),
(23, 17, 1, '0.000', '0.00', '300.00', '300.00'),
(24, 17, 2, '0.000', '0.00', '200.00', '200.00'),
(25, 18, 1, '0.000', '0.00', '300.00', '300.00'),
(26, 18, 2, '0.000', '0.00', '200.00', '200.00'),
(27, 19, 1, '0.000', '0.00', '300.00', '300.00'),
(28, 19, 2, '0.000', '0.00', '200.00', '200.00');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_payslip_taxes`
--

DROP TABLE IF EXISTS `tbl_payslip_taxes`;
CREATE TABLE IF NOT EXISTS `tbl_payslip_taxes` (
  `payslip_tax_id` int(11) NOT NULL,
  `payslip_id` int(11) NOT NULL,
  `tax_id` int(11) NOT NULL,
  `percentage` decimal(3,3) NOT NULL,
  `percentage_amount` decimal(8,2) NOT NULL,
  `fixed_amount` decimal(8,2) NOT NULL,
  `total` decimal(8,2) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_payslip_taxes`
--

INSERT INTO `tbl_payslip_taxes` (`payslip_tax_id`, `payslip_id`, `tax_id`, `percentage`, `percentage_amount`, `fixed_amount`, `total`) VALUES
(5, 7, 3, '0.040', '794.98', '0.00', '794.98'),
(6, 7, 4, '0.020', '397.49', '0.00', '397.49'),
(7, 7, 5, '0.010', '198.74', '0.00', '198.74'),
(8, 7, 6, '0.120', '2384.93', '0.00', '2384.93'),
(9, 8, 3, '0.040', '794.98', '0.00', '794.98'),
(10, 8, 4, '0.020', '397.49', '0.00', '397.49'),
(11, 8, 5, '0.010', '198.74', '0.00', '198.74'),
(12, 8, 6, '0.120', '2384.93', '0.00', '2384.93'),
(13, 9, 3, '0.040', '310.61', '0.00', '310.61'),
(14, 9, 4, '0.020', '155.30', '0.00', '155.30'),
(15, 9, 5, '0.010', '77.65', '0.00', '77.65'),
(16, 9, 6, '0.120', '931.82', '0.00', '931.82'),
(17, 10, 3, '0.040', '310.61', '0.00', '310.61'),
(18, 10, 4, '0.020', '155.30', '0.00', '155.30'),
(19, 10, 5, '0.010', '77.65', '0.00', '77.65'),
(20, 10, 6, '0.120', '931.82', '0.00', '931.82'),
(21, 11, 3, '0.040', '310.61', '0.00', '310.61'),
(22, 11, 4, '0.020', '155.30', '0.00', '155.30'),
(23, 11, 5, '0.010', '77.65', '0.00', '77.65'),
(24, 11, 6, '0.120', '931.82', '0.00', '931.82'),
(25, 12, 3, '0.040', '310.61', '0.00', '310.61'),
(26, 12, 4, '0.020', '155.30', '0.00', '155.30'),
(27, 12, 5, '0.010', '77.65', '0.00', '77.65'),
(28, 12, 6, '0.120', '931.82', '0.00', '931.82'),
(29, 13, 3, '0.040', '310.61', '0.00', '310.61'),
(30, 13, 4, '0.020', '155.30', '0.00', '155.30'),
(31, 13, 5, '0.010', '77.65', '0.00', '77.65'),
(32, 13, 6, '0.120', '931.82', '0.00', '931.82'),
(33, 14, 3, '0.040', '794.98', '0.00', '794.98'),
(34, 14, 4, '0.020', '397.49', '0.00', '397.49'),
(35, 14, 5, '0.010', '198.74', '0.00', '198.74'),
(36, 14, 6, '0.120', '2384.93', '0.00', '2384.93'),
(37, 15, 3, '0.040', '310.61', '0.00', '310.61'),
(38, 15, 4, '0.020', '155.30', '0.00', '155.30'),
(39, 15, 5, '0.010', '77.65', '0.00', '77.65'),
(40, 15, 6, '0.120', '931.82', '0.00', '931.82'),
(41, 16, 3, '0.040', '310.61', '0.00', '310.61'),
(42, 16, 4, '0.020', '155.30', '0.00', '155.30'),
(43, 16, 5, '0.010', '77.65', '0.00', '77.65'),
(44, 16, 6, '0.120', '931.82', '0.00', '931.82'),
(45, 17, 3, '0.040', '310.61', '0.00', '310.61'),
(46, 17, 4, '0.020', '155.30', '0.00', '155.30'),
(47, 17, 5, '0.010', '77.65', '0.00', '77.65'),
(48, 17, 6, '0.120', '931.82', '0.00', '931.82'),
(49, 18, 3, '0.040', '310.61', '0.00', '310.61'),
(50, 18, 4, '0.020', '155.30', '0.00', '155.30'),
(51, 18, 5, '0.010', '77.65', '0.00', '77.65'),
(52, 18, 6, '0.120', '931.82', '0.00', '931.82'),
(53, 19, 3, '0.040', '310.61', '0.00', '310.61'),
(54, 19, 4, '0.020', '155.30', '0.00', '155.30'),
(55, 19, 5, '0.010', '77.65', '0.00', '77.65'),
(56, 19, 6, '0.120', '931.82', '0.00', '931.82');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project`
--

DROP TABLE IF EXISTS `tbl_project`;
CREATE TABLE IF NOT EXISTS `tbl_project` (
  `project_id` varchar(5) DEFAULT NULL,
  `project_name` varchar(50) DEFAULT NULL,
  `client` varchar(50) DEFAULT NULL,
  `starting_date` date DEFAULT NULL,
  `ending_date` date DEFAULT NULL,
  `date_added` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_project`
--

INSERT INTO `tbl_project` (`project_id`, `project_name`, `client`, `starting_date`, `ending_date`, `date_added`) VALUES
('P1001', 'Project Almanac', 'CL1001', '2015-07-08', '2015-08-01', '2015-07-08 13:36:31'),
('P1002', 'Project Beta', 'CL1002', '2015-07-03', '2015-07-22', '2015-07-08 14:21:12'),
('P1003', 'Project X', 'CL1004', '2015-07-09', '2015-07-14', '2015-07-08 18:59:33'),
('P1004', 'Project Alpha', 'CL1003', '2015-07-10', '2015-08-07', '2015-07-08 19:05:40'),
('P1006', '9DevCorp', 'CL1005', '2015-07-15', '2015-07-22', '2015-07-21 23:19:42'),
('P1007', 'Project Pie', 'CL1002', '2015-07-20', '2015-07-23', '2015-07-20 01:06:53');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project_workers`
--

DROP TABLE IF EXISTS `tbl_project_workers`;
CREATE TABLE IF NOT EXISTS `tbl_project_workers` (
  `project_id` varchar(10) DEFAULT NULL,
  `employee_id` varchar(10) DEFAULT NULL,
  `assigned_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_project_workers`
--

INSERT INTO `tbl_project_workers` (`project_id`, `employee_id`, `assigned_date`) VALUES
('P1001', '100', '2015-07-13'),
('P1002', '100', '2015-07-20'),
('P1003', '100', '2015-07-21');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_requestentry`
--

DROP TABLE IF EXISTS `tbl_requestentry`;
CREATE TABLE IF NOT EXISTS `tbl_requestentry` (
  `req_id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `date_value` date NOT NULL,
  `time_in` time NOT NULL,
  `time_out` time NOT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `date_requested` datetime NOT NULL,
  `approved` tinyint(1) DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `date_approved` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_requestentry`
--

INSERT INTO `tbl_requestentry` (`req_id`, `emp_id`, `date_value`, `time_in`, `time_out`, `remarks`, `date_requested`, `approved`, `approved_by`, `date_approved`) VALUES
(1, 2, '2015-06-22', '08:00:00', '00:00:00', NULL, '2015-07-13 00:00:00', 0, 1, '0000-00-00 00:00:00'),
(2, 3, '2015-06-22', '08:00:00', '00:00:00', NULL, '2015-07-13 00:00:00', 1, 1, '0000-00-00 00:00:00'),
(3, 4, '2015-06-22', '08:00:00', '05:00:00', NULL, '2015-07-13 00:00:00', 0, 1, '0000-00-00 00:00:00'),
(4, 5, '2015-06-22', '08:00:00', '05:00:00', NULL, '2015-07-13 00:00:00', NULL, NULL, NULL),
(5, 6, '2015-06-22', '08:00:00', '05:00:00', NULL, '2015-07-13 00:00:00', 1, 1, '0000-00-00 00:00:00'),
(6, 7, '2015-06-22', '08:00:00', '05:00:00', NULL, '2015-07-13 00:00:00', NULL, NULL, NULL),
(7, 0, '2015-06-15', '09:00:00', '04:00:00', NULL, '0000-00-00 00:00:00', 1, 1, '0000-00-00 00:00:00'),
(8, 1, '2015-06-06', '08:50:00', '12:00:00', NULL, '0000-00-00 00:00:00', NULL, NULL, '2015-07-17 23:24:04');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_restock`
--

DROP TABLE IF EXISTS `tbl_restock`;
CREATE TABLE IF NOT EXISTS `tbl_restock` (
  `item_id` varchar(10) NOT NULL,
  `vendor_id` varchar(10) NOT NULL,
  `quantity` int(10) NOT NULL,
  `date_restock` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_restock`
--

INSERT INTO `tbl_restock` (`item_id`, `vendor_id`, `quantity`, `date_restock`) VALUES
('STK1004', 'VEN1001', 1000, '2015-07-19'),
('STK1002', 'VEN1001', 333, '2015-07-21'),
('STK1004', 'VEN1001', 10000, '2015-07-20'),
('STK1006', 'VEN1001', 737, '2015-07-31'),
('STK1006', 'VEN1001', 737, '2015-07-22'),
('STK1006', 'VEN1001', 1000, '2015-07-25'),
('STK1006', 'VEN1001', 8, '2015-07-08'),
('STK1003', 'VEN1001', 1000, '2015-07-19'),
('STK1005', 'VEN1001', 1000, '2015-07-19'),
('STK1003', 'VEN1001', 1000, '2015-07-19'),
('STK1004', 'VEN1001', 1000, '2015-07-19'),
('STK1007', 'VEN1001', 1000, '2015-07-19'),
('STK1002', 'VEN1001', 610, '2015-07-19');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_school`
--

DROP TABLE IF EXISTS `tbl_school`;
CREATE TABLE IF NOT EXISTS `tbl_school` (
  `employee_id` int(5) DEFAULT NULL,
  `primary_name` varchar(50) DEFAULT NULL,
  `primary_address` varchar(50) DEFAULT NULL,
  `primary_year` smallint(50) DEFAULT NULL,
  `secondary_name` varchar(50) DEFAULT NULL,
  `secondary_address` varchar(50) DEFAULT NULL,
  `secondary_year` smallint(50) DEFAULT NULL,
  `tertiary_name` varchar(50) DEFAULT NULL,
  `tertiary_address` varchar(50) DEFAULT NULL,
  `tertiary_year` smallint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_school`
--

INSERT INTO `tbl_school` (`employee_id`, `primary_name`, `primary_address`, `primary_year`, `secondary_name`, `secondary_address`, `secondary_year`, `tertiary_name`, `tertiary_address`, `tertiary_year`) VALUES
(100, 'Aurora Central School', 'Aurora, Isabela', 2006, 'DANHS', 'Aurora, Isabela', 2010, 'JRU', 'Mandaluyong City', 2016),
(1, 'Aurora Central School', 'Aurora, Isabela', 2006, 'DANHS', 'Aurora, Isabela', 2010, 'JRU', 'Mandaluyong City', 2015),
(3, 'w', 'w', 0, 'w', 'w', 0, 'w', 'w', 0),
(20, '', '', 0, '', '', 0, '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_stocks`
--

DROP TABLE IF EXISTS `tbl_stocks`;
CREATE TABLE IF NOT EXISTS `tbl_stocks` (
  `item_id` varchar(10) NOT NULL,
  `quantity` varchar(50) NOT NULL,
  `date_last_restocked` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_stocks`
--

INSERT INTO `tbl_stocks` (`item_id`, `quantity`, `date_last_restocked`) VALUES
('STK1001', '900', '2015-07-18'),
('STK1002', '1100', '2015-07-19'),
('STK1003', '980', '2015-07-19'),
('STK1004', '950', '2015-07-19'),
('STK1005', '990', '2015-07-19'),
('STK1006', '1008', '2015-07-08'),
('STK1007', '1000', '2015-07-19');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_stocks_category`
--

DROP TABLE IF EXISTS `tbl_stocks_category`;
CREATE TABLE IF NOT EXISTS `tbl_stocks_category` (
  `category_id` varchar(10) NOT NULL,
  `category_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_stocks_category`
--

INSERT INTO `tbl_stocks_category` (`category_id`, `category_name`) VALUES
('COMP', 'Computer'),
('ELEC', 'Electronics'),
('PLSTC', 'Plastic Materials'),
('SC', 'Secret Materials'),
('STL', 'Steel Materials'),
('WD', 'Wood Materials');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_stock_info`
--

DROP TABLE IF EXISTS `tbl_stock_info`;
CREATE TABLE IF NOT EXISTS `tbl_stock_info` (
  `item_id` varchar(10) NOT NULL,
  `item_name` varchar(50) DEFAULT NULL,
  `category_id` varchar(10) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_stock_info`
--

INSERT INTO `tbl_stock_info` (`item_id`, `item_name`, `category_id`, `price`) VALUES
('STK1001', 'Steel Post', 'COMP', '1000.00'),
('STK1002', 'Wooden Chair', 'ELEC', '2000.00'),
('STK1003', 'Steel Plates', 'PLSTC', '5000.00'),
('STK1004', 'Pako', 'SC', '5.00'),
('STK1005', 'Eye of Skadiis', 'STL', '1000.00'),
('STK1007', 'Martilyo', 'WD', '100.00');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_supervisions`
--

DROP TABLE IF EXISTS `tbl_supervisions`;
CREATE TABLE IF NOT EXISTS `tbl_supervisions` (
  `supervisor_id` varchar(10) DEFAULT NULL,
  `employee_id` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_supervisions`
--

INSERT INTO `tbl_supervisions` (`supervisor_id`, `employee_id`) VALUES
('S1001', '1'),
('S1002', '2'),
('S1003', '3'),
('S1004', '4'),
('S1005', '5');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_taxes`
--

DROP TABLE IF EXISTS `tbl_taxes`;
CREATE TABLE IF NOT EXISTS `tbl_taxes` (
  `tax_id` int(4) NOT NULL,
  `tax_name` varchar(50) NOT NULL,
  `percentage` decimal(3,3) NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_taxes`
--

INSERT INTO `tbl_taxes` (`tax_id`, `tax_name`, `percentage`, `amount`, `active`) VALUES
(3, 'SSS', '0.040', '0.00', 1),
(4, 'Philhealth', '0.020', '0.00', 1),
(5, 'PagIbig', '0.010', '0.00', 1),
(6, 'Withholding', '0.120', '0.00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE IF NOT EXISTS `tbl_user` (
  `user_id` int(5) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `user_level` varchar(20) DEFAULT NULL,
  `secret_question` varchar(50) DEFAULT NULL,
  `secret_answer` varchar(50) DEFAULT NULL,
  `employee_id` varchar(10) DEFAULT NULL,
  `date_registered` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_user`
--

INSERT INTO `tbl_user` (`user_id`, `username`, `password`, `email`, `user_level`, `secret_question`, `secret_answer`, `employee_id`, `date_registered`) VALUES
(1, 'ardents', 'daca2125e1f1f3c5ff6e8663ab1edef3', 'ardents02@gmail.com', 'Administrator', 'What is your pet name?', 'ardents', '100', '2015-06-05 05:28:36');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_vendor`
--

DROP TABLE IF EXISTS `tbl_vendor`;
CREATE TABLE IF NOT EXISTS `tbl_vendor` (
  `vendor_id` varchar(10) NOT NULL,
  `vendor_name` varchar(50) NOT NULL,
  `vendor_address` varchar(50) NOT NULL,
  `vendor_contact_num` int(20) NOT NULL,
  `vendor_email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_vendor`
--

INSERT INTO `tbl_vendor` (`vendor_id`, `vendor_name`, `vendor_address`, `vendor_contact_num`, `vendor_email`) VALUES
('VEN1001', 'Secret Shop', 'Secret Lair', 999999999, 'secret@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`) VALUES
(1, '127.0.0.1', 'ardents', '$2a$07$SeBknntpZror9uyftVopmu61qg0ms8Qv1yV6FG.kQOSM.9QhmTo36', '', 'ardents', '', NULL, NULL, NULL, 1268889823, 1439351756, 1, 'Arden Jay', 'Dela Cruz', '9devcorp', '0');

-- --------------------------------------------------------

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
CREATE TABLE IF NOT EXISTS `users_groups` (
  `id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users_groups`
--

INSERT INTO `users_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 1),
(2, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_account`
--

DROP TABLE IF EXISTS `user_account`;
CREATE TABLE IF NOT EXISTS `user_account` (
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `user_level` varchar(255) DEFAULT NULL,
  `secret_question` varchar(255) DEFAULT NULL,
  `secret_answer` varchar(255) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `date_registered` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_account`
--

INSERT INTO `user_account` (`username`, `password`, `user_level`, `secret_question`, `secret_answer`, `employee_id`, `date_registered`) VALUES
('admin', '21232f297a57a5a743894a0e4a801fc3', 'Administrator', 'What is your pet name?', 'ardents', 1, '2015-08-11 12:53:12'),
('android20', 'ardents', 'HR Manager', 'What is your pet name?', 'qweqwe', 20, '2015-08-12 09:09:26');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_all_project_materials`
--
DROP VIEW IF EXISTS `view_all_project_materials`;
CREATE TABLE IF NOT EXISTS `view_all_project_materials` (
`item_name` varchar(50)
,`quantity` int(10)
,`price` decimal(10,2)
,`project_name` varchar(50)
,`date_issued` date
,`item_id` varchar(10)
,`project_id` varchar(5)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_assigned_assets`
--
DROP VIEW IF EXISTS `view_assigned_assets`;
CREATE TABLE IF NOT EXISTS `view_assigned_assets` (
`asset_id` varchar(10)
,`asset_name` varchar(50)
,`category_name` varchar(50)
,`asset_status` varchar(255)
,`name` varchar(152)
,`vendor_name` varchar(50)
,`asset_description` varchar(100)
,`brand` varchar(50)
,`serial_number` int(20)
,`model` varchar(50)
,`warranty_end_date` date
,`assigned_date` datetime
,`emp_id` int(5)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_attendance`
--
DROP VIEW IF EXISTS `view_attendance`;
CREATE TABLE IF NOT EXISTS `view_attendance` (
`emp_id` int(5)
,`first_name` varchar(50)
,`middle_name` varchar(50)
,`last_name` varchar(50)
,`position` varchar(50)
,`datelog` datetime
,`logdate` varchar(10)
,`time_in` varchar(10)
,`time_out` varchar(10)
,`man_hours` varchar(69)
,`tardiness` bigint(21)
,`overtime` varchar(67)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_employees_list`
--
DROP VIEW IF EXISTS `view_employees_list`;
CREATE TABLE IF NOT EXISTS `view_employees_list` (
`emp_id` int(5)
,`first_name` varchar(50)
,`middle_name` varchar(50)
,`last_name` varchar(50)
,`status` varchar(50)
,`start_date` date
,`department_name` varchar(100)
,`employment_type` varchar(50)
,`job_title_name` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_job_history`
--
DROP VIEW IF EXISTS `view_job_history`;
CREATE TABLE IF NOT EXISTS `view_job_history` (
`emp_id` int(4)
,`status` varchar(50)
,`employment_type` varchar(50)
,`job_title_name` varchar(20)
,`department_name` varchar(100)
,`start_date` date
,`probationary_date` date
,`permanency_date` date
,`salary` decimal(10,2)
,`end_date` date
,`pay_grade` varchar(5)
,`date_modified` datetime
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_leave_left`
--
DROP VIEW IF EXISTS `view_leave_left`;
CREATE TABLE IF NOT EXISTS `view_leave_left` (
`name` varchar(152)
,`days` smallint(2)
,`leave_type_name` varchar(50)
,`employee_id` varchar(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_leave_remaining`
--
DROP VIEW IF EXISTS `view_leave_remaining`;
CREATE TABLE IF NOT EXISTS `view_leave_remaining` (
`name` varchar(152)
,`birthday_leave` tinyint(2)
,`mandatory_leave` tinyint(2)
,`paternity_leave` tinyint(2)
,`sick_leave` tinyint(2)
,`vacation_leave` tinyint(2)
,`emp_id` int(5)
,`maternity_leave` tinyint(2)
,`total_leave` int(9)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_leave_request`
--
DROP VIEW IF EXISTS `view_leave_request`;
CREATE TABLE IF NOT EXISTS `view_leave_request` (
`name` varchar(152)
,`leave_request_id` varchar(13)
,`leave_reason` varchar(100)
,`leave_start` date
,`leave_status` varchar(20)
,`approved_by` varchar(255)
,`date_approved` date
,`date_requested` timestamp
,`num_days` int(8)
,`leave_end` date
,`leave_left` smallint(2)
,`leave_type` varchar(50)
,`leave_type_name` varchar(50)
,`emp_id` int(5)
,`leave_type_id` varchar(10)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_materials`
--
DROP VIEW IF EXISTS `view_materials`;
CREATE TABLE IF NOT EXISTS `view_materials` (
`item_name` varchar(50)
,`item_id` varchar(10)
,`quantity` int(10)
,`price` decimal(10,2)
,`project_id` varchar(10)
,`date_issued` date
,`project_name` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_project_cost`
--
DROP VIEW IF EXISTS `view_project_cost`;
CREATE TABLE IF NOT EXISTS `view_project_cost` (
`starting_date` date
,`ending_date` date
,`project_id` varchar(5)
,`project_name` varchar(50)
,`client_name` varchar(50)
,`date_added` datetime
,`total_expense` decimal(42,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_project_workers`
--
DROP VIEW IF EXISTS `view_project_workers`;
CREATE TABLE IF NOT EXISTS `view_project_workers` (
`project_id` varchar(5)
,`project_name` varchar(50)
,`name` varchar(152)
,`assigned_date` date
,`emp_id` int(5)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_stocks`
--
DROP VIEW IF EXISTS `view_stocks`;
CREATE TABLE IF NOT EXISTS `view_stocks` (
`item_name` varchar(50)
,`category_name` varchar(50)
,`quantity` varchar(50)
,`date_last_restocked` date
,`price` decimal(10,2)
,`item_id` varchar(10)
);

-- --------------------------------------------------------

--
-- Structure for view `view_all_project_materials`
--
DROP TABLE IF EXISTS `view_all_project_materials`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_all_project_materials` AS select `tbl_stock_info`.`item_name` AS `item_name`,`tbl_materials`.`quantity` AS `quantity`,`tbl_materials`.`price` AS `price`,`tbl_project`.`project_name` AS `project_name`,`tbl_materials`.`date_issued` AS `date_issued`,`tbl_stock_info`.`item_id` AS `item_id`,`tbl_project`.`project_id` AS `project_id` from ((`tbl_project` join `tbl_materials` on((`tbl_materials`.`project_id` = `tbl_project`.`project_id`))) join `tbl_stock_info` on((`tbl_materials`.`item_id` = `tbl_stock_info`.`item_id`)));

-- --------------------------------------------------------

--
-- Structure for view `view_assigned_assets`
--
DROP TABLE IF EXISTS `view_assigned_assets`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_assigned_assets` AS select `tbl_asset_info`.`asset_id` AS `asset_id`,`tbl_asset_info`.`asset_name` AS `asset_name`,`tbl_stocks_category`.`category_name` AS `category_name`,`tbl_assets`.`asset_status` AS `asset_status`,concat(`tbl_emp_info`.`first_name`,' ',`tbl_emp_info`.`middle_name`,' ',`tbl_emp_info`.`last_name`) AS `name`,`tbl_vendor`.`vendor_name` AS `vendor_name`,`tbl_asset_info`.`asset_description` AS `asset_description`,`tbl_asset_info`.`brand` AS `brand`,`tbl_asset_info`.`serial_number` AS `serial_number`,`tbl_asset_info`.`model` AS `model`,`tbl_asset_info`.`warranty_end_date` AS `warranty_end_date`,`tbl_assets`.`assigned_date` AS `assigned_date`,`tbl_emp_info`.`emp_id` AS `emp_id` from ((((`tbl_stocks_category` join `tbl_asset_info` on((`tbl_asset_info`.`category_id` = `tbl_stocks_category`.`category_id`))) join `tbl_assets` on((`tbl_assets`.`asset_id` = `tbl_asset_info`.`asset_id`))) join `tbl_emp_info` on((`tbl_assets`.`employee_id` = `tbl_emp_info`.`emp_id`))) join `tbl_vendor` on((`tbl_vendor`.`vendor_id` = `tbl_asset_info`.`vendor_id`)));

-- --------------------------------------------------------

--
-- Structure for view `view_attendance`
--
DROP TABLE IF EXISTS `view_attendance`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_attendance` AS select distinct `employees`.`emp_id` AS `emp_id`,`employees`.`first_name` AS `first_name`,`employees`.`middle_name` AS `middle_name`,`employees`.`last_name` AS `last_name`,`employees`.`position` AS `position`,`tbl_attendance`.`datelog` AS `datelog`,date_format(`tbl_attendance`.`datetimelog`,'%m/%d/%Y') AS `logdate`,`FN_GETTIMEIN`(date_format(`tbl_attendance`.`datetimelog`,'%m/%d/%Y')) AS `time_in`,`FN_GETTIMEOUT`(date_format(`tbl_attendance`.`datetimelog`,'%m/%d/%Y')) AS `time_out`,ifnull(if((timestampdiff(MINUTE,str_to_date(concat('01/01/1970 ',`FN_GETTIMEIN`(date_format(`tbl_attendance`.`datetimelog`,'%m/%d/%Y'))),'%c/%e/%Y %h:%i %p'),str_to_date(concat('01/01/1970 ',`FN_GETTIMEOUT`(date_format(`tbl_attendance`.`datetimelog`,'%m/%d/%Y'))),'%c/%e/%Y %h:%i %p')) >= 0),format(((timestampdiff(MINUTE,str_to_date(concat('01/01/1970 ',`FN_GETTIMEIN`(date_format(`tbl_attendance`.`datetimelog`,'%m/%d/%Y'))),'%c/%e/%Y %h:%i %p'),str_to_date(concat('01/01/1970 ',`FN_GETTIMEOUT`(date_format(`tbl_attendance`.`datetimelog`,'%m/%d/%Y'))),'%c/%e/%Y %h:%i %p')) / 60) - 1),2),0),0) AS `man_hours`,ifnull(if((timestampdiff(MINUTE,str_to_date('01/01/1970 08:00 AM','%c/%e/%Y %h:%i %p'),str_to_date(concat('01/01/1970 ',`FN_GETTIMEIN`(date_format(`tbl_attendance`.`datetimelog`,'%m/%d/%Y'))),'%c/%e/%Y %h:%i %p')) >= 0),timestampdiff(MINUTE,str_to_date('01/01/1970 08:00 AM','%c/%e/%Y %h:%i %p'),str_to_date(concat('01/01/1970 ',`FN_GETTIMEIN`(date_format(`tbl_attendance`.`datetimelog`,'%m/%d/%Y'))),'%c/%e/%Y %h:%i %p')),0),0) AS `tardiness`,ifnull(if((timestampdiff(MINUTE,str_to_date('01/01/1970 05:00 PM','%c/%e/%Y %h:%i %p'),str_to_date(concat('01/01/1970 ',`FN_GETTIMEOUT`(date_format(`tbl_attendance`.`datetimelog`,'%m/%d/%Y'))),'%c/%e/%Y %h:%i %p')) >= 0),format((timestampdiff(MINUTE,str_to_date('01/01/1970 05:00 PM','%c/%e/%Y %h:%i %p'),str_to_date(concat('01/01/1970 ',`FN_GETTIMEOUT`(date_format(`tbl_attendance`.`datetimelog`,'%m/%d/%Y'))),'%c/%e/%Y %h:%i %p')) / 60),2),0),0) AS `overtime` from (`employees` join `tbl_attendance` on((`tbl_attendance`.`emp_id` = `employees`.`emp_id`))) order by `employees`.`emp_id`,6;

-- --------------------------------------------------------

--
-- Structure for view `view_employees_list`
--
DROP TABLE IF EXISTS `view_employees_list`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_employees_list` AS select `tbl_emp_info`.`emp_id` AS `emp_id`,`tbl_emp_info`.`first_name` AS `first_name`,`tbl_emp_info`.`middle_name` AS `middle_name`,`tbl_emp_info`.`last_name` AS `last_name`,`tbl_emp_history`.`status` AS `status`,`tbl_emp_history`.`start_date` AS `start_date`,`tbl_departments`.`department_name` AS `department_name`,`tbl_employment_type`.`employment_type` AS `employment_type`,`tbl_job_title`.`job_title_name` AS `job_title_name` from ((((`tbl_emp_info` join `tbl_emp_history` on((`tbl_emp_info`.`emp_id` = `tbl_emp_history`.`emp_id`))) join `tbl_departments` on((`tbl_emp_history`.`department_id` = `tbl_departments`.`department_id`))) join `tbl_employment_type` on((`tbl_emp_history`.`employment_type_id` = `tbl_employment_type`.`employment_type_id`))) join `tbl_job_title` on((`tbl_emp_history`.`job_title_id` = `tbl_job_title`.`job_title_id`))) order by `tbl_emp_info`.`emp_id`;

-- --------------------------------------------------------

--
-- Structure for view `view_job_history`
--
DROP TABLE IF EXISTS `view_job_history`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_job_history` AS select `tbl_emp_history`.`emp_id` AS `emp_id`,`tbl_emp_history`.`status` AS `status`,`tbl_employment_type`.`employment_type` AS `employment_type`,`tbl_job_title`.`job_title_name` AS `job_title_name`,`tbl_departments`.`department_name` AS `department_name`,`tbl_emp_history`.`start_date` AS `start_date`,`tbl_emp_history`.`probationary_date` AS `probationary_date`,`tbl_emp_history`.`permanency_date` AS `permanency_date`,`tbl_emp_history`.`salary` AS `salary`,`tbl_emp_history`.`end_date` AS `end_date`,`tbl_emp_history`.`pay_grade` AS `pay_grade`,`tbl_emp_history`.`date_modified` AS `date_modified` from (((`tbl_emp_history` join `tbl_departments` on((`tbl_departments`.`department_id` = `tbl_emp_history`.`department_id`))) join `tbl_employment_type` on((`tbl_employment_type`.`employment_type_id` = `tbl_emp_history`.`employment_type_id`))) join `tbl_job_title` on((`tbl_job_title`.`job_title_id` = `tbl_emp_history`.`job_title_id`)));

-- --------------------------------------------------------

--
-- Structure for view `view_leave_left`
--
DROP TABLE IF EXISTS `view_leave_left`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_leave_left` AS select concat(`tbl_emp_info`.`first_name`,' ',`tbl_emp_info`.`middle_name`,' ',`tbl_emp_info`.`last_name`) AS `name`,`tbl_leave_left`.`days` AS `days`,`tbl_leave_type`.`leave_type_name` AS `leave_type_name`,`tbl_leave_left`.`employee_id` AS `employee_id` from ((`tbl_leave_type` join `tbl_leave_left` on((`tbl_leave_type`.`leave_type_id` = `tbl_leave_left`.`leave_type_id`))) join `tbl_emp_info` on((`tbl_emp_info`.`emp_id` = `tbl_leave_left`.`employee_id`)));

-- --------------------------------------------------------

--
-- Structure for view `view_leave_remaining`
--
DROP TABLE IF EXISTS `view_leave_remaining`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_leave_remaining` AS select concat(`tbl_emp_info`.`first_name`,' ',`tbl_emp_info`.`middle_name`,' ',`tbl_emp_info`.`last_name`) AS `name`,`tbl_leave_remaining`.`birthday_leave` AS `birthday_leave`,`tbl_leave_remaining`.`mandatory_leave` AS `mandatory_leave`,`tbl_leave_remaining`.`paternity_leave` AS `paternity_leave`,`tbl_leave_remaining`.`sick_leave` AS `sick_leave`,`tbl_leave_remaining`.`vacation_leave` AS `vacation_leave`,`tbl_emp_info`.`emp_id` AS `emp_id`,`tbl_leave_remaining`.`maternity_leave` AS `maternity_leave`,(((((`tbl_leave_remaining`.`birthday_leave` + `tbl_leave_remaining`.`mandatory_leave`) + `tbl_leave_remaining`.`paternity_leave`) + `tbl_leave_remaining`.`sick_leave`) + `tbl_leave_remaining`.`vacation_leave`) + `tbl_leave_remaining`.`maternity_leave`) AS `total_leave` from (`tbl_leave_remaining` join `tbl_emp_info` on((`tbl_emp_info`.`emp_id` = `tbl_leave_remaining`.`employee_id`)));

-- --------------------------------------------------------

--
-- Structure for view `view_leave_request`
--
DROP TABLE IF EXISTS `view_leave_request`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_leave_request` AS select concat(`tbl_emp_info`.`first_name`,' ',`tbl_emp_info`.`middle_name`,' ',`tbl_emp_info`.`last_name`) AS `name`,concat(`tbl_leave_request`.`prefix`,`tbl_leave_request`.`id`) AS `leave_request_id`,`tbl_leave_request`.`leave_reason` AS `leave_reason`,`tbl_leave_request`.`leave_start` AS `leave_start`,`tbl_leave_request`.`leave_status` AS `leave_status`,`tbl_leave_request`.`approved_by` AS `approved_by`,`tbl_leave_request`.`date_approved` AS `date_approved`,`tbl_leave_request`.`date_requested` AS `date_requested`,((to_days(`tbl_leave_request`.`leave_end`) - to_days(`tbl_leave_request`.`leave_start`)) + 1) AS `num_days`,`tbl_leave_request`.`leave_end` AS `leave_end`,`tbl_leave_request`.`leave_left` AS `leave_left`,`tbl_leave_request`.`leave_type` AS `leave_type`,`tbl_leave_type`.`leave_type_name` AS `leave_type_name`,`tbl_emp_info`.`emp_id` AS `emp_id`,`tbl_leave_type`.`leave_type_id` AS `leave_type_id` from ((`tbl_emp_info` join `tbl_leave_request` on((`tbl_emp_info`.`emp_id` = `tbl_leave_request`.`employee_id`))) join `tbl_leave_type` on((`tbl_leave_type`.`leave_type_id` = `tbl_leave_request`.`leave_type`))) order by concat(`tbl_leave_request`.`prefix`,`tbl_leave_request`.`id`);

-- --------------------------------------------------------

--
-- Structure for view `view_materials`
--
DROP TABLE IF EXISTS `view_materials`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_materials` AS select `tbl_stock_info`.`item_name` AS `item_name`,`tbl_materials`.`item_id` AS `item_id`,`tbl_materials`.`quantity` AS `quantity`,`tbl_materials`.`price` AS `price`,`tbl_materials`.`project_id` AS `project_id`,`tbl_materials`.`date_issued` AS `date_issued`,`tbl_project`.`project_name` AS `project_name` from ((`tbl_materials` join `tbl_stock_info` on((`tbl_materials`.`item_id` = `tbl_stock_info`.`item_id`))) join `tbl_project` on((`tbl_project`.`project_id` = `tbl_materials`.`project_id`)));

-- --------------------------------------------------------

--
-- Structure for view `view_project_cost`
--
DROP TABLE IF EXISTS `view_project_cost`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_project_cost` AS select `tbl_project`.`starting_date` AS `starting_date`,`tbl_project`.`ending_date` AS `ending_date`,`tbl_project`.`project_id` AS `project_id`,`tbl_project`.`project_name` AS `project_name`,`tbl_client`.`client_name` AS `client_name`,`tbl_project`.`date_added` AS `date_added`,sum((`tbl_materials`.`quantity` * `tbl_materials`.`price`)) AS `total_expense` from ((`tbl_project` join `tbl_client` on((`tbl_client`.`client_id` = `tbl_project`.`client`))) join `tbl_materials` on((`tbl_project`.`project_id` = `tbl_materials`.`project_id`))) group by `tbl_project`.`project_id`,`tbl_project`.`project_name`,`tbl_client`.`client_name`,`tbl_project`.`date_added`;

-- --------------------------------------------------------

--
-- Structure for view `view_project_workers`
--
DROP TABLE IF EXISTS `view_project_workers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_project_workers` AS select `tbl_project`.`project_id` AS `project_id`,`tbl_project`.`project_name` AS `project_name`,concat(`tbl_emp_info`.`first_name`,' ',`tbl_emp_info`.`middle_name`,' ',`tbl_emp_info`.`last_name`) AS `name`,`tbl_project_workers`.`assigned_date` AS `assigned_date`,`tbl_emp_info`.`emp_id` AS `emp_id` from ((`tbl_project` join `tbl_project_workers` on((`tbl_project`.`project_id` = `tbl_project_workers`.`project_id`))) join `tbl_emp_info` on((`tbl_project_workers`.`employee_id` = `tbl_emp_info`.`emp_id`)));

-- --------------------------------------------------------

--
-- Structure for view `view_stocks`
--
DROP TABLE IF EXISTS `view_stocks`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_stocks` AS select `tbl_stock_info`.`item_name` AS `item_name`,`tbl_stocks_category`.`category_name` AS `category_name`,`tbl_stocks`.`quantity` AS `quantity`,`tbl_stocks`.`date_last_restocked` AS `date_last_restocked`,`tbl_stock_info`.`price` AS `price`,`tbl_stocks`.`item_id` AS `item_id` from ((`tbl_stock_info` join `tbl_stocks_category` on((`tbl_stock_info`.`category_id` = `tbl_stocks_category`.`category_id`))) join `tbl_stocks` on((`tbl_stocks`.`item_id` = `tbl_stock_info`.`item_id`)));

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `emp_performance`
--
ALTER TABLE `emp_performance`
  ADD PRIMARY KEY (`performance_id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_201_file`
--
ALTER TABLE `tbl_201_file`
  ADD PRIMARY KEY (`file_id`);

--
-- Indexes for table `tbl_allowances`
--
ALTER TABLE `tbl_allowances`
  ADD PRIMARY KEY (`allowance_id`);

--
-- Indexes for table `tbl_asset_info`
--
ALTER TABLE `tbl_asset_info`
  ADD PRIMARY KEY (`asset_id`);

--
-- Indexes for table `tbl_attendance`
--
ALTER TABLE `tbl_attendance`
  ADD PRIMARY KEY (`attendance_id`);

--
-- Indexes for table `tbl_city`
--
ALTER TABLE `tbl_city`
  ADD PRIMARY KEY (`city_code`);

--
-- Indexes for table `tbl_countries`
--
ALTER TABLE `tbl_countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_emp_info`
--
ALTER TABLE `tbl_emp_info`
  ADD PRIMARY KEY (`emp_id`);

--
-- Indexes for table `tbl_leave_request`
--
ALTER TABLE `tbl_leave_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_payslip`
--
ALTER TABLE `tbl_payslip`
  ADD PRIMARY KEY (`payslip_id`);

--
-- Indexes for table `tbl_payslip_allowances`
--
ALTER TABLE `tbl_payslip_allowances`
  ADD PRIMARY KEY (`payslip_allowance_id`);

--
-- Indexes for table `tbl_payslip_taxes`
--
ALTER TABLE `tbl_payslip_taxes`
  ADD PRIMARY KEY (`payslip_tax_id`);

--
-- Indexes for table `tbl_requestentry`
--
ALTER TABLE `tbl_requestentry`
  ADD PRIMARY KEY (`req_id`);

--
-- Indexes for table `tbl_stocks`
--
ALTER TABLE `tbl_stocks`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `tbl_stocks_category`
--
ALTER TABLE `tbl_stocks_category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `tbl_stock_info`
--
ALTER TABLE `tbl_stock_info`
  ADD PRIMARY KEY (`item_id`);

--
-- Indexes for table `tbl_taxes`
--
ALTER TABLE `tbl_taxes`
  ADD PRIMARY KEY (`tax_id`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `tbl_vendor`
--
ALTER TABLE `tbl_vendor`
  ADD PRIMARY KEY (`vendor_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users_groups`
--
ALTER TABLE `users_groups`
  ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `uc_users_groups` (`user_id`,`group_id`), ADD KEY `fk_users_groups_users1_idx` (`user_id`), ADD KEY `fk_users_groups_groups1_idx` (`group_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `emp_id` int(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `emp_performance`
--
ALTER TABLE `emp_performance`
  MODIFY `performance_id` int(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tbl_allowances`
--
ALTER TABLE `tbl_allowances`
  MODIFY `allowance_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `tbl_attendance`
--
ALTER TABLE `tbl_attendance`
  MODIFY `attendance_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=243;
--
-- AUTO_INCREMENT for table `tbl_countries`
--
ALTER TABLE `tbl_countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=243;
--
-- AUTO_INCREMENT for table `tbl_emp_info`
--
ALTER TABLE `tbl_emp_info`
  MODIFY `emp_id` int(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=101;
--
-- AUTO_INCREMENT for table `tbl_leave_request`
--
ALTER TABLE `tbl_leave_request`
  MODIFY `id` int(5) unsigned zerofill NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tbl_payslip`
--
ALTER TABLE `tbl_payslip`
  MODIFY `payslip_id` int(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `tbl_payslip_allowances`
--
ALTER TABLE `tbl_payslip_allowances`
  MODIFY `payslip_allowance_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `tbl_payslip_taxes`
--
ALTER TABLE `tbl_payslip_taxes`
  MODIFY `payslip_tax_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=57;
--
-- AUTO_INCREMENT for table `tbl_requestentry`
--
ALTER TABLE `tbl_requestentry`
  MODIFY `req_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `tbl_taxes`
--
ALTER TABLE `tbl_taxes`
  MODIFY `tax_id` int(4) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `user_id` int(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `users_groups`
--
ALTER TABLE `users_groups`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `users_groups`
--
ALTER TABLE `users_groups`
ADD CONSTRAINT `fk_users_groups_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_users_groups_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;