/*M!999999\- enable the sandbox mode */
-- MariaDB dump 10.19-11.4.3-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: gcm_db
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `application_authorities`
--

DROP TABLE IF EXISTS `application_authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_authorities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `application_users`
--

DROP TABLE IF EXISTS `application_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_users` (
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `country_code` int DEFAULT NULL,
  `national_number` bigint DEFAULT NULL,
  `salary` double DEFAULT NULL,
  `id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK6xc3ghufqlb29rqn7pv3pd7en` FOREIGN KEY (`id`) REFERENCES `users` (`id`),
  CONSTRAINT `non_negative_salary_check` CHECK ((`salary` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bearer_tokens`
--

DROP TABLE IF EXISTS `bearer_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bearer_tokens` (
  `id` binary(16) NOT NULL,
  `expires_at` datetime(6) NOT NULL,
  `token` varchar(512) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bearer_token_token_unique_constraint` (`token`),
  KEY `FK9mhvlifv1xfa89oi4yqvensg8` (`user_id`),
  CONSTRAINT `FK9mhvlifv1xfa89oi4yqvensg8` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_companies`
--

DROP TABLE IF EXISTS `client_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_companies` (
  `id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK6byb7j6fgt41x4mtlvtrdt422` FOREIGN KEY (`id`) REFERENCES `companies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_contracts`
--

DROP TABLE IF EXISTS `client_contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_contracts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `modified_date` datetime(6) DEFAULT NULL,
  `cost` decimal(38,2) NOT NULL,
  `end_date` date NOT NULL,
  `start_date` date NOT NULL,
  `company_id` int NOT NULL,
  `project_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKt5pwoacf1n4veldvjikxjwsf1` (`company_id`),
  KEY `FKpdq7bjce5mlyh0iq9im8xm2gv` (`project_id`),
  CONSTRAINT `FKpdq7bjce5mlyh0iq9im8xm2gv` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`),
  CONSTRAINT `FKt5pwoacf1n4veldvjikxjwsf1` FOREIGN KEY (`company_id`) REFERENCES `client_companies` (`id`),
  CONSTRAINT `cost_positive_check_constraint` CHECK ((`cost` > 0.0))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_contracts_images`
--

DROP TABLE IF EXISTS `client_contracts_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_contracts_images` (
  `id` binary(16) NOT NULL,
  `basename` varchar(255) NOT NULL,
  `content_type` varchar(255) NOT NULL,
  `extension` varchar(255) NOT NULL,
  `size` bigint NOT NULL,
  `upload_date` datetime(6) NOT NULL,
  `contract_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK8lprwhgrma25cs4l7fwoahqot` (`contract_id`),
  CONSTRAINT `FKd3ws4wtes3jderh6x2srjglxh` FOREIGN KEY (`contract_id`) REFERENCES `client_contracts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_users`
--

DROP TABLE IF EXISTS `client_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_users` (
  `id` bigint NOT NULL,
  `company_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKssfisboq3hhahrivwnrk2jviu` (`company_id`),
  CONSTRAINT `FK47x42ajmqydb8ucmr9eu1tqly` FOREIGN KEY (`id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKssfisboq3hhahrivwnrk2jviu` FOREIGN KEY (`company_id`) REFERENCES `client_companies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `modified_date` datetime(6) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fax_number` varchar(255) DEFAULT NULL,
  `head_email` varchar(255) DEFAULT NULL,
  `head_full_name` varchar(255) DEFAULT NULL,
  `country_code` int DEFAULT NULL,
  `national_number` bigint DEFAULT NULL,
  `industry` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `status` enum('ACTIVE','CLOSED','INACTIVE') NOT NULL,
  `type` enum('CLIENT','SUBCONTRACTOR') NOT NULL,
  `website` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `companies_branchs`
--

DROP TABLE IF EXISTS `companies_branchs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies_branchs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `country_code` int DEFAULT NULL,
  `national_number` bigint DEFAULT NULL,
  `company_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK528ktpprw6ohr4vi04rmmuvcq` (`company_id`),
  CONSTRAINT `FK528ktpprw6ohr4vi04rmmuvcq` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `companies_logos`
--

DROP TABLE IF EXISTS `companies_logos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies_logos` (
  `id` binary(16) NOT NULL,
  `basename` varchar(255) NOT NULL,
  `content_type` varchar(255) NOT NULL,
  `extension` varchar(255) NOT NULL,
  `size` bigint NOT NULL,
  `upload_date` datetime(6) NOT NULL,
  `company_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKir4vr3r8f9m1ohtnsh9x6p4k8` (`company_id`),
  CONSTRAINT `FKomlacl10qoiq0k39a3pdugx3` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `containers`
--

DROP TABLE IF EXISTS `containers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `containers` (
  `id` int NOT NULL,
  `created_date` datetime(6) NOT NULL,
  `modified_date` datetime(6) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `status` enum('AVAILABLE','MAINTENANCE','UNAVAILABLE') NOT NULL,
  `volume_unit` enum('CUBIC_METERS','GALLONS','LITERS') NOT NULL,
  `volume_value` double NOT NULL,
  `waste_type` enum('ASBESTOS','ASPHALT','BATTERIES','CARDBOARD','CONCRETE','CONCRETE_WASH_WATER','CONTAMINATED_MATERIAL','CONTAMINATED_SOIL','EXCAVATED_MATERIAL','FOOD_WASTE','GENERAL_WASTE','GLASS','HAZARDOUS_ELECTRONIC','MEDICAL','METAL_STEEL','NON_HAZARDOUS_ELECTRONIC','OILS_FUELS_OILY_WATER','OTHER','PAPER','PLASTIC','RAGS_DRUMS_FILTERS','SEWAGE','TIRES','WOOD') NOT NULL,
  `weight_unit` enum('KILOGRAMS','POUNDS') NOT NULL,
  `weight_value` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `modified_date` datetime(6) DEFAULT NULL,
  `end_date` date NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `name` varchar(255) NOT NULL,
  `remain_cost` decimal(38,2) NOT NULL,
  `start_date` date NOT NULL,
  `status` enum('CLOSED','OPEN','PENDING') NOT NULL,
  `total_cost` decimal(38,2) NOT NULL,
  `created_by_id` bigint NOT NULL,
  `modified_by_id` bigint DEFAULT NULL,
  `company_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_project_name_unique_constraint` (`name`,`company_id`),
  KEY `fk_created_by_base_user` (`created_by_id`),
  KEY `fk_last_modified_by_base_user` (`modified_by_id`),
  KEY `fk_project_client_company` (`company_id`),
  CONSTRAINT `fk_created_by_base_user` FOREIGN KEY (`created_by_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_last_modified_by_base_user` FOREIGN KEY (`modified_by_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_project_client_company` FOREIGN KEY (`company_id`) REFERENCES `client_companies` (`id`),
  CONSTRAINT `remain_cost_non_negative_check_constraint` CHECK ((`remain_cost` >= 0.0)),
  CONSTRAINT `total_cost_non_negative_check_constraint` CHECK ((`total_cost` >= 0.0))
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reset_password_tokens`
--

DROP TABLE IF EXISTS `reset_password_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reset_password_tokens` (
  `id` binary(16) NOT NULL,
  `code` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `expires_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_code_unique_constraint` (`code`),
  UNIQUE KEY `token_user_unique_constraint` (`user_id`),
  CONSTRAINT `FKnwk79win0k7k6tlb6imjninfu` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subcontractor_companies`
--

DROP TABLE IF EXISTS `subcontractor_companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subcontractor_companies` (
  `id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK42166u7itjkewyd4i2wf93l5h` FOREIGN KEY (`id`) REFERENCES `companies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trucks`
--

DROP TABLE IF EXISTS `trucks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trucks` (
  `volume_unit` enum('CUBIC_METERS','GALLONS','LITERS') NOT NULL,
  `volume_value` double NOT NULL,
  `id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FKjh6ghnjn1yc09ti1qnf2mn9en` FOREIGN KEY (`id`) REFERENCES `vehicles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `modified_date` datetime(6) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `gender` enum('FEMALE','MALE') NOT NULL,
  `locked` bit(1) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('APPLICATION_USER','BASE_USER','CLIENT_USER') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_email_unique_constraint` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_authorities`
--

DROP TABLE IF EXISTS `users_authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_authorities` (
  `users_id` bigint NOT NULL,
  `authorities_id` int NOT NULL,
  PRIMARY KEY (`users_id`,`authorities_id`),
  KEY `FKjln5gro4k7os7syyllqax3fv4` (`authorities_id`),
  CONSTRAINT `FK2cmfwo8tbjcpmltse0rh5ir0t` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKjln5gro4k7os7syyllqax3fv4` FOREIGN KEY (`authorities_id`) REFERENCES `application_authorities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users_pictures`
--

DROP TABLE IF EXISTS `users_pictures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_pictures` (
  `id` binary(16) NOT NULL,
  `basename` varchar(255) NOT NULL,
  `content_type` varchar(255) NOT NULL,
  `extension` varchar(255) NOT NULL,
  `size` bigint NOT NULL,
  `upload_date` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKng395i5mu5kjsggv918c206ls` (`user_id`),
  CONSTRAINT `FKqrh5tqdre4a8t5pnr9pqtfjaw` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_date` datetime(6) NOT NULL,
  `modified_date` datetime(6) DEFAULT NULL,
  `licence_plate` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` enum('AVAILABLE','MAINTENANCE','UNAVAILABLE') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vehicle_licence_plate_unique_constraint` (`licence_plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2024-09-13 21:44:47
