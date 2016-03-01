-- MySQL dump 10.13  Distrib 5.5.46, for Linux (x86_64)
--
-- Host: mysql.mydomain.com    Database: MY_DB_DATABASE
-- ------------------------------------------------------
-- Server version	5.5.46

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_username` varchar(255) DEFAULT NULL,
  `account_password` varchar(255) DEFAULT NULL,
  `account_name_first` varchar(255) DEFAULT NULL,
  `account_name_last` varchar(255) DEFAULT NULL,
  `account_phone` varchar(255) DEFAULT NULL,
  `account_email` varchar(255) DEFAULT NULL,
  `account_desc` text,
  `account_note` text,
  `account_agree` int(11) DEFAULT NULL,
  `account_created` datetime DEFAULT NULL,
  `account_accessed` datetime DEFAULT NULL,
  `account_type` int(11) DEFAULT NULL,
  `account_verified` int(11) NOT NULL DEFAULT '0',
  `account_status` int(11) DEFAULT NULL,
  `account_partnercrumb` varchar(100) NOT NULL DEFAULT 'launchleader',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_username` (`account_username`)
) ENGINE=MyISAM AUTO_INCREMENT=2378 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (2128,'admin@mydomain.com','.vvtkbVdvBe3.','LaunchLeader','Admin',NULL,'admin@mydomain.com',NULL,NULL,NULL,NULL,'2016-03-01 01:24:39',NULL,1,80003,'launchleader'),(2129,'testuser','.vvtkbVdvBe3.','Jayden','Mann','Vancouver, WA, USA','test@mydomain.com','Youth Localized Venture Umbrella ',NULL,1,'2014-12-09 02:30:06','2014-12-09 02:30:06',1,1,79999,'launchleader');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_detail`
--

DROP TABLE IF EXISTS `account_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_detail` (
  `account_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `detail_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `account_detail_name` varchar(255) DEFAULT NULL,
  `account_detail_desc` text,
  `account_detail_note` text,
  `account_detail_type` int(11) DEFAULT NULL,
  `account_detail_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`account_detail_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6177 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_detail`
--

