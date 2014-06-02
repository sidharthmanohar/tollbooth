-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 02, 2014 at 05:22 PM
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
(2, 'Multiple Entry'),
(3, 'Monthly Pass');

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
('141401716102', 1, 1, 4, 1, 'adf', 1, 12, '2014-06-02 19:05:03', 'T1B4-1', '2014-06-03 13:35:03');

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
(1, 5, 1, 13, '2014-06-02', 1, 1);

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
('111401721432', 1, '2014-06-02 15:03:53', 1);

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
