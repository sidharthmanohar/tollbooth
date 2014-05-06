-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 06, 2014 at 12:47 PM
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
(1, 'one way'),
(2, 'two way');

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

INSERT INTO `ticket` (`barcode`, `from_toll_plaza_id`, `to_toll_plaza_id`, `tollbooth_id`, `pass_type`, `vehicle_no`, `vehicle_type_id`, `fare_collected`, `registration_time`) VALUES
('dc24717299149633', 0, 0, 0, 1, 'dc', 0, 0, '2014-05-06 18:10:55'),
('dedd24411619967685', 0, 0, 0, 1, 'dedd', 0, 0, '2014-05-06 18:05:49'),
('ed24679072905133', 0, 0, 0, 1, 'ed', 0, 0, '2014-05-06 18:10:17'),
('TN59AL24001400111835891', 1, 0, 0, 1, 'TN59AL2400', 0, 300, '2014-05-06 11:42:18'),
('w24315705555413', 0, 0, 0, 1, 'w', 0, 0, '2014-05-06 18:04:13');

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
  KEY `from_toll_plaza_id` (`from_toll_plaza_id`),
  KEY `to_toll_plaza_id` (`to_toll_plaza_id`),
  KEY `vehicle_type` (`vehicle_type_id`),
  KEY `pass_id` (`pass_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `toll_charge`
--

INSERT INTO `toll_charge` (`from_toll_plaza_id`, `to_toll_plaza_id`, `pass_id`, `fare`, `effect_from`, `vehicle_type_id`) VALUES
(0, 1, 1, 200, '2014-03-15', 0),
(1, 0, 1, 300, '2014-03-14', 0);

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
(0, 'toll plaza 1', 'toll plaza desc', 0),
(1, 'toll plaza 2', 'toll plaza desc', 0);

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
  PRIMARY KEY (`user_id`),
  KEY `toll_plaza_id` (`toll_plaza_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_detail`
--

INSERT INTO `user_detail` (`user_id`, `password`, `user_type`, `toll_plaza_id`, `tollbooth_no`) VALUES
('admin', 'admin', 1, 0, 0),
('user', 'user', 2, 0, 0);

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
('TN59AL24001400111835891', 1, '2014-05-06 06:12:18', 0),
('w24315705555413', 0, '2014-05-06 12:34:13', 0),
('dedd24411619967685', 0, '2014-05-06 12:35:49', 0),
('dc24717299149633', 0, '2014-05-06 12:40:55', 0);

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
(0, 'Heavy Vehicle', 'bus,lorry'),
(1, 'Light Vehicle', 'car, lorry');

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
