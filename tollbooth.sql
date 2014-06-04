-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 04, 2014 at 03:38 PM
-- Server version: 5.6.12-log
-- PHP Version: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tollbooth`
--
CREATE DATABASE IF NOT EXISTS `tollbooth` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `tollbooth`;

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE IF NOT EXISTS `location` (
  `location_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`location_id`, `name`) VALUES
(1, 'Melur'),
(2, 'Sivagangai'),
(3, 'Ramnad'),
(4, 'Nedunkulam'),
(5, 'Aruppukottai'),
(6, 'Kanyakumari');

-- --------------------------------------------------------

--
-- Table structure for table `pass_type`
--

CREATE TABLE IF NOT EXISTS `pass_type` (
  `pass_id` int(11) NOT NULL,
  `pass_type` varchar(30) NOT NULL,
  PRIMARY KEY (`pass_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pass_type`
--

INSERT INTO `pass_type` (`pass_id`, `pass_type`) VALUES
(1, 'Single Trip'),
(2, 'Round Trip'),
(3, 'Multiple Entry'),
(4, 'Monthly Pass');

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE IF NOT EXISTS `ticket` (
  `barcode` varchar(60) NOT NULL,
  `from_toll_plaza_id` int(11) NOT NULL,
  `to_toll_plaza_id` int(11) NOT NULL,
  `tollbooth_id` int(11) NOT NULL,
  `pass_type` int(11) NOT NULL,
  `vehicle_no` varchar(10) NOT NULL,
  `vehicle_type_id` int(11) NOT NULL,
  `fare_collected` bigint(20) NOT NULL,
  `registration_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ticket_no` varchar(20) NOT NULL,
  `validity` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`barcode`),
  KEY `from_toll_plaza_id` (`from_toll_plaza_id`),
  KEY `to_toll_plaza_id` (`to_toll_plaza_id`),
  KEY `vehicle_type_id` (`vehicle_type_id`),
  KEY `pass_type` (`pass_type`),
  KEY `tollbooth_id` (`tollbooth_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`barcode`, `from_toll_plaza_id`, `to_toll_plaza_id`, `tollbooth_id`, `pass_type`, `vehicle_no`, `vehicle_type_id`, `fare_collected`, `registration_time`, `ticket_no`, `validity`) VALUES
('111400747950', 1, 1, 1, 1, 'TN54AL400', 1, 10, '2014-05-22 14:09:11', 'T1B1-1', '2014-05-23 08:39:11'),
('111400747971', 1, 1, 1, 1, 'TN45BL600', 1, 30, '2014-05-22 14:09:31', 'T1B1-2', '2014-05-23 08:39:31'),
('111400747995', 1, 5, 1, 1, 'TN34AL4300', 1, 210, '2014-05-22 14:09:56', 'T1B1-3', '2014-05-23 08:39:56'),
('111400748121', 1, 5, 1, 2, 'TN45N0000', 1, 210, '2014-05-22 14:12:01', 'T1B1-4', '2014-05-23 08:42:01'),
('111401716079', 1, 1, 1, 1, 'tn3453', 1, 46, '2014-06-02 19:04:39', 'T1B1-5', '2014-06-03 13:34:39'),
('111401716749', 1, 1, 1, 1, 'asd', 1, 46, '2014-06-02 19:15:50', 'T1B1-6', '2014-06-03 13:45:50'),
('111401721330', 1, 1, 1, 1, 'asd', 1, 46, '2014-06-02 20:32:11', 'T1B1-7', '2014-06-03 15:02:11'),
('111401721432', 1, 1, 1, 1, 'sad', 1, 46, '2014-06-02 20:33:53', 'T1B1-8', '2014-06-03 15:03:53'),
('111401883269', 1, 1, 1, 1, 'TN59A2400', 1, 24, '2014-06-04 17:31:09', 'T1B1-9', '2014-06-05 12:01:09'),
('111401883426', 1, 1, 1, 1, 'sad', 1, 24, '2014-06-04 17:33:46', 'T1B1-10', '2014-06-05 12:03:46'),
('111401883812', 1, 1, 1, 1, 'adsf', 1, 24, '2014-06-04 17:40:12', 'T1B1-11', '2014-06-05 12:10:12'),
('111401883818', 1, 1, 1, 1, 'adsf', 1, 24, '2014-06-04 17:40:19', 'T1B1-12', '2014-06-05 12:10:19'),
('111401883863', 1, 5, 1, 1, 'ewr', 1, 563, '2014-06-04 17:41:04', 'T1B1-13', '2014-06-05 12:11:04'),
('111401884311', 1, 1, 1, 3, 'ad', 1, 0, '2014-06-04 17:48:32', 'T1B1-14', '2014-01-31 18:30:00'),
('111401889529', 1, 1, 1, 1, 't', 1, 24, '2014-06-04 19:15:29', 'T1B1-15', '2014-06-05 13:45:29'),
('111401890227', 1, 1, 1, 1, 'g', 1, 24, '2014-06-04 19:27:07', 'T1B1-16', '2014-06-05 13:57:07'),
('111401890562', 1, 1, 1, 1, 'ad', 1, 24, '2014-06-04 19:32:43', 'T1B1-17', '2014-06-05 14:02:43'),
('111401890573', 1, 1, 1, 2, 'ds', 1, 0, '2014-06-04 19:32:53', 'T1B1-18', '2014-06-05 14:02:53'),
('111401890581', 1, 1, 1, 3, 'ad', 1, 0, '2014-06-04 19:33:02', 'T1B1-19', '2014-06-05 14:03:02'),
('111401890590', 1, 1, 1, 4, 'adfs', 1, 0, '2014-06-04 19:33:11', 'T1B1-20', '2014-01-31 18:30:00'),
('111401890641', 1, 1, 1, 3, 'a', 1, 0, '2014-06-04 19:34:02', 'T1B1-21', '2014-06-05 14:04:02'),
('111401892128', 1, 2, 1, 1, 'a', 1, 25, '2014-06-04 19:58:49', 'T1B1-22', '2014-06-05 14:28:49'),
('111401892239', 1, 2, 1, 2, 'a', 1, 35, '2014-06-04 20:00:39', 'T1B1-23', '2014-06-05 14:30:39'),
('111401892252', 1, 2, 1, 3, 'd', 1, 75, '2014-06-04 20:00:52', 'T1B1-24', '2014-06-05 14:30:52'),
('111401892270', 1, 2, 1, 4, 'd', 1, -10, '2014-06-04 20:01:11', 'T1B1-25', '2014-01-31 18:30:00'),
('111401893536', 1, 1, 1, 1, 'q', 1, 222, '2014-06-04 20:22:17', 'T1B1-26', '2014-06-05 14:52:17'),
('111401893600', 1, 1, 1, 4, 'a', 1, -10, '2014-06-04 20:23:20', 'T1B1-27', '2014-01-31 18:29:59'),
('111401893867', 1, 1, 1, 4, 'a', 1, -10, '2014-06-04 20:27:47', 'T1B1-28', '2014-01-31 18:29:59'),
('111401894505', 1, 1, 1, 4, 'a', 1, -10, '2014-06-04 20:38:25', 'T1B1-29', '2014-01-31 18:29:59'),
('111401894610', 1, 2, 1, 2, 'a', 1, 343, '2014-06-04 20:40:10', 'T1B1-30', '2014-06-05 15:10:10'),
('111401894631', 1, 2, 1, 4, 's', 1, 10633, '2014-06-04 20:40:32', 'T1B1-31', '2014-01-31 18:30:00'),
('111401894659', 1, 2, 1, 4, '1', 1, 9604, '2014-06-04 20:41:00', 'T1B1-32', '2014-02-28 18:30:00'),
('111401895413', 1, 1, 1, 4, 'a', 1, 10323, '2014-06-04 20:53:34', 'T1B1-33', '2014-12-31 18:30:00'),
('111401895433', 1, 1, 1, 4, 'a', 1, 9990, '2014-06-04 20:53:53', 'T1B1-34', '2014-06-30 18:29:59'),
('111401895453', 1, 1, 1, 4, 'a', 1, 10323, '2014-06-04 20:54:14', 'T1B1-35', '2014-07-31 18:30:00'),
('111401895461', 1, 1, 1, 4, 'a', 1, 10323, '2014-06-04 20:54:21', 'T1B1-36', '2015-01-31 18:29:59'),
('111401895824', 1, 1, 1, 1, 'a', 1, 222, '2014-06-04 21:00:25', 'T1B1-37', '2014-06-05 15:30:25'),
('111401895835', 1, 1, 1, 4, 'a', 1, 10323, '2014-06-04 21:00:36', 'T1B1-38', '2014-08-31 18:30:00'),
('111401896091', 1, 1, 1, 4, 'TN59A2400', 1, 10323, '2014-06-04 21:04:52', 'T1B1-39', '2014-08-31 18:30:00'),
('141401716102', 1, 1, 4, 1, 'adf', 1, 12, '2014-06-02 19:05:03', 'T1B4-1', '2014-06-03 13:35:03'),
('141401883894', 1, 1, 4, 1, 'afd', 1, 23, '2014-06-04 17:41:35', 'T1B4-2', '2014-06-05 12:11:35'),
('211401888983', 2, 2, 1, 1, 'TN59A2400', 1, 30, '2014-06-04 19:06:24', 'T2B1-1', '2014-06-05 13:36:24'),
('211401889000', 2, 3, 1, 1, 's', 1, 40, '2014-06-04 19:06:40', 'T2B1-2', '2014-06-05 13:36:40'),
('211401889012', 2, 5, 1, 1, 's', 1, 60, '2014-06-04 19:06:53', 'T2B1-3', '2014-06-05 13:36:53'),
('241401889026', 2, 1, 4, 1, 'f', 1, 10, '2014-06-04 19:07:07', 'T2B4-1', '2014-06-05 13:37:07'),
('241401889039', 2, 2, 4, 1, '1', 1, 20, '2014-06-04 19:07:20', 'T2B4-2', '2014-06-05 13:37:20');

-- --------------------------------------------------------

--
-- Table structure for table `toll_charge`
--

CREATE TABLE IF NOT EXISTS `toll_charge` (
  `from_toll_plaza_id` int(11) NOT NULL,
  `to_toll_plaza_id` int(11) NOT NULL,
  `pass_id` int(11) NOT NULL,
  `fare` int(11) NOT NULL,
  `effect_from` date NOT NULL,
  `vehicle_type_id` int(20) NOT NULL,
  `direction` int(11) NOT NULL,
  KEY `from_toll_plaza_id` (`from_toll_plaza_id`),
  KEY `to_toll_plaza_id` (`to_toll_plaza_id`),
  KEY `vehicle_type` (`vehicle_type_id`),
  KEY `pass_id` (`pass_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `toll_charge`
--

INSERT INTO `toll_charge` (`from_toll_plaza_id`, `to_toll_plaza_id`, `pass_id`, `fare`, `effect_from`, `vehicle_type_id`, `direction`) VALUES
(1, 1, 1, 23, '2014-06-03', 1, 2),
(1, 1, 1, 24, '2014-06-03', 1, 1),
(1, 2, 1, 25, '2014-06-03', 1, 1),
(1, 3, 1, 63, '2014-06-03', 1, 1),
(1, 4, 1, 536, '2014-06-03', 1, 1),
(1, 5, 1, 563, '2014-06-03', 1, 1),
(1, 1, 1, 11, '2014-06-02', 1, 2),
(1, 1, 1, 21, '2014-06-02', 1, 1),
(1, 2, 1, 2, '2014-06-02', 1, 1),
(1, 3, 1, 12, '2014-06-02', 1, 1),
(1, 4, 1, 13, '2014-06-02', 1, 1),
(1, 5, 1, 13, '2014-06-02', 1, 1),
(2, 1, 1, 10, '2014-06-04', 1, 2),
(2, 2, 1, 20, '2014-06-04', 1, 2),
(2, 2, 1, 30, '2014-06-04', 1, 1),
(2, 3, 1, 40, '2014-06-04', 1, 1),
(2, 4, 1, 50, '2014-06-04', 1, 1),
(2, 5, 1, 60, '2014-06-04', 1, 1),
(1, 1, 1, 111, '2014-06-04', 1, 2),
(1, 1, 1, 222, '2014-06-04', 1, 1),
(1, 2, 1, 333, '2014-06-04', 1, 1),
(1, 3, 1, 444, '2014-06-04', 1, 1),
(1, 4, 1, 555, '2014-06-04', 1, 1),
(1, 5, 1, 666, '2014-06-04', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `toll_plaza`
--

CREATE TABLE IF NOT EXISTS `toll_plaza` (
  `toll_plaza_id` int(11) NOT NULL,
  `toll_plaza_name` varchar(20) NOT NULL,
  `toll_plaza_description` varchar(50) NOT NULL,
  `no_of_tollbooth` int(11) NOT NULL,
  PRIMARY KEY (`toll_plaza_id`),
  UNIQUE KEY `toll_plaza_name` (`toll_plaza_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `toll_plaza`
--

INSERT INTO `toll_plaza` (`toll_plaza_id`, `toll_plaza_name`, `toll_plaza_description`, `no_of_tollbooth`) VALUES
(1, 'Toll Plaza 1', '', 6),
(2, 'Toll Plaza 2', '', 6),
(3, 'Toll Plaza 3', '', 6),
(4, 'Toll Plaza 4', '', 6),
(5, 'Toll Plaza 5', '', 6);

-- --------------------------------------------------------

--
-- Table structure for table `user_detail`
--

CREATE TABLE IF NOT EXISTS `user_detail` (
  `user_id` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `user_type` tinyint(4) NOT NULL,
  `toll_plaza_id` int(11) NOT NULL,
  `tollbooth_no` int(11) NOT NULL,
  `lane` int(11) NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `toll_plaza_id` (`toll_plaza_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_detail`
--

INSERT INTO `user_detail` (`user_id`, `password`, `user_type`, `toll_plaza_id`, `tollbooth_no`, `lane`) VALUES
('admin', 'admin', 1, 1, 1, 1),
('plaza1booth1', '11', 2, 1, 1, 1),
('plaza1booth4', '14', 2, 1, 4, 2),
('plaza2booth1', '21', 2, 2, 1, 1),
('plaza2booth4', '24', 2, 2, 4, 2),
('plaza3booth1', '31', 2, 3, 1, 1),
('plaza3booth4', '34', 2, 3, 4, 2),
('plaza4booth1', '41', 2, 4, 1, 1),
('plaza4booth2', '42', 2, 4, 4, 2),
('plaza5booth1', '51', 2, 5, 1, 1),
('plaza5booth4', '54', 2, 5, 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_tracking`
--

CREATE TABLE IF NOT EXISTS `vehicle_tracking` (
  `barcode` varchar(60) NOT NULL,
  `toll_plaza_id` int(11) NOT NULL,
  `registration_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `booth_no` int(11) NOT NULL,
  KEY `barcode` (`barcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vehicle_tracking`
--

INSERT INTO `vehicle_tracking` (`barcode`, `toll_plaza_id`, `registration_time`, `booth_no`) VALUES
('111400747950', 1, '2014-05-22 08:39:11', 1),
('111400747971', 1, '2014-05-22 08:39:31', 1),
('111400747995', 1, '2014-05-22 08:39:56', 1),
('111400748121', 1, '2014-05-22 08:42:01', 1),
('111400748121', 2, '2014-05-22 08:43:13', 1),
('111401716079', 1, '2014-06-02 13:34:39', 1),
('141401716102', 1, '2014-06-02 13:35:03', 4),
('111401716749', 1, '2014-06-02 13:45:50', 1),
('111401721330', 1, '2014-06-02 15:02:11', 1),
('111401721432', 1, '2014-06-02 15:03:53', 1),
('111401883269', 1, '2014-06-04 12:01:09', 1),
('111401883426', 1, '2014-06-04 12:03:46', 1),
('111401883812', 1, '2014-06-04 12:10:12', 1),
('111401883818', 1, '2014-06-04 12:10:19', 1),
('111401883863', 1, '2014-06-04 12:11:04', 1),
('141401883894', 1, '2014-06-04 12:11:35', 4),
('111401884311', 1, '2014-06-04 12:18:32', 1),
('211401888983', 2, '2014-06-04 13:36:24', 1),
('211401889000', 2, '2014-06-04 13:36:40', 1),
('211401889012', 2, '2014-06-04 13:36:53', 1),
('241401889026', 2, '2014-06-04 13:37:07', 4),
('241401889039', 2, '2014-06-04 13:37:20', 4),
('111401889529', 1, '2014-06-04 13:45:29', 1),
('111401890227', 1, '2014-06-04 13:57:07', 1),
('111401890562', 1, '2014-06-04 14:02:43', 1),
('111401890573', 1, '2014-06-04 14:02:53', 1),
('111401890581', 1, '2014-06-04 14:03:02', 1),
('111401890590', 1, '2014-06-04 14:03:11', 1),
('111401890641', 1, '2014-06-04 14:04:02', 1),
('111401892128', 1, '2014-06-04 14:28:49', 1),
('111401892239', 1, '2014-06-04 14:30:39', 1),
('111401892252', 1, '2014-06-04 14:30:52', 1),
('111401892270', 1, '2014-06-04 14:31:11', 1),
('111401893536', 1, '2014-06-04 14:52:17', 1),
('111401893600', 1, '2014-06-04 14:53:20', 1),
('111401893867', 1, '2014-06-04 14:57:47', 1),
('111401894505', 1, '2014-06-04 15:08:25', 1),
('111401894610', 1, '2014-06-04 15:10:10', 1),
('111401894631', 1, '2014-06-04 15:10:32', 1),
('111401894659', 1, '2014-06-04 15:11:00', 1),
('111401895413', 1, '2014-06-04 15:23:34', 1),
('111401895433', 1, '2014-06-04 15:23:53', 1),
('111401895453', 1, '2014-06-04 15:24:14', 1),
('111401895461', 1, '2014-06-04 15:24:21', 1),
('111401895824', 1, '2014-06-04 15:30:25', 1),
('111401895835', 1, '2014-06-04 15:30:36', 1),
('111401896091', 1, '2014-06-04 15:34:52', 1);

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_type`
--

CREATE TABLE IF NOT EXISTS `vehicle_type` (
  `vehicle_type_id` int(11) NOT NULL,
  `vehicle_type` varchar(20) NOT NULL,
  `vehicle_description` varchar(50) NOT NULL,
  PRIMARY KEY (`vehicle_type_id`),
  UNIQUE KEY `vehicle_type` (`vehicle_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vehicle_type`
--

INSERT INTO `vehicle_type` (`vehicle_type_id`, `vehicle_type`, `vehicle_description`) VALUES
(1, 'Light Vehicle', 'car, lorry'),
(2, 'Medium Vehicle', ''),
(3, 'Heavy Vehicle', 'lorry, bus');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`vehicle_type_id`) REFERENCES `vehicle_type` (`vehicle_type_id`),
  ADD CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`from_toll_plaza_id`) REFERENCES `toll_plaza` (`toll_plaza_id`),
  ADD CONSTRAINT `ticket_ibfk_3` FOREIGN KEY (`to_toll_plaza_id`) REFERENCES `toll_plaza` (`toll_plaza_id`),
  ADD CONSTRAINT `ticket_ibfk_4` FOREIGN KEY (`pass_type`) REFERENCES `pass_type` (`pass_id`);

--
-- Constraints for table `toll_charge`
--
ALTER TABLE `toll_charge`
  ADD CONSTRAINT `toll_charge_ibfk_1` FOREIGN KEY (`to_toll_plaza_id`) REFERENCES `toll_plaza` (`toll_plaza_id`),
  ADD CONSTRAINT `toll_charge_ibfk_2` FOREIGN KEY (`vehicle_type_id`) REFERENCES `vehicle_type` (`vehicle_type_id`),
  ADD CONSTRAINT `toll_charge_ibfk_3` FOREIGN KEY (`from_toll_plaza_id`) REFERENCES `toll_plaza` (`toll_plaza_id`),
  ADD CONSTRAINT `toll_charge_ibfk_4` FOREIGN KEY (`pass_id`) REFERENCES `pass_type` (`pass_id`);

--
-- Constraints for table `user_detail`
--
ALTER TABLE `user_detail`
  ADD CONSTRAINT `user_detail_ibfk_1` FOREIGN KEY (`toll_plaza_id`) REFERENCES `toll_plaza` (`toll_plaza_id`);

--
-- Constraints for table `vehicle_tracking`
--
ALTER TABLE `vehicle_tracking`
  ADD CONSTRAINT `vehicle_tracking_ibfk_1` FOREIGN KEY (`barcode`) REFERENCES `ticket` (`barcode`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
