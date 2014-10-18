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
  `f_opinion_id` int(11) NOT NULL AUTO_INCREMENT,
  `f_tag_id` int(11) DEFAULT NULL,
  `f_time` datetime DEFAULT NULL COMMENT 'Date and time upto seconds',
  `f_user_id` int(11) DEFAULT NULL COMMENT 'User id',
  `f_geocode` point DEFAULT NULL COMMENT 'Using Mysql point datatype for easy seeks.',
  `f_longitude` float DEFAULT NULL,
  `f_latitude` float DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_opinion`
--

LOCK TABLES `t_opinion` WRITE;
/*!40000 ALTER TABLE `t_opinion` DISABLE KEYS */;
INSERT INTO `t_opinion` VALUES (1,6,'2014-09-09 20:27:39',86,NULL,-140.805,-42.0414,1,58,32,NULL,NULL,NULL,NULL,NULL,'Active'),(2,3,'2014-09-29 04:08:03',174,NULL,-63.1166,-86.9605,28,128,44,NULL,NULL,NULL,NULL,NULL,'Active'),(3,6,'2014-09-29 01:26:18',118,NULL,148.925,54.9015,72,1,44,NULL,NULL,NULL,NULL,NULL,'Active'),(4,2,'2014-09-06 15:14:06',20,NULL,-71.9894,-52.6617,35,16,231,NULL,NULL,NULL,NULL,NULL,'Active'),(5,6,'2014-08-24 21:42:39',150,NULL,142.726,-47.5602,125,189,59,NULL,NULL,NULL,NULL,NULL,'Active'),(6,1,'2014-10-18 07:36:36',45,NULL,-151.196,42.4506,112,252,159,NULL,NULL,NULL,NULL,NULL,'Active'),(7,4,'2014-08-27 18:24:15',8,NULL,-6.52222,-35.8817,14,98,194,NULL,NULL,NULL,NULL,NULL,'Active'),(8,4,'2014-08-28 13:22:48',107,NULL,-175.276,-6.71388,70,251,23,NULL,NULL,NULL,NULL,NULL,'Active'),(9,2,'2014-10-04 04:45:00',151,NULL,177.066,37.5778,145,183,222,NULL,NULL,NULL,NULL,NULL,'Active'),(10,5,'2014-09-24 00:55:08',104,NULL,-69.7982,85.5962,245,222,120,NULL,NULL,NULL,NULL,NULL,'Active');
/*!40000 ALTER TABLE `t_opinion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_tag`
--

DROP TABLE IF EXISTS `t_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_tag` (
  `f_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `f_timestamp` datetime DEFAULT NULL,
  `f_user_id` int(11) DEFAULT NULL,
  `f_tag` varchar(200) DEFAULT NULL,
  `f_status` varchar(45) DEFAULT NULL COMMENT 'Active, Deleted, Abuse, Duplicate',
  PRIMARY KEY (`f_tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_tag`
--

LOCK TABLES `t_tag` WRITE;
/*!40000 ALTER TABLE `t_tag` DISABLE KEYS */;
INSERT INTO `t_tag` VALUES (1,'2014-09-29 13:20:46',2,'ebola','Active'),(2,'2014-08-30 11:27:17',4,'Arsenal','Active'),(3,'2014-10-03 12:17:50',2,'Islamic State','Active'),(4,'2014-09-04 13:44:23',7,'Cancer','Active'),(5,'2014-10-17 02:52:06',1,'Mood','Active'),(6,'2014-08-30 10:51:04',5,'Weather','Active');
/*!40000 ALTER TABLE `t_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'synesthesia'
--
/*!50003 DROP PROCEDURE IF EXISTS `get_tags` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`synesthesia`@`%` PROCEDURE `get_tags`()
BEGIN
	select f_tag from t_tag where f_status = 'active';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sample_data` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`synesthesia`@`%` PROCEDURE `sample_data`(in totalrows int)
BEGIN
declare currentrow int default 0;
while currentrow < totalrows
do
	insert into t_opinion (f_tag_id, f_time, f_user_id, f_longitude, f_latitude, 
	f_op_red, f_op_green, f_op_blue, f_op_status)
	select floor(max(a.f_tag_id) * rand() + 1), 
	sysdate() - interval floor(rand() * 5000000) second,
	floor(rand() * 200) + 1,
	rand() * 360 - 180,
	rand() * 180 - 90,
	floor(rand() * 256), floor(rand() * 256), floor(rand() * 256),
	'Active'
	from t_tag a;
set currentrow = currentrow + 1;
end while; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-10-18 20:12:04