LOCK TABLES `account_detail` WRITE;
/*!40000 ALTER TABLE `account_detail` DISABLE KEYS */;
INSERT INTO `account_detail` VALUES (2479,13,2129,'Focus','Data/Analytics','',1,1),(2480,12,2129,'Specialty','Developer','',1,1),(2481,27,2129,'Summary','Umbrella for Young Volunteers','',1,1),(2482,24,2129,'Seeking',',Developer,Designer,Marketer,Product Manager,Scientist','',1,1),(2483,25,2129,'Profile Photo','Umbrella02.jpg','',1,1),(2484,46,2129,'Facebook Page','Facebook Page','',1,1),(2485,47,2129,'Twitter Page','Twitter Page','',1,1),(2486,28,2129,'Idea','yes','',1,1),(2487,14,2129,'Industry','Construction','',1,1),(2488,34,2129,'Industry','Education','',1,1),(2489,35,2129,'Industry','Energy','',1,1),(2490,17,2129,'Select Skill/Area of Expertise','Advertising','',1,1),(2491,22,2129,'Select Skill/Area of Expertise','Algorithm Design','',1,1),(2492,23,2129,'Select Skill/Area of Expertise','Analytics','',1,1),(2493,16,2129,'College','SUST','',1,1),(2494,43,2129,'Experience','BrainCabin','',1,1),(2495,36,2129,'Idea-Summary','Umbrella for Young Volunteer','',1,1),(2496,41,2129,'Idea-Photo','Umbrella02.jpg','',1,1),(2497,26,2129,'Idea-Video','','',1,1),(2498,42,2129,'Idea-Description','Umbrella for Young Volunteers','',1,1),(2734,48,2129,'Education','','',1,1),(2735,49,2129,'Experience','','',1,1),(2736,50,2129,'Experience','','',1,1);
/*!40000 ALTER TABLE `account_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_detail_status`
--

DROP TABLE IF EXISTS `account_detail_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_detail_status` (
  `account_detail_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_detail_status_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`account_detail_status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_detail_status`
--

LOCK TABLES `account_detail_status` WRITE;
/*!40000 ALTER TABLE `account_detail_status` DISABLE KEYS */;
INSERT INTO `account_detail_status` VALUES (1,'Active'),(2,'Disabled - Permanent'),(3,'Disabled - Temporary');
/*!40000 ALTER TABLE `account_detail_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_detail_type`
--

DROP TABLE IF EXISTS `account_detail_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_detail_type` (
  `account_detail_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_detail_type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`account_detail_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_detail_type`
--

LOCK TABLES `account_detail_type` WRITE;
/*!40000 ALTER TABLE `account_detail_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_detail_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_element`
--

DROP TABLE IF EXISTS `account_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_element` (
  `account_element_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `element_id` int(11) DEFAULT NULL,
  `account_element_name` varchar(255) DEFAULT NULL,
  `account_element_desc` text,
  `account_element_note` text,
  `account_element_date` datetime DEFAULT NULL,
  `account_element_type` int(11) DEFAULT NULL,
  `account_element_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`account_element_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_element`
--

LOCK TABLES `account_element` WRITE;
/*!40000 ALTER TABLE `account_element` DISABLE KEYS */;
INSERT INTO `account_element` VALUES (1,3,1,'Logo','Here is the new awesome logo, really embodies the idea','','2014-10-15 11:52:44',1,1);
/*!40000 ALTER TABLE `account_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_funder`
--

DROP TABLE IF EXISTS `account_funder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_funder` (
  `account_funder_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_funder_name` varchar(255) DEFAULT NULL,
  `account_funder_avatar` varchar(200) DEFAULT NULL,
  `account_funder_social_id` varchar(200) DEFAULT NULL,
  `account_funder_username` varchar(200) DEFAULT NULL,
  `account_funder_password` varchar(100) NOT NULL,
  `account_funder_email` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`account_funder_id`)
) ENGINE=MyISAM AUTO_INCREMENT=104 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_funder`
--

LOCK TABLES `account_funder` WRITE;
/*!40000 ALTER TABLE `account_funder` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_funder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_partner`
--

DROP TABLE IF EXISTS `account_partner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_partner` (
  `account_partner_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_partner_name` varchar(200) NOT NULL,
  `account_partner_crumb` varchar(100) NOT NULL,
  `account_partner_details` text NOT NULL,
  `account_partner_thumbnail` varchar(255) NOT NULL,
  `account_partner_status` int(11) NOT NULL,
  PRIMARY KEY (`account_partner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_partner`
--

LOCK TABLES `account_partner` WRITE;
/*!40000 ALTER TABLE `account_partner` DISABLE KEYS */;
INSERT INTO `account_partner` VALUES (1,'UNM Los Alamos','unmla','The University of New Mexico, Los Alamos ','images/los-alamos-logo.png',1),(2,'ReVTech Accelerator','revtech','ReVTech accelerator','images/ReVTech_logo.png',1);
/*!40000 ALTER TABLE `account_partner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_status`
--

DROP TABLE IF EXISTS `account_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_status` (
  `account_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_status_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`account_status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_status`
--

LOCK TABLES `account_status` WRITE;
/*!40000 ALTER TABLE `account_status` DISABLE KEYS */;
INSERT INTO `account_status` VALUES (1,'Active'),(2,'Disabled');
/*!40000 ALTER TABLE `account_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_type`
--

DROP TABLE IF EXISTS `account_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_type` (
  `account_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`account_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_type`
--

LOCK TABLES `account_type` WRITE;
/*!40000 ALTER TABLE `account_type` DISABLE KEYS */;
INSERT INTO `account_type` VALUES (1,'User'),(2,'Staff'),(3,'Partner'),(4,'Mentor');
/*!40000 ALTER TABLE `account_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_verification`
--

DROP TABLE IF EXISTS `account_verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_verification` (
  `account_verification_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_verification_username` varchar(255) DEFAULT NULL,
  `account_verification_token` varchar(100) DEFAULT NULL,
  `account_verification_taken` int(11) DEFAULT NULL,
  `account_verification_expire` datetime DEFAULT NULL,
  PRIMARY KEY (`account_verification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_verification`
--

LOCK TABLES `account_verification` WRITE;
/*!40000 ALTER TABLE `account_verification` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_verification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer` (
  `answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `answer_name` varchar(255) DEFAULT NULL,
  `answer_wiki` varchar(255) DEFAULT NULL,
  `answer_img` varchar(255) DEFAULT NULL,
  `answer_url` varchar(255) DEFAULT NULL,
  `answer_desc` text,
  `answer_note` text,
  `answer_added` datetime DEFAULT NULL,
  `answer_ended` datetime DEFAULT NULL,
  `answer_type` int(11) DEFAULT NULL,
  `answer_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`answer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2652 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (7,0,0,'Strongly Disagree',NULL,'/images/false.png',NULL,'Strongly Disagree','','2013-08-20 00:10:43',NULL,5,1),(8,0,0,'Strongly Agree',NULL,'/images/true.png',NULL,'Strongly Agree','','2013-08-20 00:10:43',NULL,5,1),(9,0,0,'True',NULL,'/images/true.png',NULL,'True','','2013-08-20 00:10:43',NULL,8,1),(10,0,0,'False',NULL,'/images/false.png',NULL,'False','','2013-08-20 00:10:43',NULL,8,1),(11,1,0,'Focus',NULL,'/images/internet.png',NULL,'Internet','','2013-08-20 00:10:43',NULL,2,1),(12,1,0,'Focus',NULL,'/images/mobile.png',NULL,'Mobile','','2013-08-20 00:10:43',NULL,2,1),(13,1,0,'Focus',NULL,'/images/software.png',NULL,'Software','','2013-08-20 00:10:43',NULL,2,1),(14,1,0,'Focus',NULL,'/images/ecommerce.jpg',NULL,'eCommerce','','2013-08-20 00:10:43',NULL,2,1),(15,1,0,'Focus',NULL,'/images/saas.png',NULL,'SaaS','','2013-08-20 00:10:43',NULL,2,1),(16,1,0,'Focus',NULL,'/images/devices.jpg',NULL,'Physical Devices','','2013-08-20 00:10:43',NULL,2,1),(17,1,0,'Focus',NULL,'/images/hardware.jpg',NULL,'Hardware','','2013-08-20 00:10:43',NULL,2,1),(18,1,0,'Focus',NULL,'/images/cloud.jpg',NULL,'Cloud','','2013-08-20 00:10:43',NULL,2,1),(19,1,0,'Focus',NULL,'/images/science.png',NULL,'Technology','','2013-08-20 00:10:43',NULL,2,1),(20,1,0,'Focus',NULL,'/images/data.png',NULL,'Data/Analytics','','2013-08-20 00:10:43',NULL,2,1),(21,1,0,'Focus',NULL,'/images/social.jpg',NULL,'Social Media','','2013-08-20 00:10:43',NULL,2,1),(22,1,0,'Focus',NULL,'/images/product.gif',NULL,'Consumer Products','','2013-08-20 00:10:43',NULL,2,1),(23,1,0,'Focus',NULL,'/images/other.jpg',NULL,'Other','','2013-08-20 00:10:43',NULL,2,1),(24,1,0,'Focus',NULL,'/images/undecided.png',NULL,'Undecided','','2013-08-20 00:10:43',NULL,2,1),(25,2,0,'Industry',NULL,'images/it.jpg',NULL,'Information Technology','','2013-08-20 00:10:43',NULL,2,1),(26,2,0,'Industry',NULL,'/images/lifescience.jpg',NULL,'Life Sciences','','2013-08-20 00:10:43',NULL,2,1),(27,2,0,'Industry',NULL,'/images/cleantech.jpg',NULL,'Cleantech','','2013-08-20 00:10:43',NULL,2,1),(28,2,0,'Industry',NULL,'/images/health.gif',NULL,'Healthcare','','2013-08-20 00:10:43',NULL,2,1),(29,2,0,'Industry',NULL,'/images/energy.png',NULL,'Energy','','2013-08-20 00:10:43',NULL,2,1),(30,2,0,'Industry',NULL,'/images/gaming.png',NULL,'Gaming','','2013-08-20 00:10:43',NULL,2,1),(31,2,0,'Industry',NULL,'/images/media.png',NULL,'Media','','2013-08-20 00:10:43',NULL,2,1),(32,2,0,'Industry',NULL,'/images/sustainability.jpg',NULL,'Sustainability','','2013-08-20 00:10:43',NULL,2,1),(33,2,0,'Industry',NULL,'/images/transportation.jpg',NULL,'Transportation & Logistics','','2013-08-20 00:10:43',NULL,2,1),(34,2,0,'Industry',NULL,'/images/retail.png',NULL,'Retail','','2013-08-20 00:10:43',NULL,2,1),(35,2,0,'Industry',NULL,'/images/education.jpg',NULL,'Education','','2013-08-20 00:10:43',NULL,2,1),(36,2,0,'Industry',NULL,'/images/food.jpg',NULL,'Food & Beverage','','2013-08-20 00:10:43',NULL,2,1),(37,2,0,'Industry',NULL,'/images/financial.png',NULL,'Financial Services','','2013-08-20 00:10:43',NULL,2,1),(38,2,0,'Industry',NULL,'/images/socialent.png',NULL,'Nonprofit','','2013-08-20 00:10:43',NULL,2,1),(39,2,0,'Industry',NULL,'/images/realestate.png',NULL,'Real Estate','','2013-08-20 00:10:43',NULL,2,1),(40,2,0,'Industry',NULL,'/images/sports.png',NULL,'Sports & Entertainment','','2013-08-20 00:10:43',NULL,2,1),(41,2,0,'Industry',NULL,'/images/telecommunications.jpg',NULL,'Telecommunications','','2013-08-20 00:10:43',NULL,2,1),(42,2,0,'Industry',NULL,'/images/travel.png',NULL,'Travel & Tourism','','2013-08-20 00:10:43',NULL,2,1),(43,2,0,'Industry',NULL,'/images/biotech.jpg',NULL,'Biotech','','2013-08-20 00:10:43',NULL,2,1),(44,2,0,'Industry',NULL,'/images/other.jpg',NULL,'Other','','2013-08-20 00:10:43',NULL,2,1),(45,2,0,'Industry',NULL,'/images/undecided.png',NULL,'Undecided','','2013-08-20 00:10:43',NULL,2,1),(46,3,0,'Profiles',NULL,'http://upload.wikimedia.org/wikipedia/commons/0/01/LinkedIn_Logo.svg',NULL,'LinkedIn','','2013-08-20 00:10:43',NULL,2,1),(47,3,0,'Profiles',NULL,'https://angel.co/images/shared/al_logo.png',NULL,'AngelList','','2013-08-20 00:10:43',NULL,2,1),(48,3,0,'Profiles',NULL,'http://upload.wikimedia.org/wikipedia/en/8/84/GUST-logo.png',NULL,'Gust','','2013-08-20 00:10:43',NULL,2,1),(49,3,0,'Profiles',NULL,'',NULL,'None',NULL,'2013-08-20 00:10:43',NULL,2,1),(50,4,0,'Gender',NULL,'/images/female.png',NULL,'Female','','2013-08-20 00:10:43',NULL,2,1),(51,4,0,'Gender',NULL,'/images/male.png',NULL,'Male','','2013-08-20 00:10:43',NULL,2,1),(52,5,0,'Age',NULL,NULL,NULL,'13 - 17 years old','','2013-08-20 00:10:43',NULL,2,1),(53,5,0,'Age',NULL,NULL,NULL,'18 - 24 years old','','2013-08-20 00:10:43',NULL,2,1),(54,5,0,'Age',NULL,NULL,NULL,'25 - 34 years old','','2013-08-20 00:10:43',NULL,2,1),(55,5,0,'Age',NULL,NULL,NULL,'35 - 44 years old','','2013-08-20 00:10:43',NULL,2,1),(56,5,0,'Age',NULL,NULL,NULL,'45 - 54 years old','','2013-08-20 00:10:43',NULL,2,1),(57,5,0,'Age',NULL,NULL,NULL,'55 or older','','2013-08-20 00:10:43',NULL,2,1),(58,6,0,'Education',NULL,NULL,NULL,'HS or less','','2013-08-20 00:10:43',NULL,2,1),(59,6,0,'Education',NULL,NULL,NULL,'Some college','','2013-08-20 00:10:43',NULL,2,1),(60,6,0,'Education',NULL,NULL,NULL,'Associate degree','','2013-08-20 00:10:43',NULL,2,1),(61,6,0,'Education',NULL,NULL,NULL,'Bachelor degree','','2013-08-20 00:10:43',NULL,2,1),(62,6,0,'Education',NULL,NULL,NULL,'Advanced degree','','2013-08-20 00:10:43',NULL,2,1),(63,7,0,'Motivation',NULL,'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Mcol_money_bag.svg/102px-Mcol_money_bag.svg.png',NULL,'Get rich','','2013-08-20 00:10:43',NULL,2,1),(64,7,0,'Motivation',NULL,'http://upload.wikimedia.org/wikipedia/en/2/25/EricClaptonChangeTheWorldCDSingleCover.jpg',NULL,'Change the world','','2013-08-20 00:10:43',NULL,2,1),(65,7,0,'Motivation',NULL,'http://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Us_declaration_independence.jpg/202px-Us_declaration_independence.jpg',NULL,'Independence','','2013-08-20 00:10:43',NULL,2,1),(66,7,0,'Motivation',NULL,'/images/soup.jpg',NULL,'I can\'t find a job','','2013-08-20 00:10:43',NULL,2,1),(67,7,0,'Motivation',NULL,'http://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Plato-raphael.jpg/100px-Plato-raphael.jpg',NULL,'I have a great idea','','2013-08-20 00:10:43',NULL,2,1),(68,9,0,'Entrepreneurship',NULL,NULL,NULL,'No','','2013-08-20 00:10:43',NULL,2,1),(69,9,0,'Entrepreneurship',NULL,NULL,NULL,'Yes','','2013-08-20 00:10:43',NULL,2,1),(213,113,0,'Idea','','','','Blue ocean strategy','Wrong!','2013-08-30 12:25:07','2013-08-30 12:25:07',2,1),(214,113,0,'Idea','','','http://youtu.be/7o8uYdUaFR4','Lean Canvas','Right!  The Lean Canvas was created by Ash Maurya to helps startups find a scalable and repeatable business model.','2013-08-30 12:30:10','2013-08-30 12:30:10',2,1),(215,113,0,'Idea','','','','PESTLE analysis','Wrong!','2013-08-30 12:23:47','2013-08-30 12:23:47',2,1),(216,113,0,'Idea','','','','Term sheet','Wrong!','2013-08-30 12:23:26','2013-08-30 12:23:26',2,1),(217,113,0,'Idea','','','','SWOT Analysis','Wrong!','2013-08-30 12:27:59','2013-08-30 12:27:59',2,1),(218,114,0,'Idea','http://cdixon.org/2013/08/04/the-idea-maze/','','','Idea Maze','Right!  The Idea Maze was developed by Balaji Srinivasan to explain how good startup ideas evolve over time.','2013-08-30 12:21:39','2013-08-30 12:21:39',1,1),(235,115,0,'Idea','','','http://youtu.be/E4ex0fejo8w','True','Right! The MVP is the first fully functioning version of your product.','2013-08-30 12:55:45','2013-08-30 12:55:45',1,1),(243,115,0,'Idea','','','','False','Wrong!','2013-08-30 13:02:19','2013-08-30 13:02:19',1,1),(244,116,0,'Legal','','','','NDA','Wrong!','2013-08-30 13:18:33','2013-08-30 13:18:33',2,1),(245,116,0,'Legal','','','','IRR','Wrong!','2013-08-30 13:18:55','2013-08-30 13:18:55',2,1),(246,116,0,'Legal','','','','TAM','Wrong!','2013-08-30 13:19:25','2013-08-30 13:19:25',2,1),(247,116,0,'Legal','http://www.kaplaw.com/CM/Custom/Can-a-Letter-of-Intent-be-Legally-Binding.asp','','','LOI','Right!  A letter of intent, sometimes called a Memorandum of Understanding (MOU), is typically a non-legally binding informal agreement.','2013-08-30 13:20:29','2013-08-30 13:20:29',2,1),(248,116,0,'','','','','KPI','Wrong!','2013-08-30 13:20:56','2013-08-30 13:20:56',2,1),(256,117,0,'Legal','','','','Narrow-based Weighted Avg.','Wrong!','2013-08-30 14:09:56','2013-08-30 14:09:56',2,1),(257,117,0,'Legal','','','','Ratchet','Wrong!','2013-08-30 14:12:10','2013-08-30 14:12:10',2,1),(258,117,0,'Legal','','','','Broad-based Weighted Avg.','Wrong!','2013-08-30 14:12:40','2013-08-30 14:12:40',2,1),(259,117,0,'Legal','','','http://youtu.be/M7nBQ-vtsGI','Cliff','Right! Broad-based weighted average is by far the most common form of anti-dilution and also the most favorable to the startup. The least favorable to startups is the ratchet. ','2013-08-30 14:13:45','2013-08-30 14:13:45',2,1),(277,118,0,'Legal','http://venturehacks.com/articles/cap-table','','','Capitalization table, Cap table','Right! The capitalization table, or cap table for short, details the owners of the company and their shares.','2013-09-01 19:31:22','2013-09-01 19:31:22',1,1),(2491,144,0,'Stage',NULL,NULL,NULL,'   Seed (>$0 <$500,000 Revenue)','','2014-04-03 04:36:06',NULL,2,1),(2490,144,0,'Stage',NULL,NULL,NULL,'    Concept ($0 Revenue)','','2014-04-03 04:36:06',NULL,2,1),(352,119,0,'Finance','','','http://youtu.be/f4KagovcMdg','$10,000,000; 10000000','Right!  To calculate the post-money valuation you add the pre-money valuation ($6,000,000) to the total equity investment ($4,000,000) for the Series A round.','2013-09-02 11:54:13','2013-09-02 11:54:13',1,1),(364,120,0,'Finance','','','http://youtu.be/f4KagovcMdg','40%','Right! Each Series A investor owns 20% of the company (2,080,000 shares / 10,400,000 shares), so combined the investors own 40% of the company.','2013-09-02 13:27:39','2013-09-02 13:27:39',1,1),(367,121,0,'Finance','','','http://youtu.be/f4KagovcMdg','15%','Right!  The percentage of the post-money option pool is calculated by dividing the number of post-money option shares (1,560,000) by the total number of shares (10,400,000) ','2013-09-02 13:30:18','2013-09-02 13:30:18',1,1),(373,122,0,'','','','http://youtu.be/f4KagovcMdg','38%','Right!  Since there are 4,600,000 total shares of founder stock and pre-money options, and 600,000 of those shares are in the pre-money option pool, the founders own 4,000,000 divided by the total number of shares (10,400,000).','2013-09-02 13:42:43','2013-09-02 13:42:43',1,1),(377,123,0,'Finance','','','http://youtu.be/f4KagovcMdg','$4,076,923; $4076923 ','Right! Given that the share price is $0.96 and the debt investors own 80,000 shares and the equity investors own 4,160,000 shares, the total share value for investors is 4,240,000 multiplied by $0.96.','2013-09-02 13:46:42','2013-09-02 13:46:42',1,1),(379,124,0,'Finance','','','http://youtu.be/f4KagovcMdg','$19,230,769; $19230769 ','Right! Since the company\'s value increased from $10,000,000 to $50,000,000, the founders\' share value would increase by 5x the current value of $3,846,154. ','2013-09-02 13:49:46','2013-09-02 13:49:46',1,1),(1718,141,0,'Skills',NULL,NULL,NULL,'Career Advice','','2014-01-28 13:53:32',NULL,2,1),(381,125,0,'Finance','http://pandodaily.com/2012/11/28/the-series-a-crunch-is-hitting-now-have-we-even-noticed/','','','Series A Crunch; Series-A Crunch; SeriesA Crunch','Right! Series A Crunch; Series-A Crunch; SeriesA Crunch | The \'Series A Crunch\' refers to entrepreneurs who raised their first round of seed financing having difficulty raising their Series A round due to a glut of startups in the marketplace.','2013-09-02 13:56:58','2013-09-02 13:56:58',1,1),(384,126,0,'Finance','http://www.axial.net/blog/pledge-funds-tire-kickers-or-serious-buyers/','','','pledge','Right! A pledge fund (or \'non-committed fund\' or \'fundless sponsor\') can be contrasted with a committed fund, where the investor is obligated to contribute money.','2013-09-02 14:01:38','2013-09-02 14:01:38',1,1),(387,127,0,'Finance','http://www.bothsidesofthetable.com/2010/07/22/want-to-know-how-vcs-calculate-valuation-differently-from-founders/','','','25%','Right! 25%. The investor owns $1M invested divided by $4M post-money valuation.','2013-09-02 14:05:03','2013-09-02 14:05:03',2,1),(388,127,0,'Finance','','','','33%','Wrong!','2013-09-02 14:05:44','2013-09-02 14:05:44',2,1),(389,127,0,'Finance','','','','66%','Wrong!','2013-09-02 14:06:19','2013-09-02 14:06:19',2,1),(390,127,0,'Finance','','','','75%','Wrong!','2013-09-02 14:06:42','2013-09-02 14:06:42',2,1),(391,127,0,'','','','','100%','Wrong!','2013-09-02 14:07:15','2013-09-02 14:07:15',2,1),(403,128,0,'Marketing','http://www.business2community.com/social-media/10-social-media-facts-figures-statistics-need-know-0598297','','','Facebook, YouTube, Twitter, LinkedIn, Foursquare','Right! Facebook has over 1 billion active users while Foursquare has 30 million.','2013-09-03 05:48:43','2013-09-03 05:48:43',1,1),(409,129,0,'Marketing','','','','Operational excellence','Wrong!','2013-09-03 05:52:10','2013-09-03 05:52:10',2,1),(410,129,0,'Marketing','http://www.leadershipalliance.com/discmktlead.htm','','','Brand equity','Right!  Value discipline refers to the unique value that your company can consistently deliver to a selected market, such as having the best and most innovative products.','2013-09-03 08:35:34','2013-09-03 08:35:34',2,1),(411,129,0,'Marketing','','','','Product leadership','Wrong!','2013-09-03 08:36:05','2013-09-03 08:36:05',2,1),(412,129,0,'Marketing','','','','Customer intimacy','Wrong!','2013-09-03 08:36:47','2013-09-03 08:36:47',2,1),(419,130,0,'Marketing','http://www.slideshare.net/sjhus/brand-personality-presentation','','','Brand personality','Right! The brand personality describes how a brand behaves, such as intelligent, rugged or sincere','2013-09-03 08:48:40','2013-09-03 08:48:40',1,1),(423,131,0,'Human Resources','http://www.attorneys.com/discrimination/what-are-protected-classes/','','','Protected classes','Right!  Protected classes include race, religion, age, sex and pregnancy.','2013-09-03 09:14:46','2013-09-03 09:14:46',1,1),(427,132,0,'Human Resources','http://www.brighthub.com/office/human-resources/articles/112907.aspx','','','Organizational chart; org chart','Right!  Companies of all sizes should have an organizational chart, which will generally be either hierarchical, matrix or flat type.','2013-09-03 09:18:39','2013-09-03 09:18:39',1,1),(430,133,0,'Human Resources','','','','Peers','','2013-09-03 09:21:18','2013-09-03 09:21:18',2,1),(431,133,0,'Human Resources','','','','Self','','2013-09-03 09:21:38','2013-09-03 09:21:38',2,1),(432,133,0,'Human Resources','','','','Supervisor','','2013-09-03 09:22:02','2013-09-03 09:22:02',2,1),(433,133,0,'Human Resources','','','','Subordinate','','2013-09-03 09:22:26','2013-09-03 09:22:26',2,1),(434,133,0,'Human Resources','','','http://youtu.be/OXJkP13xACg','All of the above','Right! All of the above. The survey may also include external stakeholders such as suppliers and customers.','2013-09-03 09:23:26','2013-09-03 09:23:26',2,1),(440,134,0,'Management','','','http://youtu.be/NCta6j5_FdM','KPIs','Right!  KPIs (Key Performance Indicators) vary by company but they should always be measurable.','2013-09-03 09:31:55','2013-09-03 09:31:55',1,1),(442,135,0,'Management','','','http://youtu.be/-JBYC6WpIaY','False','Right!  A mission statement explains a company\'s purpose. It may be substituted by a company mantra.','2013-09-03 09:36:23','2013-09-03 09:36:23',8,1),(445,136,0,'Management','','','http://youtu.be/e5bYfMo5fy8','Advisory board; advisors','Right!  Advisors are often granted 0.1% - 1% equity but they should be managed and held accountable for their contributions.','2013-09-03 09:38:06','2013-09-03 09:38:06',1,1),(448,137,0,'IT','http://office.microsoft.com/en-us/excel-help/excel-shortcut-and-function-keys-HP001111659.aspx','','','F12','Right!  The F12 key displays the Save As dialog box. Other Function key shortcuts include Spell Check and Paste.','2013-09-03 09:41:57','2013-09-03 09:41:57',1,1),(451,138,0,'IT','','','','1 GB','Wrong!','2013-09-03 09:47:54','2013-09-03 09:47:54',2,1),(452,138,0,'IT','','','','5 GB','Wrong!','2013-09-03 09:47:33','2013-09-03 09:47:33',2,1),(453,138,0,'IT','','','','10 GB','Wrong!','2013-09-03 09:47:15','2013-09-03 09:47:15',2,1),(454,138,0,'IT','https://support.google.com/drive/answer/2424384?hl=en','','','15 GB','Right!  Google Drive lets you create, store, access and share files from anywhere. After you reach the 15 GB storage limit you can purchase additional capacity.  ','2013-09-18 18:57:59','2013-09-18 18:57:59',2,1),(455,138,0,'IT','','','','20 GB','Wrong!','2013-09-03 09:46:47','2013-09-03 09:46:47',2,1),(460,139,0,'IT','http://searchnetworking.techtarget.com/definition/ping','','','PING','Right!  PING (Packet INternet Groper) in an Internet program used to test connectivity and response time - typically measured in milliseconds. ','2013-09-03 09:50:46','2013-09-03 09:50:46',1,1),(2305,301,0,'Sales Presentation','','','','Benefits','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2304,301,0,'Sales Presentation','','','','Complexity','Right! Sales presentations should be made with simple language focusing on how you help solve a problem.','2014-02-13 11:07:02',NULL,2,1),(2303,301,0,'Sales Presentation','','','','Empathy','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2302,301,0,'Sales Presentation','','','','Value Proposition','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2434,310,0,'Public Speaking','','','','FALSE','Right! If you make a small mistake, the audience is unlikely to notice so keep going and get back on track.','2014-03-04 11:35:34',NULL,8,1),(2300,300,0,'Storytelling','','','','Legends','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2299,300,0,'Storytelling','','','','Fun','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2298,300,0,'Storytelling','','','','Failure','Right! Failure stories have the unique capacity to communicate humility, learning and tenacity.','2014-02-13 11:07:02',NULL,2,1),(2297,300,0,'Storytelling','','','','Success','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2295,299,0,'Closing','','','','All of the Above','Right! Objections are common in sales conversations but can be overcome by listening, questioning and reassuring.','2014-02-13 11:07:02',NULL,2,1),(2294,299,0,'Closing','','','','Flattery','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2293,299,0,'Closing','','','','Reassurance','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2292,299,0,'Closing','','','','Questions','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2290,298,0,'Sales Conversation','','','','False','Right! A purpose benefit check drives alignment for the agenda.','2014-02-13 11:07:02',NULL,8,1),(2288,297,0,'Sales Model','','','','Qualifying','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2287,297,0,'Sales Model','','','','Pitching','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2286,297,0,'Sales Model','','','','Targeting','Right! Targeting is a pre-requisite for the sales process to ensure you focus on the right prospects.','2014-02-13 11:07:02',NULL,2,1),(2285,297,0,'Sales Model','','','','Analysis','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2283,296,0,'Distribution','','','','False','Right! Selling on your website is direct distribution, selling on a third-party website is indirect distribution.','2014-02-13 11:07:02',NULL,8,1),(2436,311,0,'Product Launch','','','','FALSE','Right! Refine your messaging through earned media before paying for media exposure.','2014-03-04 11:35:34',NULL,8,1),(2281,295,0,'Pricing','','','','Yield Management','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2280,295,0,'Pricing','','','','Volume','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2279,295,0,'Pricing','','','','Cost Plus','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2278,295,0,'Pricing','','','','Voice of the Customer','Right! Pricing strategies can be either fixed, such as cost plus, or dynamic, such as yield management.','2014-02-13 11:07:02',NULL,2,1),(2276,294,0,'Wireframes','','','','High-Fidelity','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2275,294,0,'Wireframes','','','','Low-Fidelity','Right! A low-fidelity wireframe leads to a high-fidelity wifreframe, which includes more detail to better resemble the final website.','2014-02-13 11:07:02',NULL,2,1),(2274,294,0,'Wireframes','','','','High-End','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2273,294,0,'Wireframes','','','','Low-End','Wrong!','2014-02-13 11:07:02',NULL,2,1),(2271,293,0,'Product Design Sprint','','','','Understand','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2270,293,0,'Product Design Sprint','','','','Prototype','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2269,293,0,'Product Design Sprint','','','','Validate','Right! After creating a prototype, it\'s crucial to validate by getting user feedback about what works and what should be improved.','2014-02-13 11:07:01',NULL,2,1),(2268,293,0,'Product Design Sprint','','','','Diverge','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2266,292,0,'Design Thinking','','','','Observation','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2265,292,0,'Design Thinking','','','','Idea','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2264,292,0,'Design Thinking','','','','Selling','Right! The design thinking process is about learning the skill of observation and insight through empathy.','2014-02-13 11:07:01',NULL,2,1),(2263,292,0,'Design Thinking','','','','Rapid Prototyping','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2261,291,0,'Mission Statement','','','','Short Length','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2260,291,0,'Mission Statement','','','','Uses Buzzwords','Right! Buzzwords detract from the authenticity and meaning of your mission statement.','2014-02-13 11:07:01',NULL,2,1),(2259,291,0,'Mission Statement','','','','Explains Purpose','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2258,291,0,'Mission Statement','','','','Simple Language','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2256,290,0,'Logo','','','','All of the Above','Right! The color, shape, font and icon of your logo all send messages about your brand\'s personality.','2014-02-13 11:07:01',NULL,2,1),(2255,290,0,'Logo','','','','Font','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2254,290,0,'Logo','','','','Color Palette','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2253,290,0,'Logo','','','','Shape','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2251,289,0,'Market Research','','','','All of the Above','Right! Thorough market research includes a combination of industry analysis and speaking directly to prospective customers.','2014-02-13 11:07:01',NULL,2,1),(2250,289,0,'Market Research','','','','Competitive Analysis','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2249,289,0,'Market Research','','','','Research Reports','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2248,289,0,'Market Research','','','','Customer Surveys','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2246,288,0,'Customer Persona','','','','False','Right! Customer personas require greater individual detail, such as facts and behaviors, than your general target market.','2014-02-13 11:07:01',NULL,8,1),(2244,287,0,'Cost of Customer Acquisition (COCA)','','','','False','Right! COCA measures the expenses incurred for each conversion to a paying customer.','2014-02-13 11:07:01',NULL,8,1),(2438,312,0,'Prior Art','','','','FALSE','Right! Prior art is any publicly available information relevant to a specific patent.','2014-03-04 11:35:34',NULL,8,1),(2242,286,0,'Total Addressable Market (TAM)','','','','Potential Profit','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2241,286,0,'Total Addressable Market (TAM)','','','','Potential Revenue','Right! TAM must always be quantifiable and potential revenue is the most common measurement.','2014-02-13 11:07:01',NULL,2,1),(2240,286,0,'Total Addressable Market (TAM)','','','','Potential Units','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2239,286,0,'Total Addressable Market (TAM)','','','','Potential Customers','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2237,285,0,'Branding','','','','Name','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2236,285,0,'Branding','','','','Promise','Right! A brand is a company\'s promise that creates its reputation.','2014-02-13 11:07:01',NULL,2,1),(2235,285,0,'Branding','','','','Website','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2234,285,0,'Branding','','','','Logo','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2232,284,0,'Public Relations (PR)','','','','False','Right! Journalists require a hook, such as exclusive information or a unique point of view, in order to cover a story.','2014-02-13 11:07:01',NULL,8,1),(2440,313,0,'Fair Use','','','','TRUE','Right! In addition to purpose, the other fair use factors are nature of copyrighted work, amount used and effect on the original content. ','2014-03-04 11:35:34',NULL,8,1),(2230,283,0,'Competitive Analysis','','','','False','Right! Every startup has competition, either direct or indirect.','2014-02-13 11:07:01',NULL,8,1),(2228,282,0,'Customer Lifetime Value (LTV)','','','','$1,100','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2227,282,0,'Customer Lifetime Value (LTV)','','','','$1,000','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2226,282,0,'Customer Lifetime Value (LTV)','','','','$900','Right! Knowing LTV allows you to optimize marketing expenses.','2014-02-13 11:07:01',NULL,2,1),(2225,282,0,'Customer Lifetime Value (LTV)','','','','$100','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2223,281,0,'Personal Brand','','','','Online Identity','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2222,281,0,'Personal Brand','','','','Authority','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2221,281,0,'Personal Brand','','','','Fame','Right! Regardless of your position, you can take control of your personal brand by actively managing it.','2014-02-13 11:07:01',NULL,2,1),(2220,281,0,'Personal Brand','','','','Personal Style','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2218,280,0,'Partnerships','','','','Capital Efficiency','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2217,280,0,'Partnerships','','','','IP Infringement','Right! Partnerships offer many benefits but IP infringement is one of the risks that must be mitigated through agreements.','2014-02-13 11:07:01',NULL,2,1),(2216,280,0,'Partnerships','','','','Speed to Market','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2215,280,0,'Partnerships','','','','Access to New Markets','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2213,279,0,'Project Management','','','','All of the Above','Right! Project management is simply an organized way of getting things done.','2014-02-13 11:07:01',NULL,2,1),(2212,279,0,'Project Management','','','','Time','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2211,279,0,'Project Management','','','','Precedence','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2210,279,0,'Project Management','','','','Risks','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2208,278,0,'Strategic Planning','','','','Vision','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2207,278,0,'Strategic Planning','','','','ROI','Right! A strategic plan helps you understand what you want your business to be and how you will get there.','2014-02-13 11:07:01',NULL,2,1),(2206,278,0,'Strategic Planning','','','','Mission','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2205,278,0,'Strategic Planning','','','','SWOT','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2203,277,0,'Exit Strategy','','','','Private Placement','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2202,277,0,'Exit Strategy','','','','Bankruptcy','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2201,277,0,'Exit Strategy','','','','Initial Public Offering (IPO)','Right! IPOs are highly regulated and only accessible to startups that grow into very large companies.','2014-02-13 11:07:01',NULL,2,1),(2200,277,0,'Exit Strategy','','','','Acquisition','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2198,276,0,'Negotiation','','','','True','Right! Knowing your alternative options allows you to avoid taking a bad deal.','2014-02-13 11:07:01',NULL,8,1),(2442,314,0,'Due Diligence','','','','TRUE','Right! Due diligence may also refer to other voluntary investigations such as investments and legal vetting.','2014-03-04 11:35:34',NULL,8,1),(2196,275,0,'Board Meetings','','','','False','Right! Board members should receive a monthly/quarterly status report so everyone is prepared to discuss important issues during the board meeting.','2014-02-13 11:07:01',NULL,8,1),(2194,274,0,'Meetings','','','','False','Right! Short meetings force people to be more efficient.','2014-02-13 11:07:01',NULL,8,1),(2192,273,0,'Board of Directors','','','','12 to 15','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2191,273,0,'Board of Directors','','','','7 to 10','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2190,273,0,'Board of Directors','','','','3 to 5','Right! A young company should have a board that is small but includes at least one investor and one independent director.','2014-02-13 11:07:01',NULL,2,1),(2189,273,0,'Board of Directors','','','','1','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2187,272,0,'Investor Reporting','','','','False','Right! Entrepreneurs should always be transparent with investors - they are your partners.','2014-02-13 11:07:01',NULL,8,1),(2444,315,0,'Intellectual Property Overview','','','','FALSE','Right! The primary forms of IP are patents, copyrights, trademarks, trade secrets and contract rights.','2014-03-04 11:35:34',NULL,8,1),(2185,271,0,'Time Management','','','','Recognize, Analyze, Correct','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2184,271,0,'Time Management','','','','Record, Attribute, Change','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2183,271,0,'Time Management','','','','Record, Analyze, Change','Right! Poor time management is one the major sources of workplace stress.','2014-02-13 11:07:01',NULL,2,1),(2182,271,0,'Time Management','','','','Recognize, Analyze, Change','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2180,270,0,'Advisory Board','','','','False','Right! This advisory board is not as formal as the board of directors but assists the founding team with decision making, networking and gaining credibility.','2014-02-13 11:07:01',NULL,8,1),(2178,269,0,'Performance Evaluation','','','','True','Right! KPIs vary by company but they should always be measurable.','2014-02-13 11:07:01',NULL,8,1),(2446,316,0,'IP Infringement','','','','Non-Disclosure Agreement','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2176,268,0,'Pivot','','','','False','Right! A pivot is a substantial change to one ore more business model components, such as change of market segment.','2014-02-13 11:07:01',NULL,8,1),(2447,316,0,'IP Infringement','','','','Clearance Study','Right! Clearance studies are a pre-emptive investment to avoid IP disputes.','2014-03-04 11:35:34',NULL,2,1),(2174,267,0,'Operating Agreement','','','','False','Right! An operating agreement is a manual that explains how the owners of an LLC will run the business.','2014-02-13 11:07:01',NULL,8,1),(2448,316,0,'IP Infringement','','','','Feasibility Study','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2172,266,0,'By-Laws','','','','Shareholder Meetings','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2171,266,0,'By-Laws','','','','Officers','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2170,266,0,'By-Laws','','','','Directors','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2169,266,0,'By-Laws','','','','Employee Salaries','Right! By-laws cover corporate formalities.','2014-02-13 11:07:01',NULL,2,1),(2167,265,0,'Articles of Incorporation','','','','All of the Above','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2166,265,0,'Articles of Incorporation','','','','Mayor\'s Office','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2165,265,0,'Articles of Incorporation','','','','Secretary of State','Right! Each state specifies its own requirements for articles of incorporation and they typically include company name, purpose and contact information.','2014-02-13 11:07:01',NULL,2,1),(2164,265,0,'Articles of Incorporation','','','','Department of Commerce','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2162,264,0,'Corporate Structure','','','','True','Right! More than 60% of public companies are DE Corporations because the state is known for having business-friendly laws.','2014-02-13 11:07:01',NULL,8,1),(2449,316,0,'IP Infringement','','','','Term Sheet ','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2160,263,0,'Contractor Agreements','','','','False','Right! A contractor forced to work at your office may be deemed an employee and you will be responsible for paying employment taxes.','2014-02-13 11:07:01',NULL,8,1),(2451,317,0,'IP Licensing','','','','FALSE','Right! The duration of a license may vary widely from a short fixed period of time to being permanent.','2014-03-04 11:35:34',NULL,8,1),(1040,110,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-20 13:22:35','2013-09-20 13:22:35',1,1),(1041,110,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-20 13:23:07','2013-09-20 13:23:07',1,1),(2158,262,0,'Non-Disclosure Agreements','','','','True','Right! NDAs may be signed by partners, employees and investors.  However, investors should not be asked to sign an NDA until they express serious interest in the company.','2014-02-13 11:07:01',NULL,8,1),(2156,261,0,'Employee Policies','','','','All of the Above','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2155,261,0,'Employee Policies','','','','Educational History','Wrong!','2014-02-13 11:07:01',NULL,2,1),(1056,105,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-20 14:46:25','2013-09-20 14:46:25',1,1),(1057,105,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-20 14:48:43','2013-09-20 14:48:43',1,1),(2154,261,0,'Employee Policies','','','','Confidentiality Statement','Right! Other key sections include the non-compete clause and ownership provision. Remember to complete employments agreements immediately upon hiring.','2014-02-13 11:07:01',NULL,2,1),(2153,261,0,'Employee Policies','','','','Work History','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2151,260,0,'Trademarks','','','','Servicemark','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2150,260,0,'Trademarks','','','','Registration Rights','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2149,260,0,'Trademarks','','','','Intent to Use','Right! Unlike many countries, in the U.S., trademark rights only accrue when you use your mark on goods and services in the marketplace.','2014-02-13 11:07:01',NULL,2,1),(2148,260,0,'Trademarks','','','','Provisional Patent','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2488,327,0,'AIDA Model','','','','Awareness, Interest, Desire, Action','Right! AIDA is a classic model representing four stages of the sales process starting with awareness and ending with action.','2014-03-04 11:35:34',NULL,2,1),(2489,327,0,'AIDA Model','','','','Awareness, Information, Decision, Action','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2146,259,0,'Copyrights','','','','True','Right! Copyright is the right to stop others from copying, performing, selling or copying your creative work.','2014-02-13 11:07:01',NULL,8,1),(1086,99,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-20 16:58:25','2013-09-20 16:58:25',1,1),(1087,99,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-20 17:01:52','2013-09-20 17:01:52',1,1),(2453,318,0,'Networking','','','','Sales','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2144,258,0,'Trade Secrets','','','','All of the Above','Right! A trade secret can be many types of non-public assets of your company.','2014-02-13 11:07:01',NULL,2,1),(2143,258,0,'Trade Secrets','','','','Business Plan','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2142,258,0,'Trade Secrets','','','','Customer List','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2141,258,0,'Trade Secrets','','','','Production Method','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2487,327,0,'AIDA Model','','','','Attribute, Information, Decision, Action','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2139,257,0,'Patents','','','','All of the Above','Right! To be patentable an invention must be novel, non-obvious and useful.','2014-02-13 11:07:01',NULL,2,1),(2533,257,0,'Patents','','','','Is it Patentable?','Wrong!','2014-04-07 09:44:51',NULL,2,1),(2138,257,0,'Patents','','','','Is it Commercially Interesting?','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2534,257,0,'Patents','','','','Is it Technically Feasible?','Wrong!','2014-04-07 09:46:03',NULL,2,1),(2486,327,0,'AIDA Model','','','','Action, Interest, Desire, Awareness','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2134,256,0,'Customer Interviews','','','','All of the Above','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2133,256,0,'Customer Interviews','','','','Ask Obvious Questions','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2132,256,0,'Customer Interviews','','','','Extract Stories','Right! Stories are more insightful and interesting than statements.','2014-02-13 11:07:01',NULL,2,1),(2131,256,0,'Customer Interviews','','','','End with Sales Pitch','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2454,318,0,'Networking','','','','Relationships','Right! Although networking may eventually result in business outcomes, great networkers build relationships and offer help first.','2014-03-04 11:35:34',NULL,2,1),(2129,255,0,'Customer Development','','','','Creation','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2128,255,0,'Customer Development','','','','Attribution','Right! Customer development begins with the search phase to find product/market fit and transitions into the execution phase of company building.','2014-02-13 11:07:01',NULL,2,1),(2127,255,0,'Customer Development','','','','Validation','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2126,255,0,'Customer Development','','','','Discovery','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2483,326,0,'User Experience Testing','','','','9 to 20','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2484,326,0,'User Experience Testing','','','','21 to 30','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2124,254,0,'Pitch Deck','','','','Problem','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2123,254,0,'Pitch Deck','','','','Resume','Right! A resume is too much detail. Provide a few bullet point highlights about each person on one team slide.','2014-02-13 11:07:01',NULL,2,1),(2122,254,0,'Pitch Deck','','','','Solution','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2121,254,0,'Pitch Deck','','','','Team','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2482,326,0,'User Experience Testing','','','','5 to 8','Right! Most high-level usability issues can be identified with as few as 5 to 8 users.','2014-03-04 11:35:34',NULL,2,1),(2119,253,0,'Elevator Pitch','','','','True','Right! An elevator pitch should be no more than 60 seconds so you generate interest without being overwhelming.','2014-02-13 11:07:01',NULL,8,1),(2456,318,0,'Networking','','','','Hiring','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2532,141,0,'Skills',NULL,NULL,NULL,'Industrial Design',NULL,'2014-04-05 14:20:07',NULL,2,1),(2455,318,0,'Networking','','','','Fundraising','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2117,252,0,'Disciplined Entrepreneurship','','','','False','Right! Disciplined Entrepreneurship is a 24 step process to help launch a startup. Steps include defining your customer and quantifying the value proposition. ','2014-02-13 11:07:01',NULL,8,1),(2458,319,0,'Objectives and Key Results (OKRs)','','','','TRUE','Right! The overall company\'s OKRs should be reflected in each unit\'s OKRs but each unit\'s OKRs will likely be different. ','2014-03-04 11:35:34',NULL,8,1),(2530,141,0,'Skills',NULL,NULL,NULL,'Storage Systems',NULL,'2014-04-05 14:19:27',NULL,2,1),(2531,141,0,'Skills',NULL,NULL,NULL,'Graphic Design',NULL,'2014-04-05 14:19:48',NULL,2,1),(2115,251,0,'Idea','','','','True','Right! A founder\'s problem can be the basis for a great business idea as long as others share the problem.','2014-02-13 11:07:01',NULL,8,1),(2113,250,0,'Timing','','','','Age','Right! Entrepreneurship is a lifestyle that can fit many ages if the other circumstances favor it.','2014-02-13 11:07:01',NULL,2,1),(2112,250,0,'Timing','','','','Personal','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2111,250,0,'Timing','','','','Market','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2529,141,0,'Skills',NULL,NULL,NULL,'Data Mining',NULL,'2014-04-05 14:19:06',NULL,2,1),(2110,250,0,'Timing','','','','Career','Wrong!','2014-02-13 11:07:01',NULL,2,1),(1177,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 08:46:29','2013-09-21 08:46:29',1,1),(1178,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:01:19','2013-09-21 13:01:19',1,1),(1179,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:01:41','2013-09-21 13:01:41',1,1),(1180,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:06:45','2013-09-21 13:06:45',1,1),(1181,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:07:05','2013-09-21 13:07:05',1,1),(1182,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:08:53','2013-09-21 13:08:53',1,1),(1183,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:15:48','2013-09-21 13:15:48',1,1),(1184,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:16:19','2013-09-21 13:16:19',1,1),(1185,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:18:03','2013-09-21 13:18:03',1,1),(1186,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:19:09','2013-09-21 13:19:09',1,1),(1187,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:19:19','2013-09-21 13:19:19',1,1),(1188,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:21:37','2013-09-21 13:21:37',1,1),(1189,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:45:17','2013-09-21 13:45:17',1,1),(1190,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:51:04','2013-09-21 13:51:04',1,1),(1191,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:51:27','2013-09-21 13:51:27',1,1),(1192,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:53:26','2013-09-21 13:53:26',1,1),(1193,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:53:34','2013-09-21 13:53:34',1,1),(1194,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 13:53:49','2013-09-21 13:53:49',1,1),(1195,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:01:23','2013-09-21 14:01:23',1,1),(1196,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:01:23','2013-09-21 14:01:23',1,1),(1197,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:01:31','2013-09-21 14:01:31',1,1),(1198,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:05:23','2013-09-21 14:05:23',1,1),(1199,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:09:51','2013-09-21 14:09:51',1,1),(1200,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:11:55','2013-09-21 14:11:55',1,1),(1201,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:23:52','2013-09-21 14:23:52',1,1),(1202,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:23:55','2013-09-21 14:23:55',1,1),(1203,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:27:11','2013-09-21 14:27:11',1,1),(1204,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:27:48','2013-09-21 14:27:48',1,1),(1205,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:28:09','2013-09-21 14:28:09',1,1),(1206,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:46:10','2013-09-21 14:46:10',1,1),(1207,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:46:16','2013-09-21 14:46:16',1,1),(1208,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:48:08','2013-09-21 14:48:08',1,1),(1209,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:48:33','2013-09-21 14:48:33',1,1),(1210,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:49:07','2013-09-21 14:49:07',1,1),(1211,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:49:18','2013-09-21 14:49:18',1,1),(1212,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:50:59','2013-09-21 14:50:59',1,1),(1213,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:51:27','2013-09-21 14:51:27',1,1),(1214,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:51:30','2013-09-21 14:51:30',1,1),(1215,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:52:36','2013-09-21 14:52:36',1,1),(1216,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:52:38','2013-09-21 14:52:38',1,1),(1217,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:53:50','2013-09-21 14:53:50',1,1),(1218,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 14:53:52','2013-09-21 14:53:52',1,1),(1219,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 15:05:25','2013-09-21 15:05:25',1,1),(1220,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 15:05:29','2013-09-21 15:05:29',1,1),(1221,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 15:11:50','2013-09-21 15:11:50',1,1),(1222,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-21 15:11:53','2013-09-21 15:11:53',1,1),(2481,326,0,'User Experience Testing','','','','1 to 4','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2108,249,0,'Lean Startup','','','','False','Right! The MVP (Minimum Viable Product) is a no-frills product prototype designed to get feedback from early customers and learn more about the market.','2014-02-13 11:07:01',NULL,8,1),(2105,248,0,'Business Model Canvas','','','','Key Partners','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2106,248,0,'Business Model Canvas','','','','Revenue Streams','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2104,248,0,'Business Model Canvas','','','','Key Employees','Right! Employees could be a key resource but they are not a stand-alone category in the framework.','2014-02-13 11:07:01',NULL,2,1),(2103,248,0,'Business Model Canvas','','','','Value Proposition','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2527,141,0,'Skills',NULL,NULL,NULL,'Algorithm Design',NULL,'2014-04-05 14:17:23',NULL,2,1),(2395,302,0,'Business Licenses','','','','Revenue','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2396,302,0,'Business Licenses','','','','Stage of Business','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2528,141,0,'Skills',NULL,NULL,NULL,'Data Science',NULL,'2014-04-05 14:18:45',NULL,2,1),(2101,247,0,'Business Model','','','','False','Right! A business model evaluates the operational and financial viability of your business.','2014-02-13 11:07:01',NULL,8,1),(2525,141,0,'Skills',NULL,NULL,NULL,'C/C++',NULL,'2014-04-05 14:16:42',NULL,2,1),(2526,141,0,'Skills',NULL,NULL,NULL,'Middleware',NULL,'2014-04-05 14:17:07',NULL,2,1),(2098,246,0,'Firing','','','','Personal Shortcomings','Wrong!','2014-02-13 11:07:01',NULL,2,1),(1248,100,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-22 18:53:58','2013-09-22 18:53:58',1,1),(1249,100,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-22 18:54:19','2013-09-22 18:54:19',1,1),(2099,246,0,'Firing','','','','All of the Above','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2096,246,0,'Firing','','','','Future Opportunities','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2097,246,0,'Firing','','','','Unmet Expectations','Right! The conversation should include logical reasons for termination such as previous warnings and inability to perform job duties. ','2014-02-13 11:07:01',NULL,2,1),(2460,320,0,'Corporate Social Responsibility (CSR)','','','','Performance','Right! While CSR promotes ethical practices and risk management, the primary benefit is increased business performance, including innovation, brand equity and employee engagement. ','2014-03-04 11:35:34',NULL,2,1),(1262,105,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-22 20:08:36','2013-09-22 20:08:36',1,1),(1263,105,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-22 20:08:49','2013-09-22 20:08:49',1,1),(2094,245,0,'Splitting Founder Equity','','','','False','Right! Although 73% of teams split equity within a month of founding, most teams should wait to allocate equity until after key decisions and commitments are finalized.','2014-02-13 11:07:01',NULL,8,1),(2462,320,0,'Corporate Social Responsibility (CSR)','','','','Compliance','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2092,244,0,'Founding with Friends','','','','True','Right! Founding with prior co-workers is the most stable strategy, on average.','2014-02-13 11:07:01',NULL,8,1),(2461,320,0,'Corporate Social Responsibility (CSR)','','','','Moral','Wrong!','2014-03-04 11:35:34',NULL,2,1),(1276,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-22 21:15:54','2013-09-22 21:15:54',1,1),(1277,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-22 21:16:08','2013-09-22 21:16:08',1,1),(2089,243,0,'Finding a Co-Founder','','','','65%','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2090,243,0,'Finding a Co-Founder','','','','84%','Right! Co-founders still need to evaluate fit in areas such as work style, motivation and values.','2014-02-13 11:07:01',NULL,2,1),(2087,243,0,'Finding a Co-Founder','','','','24%','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2088,243,0,'Finding a Co-Founder','','','','45%','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2397,302,0,'Business Licenses','','','','Type of Business','Right! Both the nature of your business, e.g. food, and location of business affect the required licenses and permits.','2014-03-04 11:35:34',NULL,2,1),(2085,242,0,'Interviewing','','','','Be Transparent','Wrong!','2014-02-13 11:07:01',NULL,2,1),(1290,105,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-22 21:18:53','2013-09-22 21:18:53',1,1),(1291,105,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-22 21:19:03','2013-09-22 21:19:03',1,1),(2084,242,0,'Interviewing','','','','Be Prepared','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2083,242,0,'Interviewing','','','','Omit Critical Information','Right! Never misguide a prospective employee about critical information such as the demands of the job.','2014-02-13 11:07:01',NULL,2,1),(2398,302,0,'Business Licenses','','','','All of the Above','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2082,242,0,'Interviewing','','','','Listen','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2080,241,0,'Mentors','','','','False','Right! Above all else find mentors who are strategically relevant to your industry and business.','2014-02-13 11:07:01',NULL,8,1),(2463,320,0,'Corporate Social Responsibility (CSR)','','','','Risk Management','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2077,240,0,'Personnel Evaluation','','','','Subordinates','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2078,240,0,'Personnel Evaluation','','','','All of the Above','Right! The survey may also be taken by the person being evaluated and external stakeholders such as suppliers and customers.','2014-02-13 11:07:01',NULL,2,1),(2076,240,0,'Personnel Evaluation','','','','Supervisor','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2522,141,0,'Skills',NULL,NULL,NULL,'QA & User Testing',NULL,'2014-04-05 14:15:47',NULL,2,1),(2523,141,0,'Skills',NULL,NULL,NULL,'Perl',NULL,'2014-04-05 14:15:59',NULL,2,1),(2524,141,0,'Skills',NULL,NULL,NULL,'Python',NULL,'2014-04-05 14:16:20',NULL,2,1),(2075,240,0,'Personnel Evaluation','','','','Peers','Wrong!','2014-02-13 11:07:01',NULL,2,1),(1317,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 06:45:07','2013-09-23 06:45:07',1,1),(2073,239,0,'Team Failure','','','','82%','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2072,239,0,'Team Failure','','','','65%','Right! Interpersonal tensions among founders, employees and investors are the #1 cause for startup failure.','2014-02-13 11:07:01',NULL,2,1),(2402,303,0,'NAICS Codes','','','','Industry','Right! NAICS codes are based on industry and provide information on customers, competitors and general industry trends. Innovative businesses may not yet be classified.','2014-03-04 11:35:34',NULL,2,1),(2070,239,0,'Team Failure','','','','15%','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2071,239,0,'Team Failure','','','','37%','Wrong!','2014-02-13 11:07:01',NULL,2,1),(2068,238,0,'Valuation Methods','','','','False','Right! The market approach is a business valuation method based on comparing similar investments.','2014-02-13 11:07:00',NULL,8,1),(2400,303,0,'NAICS Codes','','','','Geography','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2401,303,0,'NAICS Codes','','','','Size','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2521,141,0,'Skills',NULL,NULL,NULL,'Franchising',NULL,'2014-04-05 14:15:27',NULL,2,1),(2065,237,0,'Options Pool','','','','Customers','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2066,237,0,'Options Pool','','','','All of the Above','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2519,141,0,'Skills',NULL,NULL,NULL,'Taxes',NULL,'2014-04-05 14:15:00',NULL,2,1),(2063,237,0,'Options Pool','','','','Investors','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2064,237,0,'Options Pool','','','','Employees','Right! Options may also be used to incentivize advisors, contractors and consultants.','2014-02-13 11:07:00',NULL,2,1),(2061,236,0,'Crowdfunding','','','','Pre-Order','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2520,141,0,'Skills',NULL,NULL,NULL,'Bookkeeping',NULL,'2014-04-05 14:15:16',NULL,2,1),(2060,236,0,'Crowdfunding','','','','Donation','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2058,236,0,'Crowdfunding','','','','Reward','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2059,236,0,'Crowdfunding','','','','Equity','Right! Equity crowdfunding investors receive small amounts of ownership in early stage startups.','2014-02-13 11:07:00',NULL,2,1),(2403,303,0,'NAICS Codes','','','','All of the Above','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2056,235,0,'Venture Capitalists & Angel Investors','','','','False','Right! Venture capitalists invest money from their investors, called Limited Partners (LPs), and may invest their own money as well.','2014-02-13 11:07:00',NULL,8,1),(2465,321,0,'Value Chain','','','','Materials','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2466,321,0,'Value Chain','','','','Information','Right! Value chains function through end users pulling products and information flowing to businesses so they can respond to demand.','2014-03-04 11:35:34',NULL,2,1),(2492,144,0,'Stage',NULL,NULL,NULL,'  Established (>$500,000 <$1,000,000 Revenue)','','2014-04-03 04:36:06',NULL,2,1),(2054,234,0,'Convertible Note','','','','Company Gets More Money','Right! Convertible notes are a form of debt and do not entitle companies to more money than selling equity.','2014-02-13 11:07:00',NULL,2,1),(2052,234,0,'Convertible Note','','','','Entrepreneur Keeps Control','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2053,234,0,'Convertible Note','','','','Investor Gets Discount','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2493,144,0,'Stage',NULL,NULL,NULL,' Growth (>$1,000,000 Revenue)','','2014-04-03 04:36:06',NULL,2,1),(2051,234,0,'Convertible Note','','','','Requires Less Paperwork','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2049,233,0,'Vesting','','','','False','Right! Vesting can be time-based, event-based or performance based.','2014-02-13 11:07:00',NULL,8,1),(2518,141,0,'Skills',NULL,NULL,NULL,'Content Marketing',NULL,'2014-04-05 14:14:49',NULL,2,1),(2047,232,0,'Term Sheet','','','','True','Right! A term sheet is intended to outline the agreement between an entrepreneur and investor.','2014-02-13 11:07:00',NULL,8,1),(2467,321,0,'Value Chain','','','','Transportation & Logistics','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2044,231,0,'Valuation','','','','$10,000,000','Right! To calculate the post-money valuation you add the pre-money valuation to the total equity investment for the Series A round.','2014-02-13 11:07:00',NULL,2,1),(2045,231,0,'Valuation','','','','$12,000,000','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2043,231,0,'Valuation','','','','$6,000,000','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2406,304,0,'GAAP','','','','Financial Statements','Right! GAAP is a set of standards to create consistency in financial reporting.','2014-03-04 11:35:34',NULL,2,1),(2042,231,0,'Valuation','','','','$2,000,000','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2405,304,0,'GAAP','','','','Term Sheets','Wrong!','2014-03-04 11:35:34',NULL,2,1),(1397,111,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 07:27:21','2013-09-23 07:27:21',1,1),(1398,111,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 07:27:29','2013-09-23 07:27:29',1,1),(2468,321,0,'Value Chain','','','','Technology','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2517,141,0,'Skills',NULL,NULL,NULL,'Management Information Systems',NULL,'2014-04-05 14:14:28',NULL,2,1),(2040,230,0,'Capitalization Table','','','','True','Right! The capitalization table, or cap table for short, details the owners of the company and their shares.','2014-02-13 11:07:00',NULL,8,1),(2038,229,0,'Anti-Dilution','','','','Cliff','Right! Broad-based weighted average is by far the most common form of anti-dilution and also the most favorable to the startup. The least favorable to startups is the ratchet.','2014-02-13 11:07:00',NULL,2,1),(2036,229,0,'Anti-Dilution','','','','Ratchet','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2037,229,0,'Anti-Dilution','','','','Broad-based Weighted Avg.','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2408,304,0,'GAAP','','','','Non-Disclosure Agreements','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2407,304,0,'GAAP','','','','Marketing Plans','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2035,229,0,'Anti-Dilution','','','','Narrow-based Weighted Avg.','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2033,228,0,'Debt & Equity Financing','','','','Flexibility','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2032,228,0,'Debt & Equity Financing','','','','Ownership Dilution','Right! The ownership percentage of existing shareholders decreases each time the company sells more equity.','2014-02-13 11:07:00',NULL,2,1),(2410,305,0,'Financial Statements','','','','2','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2030,228,0,'Debt & Equity Financing','','','','Covenants','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2031,228,0,'Debt & Equity Financing','','','','Interest Payments','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2514,141,0,'Skills',NULL,NULL,NULL,'Organizational Development',NULL,'2014-04-05 14:13:25',NULL,2,1),(2515,141,0,'Skills',NULL,NULL,NULL,'Management',NULL,'2014-04-05 14:13:50',NULL,2,1),(2028,227,0,'Mergers & Acquisitions (M&A)','','','','False','Right! An acquisition occurs when one company purchases another company.','2014-02-13 11:07:00',NULL,8,1),(2026,226,0,'Burn Rate','','','','Year','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2470,322,0,'Gamification','','','','FALSE','Right! Gamification incorporates game thinking and game mechanics into non-game applications in order to engage people.','2014-03-04 11:35:34',NULL,8,1),(2516,141,0,'Skills',NULL,NULL,NULL,'Accounting',NULL,'2014-04-05 14:14:05',NULL,2,1),(2025,226,0,'Burn Rate','','','','Month','Right! Burn rate provides an indication of how long it will take for a startup to run out of its money in the bank.','2014-02-13 11:07:00',NULL,2,1),(2023,226,0,'Burn Rate','','','','Day','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2024,226,0,'Burn Rate','','','','Week','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2021,225,0,'Return on Investment (ROI)','','','','600%','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2020,225,0,'Return on Investment (ROI)','','','','500%','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2018,225,0,'Return on Investment (ROI)','','','','100%','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2019,225,0,'Return on Investment (ROI)','','','','400%','Right! The profit is $400 on the $100 investment so the ROI is 400%.','2014-02-13 11:07:00',NULL,2,1),(2411,305,0,'Financial Statements','','','','4','Right! The 4 financial statements are income statement, balance sheet, cash flow statement and statement of changes in equity.','2014-03-04 11:35:34',NULL,2,1),(2016,224,0,'Time Value of Money','','','','False','Right! The time value of money concept states that money is worth more today than tomorrow because it can earn value through investing.','2014-02-13 11:07:00',NULL,8,1),(2511,141,0,'Skills',NULL,NULL,NULL,'Training',NULL,'2014-04-05 14:12:20',NULL,2,1),(2512,141,0,'Skills',NULL,NULL,NULL,'Security',NULL,'2014-04-05 14:12:34',NULL,2,1),(2513,141,0,'Skills',NULL,NULL,NULL,'Database Management',NULL,'2014-04-05 14:13:03',NULL,2,1),(2472,323,0,'Supply Chain Management','','','','FALSE','Right! Supply chains affect all industries, including services and online businesses.','2014-03-04 11:35:34',NULL,8,1),(1461,110,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 08:59:38','2013-09-23 08:59:38',1,1),(1462,110,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 08:59:56','2013-09-23 08:59:56',1,1),(1463,110,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 09:03:09','2013-09-23 09:03:09',1,1),(1464,110,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 09:04:27','2013-09-23 09:04:27',1,1),(1465,110,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 09:07:07','2013-09-23 09:07:07',1,1),(1466,110,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 09:07:26','2013-09-23 09:07:26',1,1),(2014,223,0,'Fixed & Variable Costs','','','','False','Right! Fixed cost is constant over a relevant range of output so average fixed cost decreases with output.','2014-02-13 11:07:00',NULL,8,1),(2509,141,0,'Skills',NULL,NULL,NULL,'Recruiting',NULL,'2014-04-05 14:11:56',NULL,2,1),(2510,141,0,'Skills',NULL,NULL,NULL,'Interviewing',NULL,'2014-04-05 14:12:08',NULL,2,1),(2012,222,0,'Break-Even Point','','','','True','Right! A business is operating at a loss prior to reaching the break-even point.','2014-02-13 11:07:00',NULL,8,1),(2009,221,0,'Balance Sheet','','','','Liabilities','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2010,221,0,'Balance Sheet','','','','Equity','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2008,221,0,'Balance Sheet','','','','Income','Right! The fundamental accounting equation that must always hold True is that assets equal liabilities plus equity.','2014-02-13 11:07:00',NULL,2,1),(2508,141,0,'Skills',NULL,NULL,NULL,'Market Research',NULL,'2014-04-05 14:11:21',NULL,2,1),(1479,111,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 09:12:59','2013-09-23 09:12:59',1,1),(2007,221,0,'Balance Sheet','','','','Assets','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2412,305,0,'Financial Statements','','','','6','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2413,305,0,'Financial Statements','','','','8','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2005,220,0,'Pro-Forma Financial Statements','','','','True','Right! Pro-forma projections should be based on reasonable assumptions about a company\'s performance.','2014-02-13 11:07:00',NULL,8,1),(2003,219,0,'Cash Flow Statement','','','','Marketing','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2002,219,0,'Cash Flow Statement','','','','Investing','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1492,111,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 09:13:42','2013-09-23 09:13:42',1,1),(2001,219,0,'Cash Flow Statement','','','','Operations','Right! Cash flow from operations includes daily activities of the business such as sales and payments.','2014-02-13 11:07:00',NULL,2,1),(2416,306,0,'Run Rate','','','','$400 million','Right! To calculate the run rate simply extrapolate the quarterly revenue over one year.','2014-03-04 11:35:34',NULL,2,1),(2000,219,0,'Cash Flow Statement','','','','Financing','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2506,141,0,'Skills',NULL,NULL,NULL,'Social Entrepreneurship',NULL,'2014-04-05 14:10:51',NULL,2,1),(2507,141,0,'Skills',NULL,NULL,NULL,'Marketing Strategy',NULL,'2014-04-05 14:11:06',NULL,2,1),(2415,306,0,'Run Rate','','','','$100 million','Wrong!','2014-03-04 11:35:34',NULL,2,1),(1998,218,0,'Income Statement','','','','True','Right! Income statements may also be referred to as a profit and loss statement or P&L.','2014-02-13 11:07:00',NULL,8,1),(1995,217,0,'Website','','','','White Space','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1996,217,0,'Website','','','','Calls To Action','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2474,324,0,'Logistics','','','','FALSE','Right! Logistics involves transportation and related considerations such as packaging, insurance and storage.','2014-03-04 11:35:34',NULL,8,1),(1994,217,0,'Website','','','','Buttons','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1993,217,0,'Website','','','','Complex Copy','Right! Your website should be clean and clear.','2014-02-13 11:07:00',NULL,2,1),(2417,306,0,'Run Rate','','','','$600 million','Wrong!','2014-03-04 11:35:34',NULL,2,1),(1991,216,0,'Search Engine Marketing (SEM)','','','','False','Right! SEM includes SEO but also other components such as Pay-Per-Click (PPC).','2014-02-13 11:07:00',NULL,8,1),(1989,215,0,'Web Analytics','','','','All of the Above','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1988,215,0,'Web Analytics','','','','Visitor Name','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1986,215,0,'Web Analytics','','','','Visitor Age','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1987,215,0,'Web Analytics','','','','Visiting History','Right! Website analytics detect general information such as visiting history, referral site and web page visited.','2014-02-13 11:07:00',NULL,2,1),(2504,141,0,'Skills',NULL,NULL,NULL,'Innovation',NULL,'2014-04-05 14:10:28',NULL,2,1),(1529,111,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 11:34:05','2013-09-23 11:34:05',1,1),(1530,105,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 11:35:47','2013-09-23 11:35:47',1,1),(1531,105,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 11:36:09','2013-09-23 11:36:09',1,1),(1532,101,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 13:01:51','2013-09-23 13:01:51',1,1),(1533,101,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 13:06:20','2013-09-23 13:06:20',1,1),(1534,101,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-23 13:06:32','2013-09-23 13:06:32',1,1),(2418,306,0,'Run Rate','','','','$1,200 million','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2505,141,0,'Skills',NULL,NULL,NULL,'Green',NULL,'2014-04-05 14:10:40',NULL,2,1),(1984,214,0,'Search Engine Optimization (SEO)','','','','All of the Above','Right! Search engine rankings also factor website design and development quality.','2014-02-13 11:07:00',NULL,2,1),(1981,214,0,'Search Engine Optimization (SEO)','','','','Reputation','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1982,214,0,'Search Engine Optimization (SEO)','','','','Links','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1983,214,0,'Search Engine Optimization (SEO)','','','','Words','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2423,307,0,'Ratios','','','','Lean Ratio','Wrong!','2014-03-04 11:35:34',NULL,2,1),(1979,213,0,'Social Media Marketing','','','','True','Right! To avoid being spread too thin focus your efforts on the social media channels most relevant to your audience.','2014-02-13 11:07:00',NULL,8,1),(2503,141,0,'Skills',NULL,NULL,NULL,'Board Management',NULL,'2014-04-05 14:10:07',NULL,2,1),(2420,307,0,'Ratios','','','','Slow Ratio','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2421,307,0,'Ratios','','','','Burn Ratio','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2422,307,0,'Ratios','','','','Liquidity Ratio','Right! Leverage ratios and profitability ratios are other common types.','2014-03-04 11:35:34',NULL,2,1),(1976,212,0,'A/B Testing','','','','Layout','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1977,212,0,'A/B Testing','','','','All of the Above','Right! A/B tests, also known as split tests, can be based on variations in any detail of a website.','2014-02-13 11:07:00',NULL,2,1),(2501,2,0,'Industry',NULL,NULL,NULL,'Construction','','2014-04-05 13:57:18',NULL,2,1),(1974,212,0,'A/B Testing','','','','Text','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1975,212,0,'A/B Testing','','','','Color','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2502,1,0,'Focus',NULL,NULL,NULL,'Services','','2014-04-05 14:01:29',NULL,2,1),(1972,211,0,'Email Marketing','','','','False','Right! The best time to send email varies depending on your audience and content. Test different times to see when you get the best results.','2014-02-13 11:07:00',NULL,8,1),(2476,325,0,'Inventory','','','','Stock Review','Wrong!','2014-03-04 11:35:34',NULL,2,1),(1970,210,0,'Landing Page','','','','False','Right! Landing pages are also effective for optimizing email and social media marketing campaigns.','2014-02-13 11:07:00',NULL,8,1),(2478,325,0,'Inventory','','','','PEST Analysis','Right! Proper inventory management helps plan production, prevent waste and fulfill orders on demand.','2014-03-04 11:35:34',NULL,2,1),(1967,209,0,'Content Marketing','','','','Videos','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1577,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-24 14:57:52','2013-09-24 14:57:52',1,1),(1578,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-24 14:57:55','2013-09-24 14:57:55',1,1),(1968,209,0,'Content Marketing','','','','Infographics','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2477,325,0,'Inventory','','','','Just In Time','Wrong!','2014-03-04 11:35:34',NULL,2,1),(1966,209,0,'Content Marketing','','','','Blogs','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1965,209,0,'Content Marketing','','','','Direct Mail','Right! Content marketing employs educational content that drives online traffic to your website.','2014-02-13 11:07:00',NULL,2,1),(2500,2,0,'Industry',NULL,NULL,NULL,'Agribusiness','','2014-04-05 13:56:54',NULL,2,1),(1962,208,0,'Domain Name','','','','Spelling','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1963,208,0,'Domain Name','','','','All of the Above','Right! Try to also choose a name that is inspiring and cool!','2014-02-13 11:07:00',NULL,2,1),(2426,308,0,'Preferred Stock','','','','Common Preferred','Wrong!','2014-03-04 11:35:34',NULL,2,1),(1960,208,0,'Domain Name','','','','Keyword','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1961,208,0,'Domain Name','','','','Extension','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2425,308,0,'Preferred Stock','','','','Exclusive Preferred','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2499,145,0,'Capital',NULL,NULL,NULL,'All','','2014-04-03 04:45:45',NULL,2,1),(1958,207,0,'Contact Management System','','','','False','Right! A contact management system should include email addresses but be maintained separately from your email marketing system.','2014-02-13 11:07:00',NULL,8,1),(1956,206,0,'Business Records','','','','All of the Above','Right! Good record keeping is not only a best practice but also it is the law to keep accurate records.','2014-02-13 11:07:00',NULL,2,1),(1953,206,0,'Business Records','','','','Financial Management','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1954,206,0,'Business Records','','','','Performance Evaluation','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1955,206,0,'Business Records','','','','Tax Filing','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2427,308,0,'Preferred Stock','','','','Participating Preferred','Right! Other types of preferred stock include non-participating preferred and capped participating preferred.','2014-03-04 11:35:34',NULL,2,1),(1951,205,0,'Business Insurance','','','','Financial','Right! Professional liability insurance is commonly called errors and omissions (E&O) insurance.','2014-02-13 11:07:00',NULL,2,1),(1948,205,0,'Business Insurance','','','','Errors & Ommissions','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1949,205,0,'Business Insurance','','','','General','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1950,205,0,'Business Insurance','','','','Product','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2498,145,0,'Capital',NULL,NULL,NULL,' >$1,000,000','','2014-04-03 04:45:44',NULL,2,1),(2428,308,0,'Preferred Stock','','','','Uncommon Preferred','Wrong!','2014-03-04 11:35:34',NULL,2,1),(1946,204,0,'Document Management System','','','','All of the Above','Right! Although free cloud storage is sufficient for basic needs, highly sensitive data may require a more secure cloud storage solution.','2014-02-13 11:07:00',NULL,2,1),(1945,204,0,'Document Management System','','','','Data Backup','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2431,309,0,'WOW Statement','','','','3 Sentences','Right! The shorter the better; one sentence is ideal.','2014-03-04 11:35:34',NULL,2,1),(1943,204,0,'Document Management System','','','','Access','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1944,204,0,'Document Management System','','','','Collaboration','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2497,145,0,'Capital',NULL,NULL,NULL,'  >$500,000','','2014-04-03 04:45:44',NULL,2,1),(2430,309,0,'WOW Statement','','','','1 Sentence','Wrong!','2014-03-04 11:35:34',NULL,2,1),(1941,203,0,'Business Cards','','','','False','Right! Business cards should contain basic information such as name, contact and company logo. The design should reflect your brand.','2014-02-13 11:07:00',NULL,8,1),(2479,325,0,'Inventory','','','','ABC Analysis ','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2495,145,0,'Capital',NULL,NULL,NULL,'    $0','','2014-04-03 04:45:44',NULL,2,1),(2496,145,0,'Capital',NULL,NULL,NULL,'   <$500,000','','2014-04-03 04:45:44',NULL,2,1),(1939,202,0,'Corporate Tax Filing','','','','True','Right! Corporations are always taxed as an S Corporation or C Corporation.','2014-02-13 11:07:00',NULL,8,1),(2494,144,0,'Stage',NULL,NULL,NULL,'All','','2014-04-03 04:36:08',NULL,2,1),(1936,201,0,'Payroll Taxes','','','','Medicare','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1937,201,0,'Payroll Taxes','','','','Property','Right! Keep in mind that payroll taxes vary by state and can change in a given year.','2014-02-13 11:07:00',NULL,2,1),(1934,201,0,'Payroll Taxes','','','','Social Security','Wrong!','2014-02-13 11:07:00',NULL,2,1),(1935,201,0,'Payroll Taxes','','','','Unemployment','Wrong!','2014-02-13 11:07:00',NULL,2,1),(2433,309,0,'WOW Statement','','','','7 Sentences','Wrong!','2014-03-04 11:35:34',NULL,2,1),(2432,309,0,'WOW Statement','','','','5 Sentences','Wrong!','2014-03-04 11:35:34',NULL,2,1),(1766,141,0,'Skills',NULL,NULL,NULL,'Coaching','','2014-01-28 13:53:34',NULL,2,1),(1765,141,0,'Skills',NULL,NULL,NULL,'Entrepreneurship','','2014-01-28 13:53:34',NULL,2,1),(1764,141,0,'Skills',NULL,NULL,NULL,'Leadership','','2014-01-28 13:53:34',NULL,2,1),(1763,141,0,'Skills',NULL,NULL,NULL,'Public Speaking','','2014-01-28 13:53:34',NULL,2,1),(1762,141,0,'Skills',NULL,NULL,NULL,'HTML','','2014-01-28 13:53:34',NULL,2,1),(1761,141,0,'Skills',NULL,NULL,NULL,'CSS','','2014-01-28 13:53:34',NULL,2,1),(1760,141,0,'Skills',NULL,NULL,NULL,'JavaScript','','2014-01-28 13:53:34',NULL,2,1),(1759,141,0,'Skills',NULL,NULL,NULL,'PHP','','2014-01-28 13:53:34',NULL,2,1),(1758,141,0,'Skills',NULL,NULL,NULL,'Web Development','','2014-01-28 13:53:34',NULL,2,1),(1757,141,0,'Skills',NULL,NULL,NULL,'Android','','2014-01-28 13:53:34',NULL,2,1),(1756,141,0,'Skills',NULL,NULL,NULL,'iOS','','2014-01-28 13:53:34',NULL,2,1),(1755,141,0,'Skills',NULL,NULL,NULL,'Cloud','','2014-01-28 13:53:34',NULL,2,1),(1754,141,0,'Skills',NULL,NULL,NULL,'CRM','','2014-01-28 13:53:34',NULL,2,1),(1753,141,0,'Skills',NULL,NULL,NULL,'Ruby','','2014-01-28 13:53:34',NULL,2,1),(1752,141,0,'Skills',NULL,NULL,NULL,'Mobile','','2014-01-28 13:53:34',NULL,2,1),(1751,141,0,'Skills',NULL,NULL,NULL,'Software Development','','2014-01-28 13:53:34',NULL,2,1),(1750,141,0,'Skills',NULL,NULL,NULL,'Wordpress','','2014-01-28 13:53:34',NULL,2,1),(1749,141,0,'Skills',NULL,NULL,NULL,'Agile Development','','2014-01-28 13:53:33',NULL,2,1),(1748,141,0,'Skills',NULL,NULL,NULL,'Design','','2014-01-28 13:53:33',NULL,2,1),(1747,141,0,'Skills',NULL,NULL,NULL,'Analytics','','2014-01-28 13:53:33',NULL,2,1),(1746,141,0,'Skills',NULL,NULL,NULL,'Product Management','','2014-01-28 13:53:33',NULL,2,1),(1745,141,0,'Skills',NULL,NULL,NULL,'Lean Startup','','2014-01-28 13:53:33',NULL,2,1),(1744,141,0,'Skills',NULL,NULL,NULL,'User Experience','','2014-01-28 13:53:33',NULL,2,1),(1743,141,0,'Skills',NULL,NULL,NULL,'Angel Investing','','2014-01-28 13:53:33',NULL,2,1),(1742,141,0,'Skills',NULL,NULL,NULL,'Debt','','2014-01-28 13:53:33',NULL,2,1),(1741,141,0,'Skills',NULL,NULL,NULL,'Finance','','2014-01-28 13:53:33',NULL,2,1),(1740,141,0,'Skills',NULL,NULL,NULL,'Venture Capital','','2014-01-28 13:53:33',NULL,2,1),(1739,141,0,'Skills',NULL,NULL,NULL,'Crowdfunding','','2014-01-28 13:53:33',NULL,2,1),(1738,141,0,'Skills',NULL,NULL,NULL,'Gamification','','2014-01-28 13:53:33',NULL,2,1),(1737,141,0,'Skills',NULL,NULL,NULL,'Advertising','','2014-01-28 13:53:33',NULL,2,1),(1736,141,0,'Skills',NULL,NULL,NULL,'Lead Generation','','2014-01-28 13:53:33',NULL,2,1),(1735,141,0,'Skills',NULL,NULL,NULL,'Sales','','2014-01-28 13:53:33',NULL,2,1),(1734,141,0,'Skills',NULL,NULL,NULL,'Growth Hacking','','2014-01-28 13:53:33',NULL,2,1),(1733,141,0,'Skills',NULL,NULL,NULL,'Copywriting','','2014-01-28 13:53:33',NULL,2,1),(1732,141,0,'Skills',NULL,NULL,NULL,'Email Marketing','','2014-01-28 13:53:33',NULL,2,1),(1731,141,0,'Skills',NULL,NULL,NULL,'Inbound Marketing','','2014-01-28 13:53:33',NULL,2,1),(1730,141,0,'Skills',NULL,NULL,NULL,'Publishing','','2014-01-28 13:53:33',NULL,2,1),(1729,141,0,'Skills',NULL,NULL,NULL,'Public Relations','','2014-01-28 13:53:33',NULL,2,1),(1728,141,0,'Skills',NULL,NULL,NULL,'Search Engine Marketing (SEM)','','2014-01-28 13:53:33',NULL,2,1),(1727,141,0,'Skills',NULL,NULL,NULL,'Search Engine Optimization (SEO)','','2014-01-28 13:53:33',NULL,2,1),(1726,141,0,'Skills',NULL,NULL,NULL,'Social Media Marketing','','2014-01-28 13:53:33',NULL,2,1),(1725,141,0,'Skills',NULL,NULL,NULL,'Legal','','2014-01-28 13:53:33',NULL,2,1),(1724,141,0,'Skills',NULL,NULL,NULL,'Business Development','','2014-01-28 13:53:32',NULL,2,1),(1723,141,0,'Skills',NULL,NULL,NULL,'Human Resources','','2014-01-28 13:53:32',NULL,2,1),(1722,141,0,'Skills',NULL,NULL,NULL,'Strategy','','2014-01-28 13:53:32',NULL,2,1),(1721,141,0,'Skills',NULL,NULL,NULL,'Customer Engagement','','2014-01-28 13:53:32',NULL,2,1),(1720,141,0,'Skills',NULL,NULL,NULL,'Fundraising','','2014-01-28 13:53:32',NULL,2,1),(1719,141,0,'Skills',NULL,NULL,NULL,'Branding','','2014-01-28 13:53:32',NULL,2,1),(1716,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-26 12:14:18','2013-09-26 12:14:18',1,1),(1717,106,0,'Social Intelligence',NULL,NULL,NULL,'',NULL,'2013-09-26 22:22:15','2013-09-26 22:22:15',1,1),(2535,146,0,'Seeking',NULL,NULL,NULL,'Artist',NULL,'0000-00-00 00:00:00',NULL,2,1),(2536,146,0,'Seeking',NULL,NULL,NULL,'Business',NULL,'0000-00-00 00:00:00',NULL,2,1),(2537,146,0,'Seeking',NULL,NULL,NULL,'Designer',NULL,'0000-00-00 00:00:00',NULL,2,1),(2538,146,0,'Seeking',NULL,NULL,NULL,'Developer',NULL,'0000-00-00 00:00:00',NULL,2,1),(2539,146,0,'Seeking',NULL,NULL,NULL,'Engineer',NULL,'0000-00-00 00:00:00',NULL,2,1),(2540,146,0,'Seeking',NULL,NULL,NULL,'Marketer',NULL,'0000-00-00 00:00:00',NULL,2,1),(2541,146,0,'Seeking',NULL,NULL,NULL,'Mentor',NULL,'0000-00-00 00:00:00',NULL,2,1),(2542,146,0,'Seeking',NULL,NULL,NULL,'Product Manager',NULL,'0000-00-00 00:00:00',NULL,2,1),(2543,146,0,'Seeking',NULL,NULL,NULL,'Scientist',NULL,'0000-00-00 00:00:00',NULL,2,1),(2544,146,0,'Seeking',NULL,NULL,NULL,'Writer',NULL,'0000-00-00 00:00:00',NULL,2,1),(2545,140,0,'College',NULL,NULL,NULL,'Princeton University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2546,140,0,'College',NULL,NULL,NULL,'Harvard University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2547,140,0,'College',NULL,NULL,NULL,'Yale University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2548,140,0,'College',NULL,NULL,NULL,'Columbia University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2549,140,0,'College',NULL,NULL,NULL,'Stanford University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2550,140,0,'College',NULL,NULL,NULL,'University of Chicago',NULL,'0000-00-00 00:00:00',NULL,2,1),(2551,140,0,'College',NULL,NULL,NULL,'Massachusetts Institute of Technology',NULL,'0000-00-00 00:00:00',NULL,2,1),(2552,140,0,'College',NULL,NULL,NULL,'Duke University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2553,140,0,'College',NULL,NULL,NULL,'University of Pennsylvania',NULL,'0000-00-00 00:00:00',NULL,2,1),(2554,140,0,'College',NULL,NULL,NULL,'California Institute of Technology',NULL,'0000-00-00 00:00:00',NULL,2,1),(2555,140,0,'College',NULL,NULL,NULL,'Dartmouth College',NULL,'0000-00-00 00:00:00',NULL,2,1),(2556,140,0,'College',NULL,NULL,NULL,'Johns Hopkins University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2557,140,0,'College',NULL,NULL,NULL,'Northwestern University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2558,140,0,'College',NULL,NULL,NULL,'Washington University in St. Louis',NULL,'0000-00-00 00:00:00',NULL,2,1),(2559,140,0,'College',NULL,NULL,NULL,'Cornell University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2560,140,0,'College',NULL,NULL,NULL,'Brown University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2561,140,0,'College',NULL,NULL,NULL,'University of Notre Dame',NULL,'0000-00-00 00:00:00',NULL,2,1),(2562,140,0,'College',NULL,NULL,NULL,'Vanderbilt University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2563,140,0,'College',NULL,NULL,NULL,'Rice University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2564,140,0,'College',NULL,NULL,NULL,'University of California',NULL,'0000-00-00 00:00:00',NULL,2,1),(2565,140,0,'College',NULL,NULL,NULL,'Emory University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2566,140,0,'College',NULL,NULL,NULL,'Georgetown University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2567,140,0,'College',NULL,NULL,NULL,'University of California',NULL,'0000-00-00 00:00:00',NULL,2,1),(2568,140,0,'College',NULL,NULL,NULL,'University of Virginia',NULL,'0000-00-00 00:00:00',NULL,2,1),(2569,140,0,'College',NULL,NULL,NULL,'Carnegie Mellon University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2570,140,0,'College',NULL,NULL,NULL,'University of Southern California',NULL,'0000-00-00 00:00:00',NULL,2,1),(2571,140,0,'College',NULL,NULL,NULL,'Tufts University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2572,140,0,'College',NULL,NULL,NULL,'Wake Forest University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2573,140,0,'College',NULL,NULL,NULL,'University of Michigan',NULL,'0000-00-00 00:00:00',NULL,2,1),(2574,140,0,'College',NULL,NULL,NULL,'University of North Carolina',NULL,'0000-00-00 00:00:00',NULL,2,1),(2575,140,0,'College',NULL,NULL,NULL,'Boston College',NULL,'0000-00-00 00:00:00',NULL,2,1),(2576,140,0,'College',NULL,NULL,NULL,'New York University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2577,140,0,'College',NULL,NULL,NULL,'College of William and Mary',NULL,'0000-00-00 00:00:00',NULL,2,1),(2578,140,0,'College',NULL,NULL,NULL,'University of Rochester',NULL,'0000-00-00 00:00:00',NULL,2,1),(2579,140,0,'College',NULL,NULL,NULL,'Brandeis University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2580,140,0,'College',NULL,NULL,NULL,'Georgia Institute of Technology',NULL,'0000-00-00 00:00:00',NULL,2,1),(2581,140,0,'College',NULL,NULL,NULL,'University of California',NULL,'0000-00-00 00:00:00',NULL,2,1),(2582,140,0,'College',NULL,NULL,NULL,'Case Western Reserve University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2583,140,0,'College',NULL,NULL,NULL,'University of California',NULL,'0000-00-00 00:00:00',NULL,2,1),(2584,140,0,'College',NULL,NULL,NULL,'Lehigh University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2585,140,0,'College',NULL,NULL,NULL,'University of California',NULL,'0000-00-00 00:00:00',NULL,2,1),(2586,140,0,'College',NULL,NULL,NULL,'Boston University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2587,140,0,'College',NULL,NULL,NULL,'Northeastern University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2588,140,0,'College',NULL,NULL,NULL,'Rensselaer Polytechnic Institute',NULL,'0000-00-00 00:00:00',NULL,2,1),(2589,140,0,'College',NULL,NULL,NULL,'University of California',NULL,'0000-00-00 00:00:00',NULL,2,1),(2590,140,0,'College',NULL,NULL,NULL,'University of Illinois',NULL,'0000-00-00 00:00:00',NULL,2,1),(2591,140,0,'College',NULL,NULL,NULL,'University of Wisconsin',NULL,'0000-00-00 00:00:00',NULL,2,1),(2592,140,0,'College',NULL,NULL,NULL,'Pennsylvania State University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2593,140,0,'College',NULL,NULL,NULL,'University of Florida',NULL,'0000-00-00 00:00:00',NULL,2,1),(2594,140,0,'College',NULL,NULL,NULL,'University of Miami',NULL,'0000-00-00 00:00:00',NULL,2,1),(2595,140,0,'College',NULL,NULL,NULL,'University of Washington',NULL,'0000-00-00 00:00:00',NULL,2,1),(2596,140,0,'College',NULL,NULL,NULL,'Yeshiva University',NULL,'0000-00-00 00:00:00',NULL,2,1),(2597,152,0,'Idea-Industry',NULL,'images/it.jpg',NULL,'Information Technology','','2013-08-20 00:10:43',NULL,2,1),(2598,152,0,'Idea-Industry',NULL,'/images/lifescience.jpg',NULL,'Life Sciences','','2013-08-20 00:10:43',NULL,2,1),(2599,152,0,'Idea-Industry',NULL,'/images/cleantech.jpg',NULL,'Cleantech','','2013-08-20 00:10:43',NULL,2,1),(2600,152,0,'Idea-Industry',NULL,'/images/health.gif',NULL,'Healthcare','','2013-08-20 00:10:43',NULL,2,1),(2601,152,0,'Idea-Industry',NULL,'/images/energy.png',NULL,'Energy','','2013-08-20 00:10:43',NULL,2,1),(2602,152,0,'Idea-Industry',NULL,'/images/gaming.png',NULL,'Gaming','','2013-08-20 00:10:43',NULL,2,1),(2603,152,0,'Idea-Industry',NULL,'/images/media.png',NULL,'Media','','2013-08-20 00:10:43',NULL,2,1),(2604,152,0,'Idea-Industry',NULL,'/images/sustainability.jpg',NULL,'Sustainability','','2013-08-20 00:10:43',NULL,2,1),(2605,152,0,'Idea-Industry',NULL,'/images/transportation.jpg',NULL,'Transportation & Logistics','','2013-08-20 00:10:43',NULL,2,1),(2606,152,0,'Idea-Industry',NULL,'/images/retail.png',NULL,'Retail','','2013-08-20 00:10:43',NULL,2,1),(2607,152,0,'Idea-Industry',NULL,'/images/education.jpg',NULL,'Education','','2013-08-20 00:10:43',NULL,2,1),(2608,152,0,'Idea-Industry',NULL,'/images/food.jpg',NULL,'Food & Beverage','','2013-08-20 00:10:43',NULL,2,1),(2609,152,0,'Idea-Industry',NULL,'/images/financial.png',NULL,'Financial Services','','2013-08-20 00:10:43',NULL,2,1),(2610,152,0,'Idea-Industry',NULL,'/images/socialent.png',NULL,'Nonprofit','','2013-08-20 00:10:43',NULL,2,1),(2611,152,0,'Idea-Industry',NULL,'/images/realestate.png',NULL,'Real Estate','','2013-08-20 00:10:43',NULL,2,1),(2612,152,0,'Idea-Industry',NULL,'/images/sports.png',NULL,'Sports & Entertainment','','2013-08-20 00:10:43',NULL,2,1),(2613,152,0,'Idea-Industry',NULL,'/images/telecommunications.jpg',NULL,'Telecommunications','','2013-08-20 00:10:43',NULL,2,1),(2614,152,0,'Idea-Industry',NULL,'/images/travel.png',NULL,'Travel & Tourism','','2013-08-20 00:10:43',NULL,2,1),(2615,152,0,'Idea-Industry',NULL,'/images/biotech.jpg',NULL,'Biotech','','2013-08-20 00:10:43',NULL,2,1),(2616,152,0,'Idea-Industry',NULL,'/images/other.jpg',NULL,'Other','','2013-08-20 00:10:43',NULL,2,1),(2617,152,0,'Idea-Industry',NULL,'/images/undecided.png',NULL,'Undecided','','2013-08-20 00:10:43',NULL,2,1),(2618,152,0,'Idea-Industry',NULL,NULL,NULL,'Construction','','2014-04-05 13:57:18',NULL,2,1),(2619,152,0,'Idea-Industry',NULL,NULL,NULL,'Agribusiness','','2014-04-05 13:56:54',NULL,2,1),(2620,153,0,'Focus',NULL,'/images/internet.png',NULL,'Internet','','2013-08-20 00:10:43',NULL,2,1),(2621,153,0,'Focus',NULL,'/images/mobile.png',NULL,'Mobile','','2013-08-20 00:10:43',NULL,2,1),(2622,153,0,'Focus',NULL,'/images/software.png',NULL,'Software','','2013-08-20 00:10:43',NULL,2,1),(2623,153,0,'Focus',NULL,'/images/ecommerce.jpg',NULL,'eCommerce','','2013-08-20 00:10:43',NULL,2,1),(2624,153,0,'Focus',NULL,'/images/saas.png',NULL,'SaaS','','2013-08-20 00:10:43',NULL,2,1),(2625,153,0,'Focus',NULL,'/images/devices.jpg',NULL,'Physical Devices','','2013-08-20 00:10:43',NULL,2,1),(2626,153,0,'Focus',NULL,'/images/hardware.jpg',NULL,'Hardware','','2013-08-20 00:10:43',NULL,2,1),(2627,153,0,'Focus',NULL,'/images/cloud.jpg',NULL,'Cloud','','2013-08-20 00:10:43',NULL,2,1),(2628,153,0,'Focus',NULL,'/images/science.png',NULL,'Technology','','2013-08-20 00:10:43',NULL,2,1),(2629,153,0,'Focus',NULL,'/images/data.png',NULL,'Data/Analytics','','2013-08-20 00:10:43',NULL,2,1),(2630,153,0,'Focus',NULL,'/images/social.jpg',NULL,'Social Media','','2013-08-20 00:10:43',NULL,2,1),(2631,153,0,'Focus',NULL,'/images/product.gif',NULL,'Consumer Products','','2013-08-20 00:10:43',NULL,2,1),(2632,153,0,'Focus',NULL,'/images/other.jpg',NULL,'Other','','2013-08-20 00:10:43',NULL,2,1),(2633,153,0,'Focus',NULL,'/images/undecided.png',NULL,'Undecided','','2013-08-20 00:10:43',NULL,2,1),(2634,153,0,'Focus',NULL,NULL,NULL,'Services','','2014-04-05 14:01:29',NULL,2,1),(2635,157,0,'Specialty',NULL,NULL,NULL,'Artist',NULL,'2014-10-08 13:39:05',NULL,2,1),(2636,157,0,'Specialty',NULL,NULL,NULL,'Business',NULL,'2014-10-08 13:39:05',NULL,2,1),(2637,157,0,'Specialty',NULL,NULL,NULL,'Designer',NULL,'2014-10-08 13:39:05',NULL,2,1),(2638,157,0,'Specialty',NULL,NULL,NULL,'Developer',NULL,'2014-10-08 13:39:05',NULL,2,1),(2639,157,0,'Specialty',NULL,NULL,NULL,'Engineer',NULL,'2014-10-08 13:39:05',NULL,2,1),(2640,157,0,'Specialty',NULL,NULL,NULL,'Marketer',NULL,'2014-10-08 13:39:05',NULL,2,1),(2641,157,0,'Specialty',NULL,NULL,NULL,'Mentor',NULL,'2014-10-08 13:39:05',NULL,2,1),(2642,157,0,'Specialty',NULL,NULL,NULL,'Product Manager',NULL,'2014-10-08 13:39:05',NULL,2,1),(2643,157,0,'Specialty',NULL,NULL,NULL,'Scientist',NULL,'2014-10-08 13:39:05',NULL,2,1),(2644,157,0,'Specialty',NULL,NULL,NULL,'Writer',NULL,'2014-10-08 13:39:05',NULL,2,1),(2645,146,0,'Seeking',NULL,NULL,NULL,'Other',NULL,'2014-10-08 13:46:20',NULL,2,0),(2646,157,0,'Specialty',NULL,NULL,NULL,'Other',NULL,'2014-10-08 13:46:36',NULL,2,0),(2647,2,0,'Industry',NULL,NULL,NULL,'Social Enterprise',NULL,'2014-12-18 00:00:00',NULL,2,1),(2648,1,0,'Focus',NULL,NULL,NULL,'Apparel/Accessories',NULL,'2014-12-19 00:00:00',NULL,2,1),(2649,2,0,'Industry',NULL,NULL,NULL,'Fashion',NULL,'2014-12-20 00:00:00',NULL,2,1),(2650,2,0,'Industry',NULL,NULL,NULL,'Law',NULL,'2014-12-20 00:00:00',NULL,2,1),(2651,2,0,'Industry',NULL,NULL,NULL,'Gadgets & Toys',NULL,'2014-12-20 00:00:00',NULL,2,1);
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_status`
--

DROP TABLE IF EXISTS `answer_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer_status` (
  `answer_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `answer_status_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`answer_status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_status`
--

LOCK TABLES `answer_status` WRITE;
/*!40000 ALTER TABLE `answer_status` DISABLE KEYS */;
INSERT INTO `answer_status` VALUES (1,'Active'),(2,'Disabled - Permanent'),(3,'Disabled - Temporary');
/*!40000 ALTER TABLE `answer_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_type`
--

DROP TABLE IF EXISTS `answer_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer_type` (
  `answer_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `answer_type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`answer_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_type`
--

LOCK TABLES `answer_type` WRITE;
/*!40000 ALTER TABLE `answer_type` DISABLE KEYS */;
INSERT INTO `answer_type` VALUES (1,'User Solution'),(2,'SIVI Multi-choice Answer'),(8,'True/False');
/*!40000 ALTER TABLE `answer_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) DEFAULT NULL,
  `category_desc` text,
  `category_note` text,
  `category_type` int(11) DEFAULT NULL,
  `category_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2011 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Profile','User Profile','',1,1),(2,'Attitude','Onboarding','',1,1),(100,'Confidence','Attitude','',2,1),(101,'Creativity','Attitude','',2,1),(102,'Curiosity','Attitude','',2,1),(103,'Determination','Attitude','',2,1),(104,'Discipline','Attitude','',2,1),(105,'Focus','Attitude','',2,1),(106,'Humility','Attitude','',2,1),(107,'Optimism','Attitude','',2,1),(108,'Organization','Attitude','',2,1),(109,'Problem Solving','Attitude','',2,1),(110,'Risk Tolerance','Attitude','',2,1),(111,'Social Intelligence','Attitude','',2,1),(1000,'Personal','Awareness','',3,0),(1001,'Idea','Awareness','pb-idea',3,0),(1002,'Legal','Awareness','pb-legal',3,0),(1003,'IT','Awareness','pb-it',3,0),(1004,'Finance','Awareness','pb-finance',3,0),(1005,'Marketing','Awareness','pb-marketing',3,0),(1006,'Customer Service','Awareness','pb-cs',3,0),(1007,'People','Awareness','pb-hr',3,0),(1008,'Management','Awareness','pb-management',3,0),(2000,'Administration','Awareness 2.0','pb-admin',3,1),(2001,'Online Influence','Awareness 2.0','pb-dmark',3,1),(2002,'Finance','Awareness 2.0','pb-finance',3,1),(2003,'Fundraising','Awareness 2.0','pb-funding',3,1),(2004,'People','Awareness 2.0','pb-hr',3,1),(2005,'Launch','Awareness 2.0','pb-launch',3,1),(2006,'Legal','Awareness 2.0','pb-legal',3,1),(2007,'Management','Awareness 2.0','pb-management',3,1),(2008,'Marketing','Awareness 2.0','pb-marketing',3,1),(2009,'Product','Awareness 2.0','pb-product',3,1),(2010,'Sales','Awareness 2.0','pb-sales',3,1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_status`
--

DROP TABLE IF EXISTS `category_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_status` (
  `category_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_status_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_status`
--

LOCK TABLES `category_status` WRITE;
/*!40000 ALTER TABLE `category_status` DISABLE KEYS */;
INSERT INTO `category_status` VALUES (1,'Active'),(2,'Disabled - Permanent'),(3,'Disabled - Temporary');
/*!40000 ALTER TABLE `category_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_type`
--

DROP TABLE IF EXISTS `category_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_type` (
  `category_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_type`
--

LOCK TABLES `category_type` WRITE;
/*!40000 ALTER TABLE `category_type` DISABLE KEYS */;
INSERT INTO `category_type` VALUES (1,'Profile'),(2,'Onboarding/Attitude'),(3,'Jeopardy/Awareness'),(4,'Cases/Aptitude');
/*!40000 ALTER TABLE `category_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `completed_tools`
--

DROP TABLE IF EXISTS `completed_tools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `completed_tools` (
  `completed_tools_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `element_id` int(11) NOT NULL,
  `completed_tools_title` varchar(255) DEFAULT NULL,
  `completed_tools_url` varchar(255) DEFAULT NULL,
  `completed_tools_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`completed_tools_id`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `completed_tools`
--

LOCK TABLES `completed_tools` WRITE;
/*!40000 ALTER TABLE `completed_tools` DISABLE KEYS */;
/*!40000 ALTER TABLE `completed_tools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversation_details`
--

DROP TABLE IF EXISTS `conversation_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversation_details` (
  `conversation_details_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `conversation_details_text` text,
  `conversation_type` int(11) DEFAULT NULL,
  `conversation_email` varchar(150) DEFAULT NULL,
  `conversation_details_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`conversation_details_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation_details`
--

LOCK TABLES `conversation_details` WRITE;
/*!40000 ALTER TABLE `conversation_details` DISABLE KEYS */;
INSERT INTO `conversation_details` VALUES (21,2129,'Please check this.',2,'admin@launchleader.com','2015-06-03 18:08:06');
/*!40000 ALTER TABLE `conversation_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversation_track`
--

DROP TABLE IF EXISTS `conversation_track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversation_track` (
  `conversation_track_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `funder_id` int(11) DEFAULT NULL,
  `conversation_track_token` varchar(150) DEFAULT NULL,
  `conversation_track_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`conversation_track_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation_track`
--

LOCK TABLES `conversation_track` WRITE;
/*!40000 ALTER TABLE `conversation_track` DISABLE KEYS */;
/*!40000 ALTER TABLE `conversation_track` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversation_type`
--

DROP TABLE IF EXISTS `conversation_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversation_type` (
  `conversation_type_id` int(11) DEFAULT NULL,
  `conversation_type_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation_type`
--

LOCK TABLES `conversation_type` WRITE;
/*!40000 ALTER TABLE `conversation_type` DISABLE KEYS */;
INSERT INTO `conversation_type` VALUES (1,'From Entrepreneur'),(2,'To Entrepreneur');
/*!40000 ALTER TABLE `conversation_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail`
--

DROP TABLE IF EXISTS `detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detail` (
  `detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `detail_name` varchar(255) DEFAULT NULL,
  `detail_desc` text,
  `detail_note` text,
  `detail_type` int(11) DEFAULT NULL,
  `detail_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`detail_id`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail`
--

LOCK TABLES `detail` WRITE;
/*!40000 ALTER TABLE `detail` DISABLE KEYS */;
INSERT INTO `detail` VALUES (13,'Focus','1','1',2,1),(14,'Industry','2','2',2,1),(16,'Education','140','9.00',2,1),(17,'Select Skill/Area of Expertise','141','5',2,1),(18,'Stage','144','6',2,0),(19,'Companies','143','4',2,0),(20,'Industry Years','142','3',2,0),(21,'Capital','145','7',2,0),(22,'Select Skill/Area of Expertise','141','5.2',2,1),(23,'Select Skill/Area of Expertise','141','5.3',2,1),(25,'Profile Photo','147','12.1',2,1),(26,'Idea-Video','148','13.62',2,1),(24,'Seeking','146','11',2,1),(27,'Summary','149','10',2,1),(28,'Idea','150','12.9',2,1),(36,'Idea-Summary','151','13.1',2,1),(37,'Idea-Industry','152','13.2',2,0),(38,'Idea-Focus','153','13.3',2,0),(39,'Idea-Focus','153','13.4',2,0),(40,'Idea-Focus','153','13.5',2,0),(41,'Idea-Photo','154','13.6',2,1),(42,'Idea-Description','155','13.7',2,1),(43,'Experience','156','9.1',2,1),(12,'Specialty','157','1',2,1),(34,'Industry','2','2.2',2,1),(35,'Industry','2','2.3',2,1),(46,'Social Presence','160','12.3',2,1),(47,'Social Presence','160','12.4',2,1),(48,'Education','140','9.01',2,1),(49,'Experience','156','9.11',2,1),(50,'Experience','156','9.12',2,1),(51,'Reference','165','0',2,1);
/*!40000 ALTER TABLE `detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail_status`
--

DROP TABLE IF EXISTS `detail_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detail_status` (
  `detail_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `detail_status_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`detail_status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail_status`
--

LOCK TABLES `detail_status` WRITE;
/*!40000 ALTER TABLE `detail_status` DISABLE KEYS */;
INSERT INTO `detail_status` VALUES (1,'Active'),(2,'Disabled - Permanent'),(3,'Disabled - Temporary');
/*!40000 ALTER TABLE `detail_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detail_type`
--

DROP TABLE IF EXISTS `detail_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detail_type` (
  `detail_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `detail_type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`detail_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detail_type`
--

LOCK TABLES `detail_type` WRITE;
/*!40000 ALTER TABLE `detail_type` DISABLE KEYS */;
INSERT INTO `detail_type` VALUES (1,'Normal'),(2,'Question Based'),(3,'LinkedIn Profile');
/*!40000 ALTER TABLE `detail_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `element`
--

DROP TABLE IF EXISTS `element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `element` (
  `element_id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `element_name` varchar(255) DEFAULT NULL,
  `element_desc` text,
  `element_note` text,
  `element_completed_note` varchar(255) NOT NULL,
  `element_completed_placeholder` varchar(255) NOT NULL,
  `element_amount` int(11) DEFAULT NULL,
  `element_type` int(11) DEFAULT NULL,
  `element_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`element_id`)
) ENGINE=MyISAM AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `element`
--

LOCK TABLES `element` WRITE;
/*!40000 ALTER TABLE `element` DISABLE KEYS */;
INSERT INTO `element` VALUES (1,0,'Domain','Getting a killer Domain is key and doesn\'t have to cost that much if you are creative','','Paste your Domain (URL) here if your website is live; we will automatically generate a website thumbnail that will be visible from your profile page. If your website is not live, paste your domain purchase receipt here; in most cases a DOC/PDF file or URL','Domain URL/file here',20,1,1),(2,0,'Landing Page','A simple page to get a rough idea of interest from customers','','Paste your Landing Page (URL) here if your landing page is live; we will automatically generate a website thumbnail that will be visible from your profile page. If your landing page is not live, paste your Landing Page design URL here (i.e. Dropbox link, ','Landing Page URL here',99,1,1),(3,0,'Surveys','Asking the customer what they really want can save a lot of time','','Paste your Surveys URL/Surveys result here; in most cases a DOC/PDF file or URL (i.e. Dropbox link for file). Visitors can download and view it directly from your profile page.','Surveys document URL here',300,1,1),(4,0,'Logo','Before you have a product, a logo is an elegant way to summarize your business','','Paste your logo design URL here (i.e. Dropbox link) after you get it made. Visitors can view it directly from your profile page.','Logo image URL here',500,1,1),(5,0,'Wireframes','Before you build your product, wireframes are an efficient way to get feedback','','Paste your Wireframe design URL here (i.e. Dropbox link or direct link) after you get it made. Visitors can view it directly from your profile page.','Wireframe design URL here',950,1,1),(6,0,'Search & Social Media Ads','This is where your test users could come from','','Paste your Ads design URL here (i.e. Dropbox link) after you get it made. Visitors can view it directly from your profile page.','AD design URL here',750,1,1),(7,0,'Pitch Deck','To raise money from investors, your ideas need to be presented well','','Paste your Pitch Deck URL here; in most cases a PDF/PPT file (i.e. Dropbox link). Visitors can download and view it directly from your profile page.','Pitch Deck file URL here',1000,1,1),(8,0,'Explainer Video','To sell to customers, your product needs to be presented engagingly','','Paste your explainer video URL here (i.e. YouTube/Vimeo link). Visitors can play it directly from your profile page.','Video URL here',2500,1,1),(9,0,'Crowdfunding Accelerate Package (Marketing & PR)','Get your crowdfunding campaign the rocket boost that it deserves.','','Paste your Crowdfunding progress report URL here (i.e. Dropbox link/ Hosted file). Visitors can download it directly from your profile page.','Crowdfunding report URL here',1500,1,0),(11,2129,'Logo #2','Custom Campaign','custom','','',500,2,1),(12,2129,'Logo #2','Custom Campaign','custom','','',500,2,1),(19,2129,'Logo #3','Custom Campaign','custom','','',2,2,1);
/*!40000 ALTER TABLE `element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `element_detail`
--

DROP TABLE IF EXISTS `element_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `element_detail` (
  `element_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `element_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `element_detail_status` int(11) NOT NULL DEFAULT '1',
  `element_detail_disbursed` int(11) NOT NULL DEFAULT '0',
  `element_detail_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`element_detail_id`)
) ENGINE=MyISAM AUTO_INCREMENT=288 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `element_detail`
--

LOCK TABLES `element_detail` WRITE;
/*!40000 ALTER TABLE `element_detail` DISABLE KEYS */;
INSERT INTO `element_detail` VALUES (36,2,2129,1,0,NULL),(37,3,2129,1,0,NULL),(38,4,2129,1,0,NULL),(39,5,2129,1,0,NULL),(40,6,2129,1,0,NULL),(41,11,2129,1,0,NULL),(54,19,2129,1,0,NULL);
/*!40000 ALTER TABLE `element_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `element_type`
--

DROP TABLE IF EXISTS `element_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `element_type` (
  `element_type_id` int(11) DEFAULT NULL,
  `element_type_desc` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `element_type`
--

LOCK TABLES `element_type` WRITE;
/*!40000 ALTER TABLE `element_type` DISABLE KEYS */;
INSERT INTO `element_type` VALUES (1,'default'),(2,'custom');
/*!40000 ALTER TABLE `element_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_disburse`
--

DROP TABLE IF EXISTS `email_disburse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_disburse` (
  `email_disburse_id` int(11) NOT NULL AUTO_INCREMENT,
  `email_type` varchar(100) DEFAULT NULL,
  `email_disburse_ref` int(11) DEFAULT NULL,
  `email_disburse_status` int(11) DEFAULT NULL,
  `email_disburse_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`email_disburse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_disburse`
--

LOCK TABLES `email_disburse` WRITE;
/*!40000 ALTER TABLE `email_disburse` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_disburse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fund_disbursed`
--

DROP TABLE IF EXISTS `fund_disbursed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fund_disbursed` (
  `fund_disbursed_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `element_id` int(11) DEFAULT NULL,
  `fund_amount` int(11) DEFAULT NULL,
  `disburse_status` varchar(255) NOT NULL,
  `application_fee` float NOT NULL,
  `disburse_token` varchar(255) NOT NULL,
  `funding_details_id` int(11) NOT NULL,
  `fund_disbursed_status` int(11) NOT NULL DEFAULT '1',
  `fund_disbursed_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`fund_disbursed_id`)
) ENGINE=MyISAM AUTO_INCREMENT=156 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fund_disbursed`
--

LOCK TABLES `fund_disbursed` WRITE;
/*!40000 ALTER TABLE `fund_disbursed` DISABLE KEYS */;
INSERT INTO `fund_disbursed` VALUES (29,2129,2129,2,500,'authorized',5,'ch_15A3xLBuOYpHWiauD0TfThVW',44,1,'2014-12-15 18:52:31'),(30,2129,2129,2,500,'authorized',5,'ch_15A3xLBuOYpHWiauvGnbBw0D',46,1,'2014-12-15 18:52:32');
/*!40000 ALTER TABLE `fund_disbursed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funding_authorized`
--

DROP TABLE IF EXISTS `funding_authorized`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funding_authorized` (
  `funding_authorized_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_funder_social_id` varchar(250) NOT NULL,
  `account_id` int(11) NOT NULL,
  `element_id` int(11) NOT NULL,
  `authorized_amount` int(11) NOT NULL,
  `authorized_status` tinyint(4) NOT NULL,
  `funding_details_datetime` datetime NOT NULL,
  PRIMARY KEY (`funding_authorized_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funding_authorized`
--

LOCK TABLES `funding_authorized` WRITE;
/*!40000 ALTER TABLE `funding_authorized` DISABLE KEYS */;
INSERT INTO `funding_authorized` VALUES (1,'10153062060878071',2129,3,100,0,'2015-06-03 19:01:07'),(2,'807951599271629',2129,19,100,0,'2015-06-03 19:04:51'),(3,'807951599271629',2129,19,100,1,'2015-06-03 19:17:48');
/*!40000 ALTER TABLE `funding_authorized` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funding_details`
--

DROP TABLE IF EXISTS `funding_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funding_details` (
  `funding_details_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_funder_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `element_id` int(11) DEFAULT NULL,
  `fund_amount` int(11) DEFAULT NULL,
  `funding_details_anonymous` int(11) NOT NULL DEFAULT '0',
  `funding_details_status` int(11) NOT NULL DEFAULT '1',
  `funding_details_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`funding_details_id`)
) ENGINE=MyISAM AUTO_INCREMENT=210 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funding_details`
--

LOCK TABLES `funding_details` WRITE;
/*!40000 ALTER TABLE `funding_details` DISABLE KEYS */;
INSERT INTO `funding_details` VALUES (44,12,2129,2,500,0,1,'2014-12-10 00:06:43'),(45,15,2129,6,500,0,1,'2014-12-10 20:13:59'),(46,15,2129,2,500,0,1,'2014-12-10 23:42:08'),(47,16,2129,2,8900,0,1,'2014-12-11 17:09:37'),(162,66,2129,3,10000,0,1,'2015-05-19 06:46:31'),(163,66,2129,3,500,0,1,'2015-05-19 06:47:28'),(182,24,2129,19,200,0,1,'2015-06-03 19:17:48');
/*!40000 ALTER TABLE `funding_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funding_milestones`
--

DROP TABLE IF EXISTS `funding_milestones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funding_milestones` (
  `funding_milestones_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `element_id` int(11) DEFAULT NULL,
  `funding_failure_emailed` int(11) NOT NULL DEFAULT '0',
  `funding_milestones_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`funding_milestones_id`)
) ENGINE=MyISAM AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funding_milestones`
--

LOCK TABLES `funding_milestones` WRITE;
/*!40000 ALTER TABLE `funding_milestones` DISABLE KEYS */;
INSERT INTO `funding_milestones` VALUES (13,2129,2,0,'2014-12-10 00:06:43'),(14,2129,6,0,'2014-12-10 20:13:59'),(67,2129,3,0,'2015-05-19 06:46:31'),(77,2129,19,0,'2015-06-03 19:17:48');
/*!40000 ALTER TABLE `funding_milestones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funding_tokens`
--

DROP TABLE IF EXISTS `funding_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funding_tokens` (
  `funding_tokens_id` int(11) NOT NULL AUTO_INCREMENT,
  `funding_details_id` int(11) NOT NULL,
  `funding_card_tokens` varchar(255) NOT NULL,
  `funding_tokens_datetime` datetime NOT NULL,
  PRIMARY KEY (`funding_tokens_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funding_tokens`
--

LOCK TABLES `funding_tokens` WRITE;
/*!40000 ALTER TABLE `funding_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `funding_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inbox`
--

DROP TABLE IF EXISTS `inbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inbox` (
  `inbox_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_to` int(11) DEFAULT NULL,
  `account_from` int(11) DEFAULT NULL,
  `inbox_name` varchar(255) DEFAULT NULL,
  `inbox_desc` text,
  `inbox_note` text,
  `inbox_date` datetime DEFAULT NULL,
  `inbox_type` int(11) DEFAULT NULL,
  `inbox_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`inbox_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbox`
--

LOCK TABLES `inbox` WRITE;
/*!40000 ALTER TABLE `inbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `inbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package`
--

DROP TABLE IF EXISTS `package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package` (
  `package_id` int(11) NOT NULL AUTO_INCREMENT,
  `package_name` varchar(255) DEFAULT NULL,
  `package_desc` text,
  `package_note` text,
  `package_amount` int(11) DEFAULT NULL,
  `package_type` int(11) DEFAULT NULL,
  `package_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`package_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package`
--

LOCK TABLES `package` WRITE;
/*!40000 ALTER TABLE `package` DISABLE KEYS */;
INSERT INTO `package` VALUES (1,'Catalyst','Everything you need to get your project started','',1500,1,1),(2,'Accelerate','The one thing you need to make sure your crowdfunding campaign is a success - supporters','',3000,1,1);
/*!40000 ALTER TABLE `package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_detail`
--

DROP TABLE IF EXISTS `package_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `package_detail` (
  `package_detail_id` int(11) NOT NULL AUTO_INCREMENT,
  `package_id` int(11) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `package_detail_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`package_detail_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_detail`
--

LOCK TABLES `package_detail` WRITE;
/*!40000 ALTER TABLE `package_detail` DISABLE KEYS */;
INSERT INTO `package_detail` VALUES (7,0,2129,NULL),(8,0,2130,NULL),(9,0,2131,NULL),(10,0,2132,NULL),(11,0,2134,NULL),(12,0,2133,NULL),(13,0,2136,NULL),(14,0,2138,NULL),(15,NULL,2139,NULL),(16,0,2140,NULL),(17,NULL,2142,NULL);
/*!40000 ALTER TABLE `package_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `param`
--

DROP TABLE IF EXISTS `param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `param` (
  `param_id` int(11) NOT NULL AUTO_INCREMENT,
  `param_name` varchar(255) DEFAULT NULL,
  `param_value` text,
  `param_desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`param_id`)
) ENGINE=MyISAM AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `param`
--

LOCK TABLES `param` WRITE;
/*!40000 ALTER TABLE `param` DISABLE KEYS */;
INSERT INTO `param` VALUES (1,'MIN_SCORE','30','The low-bar for the attitude assessment.'),(2,'MAX_SCORE','100','The high-bar for the attitude assessment.'),(100,'Confidence','Your results show that you are a Fighter. You don\'t just try, you do. You have exceptional will power, which will serve you well in the war of attrition that we call entrepreneurship.','Confidence Positive Feedback'),(-100,'Confidence','Keep in mind that all of us have room for improvement. Based on your responses we think you\'d benefit from words of wisdom by Eleanor Roosevelt: \"You gain strength, courage, and confidence by every experience in which you really stop to look fear in the face.\"','Confidence Negative Feedback'),(101,'Creativity','Your results show that you are a Maverick. You have a healthy appetite for risk and welcome challenges. You can breathe in problems and exhale solutions.','Creativity Positive Feedback'),(-101,'Creativity','Keep in mind that all of us have room for improvement. Based on your responses we think you\'d benefit from words of wisdom by Paulo Coelho: \"Everybody has a creative potential and from the moment you can express this creative potential, you can start changing the world.\"','Creativity Negative Feedback'),(102,'Curiosity','Your results show that you are a Builder. Information is your competitive advantage. You know how to plan your work and work your plan. ','Curiosity Positive Feedback'),(-102,'Curiosity','Keep in mind that all of us have room for improvement. Based on your responses we think you\'d benefit from words of wisdom by Walt Disney: \"We keep moving forward, opening new doors, and doing new things, because we\'re curious and curiosity keeps leading us down new paths.\"','Curiosity Negative Feedback'),(103,'Determination','Your results show that you are a Fighter. You don\'t just try, you do. You have exceptional will power, which will serve you well in the war of attrition that we call entrepreneurship.','Determination Positive Feedback'),(-103,'Determination','Keep in mind that all of us have room for improvement. Based on your responses we think you\'d benefit from words of wisdom by Dan Gable: \"Gold medals aren\'t really made of gold. They\'re made of sweat, determination, and a hard-to-find alloy called guts.\"','Determination Negattive Feedback'),(104,'Discipline','Your results show that you are a Fighter. You don\'t just try, you do. You have exceptional will power, which will serve you well in the war of attrition that we call entrepreneurship. ','Discipline Positive Feedback'),(-104,'Discipline','Keep in mind that all of us have room for improvement. Based on your responses we think you\'d benefit from words of wisdom by Jim Rohn: \"Discipline is the bridge between goals and accomplishment.\"','Discipline Negative Feedback'),(105,'Focus','Your results show that you are a Builder. Information is your competitive advantage. You know how to plan your work and work your plan. ','Focus Positive Feedback'),(-105,'Focus','Keep in mind that all of us have room for improvement. Based on your responses we think you\'d benefit from words of wisdom by Tony Robbins: \"One reason so few of us achieve what we truly want is that we never direct our focus; we never concentrate our power.\"','Focus Negative Feedback'),(106,'Humility','Your results show that you are an Improver. You get invited to everyone\'s birthday party - and have the network to succeed. You make the world a better place.','Humility Positive Feedback'),(-106,'Humility','Keep in mind that all of us have room for improvement. Based on your responses we think you\'d benefit from words of wisdom by William Penn: \"Humility and knowledge in poor clothes excel pride and ignorance in costly attire.\"','Humility Negative Feedback'),(107,'Optimism','Your results show that you are an Improver. You get invited to everyone\'s birthday party - and have the network to succeed. You make the world a better place.','Optimism Postive Feedback'),(-107,'Optimism','Keep in mind that all of us have room for improvement. Based on your responses we think you\'d benefit from words of wisdom by Helen Keller: \"Optimism is the faith that leads to achievement. Nothing can be done without hope and confidence.\"','Optimism Negative Feedback'),(108,'Organization','Your results show that you are a Builder. Information is your competitive advantage. You know how to plan your work and work your plan.','Organization Postive Feedback'),(-108,'Organization','Keep in mind that all of us have room for improvement. Based on your responses we think you\'d benefit from words of wisdom by Napoleon Hill: \"First comes thought; then organization of that thought into ideas and plans; then transformation of those plans into reality.\"','Organization Negative Feedback'),(109,'Problem Solving','Your results show that you are a Maverick. You have a healthy appetite for risk and welcome challenges. You can breathe in problems and exhale solutions. ','Problem Solving Postive Feedback'),(-109,'Problem Solving','Keep in mind that all of us have room for improvement. Based on your responses we think you\'d benefit from words of wisdom by Albert Einstein: \"No problem can be solved from the same level of consciousness that created it.\"','Problem Solving Negative Feedback'),(110,'Risk Tolerance','Your results show that you are a Maverick. You have a healthy appetite for risk and welcome challenges. You can breathe in problems and exhale solutions.','Risk Tolerance Postive Feedback'),(-110,'Risk Tolerance','Keep in mind that all of us have room for improvement. Based on your responses we think you\'d benefit from words of wisdom by T.S. Eliot: \"Only those who will risk going too far can possibly find out how far one can go.\"','Risk Tolerance Negative Feedback'),(111,'Social Intelligence','Your results show that you are an Improver. You get invited to everyone\'s birthday party - and have the network to succeed. You make the world a better place.','Social Intelligence Postive Feedback'),(-111,'Social Intelligence','Keep in mind that all of us have room for improvement. Based on your responses we think you\'d benefit from words of wisdom by Zig Ziglar: \"You can have everything in life you want, if you will just help other people get what they want.\"','Social Intelligence Negative Feedback'),(112,'STRIPE_PRIVATE_KEY','sk_live_MY_STRIPE_PRIVATE_KEY','LaunchLeader:Stripe Privae Key'),(113,'STRIPE_PUBLIC_KEY','pk_live_MY_STRIPE_PUBLIC_KEY','LaunchLeader:Stripe Public Key'),(114,'STRIPE_CLIENT_ID','ca_MY_STRIPE_CLIENT_ID','LaunchLeader:Stripe Client ID usually required for Stripe oAuth Connect'),(115,'CHARGE_LATER','1','LaunchLeader:Stripe Charge Later flag will be used whether the card will be charged immediately or not'),(116,'TOKEN_URI','https://connect.stripe.com/oauth/token','LaunchLeader:Stripe Token URI'),(117,'AUTHORIZE_URI','https://connect.stripe.com/oauth/authorize','LaunchLeader:Stripe Authorize URI'),(118,'FB_APP_ID','MY_FB_APP_ID','LaunchLeader:Facebook APP ID for Share, Connect etc.'),(119,'SIVI_ADMIN_EMAIL','admin@mydomain.com','LaunchLeader:SIVI admin mail for all CC, Alert emails'),(120,'FROM_EMAIL_ADDRESS','info@mydomain.com','LaunchLeader:Global From Address for Launchleader'),(121,'DEFAULT_MILESTONE','30','LaunchLeader:Default Milestone for Launchleader: Specially the Funding deadline');
/*!40000 ALTER TABLE `param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset`
--

DROP TABLE IF EXISTS `password_reset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset` (
  `password_reset_id` int(11) NOT NULL AUTO_INCREMENT,
  `password_reset_username` varchar(100) DEFAULT NULL,
  `password_reset_token` varchar(100) DEFAULT NULL,
  `password_reset_taken` int(11) DEFAULT NULL,
  `password_reset_expire` datetime DEFAULT NULL,
  PRIMARY KEY (`password_reset_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset`
--

LOCK TABLES `password_reset` WRITE;
/*!40000 ALTER TABLE `password_reset` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `question_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `question_name` varchar(255) DEFAULT NULL,
  `question_wiki` varchar(255) DEFAULT NULL,
  `question_img` varchar(255) DEFAULT NULL,
  `question_url` varchar(255) DEFAULT NULL,
  `question_desc` text,
  `question_note` text,
  `question_added` datetime DEFAULT NULL,
  `question_ended` datetime DEFAULT NULL,
  `question_type` int(11) DEFAULT NULL,
  `question_limit` int(11) NOT NULL,
  `question_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`question_id`)
) ENGINE=MyISAM AUTO_INCREMENT=328 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,1,'Focus','','','','What is your primary focus?','','2013-07-09 10:59:56',NULL,6,0,1),(2,1,'Industry','','','','What industry interests you most? (Choose up to 3)','What industry are you most experienced in?','2013-07-09 10:59:56',NULL,10,3,1),(3,1,'Profiles','','','','Which of the following profiles do you have?','','2013-08-20 00:10:43',NULL,7,0,3),(4,1,'Gender','','','','Are you male or female?','','2013-08-20 00:10:43',NULL,6,0,3),(5,1,'Age','','','','How old are you?','','2013-08-20 00:10:43',NULL,6,0,3),(6,1,'Education','','','','What is the higest level of education you completed?','','2013-08-20 00:10:43',NULL,3,0,3),(7,1,'Motivation','','','','Why do you want to be an entrepreneur? (check all that apply)','','2013-08-20 00:10:43',NULL,7,0,3),(8,1,'Location','','','','What is your zip code?','','2013-08-20 00:10:43',NULL,2,0,1),(9,1,'Entrepreneurship','','','','Do you believe that entrepreneurship can be learned?','','2013-08-20 00:10:43',NULL,6,0,3),(10,100,'Confidence','','','','I see myself as an entrepreneur','100','2013-08-20 00:10:43',NULL,8,0,1),(11,100,'Confidence','','','','Setbacks don\'t discourage me','100','2013-08-20 00:10:43',NULL,5,0,1),(12,100,'Confidence','','','','Fear doesn\'t stop me from trying','100','2013-08-20 00:10:43',NULL,5,0,1),(13,100,'Confidence','','','','I am not bothered by criticism','100','2013-08-20 00:10:43',NULL,5,0,1),(14,100,'Confidence','','','','I feel anxiety about public speaking','100','2013-08-20 00:10:43',NULL,-8,0,1),(15,100,'Confidence','','','','I am thrilled by speaking to large crowds of strangers','100','2013-08-20 00:10:43',NULL,8,0,1),(16,100,'Confidence','','','','I am accountable to myself','100','2013-08-20 00:10:43',NULL,8,0,1),(17,100,'Confidence','','','','I believe in myself','100','2013-08-20 00:10:43',NULL,5,0,1),(18,100,'Confidence','','','','I feel bad about disappointing people who believe in me','100','2013-08-20 00:10:43',NULL,5,0,1),(19,100,'Confidence','','','','I can laugh at myself','100','2013-08-20 00:10:43',NULL,8,0,1),(20,100,'Confidence','','','','I can sell anything','100','2013-08-20 00:10:43',NULL,8,0,1),(21,100,'Confidence','','','','\"Selling\" is a dirty word','100','2013-08-20 00:10:43',NULL,-8,0,1),(22,100,'Confidence','','','','I persuade people to see my point of view','100','2013-08-20 00:10:43',NULL,5,0,1),(23,100,'Confidence','','','','I am comfortable working alone for extended periods of time','100','2013-08-20 00:10:43',NULL,5,0,1),(24,101,'Creativity','','','','I like things the way that they are','100','2013-08-20 00:10:43',NULL,-5,0,1),(25,101,'Creativity','','','','Innovation excites me','100','2013-08-20 00:10:43',NULL,5,0,1),(26,101,'Creativity','','','','People are inspired by my ideas','100','2013-08-20 00:10:43',NULL,5,0,1),(27,101,'Creativity','','','','When others see problems I see opportunities','100','2013-08-20 00:10:43',NULL,5,0,1),(28,102,'Curiosity','','','','I enjoy researching to learn','100','2013-08-20 00:10:43',NULL,5,0,1),(29,102,'Curiosity','','','','Research isn\'t worth spending time on','100','2013-08-20 00:10:43',NULL,-5,0,1),(30,102,'Curiosity','','','','I like asking questions','100','2013-08-20 00:10:43',NULL,8,0,1),(31,102,'Curiosity','','','','I am annoyed by people who ask lots of questions','100','2013-08-20 00:10:43',NULL,-8,0,1),(32,102,'Curiosity','','','','I am always curious about how things work','100','2013-08-20 00:10:43',NULL,8,0,1),(33,102,'Curiosity','','','','Learning is an ongoing process','100','2013-08-20 00:10:43',NULL,8,0,1),(34,102,'Curiosity','','','','I like to read','100','2013-08-20 00:10:43',NULL,5,0,1),(35,103,'Determination','','','','I work hard','100','2013-08-20 00:10:43',NULL,5,0,1),(36,103,'Determination','','','','I am a dreamer AND a doer','100','2013-08-20 00:10:43',NULL,5,0,1),(37,103,'Determination','','','','Failures can be overcome with effort','100','2013-08-20 00:10:43',NULL,5,0,1),(38,103,'Determination','','','','Monday to Friday is for work and the weekend is for play','100','2013-08-20 00:10:43',NULL,-8,0,1),(39,103,'Determination','','','','I work 8 hours a day or less','100','2013-08-20 00:10:43',NULL,-8,0,1),(40,103,'Determination','','','','I believe there is a lesson in every failure','100','2013-08-20 00:10:43',NULL,8,0,1),(41,103,'Determination','','','','If I don\'t succeed at first I make adjustments and keep trying','100','2013-08-20 00:10:43',NULL,5,0,1),(42,103,'Determination','','','','I have overcome difficult challenges in my life','100','2013-08-20 00:10:43',NULL,8,0,1),(43,103,'Determination','','','','I admire tenacious people','100','2013-08-20 00:10:43',NULL,8,0,1),(44,104,'Discipline','','','','I follow through on completing my goals','100','2013-08-20 00:10:43',NULL,5,0,1),(45,104,'Discipline','','','','I tend to procrastinate','100','2013-08-20 00:10:43',NULL,-5,0,1),(46,104,'Discipline','','','','I think twice before sending angry emails','100','2013-08-20 00:10:43',NULL,5,0,1),(47,104,'Discipline','','','','I choose my words carefully','100','2013-08-20 00:10:43',NULL,5,0,1),(48,104,'Discipline','','','','If I say I will do something I stick to it','100','2013-08-20 00:10:43',NULL,5,0,1),(49,104,'Discipline','','','','I work best when I\'m being managed','100','2013-08-20 00:10:43',NULL,-5,0,1),(50,104,'Discipline','','','','I follow up with people','100','2013-08-20 00:10:43',NULL,8,0,1),(51,104,'Discipline','','','','I am comfortable making my own schedule','100','2013-08-20 00:10:43',NULL,5,0,1),(52,104,'Discipline','','','','I like to spend money freely','100','2013-08-20 00:10:43',NULL,-5,0,1),(53,105,'Focus','','','','I frequently start new projects without completing previous ones','100','2013-08-20 00:10:43',NULL,-5,0,1),(54,105,'Focus','','','','It is difficult for me to focus on one idea or project at a time','100','2013-08-20 00:10:43',NULL,-5,0,1),(55,105,'Focus','','','','My interests change frequently','100','2013-08-20 00:10:43',NULL,-8,0,1),(56,105,'Focus','','','','I am focused on one or a small number of ideas','100','2013-08-20 00:10:43',NULL,8,0,1),(57,105,'Focus','','','','Some of my goals have taken years to accomplish but I achieved them','100','2013-08-20 00:10:43',NULL,8,0,1),(58,105,'Focus','','','','I often start projects that I don\'t finish','100','2013-08-20 00:10:43',NULL,5,0,1),(59,105,'Focus','','','','I am detail-oriented','100','2013-08-20 00:10:43',NULL,5,0,1),(60,105,'Focus','','','','I write myself notes to remember what I need to get done','100','2013-08-20 00:10:43',NULL,8,0,1),(61,105,'Focus','','','','As a student, I took careful notes in class','100','2013-08-20 00:10:43',NULL,8,0,1),(62,105,'Focus','','','','My most common activity on the Internet/phone is playing games','100','2013-08-20 00:10:43',NULL,-8,0,1),(63,105,'Focus','','','','I am bored easily','100','2013-08-20 00:10:43',NULL,8,0,1),(64,106,'Humility','','','','I seek out help when I need it','100','2013-08-20 00:10:43',NULL,5,0,1),(65,106,'Humility','','','','I can admit when I am wrong','100','2013-08-20 00:10:43',NULL,5,0,1),(66,106,'Humility','','','','I can change course when things are not working','100','2013-08-20 00:10:43',NULL,8,0,1),(67,106,'Humility','','','','I value feedback from others','100','2013-08-20 00:10:43',NULL,5,0,1),(68,106,'Humility','','','','I can learn from the experience of others','100','2013-08-20 00:10:43',NULL,5,0,1),(69,106,'Humility','','','','I have no weaknesses','100','2013-08-20 00:10:43',NULL,-8,0,1),(70,107,'Optimism','','','','I have achieved at least one professional success over the past year','100','2013-08-20 00:10:43',NULL,8,0,1),(71,107,'Optimism','','','','I have improved my work in at least one area over the past year','100','2013-08-20 00:10:43',NULL,8,0,1),(72,107,'Optimism','','','','I can create the future','100','2013-08-20 00:10:43',NULL,5,0,1),(73,107,'Optimism','','','','Friends would describe me as happy','100','2013-08-20 00:10:43',NULL,5,0,1),(74,107,'Optimism','','','','I am enthusiastic about life','100','2013-08-20 00:10:43',NULL,5,0,1),(75,107,'Optimism','','','','I am fortunate to have many opportunities','100','2013-08-20 00:10:43',NULL,5,0,1),(76,107,'Optimism','','','','I am an unlucky person','100','2013-08-20 00:10:43',NULL,-8,0,1),(77,107,'Optimism','','','','I believe that good things will happen in my life','100','2013-08-20 00:10:43',NULL,5,0,1),(78,107,'Optimism','','','','Bad things always happen to me','100','2013-08-20 00:10:43',NULL,-5,0,1),(79,107,'Optimism','','','','I have a lot to be grateful for','100','2013-08-20 00:10:43',NULL,5,0,1),(80,107,'Optimism','','','','I can contribute to a better future','100','2013-08-20 00:10:43',NULL,5,0,1),(81,107,'Optimism','','','','Friends would describe me as idealistic','100','2013-08-20 00:10:43',NULL,5,0,1),(82,107,'Optimism','','','','I want to change people\'s lives','100','2013-08-20 00:10:43',NULL,5,0,1),(83,108,'Organization','','','','I can follow directions','100','2013-08-20 00:10:43',NULL,5,0,1),(84,108,'Organization','','','','I am a good multi-tasker','100','2013-08-20 00:10:43',NULL,5,0,1),(85,108,'Organization','','','','I can quickly find what I\'m looking for','100','2013-08-20 00:10:43',NULL,5,0,1),(86,108,'Organization','','','','Structure is important to running a business','100','2013-08-20 00:10:43',NULL,5,0,1),(87,108,'Organization','','','','I prioritize my tasks','100','2013-08-20 00:10:43',NULL,5,0,1),(88,108,'Organization','','','','I get things done efficiently','100','2013-08-20 00:10:43',NULL,5,0,1),(89,109,'Problem Solving','','','','I can anticipate problems before they occur','100','2013-08-20 00:10:43',NULL,5,0,1),(90,109,'Problem Solving','','','','I welcome challenges','100','2013-08-20 00:10:43',NULL,5,0,1),(91,109,'Problem Solving','','','','I look for solutions during conflicts','100','2013-08-20 00:10:43',NULL,5,0,1),(92,109,'Problem Solving','','','','I like to fix things that are broken','100','2013-08-20 00:10:43',NULL,5,0,1),(93,110,'Risk Tolerance','','','','I enjoy being independent','100','2013-08-20 00:10:43',NULL,5,0,1),(94,110,'Risk Tolerance','','','','I am willing to relocate to pursue my goals','100','2013-08-20 00:10:43',NULL,5,0,1),(95,110,'Risk Tolerance','','','','I am comfortable with uncertainty','100','2013-08-20 00:10:43',NULL,5,0,1),(96,110,'Risk Tolerance','','','','I don\'t require a regular paycheck','100','2013-08-20 00:10:43',NULL,8,0,1),(97,110,'Risk Tolerance','','','','I take risks if I want the reward','100','2013-08-20 00:10:43',NULL,5,0,1),(98,111,'Social Intelligence','','','','People usually think I am wrong','100','2013-08-20 00:10:43',NULL,-5,0,1),(99,111,'Social Intelligence','','','','People gravitate towards me','100','2013-08-20 00:10:43',NULL,5,0,1),(100,111,'Social Intelligence','','','','It\'s easy for me to make friends','100','2013-08-20 00:10:43',NULL,5,0,1),(101,111,'Social Intelligence','','','','I am a good listener','100','2013-08-20 00:10:43',NULL,5,0,1),(102,111,'Social Intelligence','','','','I interrupt people when they are speaking','100','2013-08-20 00:10:43',NULL,-8,0,1),(103,111,'Social Intelligence','','','','I am collaborative with other people','100','2013-08-20 00:10:43',NULL,5,0,1),(104,111,'Social Intelligence','','','','I like working by myself rather than with other people','100','2013-08-20 00:10:43',NULL,-5,0,1),(105,111,'Social Intelligence','','','','I make friends with entrepreneurs','100','2013-08-20 00:10:43',NULL,8,0,1),(106,111,'Social Intelligence','','','','I am comfortable introducing myself to new people','100','2013-08-20 00:10:43',NULL,5,0,1),(107,111,'Social Intelligence','','','','I enjoy helping others succeed','100','2013-08-20 00:10:43',NULL,5,0,1),(108,111,'Social Intelligence','','','','I like to make people laugh','100','2013-08-20 00:10:43',NULL,5,0,1),(109,111,'Social Intelligence','','','','I use humor to engage people','100','2013-08-20 00:10:43',NULL,5,0,1),(110,111,'Social Intelligence','','','','I like to show appreciation for others','100','2013-08-20 00:10:43',NULL,5,0,1),(111,111,'Social Intelligence','','','','I care about other peoples\' feelings','100','2013-08-20 00:10:43',NULL,5,0,1),(112,111,'Social Intelligence','','','','I don\'t care what other people think about me','100','2013-08-20 00:10:43',NULL,-5,0,1),(113,1001,'Idea','','','http://www.youtube.com/watch?v=XnLaQzi8xJc','This framework helps you document your business model based on criteria such as your Unfair Advantage and Early Adopters.','100','2013-09-18 10:10:24','2013-09-18 10:10:24',3,0,1),(114,1001,'Idea','http://www.kpcb.com/insights/2013-internet-trends','','http://www.youtube.com/watch?v=RpaKdSxCo2M','The _ _ _ _   _ _ _ _ describes the process of iterating on an idea depending on environmental changes such as technology and competition.','100','2013-09-17 20:16:13','2013-09-17 20:16:13',2,0,1),(115,1001,'Idea','','','http://www.youtube.com/watch?v=AiCv7iYAPpc','The MVP is the first fully functioning version of your product.','100','2013-09-18 10:32:35','2013-09-18 10:32:35',8,0,1),(116,1002,'Legal','','','http://www.youtube.com/watch?v=tCQHo9X5O58','This document outlines the specifics of a transaction that the negotiating parties are planning to conduct.','100','2013-09-18 10:54:00','2013-09-18 10:54:00',3,0,1),(117,1002,'Legal','','','http://www.youtube.com/watch?v=Kk748uV7eUY','Which of the following is NOT one of the types of anti-dilution protection?','100','2013-09-18 11:14:08','2013-09-18 11:14:08',3,0,1),(118,1002,'Legal','','','http://www.youtube.com/watch?v=ZqeL-KnU7KU','This ledger is a list of who owns what in a startup.','100','2013-09-18 11:21:48','2013-09-18 11:21:48',2,0,1),(119,1004,'Finance','','/images/finance1.png','http://www.youtube.com/watch?v=0HyP11ZjAg4','What is the post-money valuation following this company\'s Series A funding round? ','100','2013-09-02 11:52:40','2013-09-02 11:52:40',2,0,1),(120,1004,'Finance','','/images/finance2.png','http://www.youtube.com/watch?v=tjQzJ7GY0GY','What percentage of the company do the Series A investors own in total? ','100','2013-09-19 19:35:57','2013-09-19 19:35:57',2,0,1),(121,1004,'Finance','','/images/finance3.png','http://www.youtube.com/watch?v=g2FVJmY4ZDQ','What percent of stock has been set aside for the post-money option pool? ','100','2013-09-19 19:33:47','2013-09-19 19:33:47',2,0,1),(122,1004,'Finance','','/images/finance4.png','http://www.youtube.com/watch?v=sckl-kJxmzM','If there are 600,000 shares in the pre-money option pool, what percentage of the company do the founders own after the financing?','100','2013-09-19 19:29:52','2013-09-19 19:29:52',2,0,1),(123,1004,'Finance','','/images/finance5.png','http://www.youtube.com/watch?v=QgMLrhqo3RE','What is the total share value for the seed debt and Series A equity investors?  ','100','2013-09-19 19:28:53','2013-09-19 19:28:53',2,0,1),(124,1004,'Finance','','/images/finance6.png','http://www.youtube.com/watch?v=ekoueytvbDE','If the company sells for $50,000,000, what is the projected exit value for the founders? ','100','2013-09-18 19:25:22','2013-09-18 19:25:22',2,0,1),(125,1004,'Finance','','','http://www.youtube.com/watch?v=mcW7p2jHFQM','This hotly debated phenomenon refers to entrepreneurs having difficulty raising their first round of financing.','100','2013-09-02 13:54:20','2013-09-02 13:54:20',2,0,1),(126,1004,'Finance','','','http://www.youtube.com/watch?v=edR3duNwTvc','A _ _ _ _ _ _ fund is a private equity investment where investors provide capital on a deal-by-deal basis.','100','2013-09-19 19:43:46','2013-09-19 19:43:46',2,0,1),(127,1004,'Finance','','','http://www.youtube.com/watch?v=Qog9JecpYXs','If the founders own 100% of their company and raise $1M at a $3M pre-money valuation, \r\nwhat percentage of the company does the investor own after the deal? ','100','2013-09-19 19:47:07','2013-09-19 19:47:07',3,0,1),(128,1005,'Marketing','','','http://www.youtube.com/watch?v=5yxuljHX09I','Order the following social media properties by number of monthly active users - from least to most: YouTube, Foursquare, Facebook, LinkedIn, Twitter','100','2013-09-19 19:51:32','2013-09-19 19:51:32',1,0,1),(129,1005,'Marketing','','','http://www.youtube.com/watch?v=Nyr5G1W8MGk','Which of the following is NOT one of the 3 value disciplines? ','100','2013-09-19 19:52:54','2013-09-19 19:52:54',3,0,1),(130,1005,'Marketing','','','http://www.youtube.com/watch?v=ZJIL5tJevg4','The set of human characteristics associated with a brand is called a:  _ _ _ _ _   _ _ _ _ _ _ _ _ _ _ _','100','2013-09-19 20:01:05','2013-09-19 20:01:05',2,0,1),(131,1007,'Human Resources','','','http://www.youtube.com/watch?v=hHfSgLzd3Hs','It is illegal to discriminate against a job candidate based on this set of personal characteristics.','100','2013-09-19 20:06:20','2013-09-19 20:06:20',2,0,1),(132,1007,'Human Resources','','','http://www.youtube.com/watch?v=95u0Guc1WuM','This corporate diagram shows the structure of a company and the relationships among its staff.','100','2013-09-19 20:10:44','2013-09-19 20:10:44',2,0,1),(133,1007,'Human Resources','','','http://www.youtube.com/watch?v=NBKZ6Puml1c','A 360 feedback personnel evaluation may include feedback from which of the following parties? ','100','2013-09-19 20:13:29','2013-09-19 20:13:29',3,0,1),(134,1008,'Management','','','http://www.youtube.com/watch?v=6itk4q0yd6w','A company\'s _ _ _ help define and evaluate progress toward its goals.','100','2013-09-19 20:15:30','2013-09-19 20:15:30',2,0,1),(135,1008,'Management','','','http://www.youtube.com/watch?v=LJhG3HZ7b4o','The company mission statement explains its strategy.','100','2013-09-19 20:17:33','2013-09-19 20:17:33',8,0,1),(136,1008,'Management','','','http://www.docstoc.com/video/94824803/how-to-build-an-advisory-board','This support group is not as formal as the board of directors but still assists the founding team with decision making, networking and gaining credibility.','100','2013-09-19 20:22:08','2013-09-19 20:22:08',2,0,1),(137,1003,'IT','','','http://www.youtube.com/watch?v=exxBmHaWSLs','Which function key in Excel is the shortcut to Save As?','100','2013-09-18 18:32:08','2013-09-18 18:32:08',2,0,1),(138,1003,'IT','','','http://www.youtube.com/watch?v=wKJ9KzGQq0w','How much free storage space do you get from Google Drive?','100','2013-09-18 18:34:38','2013-09-18 18:34:38',3,0,1),(139,1003,'IT','','','http://www.youtube.com/watch?v=DRfAu6kTyvM','This test checks if a web host or IP address is reachable across the Internet.','100','2013-09-18 18:38:22','2013-09-18 18:38:22',2,0,1),(140,1,'Education','','','','What schools did you attend?','','2014-01-28 13:42:37',NULL,2,0,1),(141,1,'Skills','','','','What are your top 3 skills or areas of expertise?','','2014-01-28 13:44:49',NULL,10,3,1),(271,2007,'Time Management','','','71','What does RAC stand for? Recognize, Analyze, Change / Record, Analyze, Change / Record, Attribute, Change / Recognize, Analyze, Correct','100','2014-02-12 14:06:43',NULL,3,0,1),(270,2007,'Advisory Board','','','70','True or False: The advisory board is the same as the board of directors.','100','2014-02-12 14:06:43',NULL,8,0,1),(269,2007,'Performance Evaluation','','','69','True or False: KPI\'s (Key Performance Indicators) help define and evaluate a company\'s progress toward its goals.','100','2014-02-12 14:06:43',NULL,8,0,1),(268,2007,'Pivot','','','68','True or False: A pivot is a small change in one or more business model components.','100','2014-02-12 14:06:43',NULL,8,0,1),(267,2006,'Operating Agreement','','','67','True or False: An operating agreement is a handbook for C-Corporations.','100','2014-02-12 14:06:43',NULL,8,0,1),(266,2006,'By-Laws','','','66','Which of the following is NOT discussed in a corporation\'s By-Laws? Employee Salaries, Directors, Officers or Shareholder Meetings','100','2014-02-12 14:06:43',NULL,3,0,1),(265,2006,'Articles of Incorporation','','','65','Articles of incorporation are filed with the following government office:','100','2014-02-12 14:06:43',NULL,3,0,1),(264,2006,'Corporate Structure','','','64','True or False: The majority of public companies are formed as Delaware Corporations.','100','2014-02-12 14:06:43',NULL,8,0,1),(263,2006,'Contractor Agreements','','','63','True or False: An independent contractor should perform all duties at your office.','100','2014-02-12 14:06:43',NULL,8,0,1),(262,2006,'Non-Disclosure Agreements','','','62','True or False: A Non-Disclosure Agreement (NDA) protects confidential information and trade secrets','100','2014-02-12 14:06:43',NULL,8,0,1),(261,2006,'Employee Policies','','','61','An employment agreement should include which of the following sections? Work History, Confidentiality Statement, Educational History or All of the Above','100','2014-02-12 14:06:43',NULL,3,0,1),(260,2006,'Trademarks','','','60','In the U.S., what can be filed to temporarily reserve a trademark before it is used? Provisional Patent, Intent to Use Trademark Application, Registration Rights or Servicemark','100','2014-02-12 14:06:43',NULL,3,0,1),(259,2006,'Copyrights','','','59','True or False: You cannot sue without first registering your copyright.','100','2014-02-12 14:06:43',NULL,8,0,1),(258,2006,'Trade Secrets','','','58','Which of the following is an example of a potential trade secret? Production Method, Customer List, Business Plan or All of the Above','100','2014-02-12 14:06:43',NULL,3,0,1),(257,2006,'Patents','','','57','Which of the following questions should be considered before filing a patent for an invention? Is It Patentable?, Is It Technically Feasible?, Is It Commercially Interesting? or All of the Above','100','2014-02-12 14:06:43',NULL,3,0,1),(256,2005,'Customer Interviews','','','56','Which of the following best practices apply to customer interviews:','100','2014-02-12 14:06:43',NULL,3,0,1),(255,2005,'Customer Development','','','55','Which of the following is not a step in the customer development process? Discovery, Validation, Attribution or Creation','100','2014-02-12 14:06:43',NULL,3,0,1),(254,2005,'Pitch Deck','','','54','Which of the following is NOT part of a good pitch deck? Team, Solution, Resume or Problem','100','2014-02-12 14:06:43',NULL,3,0,1),(253,2005,'Elevator Pitch','','','53','True or False: An elevator pitch should include a story of the problem, your solution, how you\'re different and the ask.','100','2014-02-12 14:06:43',NULL,8,0,1),(252,2005,'Disciplined Entrepreneurship','','','52','True or False: The Disciplined Entrepreneurship framework emphasizes the idea over the process.','100','2014-02-12 14:06:43',NULL,8,0,1),(251,2005,'Idea','','','51','True or False: Many of the best ideas come from the founder\'s own problems.','100','2014-02-12 14:06:43',NULL,8,0,1),(249,2005,'Lean Startup','','','49','True or False: The MVP is the first fully functioning version of your product.','100','2014-02-12 14:06:43',NULL,8,0,1),(250,2005,'Timing','','','50','Which of the following circumstances is NOT a factor for deciding when to start a business? Career, Market, Personal or Age','100','2014-02-12 14:06:43',NULL,3,0,1),(248,2005,'Business Model Canvas','','','48','Which of the following is NOT a building block of the business model canvas? Value Proposition, Key Employees, Key Partners or Revenue Streams','100','2014-02-12 14:06:43',NULL,3,0,1),(246,2004,'Firing','','','46','When firing an employee for poor performance, you should discuss:','100','2014-02-12 14:06:43',NULL,3,0,1),(303,2000,'NAICS Codes','','','103','The NAICS system classifies North American businesses by which of the following characteristics?','100','2014-03-04 10:41:27',NULL,3,0,1),(247,2005,'Business Model','','','47','True or False: A business model evaluates the uniqueness of your idea.','100','2014-02-12 14:06:43',NULL,8,0,1),(245,2004,'Splitting Founder Equity','','','45','True or False: Most founders should split equity at the beginning of a startup.','100','2014-02-12 14:06:43',NULL,8,0,1),(244,2004,'Founding with Friends','','','44','True or False: Teams founded by friends are less likely to stay intact over time.','100','2014-02-12 14:06:43',NULL,8,0,1),(243,2004,'Finding a Co-Founder','','','43','What percent of innovation startups have at least 2 co-founders? 24%, 45%, 65% or 84%','100','2014-02-12 14:06:43',NULL,3,0,1),(242,2004,'Interviewing','','','42','Which of the following is NOT a best practice for conducting interviews? Listen, Omit Critical Information, Be Prepared or Be Transparent','100','2014-02-12 14:06:43',NULL,3,0,1),(239,2004,'Team Failure','','','39','What percent of startups fail due to people problems? 15%, 37%, 65% or 82%','100','2014-02-12 14:06:43',NULL,3,0,1),(240,2004,'Personnel Evaluation','','','40','A 360 feedback personnel evaluation may include feedback from which of the following parties? Peers, Supervisor, Subordinates or All of the Above','100','2014-02-12 14:06:43',NULL,3,0,1),(241,2004,'Mentors','','','41','True or False: Well-known entrepreneurs make the best mentors.','100','2014-02-12 14:06:43',NULL,8,0,1),(238,2003,'Valuation Methods','','','38','True or False: The Discounted Cash Flow (DCF) method of valuing a startup looks at comparable companies that recently got funded.','100','2014-02-12 14:06:43',NULL,8,0,1),(236,2003,'Crowdfunding','','','36','Which of the following is the newest model of crowdfunding? Reward, Equity, Donation or Pre-Order','100','2014-02-12 14:06:43',NULL,3,0,1),(237,2003,'Options Pool','','','37','An options pool is created to incentivize future:','100','2014-02-12 14:06:43',NULL,3,0,1),(235,2003,'Venture Capitalists & Angel Investors','','','35','True or False: Angel investors invest other peoples\' money.','100','2014-02-12 14:06:43',NULL,8,0,1),(233,2003,'Vesting','','','33','True or False: Vesting is always based on time.','100','2014-02-12 14:06:43',NULL,8,0,1),(234,2003,'Convertible Note','','','34','Which of the following is NOT a benefit of a convertible note? Requires Less Paperwork, Entrepreneur Does Not Lose Control, Investor Gets a Discount on Future Stock or Company Gets More Money','100','2014-02-12 14:06:43',NULL,3,0,1),(231,2003,'Valuation','','','31','If the pre-money valuation is $6,000,000, what is the post-money valuation following the company\'s $4,000,000 investment? $2,000,000 / $6,000,000 / $10,000,000 / $12,000,000','100','2014-02-12 14:06:43',NULL,3,0,1),(232,2003,'Term Sheet','','','32','True or False: Term sheets are not legally binding.','100','2014-02-12 14:06:43',NULL,8,0,1),(229,2003,'Anti-Dilution','','','29','Which of the following is NOT one of the types of anti-dilution protection? Narrow-Based Weighted Average, Ratchet, Broad-Based Weighted Average or Cliff','100','2014-02-12 14:06:43',NULL,3,0,1),(230,2003,'Capitalization Table','','','30','True or False: The cap table is a ledger of who owns what in a startup.','100','2014-02-12 14:06:43',NULL,8,0,1),(228,2003,'Debt & Equity Financing','','','28','Which of the following is a disadvantage of equity financing? Covenants, Interest Payments, Ownership Dilution or Flexibility','100','2014-02-12 14:06:43',NULL,3,0,1),(227,2002,'Mergers & Acquisitions (M&A)','','','27','True or False: An acquisition occurs when two companies combine into a new company.','100','2014-02-12 14:06:43',NULL,8,0,1),(226,2002,'Burn Rate','','','26','Burn rate is typically calculated per:','100','2014-02-12 14:06:43',NULL,3,0,1),(224,2002,'Time Value of Money','','','24','True or False: The time value of money is a concept that states the value of money increases over time.','100','2014-02-12 14:06:43',NULL,8,0,1),(225,2002,'Return on Investment (ROI)','','','25','If you invest $100 and receive back $500, what is your ROI? 100%, 400%, 500% or 600%','100','2014-02-12 14:06:43',NULL,3,0,1),(223,2002,'Fixed & Variable Costs','','','23','True or False: Average fixed cost increases with output.','100','2014-02-12 14:06:43',NULL,8,0,1),(222,2002,'Break-Even Point','','','22','True or False: You cannot achieve profitability without first reaching the break-even point.','100','2014-02-12 14:06:43',NULL,8,0,1),(221,2002,'Balance Sheet','','','21','Which of the following is NOT one of the sections of a balance sheet? Assets, Income, Liabilities or Equity','100','2014-02-12 14:06:43',NULL,3,0,1),(220,2002,'Pro-Forma Financial Statements','','','20','True or False: Pro-forma financial statements are forward-looking projections.','100','2014-02-12 14:06:43',NULL,8,0,1),(219,2002,'Cash Flow Statement','','','19','Which section of the cash flow statement shows cash inflows from sales? Financing, Operations, Investing or Marketing','100','2014-02-12 14:06:43',NULL,3,0,1),(218,2002,'Income Statement','','','18','True or False: An income statement shows a company\'s profit or loss over a specific time period.','100','2014-02-12 14:06:43',NULL,8,0,1),(216,2001,'Search Engine Marketing (SEM)','','','16','True or False: Search Engine Marketing (SEM) is also known as Search Engine Optimization (SEO).','100','2014-02-12 14:06:43',NULL,8,0,1),(217,2001,'Website','','','17','Which of the following website design elements can easily damage user experience? Complex Copy, Buttons, White Space or Calls To Action','100','2014-02-12 14:06:43',NULL,3,0,1),(215,2001,'Web Analytics','','','15','Which of the following information about your website visitors is detected by JavaScript? Visitor Age, Visiting History, Visitor Name or All of the Above','100','2014-02-12 14:06:43',NULL,3,0,1),(214,2001,'Search Engine Optimization (SEO)','','','14','Which of the following is an ingredient of search engine algorithms? Reputation, Links, Words or All of the Above','100','2014-02-12 14:06:43',NULL,3,0,1),(213,2001,'Social Media Marketing','','','13','True or False: Social media marketing should be focused on a limited number of channels.','100','2014-02-12 14:06:43',NULL,8,0,1),(210,2001,'Landing Page','','','10','True or False: Landing pages are only used for search engine marketing.','100','2014-02-12 14:06:43',NULL,8,0,1),(211,2001,'Email Marketing','','','11','True or False: The best time to send email is Friday morning.','100','2014-02-12 14:06:43',NULL,8,0,1),(212,2001,'A/B Testing','','','12','A/B tests may include website variations in which of the following areas:','100','2014-02-12 14:06:43',NULL,3,0,1),(209,2001,'Content Marketing','','','9','Which of the following is NOT a common tool used in content marketing? Direct Mail, Blogs, Videos or Infographics','100','2014-02-12 14:06:43',NULL,3,0,1),(208,2001,'Domain Name','','','8','Which of the following should be considered when choosing a domain name? Keyword, Extension, Spelling or All of the Above','100','2014-02-12 14:06:43',NULL,3,0,1),(207,2000,'Contact Management System','','','7','True or False: An email marketing system is an example of a contact management system.','100','2014-02-12 14:06:43',NULL,8,0,1),(206,2000,'Business Records','','','6','Which of the following is a justification for keeping careful business records? Financial Management, Performance Evaluation, Tax Filing or All of the Above','100','2014-02-12 14:06:43',NULL,3,0,1),(204,2000,'Document Management System','','','4','Which of the following is a benefit of storing files on a cloud service such as Google Drive? Access, Collaboration, Data Backup or All of the Above','100','2014-02-12 14:06:43',NULL,3,0,1),(205,2000,'Business Insurance','','','5','Which of the following is NOT a type of liability insurance? Errors & Omissions, General, Product or Financial','100','2014-02-12 14:06:43',NULL,3,0,1),(203,2000,'Business Cards','','','3','True or False: Business cards should include as much information as you can fit.','100','2014-02-12 14:06:43',NULL,8,0,1),(202,2000,'Corporate Tax Filing','','','2','True or False: LLC owners in the US have the option to be taxed as an individual or corporation.','100','2014-02-12 14:06:43',NULL,8,0,1),(201,2000,'Payroll Taxes','','','1','Which of the following is NOT an employer payroll tax in the US? Social Security, Unemployment, Medicare or Property','100','2014-02-12 14:06:43',NULL,3,0,1),(272,2007,'Investor Reporting','','','72','True or False: A monthly or quarterly investor report should not include bad news.','100','2014-02-12 14:06:43',NULL,8,0,1),(273,2007,'Board of Directors','','','73','How many board members should an early stage company have? 1, 3 to 5, 7 to 10 or 12 to 15','100','2014-02-12 14:06:43',NULL,3,0,1),(274,2007,'Meetings','','','74','True or False: Long meetings are more productive than short meetings.','100','2014-02-12 14:06:43',NULL,8,0,1),(275,2007,'Board Meetings','','','75','True or False: Board members should only receive reports during the board meeting.','100','2014-02-12 14:06:43',NULL,8,0,1),(276,2007,'Negotiation','','','76','True or False: BATNA stands for Best Alternative To a Negotiated Agreement.','100','2014-02-12 14:06:43',NULL,8,0,1),(277,2007,'Exit Strategy','','','77','Which of the following events is the least common exit for a company? Acquisition, Initial Public Offering (IPO), Bankruptcy or Private Placement','100','2014-02-12 14:06:43',NULL,3,0,1),(278,2007,'Strategic Planning','','','78','Which of the following is NOT part of the strategic planning process? SWOT, Mission, ROI or Vision','100','2014-02-12 14:06:43',NULL,3,0,1),(279,2007,'Project Management','','','79','Which of the following is a key consideration of startup project management? Risks, Precedence, Time or All of the Above','100','2014-02-12 14:06:43',NULL,3,0,1),(280,2007,'Partnerships','','','80','Which of the following is NOT a potential benefit of partnerships? Access to New Markets, Speed to Market, IP Infringement or Capital Efficiency','100','2014-02-12 14:06:43',NULL,3,0,1),(281,2008,'Personal Brand','','','81','Which of the following is NOT a necessary component of personal brand? Personal Style, Fame, Authority or Online Identity','100','2014-02-12 14:06:43',NULL,3,0,1),(282,2008,'Customer Lifetime Value (LTV)','','','82','If your LTV is $1,000 and your cost to acquire a customer is $100, what is your gross margin per customer? $100, $900, $1000 or $1100','100','2014-02-12 14:06:43',NULL,3,0,1),(283,2008,'Competitive Analysis','','','83','True or False: Innovative startups tend to have zero competitors.','100','2014-02-12 14:06:43',NULL,8,0,1),(284,2008,'Public Relations (PR)','','','84','True or False: Media should be contacted for every company milestone.','100','2014-02-12 14:06:43',NULL,8,0,1),(285,2008,'Branding','','','85','Your brand is your:','100','2014-02-12 14:06:43',NULL,3,0,1),(286,2008,'Total Addressable Market (TAM)','','','86','What is the most common measurement of TAM? Potential Customers, Potential Units, Potential Revenue or Potential Profit','100','2014-02-12 14:06:43',NULL,3,0,1),(287,2008,'Cost of Customer Acquisition (COCA)','','','87','True or False: COCA measures the expenses you incur to generate each lead.','100','2014-02-12 14:06:43',NULL,8,0,1),(288,2008,'Customer Persona','','','88','True or False: Customer personas are also known as your target market.','100','2014-02-12 14:06:43',NULL,8,0,1),(289,2008,'Market Research','','','89','Which of the following tools is a component of market research? Customer Surveys, Research Reports, Competitive Analysis or All of the Above','100','2014-02-12 14:06:43',NULL,3,0,1),(290,2008,'Logo','','','90','Which of the following characteristics influence your logo\'s emotional impact? Shape, Color Palette, Font or All of the Above','100','2014-02-12 14:06:43',NULL,3,0,1),(291,2008,'Mission Statement','','','91','Which of the following principles do NOT apply to a good mission statement? Simple Language, Explains Purpose, Uses Buzzwords or Short Length','100','2014-02-12 14:06:43',NULL,3,0,1),(292,2009,'Design Thinking','','','92','Which of the following stages is NOT part of the design thinking process? Rapid Prototyping, Selling, Idea or Observation','100','2014-02-12 14:06:43',NULL,3,0,1),(293,2009,'Product Design Sprint','','','93','What is the final step in a product design sprint? Diverge, Validate, Prototype or Understand','100','2014-02-12 14:06:43',NULL,3,0,1),(294,2009,'Wireframes','','','94','What type of wireframe is a rough and quick sketch? Low-End, High-End, Low-Fidelity, High-Fidelity','100','2014-02-12 14:06:43',NULL,3,0,1),(295,2009,'Pricing','','','95','Which of the following is NOT a pricing strategy? Voice of the Customer, Cost Plus, Volume or Yield Management','100','2014-02-12 14:06:43',NULL,3,0,1),(296,2009,'Distribution','','','96','True or False: Your website is an example of an indirect distribution channel.','100','2014-02-12 14:06:43',NULL,8,0,1),(297,2010,'Sales Model','','','97','What stage begins the sales model cycle? Analysis, Targeting, Pitching or Qualifying','100','2014-02-12 14:06:43',NULL,3,0,1),(298,2010,'Sales Conversation','','','98','True or False: A purpose benefit check is also known as an agenda.','100','2014-02-12 14:06:43',NULL,8,0,1),(299,2010,'Closing','','','99','Which of the following is a strategy for handling sales objections? Questions, Reassurance, Flattery or All of the Above','100','2014-02-12 14:06:43',NULL,3,0,1),(300,2010,'Storytelling','','','100','Which of the following is the most powerful category of a startup story? Success, Failure, Fun or Legends','100','2014-02-12 14:06:43',NULL,3,0,1),(301,2010,'Sales Presentation','','','101','Which of the following is NOT an element of a good sales presentation:','100','2014-02-12 14:06:43',NULL,3,0,1),(144,1,'Stage','','','','What stage is your business?','What stage business are you interested in?','2014-04-03 04:56:55',NULL,6,0,1),(302,2000,'Business Licenses','','','102','Which of the following criteria determines the required business licenses?','100','2014-03-04 10:41:27',NULL,3,0,1),(304,2002,'GAAP','','','104','Generally Accepted Accounting Principles (GAAP) affect the preparation of: ','100','2014-03-04 10:41:27',NULL,3,0,1),(305,2002,'Financial Statements','','','105','How many documents compose a company\'s financial statements?','100','2014-03-04 10:41:27',NULL,3,0,1),(306,2002,'Run Rate','','','106','If a company generated revenues of $100 million in its most recent quarter, what is its annual run rate?','100','2014-03-04 10:41:27',NULL,3,0,1),(307,2002,'Ratios','','','107','Which of the following is a common type of financial ratio?','100','2014-03-04 10:41:27',NULL,3,0,1),(308,2003,'Preferred Stock','','','108','Which of the following is an example of preferred stock?','100','2014-03-04 10:41:27',NULL,3,0,1),(309,2005,'WOW Statement','','','109','What is the maximum length of a great WOW statement?','100','2014-03-04 10:41:27',NULL,3,0,1),(310,2005,'Public Speaking','','','110','True or False: If you make a small mistake while speaking, apologize and move on.','100','2014-03-04 10:41:27',NULL,8,0,1),(311,2005,'Product Launch','','','111','True or False: Your product launch should focus on paid media.','100','2014-03-04 10:41:27',NULL,8,0,1),(312,2006,'Prior Art','','','112','True or False: Prior art can be public or privately available information.','100','2014-03-04 10:41:27',NULL,8,0,1),(313,2006,'Fair Use','','','113','True or False: Fair use of copyrighted material is more likely to be approved for educational or socially beneficial purposes.','100','2014-03-04 10:41:27',NULL,8,0,1),(314,2006,'Due Diligence','','','114','True or False: Due diligence often refers to the process of an acquirer evaluating a business.','100','2014-03-04 10:41:27',NULL,8,0,1),(315,2006,'Intellectual Property Overview','','','115','True or False: Patents are the primary form of intellectual property (IP).','100','2014-03-04 10:41:27',NULL,8,0,1),(316,2006,'IP Infringement','','','116','What is one way to avoid IP infringement at the beginning of a project? ','100','2014-03-04 10:41:27',NULL,3,0,1),(317,2006,'IP Licensing','','','117','True or False: IP licenses last for 7 years from the date of first use.','100','2014-03-04 10:41:27',NULL,8,0,1),(318,2007,'Networking','','','118','Networking should be about which of the following?','100','2014-03-04 10:41:27',NULL,3,0,1),(319,2007,'Objectives and Key Results (OKRs)','','','119','True or False: Objectives can be unique for different units of the business.','100','2014-03-04 10:41:27',NULL,8,0,1),(320,2007,'Corporate Social Responsibility (CSR)','','','120','What is the strongest argument for CSR?','100','2014-03-04 10:41:27',NULL,3,0,1),(321,2008,'Value Chain','','','121','What is the most important resource in a value chain?','100','2014-03-04 10:41:27',NULL,3,0,1),(322,2008,'Gamification','','','122','True or False: Gamification refers to incorporating games into marketing.','100','2014-03-04 10:41:27',NULL,8,0,1),(323,2009,'Supply Chain Management','','','123','True or False: Supply chains are only relevant to physical product companies.','100','2014-03-04 10:41:27',NULL,8,0,1),(324,2009,'Logistics','','','124','True or False: Logistics managers are exclusively concerned with transportation.','100','2014-03-04 10:41:27',NULL,8,0,1),(325,2009,'Inventory','','','125','Which of the following is NOT an inventory management technique?','100','2014-03-04 10:41:27',NULL,3,0,1),(326,2009,'User Experience Testing','','','126','What is the minimum sample size for reliable user experience testing?','100','2014-03-04 10:41:27',NULL,3,0,1),(327,2010,'AIDA Model','','','127','What does AIDA stand for?','100','2014-03-04 10:41:27',NULL,3,0,1),(143,1,'Companies','','','','What companies would you like mentors from?','What companies have you worked for?','2014-04-03 04:52:56',NULL,2,0,1),(142,1,'Industry Years','','','','','How many years did you work in that industry?','2014-04-03 04:52:50',NULL,2,0,1),(145,1,'Capital','','','','How much capital have you raised?','How much capital should a business have raised for you to be interested?','2014-04-03 04:57:06',NULL,6,0,1),(147,1,'Profile Photo',NULL,NULL,NULL,'Profile Photo','File type: PNG, JPEG, JPG, BMP<br>Recommended resolution: 640x360 or 1.75:1',NULL,NULL,11,0,1),(148,1,'Idea Video',NULL,NULL,NULL,'<i><small>Tip: Videos significantly increase the probability of getting funded. Tell your story and make it fun!</small></i>','Paste a YouTube URL.',NULL,NULL,2,0,1),(146,1,'Seeking',NULL,NULL,NULL,'Seeking','Which experts are you are seeking for your team?',NULL,NULL,3,0,1),(149,1,'Summary',NULL,NULL,NULL,'&nbsp;','Share 3-5 sentences about your background, values and accomplishments',NULL,NULL,1,0,1),(150,1,'Idea',NULL,NULL,NULL,'Add Idea Section To Your Profile So You Can Raise Money?<br><i><small>Creating an Idea section will allow you to start crowdfunding.</small></i> ',NULL,NULL,NULL,8,0,1),(151,1,'Idea Summary',NULL,NULL,NULL,'<small><i>Tip: This is your elevator pitch. Consider comparing your idea to something familiar, e.g. \"Yelp for health food.\"</i></small>','Describe your idea in 140 characters or less',NULL,NULL,1,0,1),(152,1,'Idea Industry',NULL,NULL,NULL,'Industry',NULL,NULL,NULL,6,0,1),(153,1,'Idea Focus',NULL,NULL,NULL,'Focus',NULL,NULL,NULL,6,0,1),(154,1,'Idea Photo',NULL,NULL,NULL,'Idea Photo<br><i><small>Tip: Good visual aids can be pictures, designs or screen shots</small></i>','File type: PNG, JPEG, JPG, BMP<br>Recommended resolution: 640x360 or 1.75:1',NULL,NULL,11,0,1),(155,1,'Idea Description',NULL,NULL,NULL,'<i><small>Tip: People want to know things like what problem you are solving, how you came up with the idea, why you care about it, what you need help with and how you plan to use the funding.</i></small>','Provide a detailed description of your idea so people can understand your vision.',NULL,NULL,1,0,1),(156,1,'Experience','','','','What companies have you worked for?','','2014-10-05 15:37:44',NULL,2,0,1),(157,1,'Specialty',NULL,NULL,NULL,'Specialty','What is your specialty?','2014-10-08 13:29:28',NULL,7,0,1),(160,1,'Social Presence',NULL,NULL,NULL,'Tip: People are more likely to connect with you when they can visit your social pages and get to know you first.',NULL,NULL,NULL,2,0,1),(161,1,'Twitter',NULL,NULL,NULL,'Twitter <small>Tip: People are more likely to fund you when they can follow your twitter and get to know you more.</i></small>',NULL,NULL,NULL,2,0,1);
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_status`
--

DROP TABLE IF EXISTS `question_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_status` (
  `question_status_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_status_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`question_status_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_status`
--

LOCK TABLES `question_status` WRITE;
/*!40000 ALTER TABLE `question_status` DISABLE KEYS */;
INSERT INTO `question_status` VALUES (1,'Required'),(2,'Optional'),(3,'Disabled - Permanent'),(4,'Disabled - Temporary');
/*!40000 ALTER TABLE `question_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_type`
--

DROP TABLE IF EXISTS `question_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_type` (
  `question_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`question_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_type`
--

LOCK TABLES `question_type` WRITE;
/*!40000 ALTER TABLE `question_type` DISABLE KEYS */;
INSERT INTO `question_type` VALUES (1,'Text-Long'),(2,'Text-Short'),(3,'Multi-Choice ID SORT'),(4,'Multi-Select ID SORT'),(5,'Likert Scale'),(6,'Multi-Choice ALPHA SORT'),(7,'Multi-Select ALPHA SORT'),(8,'True/False'),(11,'Image-Video-Uploader'),(9,'Multi-Select OptGroup'),(10,'Multi-Select Selected-Disabled');
/*!40000 ALTER TABLE `question_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stripe_connect`
--

DROP TABLE IF EXISTS `stripe_connect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stripe_connect` (
  `stripe_connect_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `stripe_token_data` text,
  `stripe_connect_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`stripe_connect_id`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stripe_connect`
--

LOCK TABLES `stripe_connect` WRITE;
/*!40000 ALTER TABLE `stripe_connect` DISABLE KEYS */;
/*!40000 ALTER TABLE `stripe_connect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stripe_customers`
--

DROP TABLE IF EXISTS `stripe_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stripe_customers` (
  `stripe_customers_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` varchar(150) DEFAULT NULL,
  `account_funder_social_id` varchar(200) DEFAULT NULL,
  `stripe_customers_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`stripe_customers_id`)
) ENGINE=MyISAM AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stripe_customers`
--

LOCK TABLES `stripe_customers` WRITE;
/*!40000 ALTER TABLE `stripe_customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `stripe_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriber`
--

DROP TABLE IF EXISTS `subscriber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscriber` (
  `subscriber_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `subscriber_email` varchar(255) DEFAULT NULL,
  `subscriber_status` int(11) DEFAULT NULL,
  `subscriber_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`subscriber_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriber`
--

LOCK TABLES `subscriber` WRITE;
/*!40000 ALTER TABLE `subscriber` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriber` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_update`
--

DROP TABLE IF EXISTS `user_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_update` (
  `user_update_id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) DEFAULT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  `user_update_title` varchar(255) NOT NULL,
  `user_update_text` text,
  `user_update_public` int(11) DEFAULT NULL,
  `user_update_sendemail` int(11) DEFAULT NULL,
  `user_update_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`user_update_id`)
) ENGINE=MyISAM AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_update`
--

LOCK TABLES `user_update` WRITE;
/*!40000 ALTER TABLE `user_update` DISABLE KEYS */;
INSERT INTO `user_update` VALUES (28,2129,0,'test post','',1,1,'2014-12-15 18:01:53'),(30,2129,0,'landing page campaign completed!','',1,1,'2014-12-16 03:49:03'),(32,2129,0,'Support is growing. Domain procured.','',1,1,'2014-12-18 01:44:47');
/*!40000 ALTER TABLE `user_update` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-01  2:08:09
