CREATE DATABASE  IF NOT EXISTS `synesthesia` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `synesthesia`;
-- MySQL dump 10.13  Distrib 5.6.13, for osx10.6 (i386)
--
-- Host: 127.0.0.1    Database: synesthesia
-- ------------------------------------------------------
-- Server version	5.5.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `t_opinion`
--

DROP TABLE IF EXISTS `t_opinion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_opinion` (
  `f_opinion_id` int(11) NOT NULL,
  `f_tag_id` int(11) DEFAULT NULL,
  `f_time` datetime DEFAULT NULL COMMENT 'Date and time upto seconds',
  `f_user_id` int(11) DEFAULT NULL COMMENT 'User id',
  `f_longitude` decimal(25,20) DEFAULT NULL,
  `f_latitude` decimal(25,20) DEFAULT NULL,
  `f_op_red` int(11) DEFAULT NULL COMMENT 'Red colour from 0-255',
  `f_op_green` int(11) DEFAULT NULL COMMENT 'Green colour from 0-255',
  `f_op_blue` int(11) DEFAULT NULL COMMENT 'Blue\n colour from 0-255',
  `f_op_text` varchar(400) DEFAULT NULL COMMENT 'Future proof - capture opinion with the colour. Limit 400\n',
  `f_location_id` int(11) DEFAULT NULL COMMENT 'The location id from google map API. ',
  `f_city` varchar(45) DEFAULT NULL COMMENT 'City text from google map API.',
  `f_state` varchar(45) DEFAULT NULL COMMENT 'State text from google map API.',
  `f_country` varchar(45) DEFAULT NULL COMMENT 'Country text from google map api',
  `f_op_status` varchar(45) DEFAULT NULL COMMENT 'Active; Deleted; Abuse',
  PRIMARY KEY (`f_opinion_id`),
  KEY `fk_tag_idx` (`f_tag_id`),
  CONSTRAINT `fk_tag` FOREIGN KEY (`f_tag_id`) REFERENCES `t_tag` (`f_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_tag`
--

DROP TABLE IF EXISTS `t_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_tag` (
  `f_tag_id` int(11) NOT NULL,
  `f_tag` varchar(200) DEFAULT NULL,
  `f_status` varchar(45) DEFAULT NULL COMMENT 'Active, Deleted, Abuse, Duplicate',
  PRIMARY KEY (`f_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'synesthesia'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-10-18 18:10:02
