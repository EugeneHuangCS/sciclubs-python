-- phpMyAdmin SQL Dump
-- version 4.2.12deb2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 03, 2015 at 08:24 PM
-- Server version: 10.0.15-MariaDB-3
-- PHP Version: 5.6.4-4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `scicompass`
--

-- --------------------------------------------------------

--
-- Table structure for table `catalog`
--

CREATE TABLE IF NOT EXISTS `catalog` (
`ID` int(11) NOT NULL,
  `categoryID` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `info` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
`ID` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `info` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
`ID` int(11) NOT NULL,
  `instrumentID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `time` datetime NOT NULL,
  `word` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `institute`
--

CREATE TABLE IF NOT EXISTS `institute` (
`ID` int(11) NOT NULL,
  `chief` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `info` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `instrument`
--

CREATE TABLE IF NOT EXISTS `instrument` (
`ID` int(11) NOT NULL,
  `catalogID` int(11) NOT NULL,
  `instituteID` int(11) NOT NULL,
  `location` point NOT NULL,
  `address` varchar(64) NOT NULL,
  `price` int(11) NOT NULL,
  `rate` int(11) NOT NULL,
  `info` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `operator`
--

CREATE TABLE IF NOT EXISTS `operator` (
`ID` int(11) NOT NULL,
  `instituteID` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `loginName` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `phone` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `credit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE IF NOT EXISTS `order` (
`ID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `usageID` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `status` int(11) NOT NULL,
  `fee` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `usage`
--

CREATE TABLE IF NOT EXISTS `usage` (
`ID` int(11) NOT NULL,
  `instrumentID` int(11) NOT NULL,
  `operatorID` int(11) NOT NULL,
  `begin` datetime NOT NULL,
  `end` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
`ID` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `loginName` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `phone` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `credit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `catalog`
--
ALTER TABLE `catalog`
 ADD PRIMARY KEY (`ID`), ADD KEY `categoryID` (`categoryID`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
 ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
 ADD PRIMARY KEY (`ID`), ADD KEY `instrumentID` (`instrumentID`), ADD KEY `userID` (`userID`);

--
-- Indexes for table `institute`
--
ALTER TABLE `institute`
 ADD PRIMARY KEY (`ID`), ADD KEY `chief` (`chief`);

--
-- Indexes for table `instrument`
--
ALTER TABLE `instrument`
 ADD PRIMARY KEY (`ID`), ADD KEY `catalogID` (`catalogID`,`instituteID`), ADD KEY `instituteID` (`instituteID`);

--
-- Indexes for table `operator`
--
ALTER TABLE `operator`
 ADD PRIMARY KEY (`ID`), ADD KEY `instituteID` (`instituteID`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
 ADD PRIMARY KEY (`ID`), ADD KEY `usageID` (`usageID`), ADD KEY `userID` (`userID`);

--
-- Indexes for table `usage`
--
ALTER TABLE `usage`
 ADD PRIMARY KEY (`ID`), ADD KEY `instrumentID` (`instrumentID`,`operatorID`), ADD KEY `operatorID` (`operatorID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
 ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `catalog`
--
ALTER TABLE `catalog`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `comment`
--
ALTER TABLE `comment`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `institute`
--
ALTER TABLE `institute`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `instrument`
--
ALTER TABLE `instrument`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `operator`
--
ALTER TABLE `operator`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `usage`
--
ALTER TABLE `usage`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `catalog`
--
ALTER TABLE `catalog`
ADD CONSTRAINT `catalog_ibfk_1` FOREIGN KEY (`categoryID`) REFERENCES `category` (`ID`);

--
-- Constraints for table `comment`
--
ALTER TABLE `comment`
ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`instrumentID`) REFERENCES `instrument` (`ID`),
ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`);

--
-- Constraints for table `institute`
--
ALTER TABLE `institute`
ADD CONSTRAINT `institute_ibfk_1` FOREIGN KEY (`chief`) REFERENCES `operator` (`ID`);

--
-- Constraints for table `instrument`
--
ALTER TABLE `instrument`
ADD CONSTRAINT `instrument_ibfk_1` FOREIGN KEY (`catalogID`) REFERENCES `catalog` (`ID`),
ADD CONSTRAINT `instrument_ibfk_2` FOREIGN KEY (`instituteID`) REFERENCES `institute` (`ID`);

--
-- Constraints for table `operator`
--
ALTER TABLE `operator`
ADD CONSTRAINT `operator_ibfk_1` FOREIGN KEY (`instituteID`) REFERENCES `institute` (`ID`);

--
-- Constraints for table `order`
--
ALTER TABLE `order`
ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`),
ADD CONSTRAINT `order_ibfk_2` FOREIGN KEY (`usageID`) REFERENCES `usage` (`ID`);

--
-- Constraints for table `usage`
--
ALTER TABLE `usage`
ADD CONSTRAINT `usage_ibfk_1` FOREIGN KEY (`instrumentID`) REFERENCES `instrument` (`ID`),
ADD CONSTRAINT `usage_ibfk_2` FOREIGN KEY (`operatorID`) REFERENCES `operator` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
