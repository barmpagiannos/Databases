-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: cityopsdb
-- ------------------------------------------------------
-- Server version	8.0.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `action`
--

DROP TABLE IF EXISTS `action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `action` (
  `ActionID` varchar(10) NOT NULL,
  `ActionDate` datetime NOT NULL,
  `Cost` decimal(10,2) DEFAULT '0.00',
  `Comments` varchar(500) DEFAULT NULL,
  `IncidentID` varchar(10) NOT NULL,
  `EmployeeID` varchar(10) NOT NULL,
  `ActionTypeID` varchar(10) NOT NULL,
  PRIMARY KEY (`ActionID`),
  KEY `IncidentID` (`IncidentID`),
  KEY `EmployeeID` (`EmployeeID`),
  KEY `ActionTypeID` (`ActionTypeID`),
  CONSTRAINT `action_ibfk_1` FOREIGN KEY (`IncidentID`) REFERENCES `incident` (`IncidentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `action_ibfk_2` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `action_ibfk_3` FOREIGN KEY (`ActionTypeID`) REFERENCES `actiontype` (`ActionTypeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `action`
--

LOCK TABLES `action` WRITE;
/*!40000 ALTER TABLE `action` DISABLE KEYS */;
INSERT INTO `action` VALUES ('LOG001','2025-08-31 10:00:00',0.00,'Έλεγχος στο πεζοδρόμιο','AAAA000001','AAAA000003','ACT003'),('LOG002','2025-09-01 12:00:00',150.00,'Αγορά πλακών πεζοδρομίου','AAAA000001','AAAA000001','ACT001'),('LOG003','2025-09-02 09:30:00',0.00,'Τοποθέτηση πλακών','AAAA000001','AAAA000002','ACT002'),('LOG004','2025-09-04 12:00:00',331.00,'Επισκευή Τσουλήθρας','AAAA000002','AAAA000002','ACT002'),('LOG005','2025-09-04 13:00:00',0.00,'Εργασίες Καθαριότητας','AAAA000003','AAAA000004','ACT005');
/*!40000 ALTER TABLE `action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `action_details_view`
--

DROP TABLE IF EXISTS `action_details_view`;
/*!50001 DROP VIEW IF EXISTS `action_details_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `action_details_view` AS SELECT 
 1 AS `IncidentID`,
 1 AS `ActionID`,
 1 AS `ActionDate`,
 1 AS `Cost`,
 1 AS `ActionComments`,
 1 AS `IncidentDescription`,
 1 AS `EmployeeID`,
 1 AS `EmployeeLastName`,
 1 AS `EmployeeEmail`,
 1 AS `DepartmentName`,
 1 AS `ActionType`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `actiontype`
--

DROP TABLE IF EXISTS `actiontype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actiontype` (
  `ActionTypeID` varchar(10) NOT NULL,
  `ActionName` varchar(50) NOT NULL,
  `Description` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ActionTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actiontype`
--

LOCK TABLES `actiontype` WRITE;
/*!40000 ALTER TABLE `actiontype` DISABLE KEYS */;
INSERT INTO `actiontype` VALUES ('ACT001','Προμήθεια','Αγορά υλικών και ανταλλακτικών'),('ACT002','Επισκευή','Επιτόπια εργασία αποκατάστασης'),('ACT003','Έλεγχος','Επίσκεψη για εκτίμηση βλάβης'),('ACT004','Αντικατάσταση','Αντικατάσταση φθαρμένων υλικών'),('ACT005','Καθαριότητα (Δήμος)','Καθαριότητα χώρων απο συνεργεία του Δήμου');
/*!40000 ALTER TABLE `actiontype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assignment`
--

DROP TABLE IF EXISTS `assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assignment` (
  `AssignmentID` varchar(10) NOT NULL,
  `IncidentID` varchar(10) NOT NULL,
  `EmployeeID` varchar(10) NOT NULL,
  `AssignmentDate` datetime NOT NULL,
  `Comments` varchar(500) DEFAULT NULL,
  `Priority` int DEFAULT NULL,
  PRIMARY KEY (`AssignmentID`),
  KEY `IncidentID` (`IncidentID`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`IncidentID`) REFERENCES `incident` (`IncidentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `assignment_ibfk_2` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`EmployeeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment`
--

LOCK TABLES `assignment` WRITE;
/*!40000 ALTER TABLE `assignment` DISABLE KEYS */;
INSERT INTO `assignment` VALUES ('AAAA000001','AAAA000001','AAAA000001','2025-09-10 09:00:00',NULL,2),('AAAA000002','AAAA000002','AAAA000003','2025-10-13 11:30:00','Παρακαλώ για την άμεση διευθέτηση.',3),('AAAA000003','AAAA000003','AAAA000004','2025-10-14 11:30:00',NULL,1),('AAAA000004','AAAA000004','AAAA000004','2025-10-18 11:30:00',NULL,2),('AAAA000005','AAAA000005','AAAA000003','2025-01-05 14:30:00',NULL,1);
/*!40000 ALTER TABLE `assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citizen`
--

DROP TABLE IF EXISTS `citizen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citizen` (
  `UserID` varchar(10) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `Password` varchar(50) NOT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citizen`
--

LOCK TABLES `citizen` WRITE;
/*!40000 ALTER TABLE `citizen` DISABLE KEYS */;
INSERT INTO `citizen` VALUES ('AAAA000001','Παναγιώτης','Δεμιτσόγλου','pldemits@ece.auth.gr','6942456789','pdfg123456'),('AAAA000002','Βασίλης','Μπαρμπαγιάννος','vmparmpg@ece.auth.gr','6987456123','vm123456'),('AAAA000003','Βασίλης','Καλαντζής','kalavasi@ece.auth.gr','6930231258','159753vk');
/*!40000 ALTER TABLE `citizen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `DepartmentID` varchar(10) NOT NULL,
  `DeptName` varchar(50) NOT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`DepartmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('AAAA000001','Διεύθυνση Καθαριότητας','2310445510'),('AAAA000002','Διεύθυνση Βιώσιμης Κινητικότητας','2310445511'),('AAAA000003','Διεύθυνση Κατασκευών','2310445512'),('AAAA000004','Διεύθυνση Προμηθειών','2310445513');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `district` (
  `DistrictID` varchar(10) NOT NULL,
  `DistrictName` varchar(50) NOT NULL,
  `ZipCode` int NOT NULL,
  PRIMARY KEY (`DistrictID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district`
--

LOCK TABLES `district` WRITE;
/*!40000 ALTER TABLE `district` DISABLE KEYS */;
INSERT INTO `district` VALUES ('AAAA000001','Νέα Παραλία - Λευκός Πύργος',54248),('AAAA000002','Ροτόντα',54351),('AAAA000003','Πλατεία Αριστοτέλους',54624),('AAAA000004','Αγίου Δημητρίου',54643);
/*!40000 ALTER TABLE `district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `EmployeeID` varchar(10) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Phone` varchar(15) DEFAULT NULL,
  `DepartmentID` varchar(10) NOT NULL,
  `Role` varchar(50) NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  KEY `DepartmentID` (`DepartmentID`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`DepartmentID`) REFERENCES `department` (`DepartmentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('AAAA000001','Νικόλαος','Μπαντής','n.mpantis@dthess.gr','2310445561','AAAA000004','Υπεύθυνος Προμηθειών'),('AAAA000002','Ιωάννης','Ψυχίδης','i.psychidis@dthess.gr','2310445563','AAAA000003','Υπάλληλος Τεχνικών Υπηρεσιών'),('AAAA000003','Πέτρος','Παπαργυρίου','p.papargyriou@dthess.gr','2310445562','AAAA000003','Προϊστάμενος Τεχνικών Έργων'),('AAAA000004','Παντελής','Νικολάου','p.nikolaou@dthess.gr','2310445560','AAAA000001','Υπάλληλος Καθαριότητας');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident`
--

DROP TABLE IF EXISTS `incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incident` (
  `IncidentID` varchar(10) NOT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `SubmissionDate` datetime NOT NULL,
  `Street` varchar(50) DEFAULT NULL,
  `StreetNumber` int DEFAULT NULL,
  `Latitude` decimal(9,6) DEFAULT NULL,
  `Longitude` decimal(9,6) DEFAULT NULL,
  `UserID` varchar(10) NOT NULL,
  `TypeID` varchar(10) NOT NULL,
  `DistrictID` varchar(10) NOT NULL,
  PRIMARY KEY (`IncidentID`),
  KEY `UserID` (`UserID`),
  KEY `TypeID` (`TypeID`),
  KEY `DistrictID` (`DistrictID`),
  CONSTRAINT `incident_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `citizen` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incident_ibfk_2` FOREIGN KEY (`TypeID`) REFERENCES `incidenttype` (`TypeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `incident_ibfk_3` FOREIGN KEY (`DistrictID`) REFERENCES `district` (`DistrictID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incident`
--

LOCK TABLES `incident` WRITE;
/*!40000 ALTER TABLE `incident` DISABLE KEYS */;
INSERT INTO `incident` VALUES ('AAAA000001','Σπασμένο πεζοδρόμιο, με αποτέλεσμα να σπάσω το πόδι μου.','2025-08-30 16:41:12','Νίκης',15,40.374930,22.570660,'AAAA000001','AAAA000002','AAAA000001'),('AAAA000002','Κακοτεχνία σε τσουλήθρα παιδικής χαράς.','2025-09-22 08:30:05','Λεωφ. Μεγ. Αλεξάνδρου',25,40.630349,22.951826,'AAAA000001','AAAA000001','AAAA000001'),('AAAA000003','Σκουπίδια στο πάρκο.','2025-09-15 10:00:00','Εγνατία',100,40.632000,22.950000,'AAAA000003','AAAA000004','AAAA000002'),('AAAA000004','Σκουπίδια στο οδόστρωμμα ','2026-01-05 10:12:08','Αγ. Δημητρίου',154,NULL,NULL,'AAAA000001','AAAA000004','AAAA000004'),('AAAA000005','Σπασμένη μπασκέτα','2026-01-05 13:42:10','Λεωφ. Νίκης',33,NULL,NULL,'AAAA000001','AAAA000003','AAAA000001');
/*!40000 ALTER TABLE `incident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `incident_details_view`
--

DROP TABLE IF EXISTS `incident_details_view`;
/*!50001 DROP VIEW IF EXISTS `incident_details_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `incident_details_view` AS SELECT 
 1 AS `IncidentID`,
 1 AS `IncidentDescription`,
 1 AS `SubmissionDate`,
 1 AS `Street`,
 1 AS `StreetNumber`,
 1 AS `IncidentType`,
 1 AS `Importance`,
 1 AS `CitizenLastName`,
 1 AS `CitizenPhone`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `incidenttype`
--

DROP TABLE IF EXISTS `incidenttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incidenttype` (
  `TypeID` varchar(10) NOT NULL,
  `TypeName` varchar(50) NOT NULL,
  `Importance` enum('ΧΑΜΗΛΗ','ΜΕΤΡΙΑ','ΥΨΗΛΗ') NOT NULL,
  PRIMARY KEY (`TypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidenttype`
--

LOCK TABLES `incidenttype` WRITE;
/*!40000 ALTER TABLE `incidenttype` DISABLE KEYS */;
INSERT INTO `incidenttype` VALUES ('AAAA000001','Παιδική χαρά','ΥΨΗΛΗ'),('AAAA000002','Κακοτεχνία Πεζοδρομίου','ΜΕΤΡΙΑ'),('AAAA000003','Βανδαλισμός','ΜΕΤΡΙΑ'),('AAAA000004','Καθαριότητα','ΧΑΜΗΛΗ');
/*!40000 ALTER TABLE `incidenttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photo` (
  `IncidentID` varchar(10) NOT NULL,
  `PhotoID` varchar(10) NOT NULL,
  `URL` varchar(255) NOT NULL,
  `UploadDate` datetime NOT NULL,
  PRIMARY KEY (`IncidentID`,`PhotoID`),
  CONSTRAINT `photo_ibfk_1` FOREIGN KEY (`IncidentID`) REFERENCES `incident` (`IncidentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo`
--

LOCK TABLES `photo` WRITE;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` VALUES ('AAAA000001','PH001','http://cityops.gr/photos/img2.jpg','2025-09-22 08:31:00'),('AAAA000003','PH001','http://cityops.gr/photos/img1.jpg','2025-08-30 16:42:00');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statushistory`
--

DROP TABLE IF EXISTS `statushistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statushistory` (
  `IncidentID` varchar(10) NOT NULL,
  `HistoryID` varchar(10) NOT NULL,
  `ChangeDate` datetime NOT NULL,
  `Status` enum('NEO','ΣΕ_ΑΝΑΘΕΣΗ','ΣΕ_ΕΞΕΛΙΞΗ','ΟΛΟΚΛΗΡΩΘΗΚΕ','ΑΚΥΡΩΘΗΚΕ') NOT NULL,
  `Comments` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`IncidentID`,`HistoryID`),
  CONSTRAINT `statushistory_ibfk_1` FOREIGN KEY (`IncidentID`) REFERENCES `incident` (`IncidentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statushistory`
--

LOCK TABLES `statushistory` WRITE;
/*!40000 ALTER TABLE `statushistory` DISABLE KEYS */;
INSERT INTO `statushistory` VALUES ('AAAA000001','HIST001','2025-08-30 16:41:12','NEO','Αρχική Υποβολή'),('AAAA000001','HIST003','2025-09-13 12:00:00','ΣΕ_ΕΞΕΛΙΞΗ','Το περιστατικό ανατέθηκε στην αρμόδια υπηρεσία.'),('AAAA000001','HIST004','2026-01-05 09:55:26','ΟΛΟΚΛΗΡΩΘΗΚΕ','Η εργασίες αποκατάστασης ολοκληρώθηκαν'),('AAAA000002','HIST003','2025-10-22 14:00:00','ΣΕ_ΕΞΕΛΙΞΗ','Το περιστατικό διευθετήθηκε'),('AAAA000003','HIST001','2025-09-15 10:00:00','NEO','Υπό διερεύνηση'),('AAAA000004','HIST003','2026-01-05 10:12:08','ΣΕ_ΕΞΕΛΙΞΗ','Αρχική Υποβολή'),('AAAA000005','HIST001','2026-01-05 13:42:10','NEO','Αρχική Υποβολή'),('AAAA000005','HIST002','2026-01-05 14:26:43','ΣΕ_ΑΝΑΘΕΣΗ','Το περιστατικό είναι σε διαδικασία ανάθεσης');
/*!40000 ALTER TABLE `statushistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `action_details_view`
--

/*!50001 DROP VIEW IF EXISTS `action_details_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `action_details_view` AS select `i`.`IncidentID` AS `IncidentID`,`a`.`ActionID` AS `ActionID`,`a`.`ActionDate` AS `ActionDate`,`a`.`Cost` AS `Cost`,`a`.`Comments` AS `ActionComments`,`i`.`Description` AS `IncidentDescription`,`e`.`EmployeeID` AS `EmployeeID`,`e`.`LastName` AS `EmployeeLastName`,`e`.`Email` AS `EmployeeEmail`,`d`.`DeptName` AS `DepartmentName`,`at`.`ActionName` AS `ActionType` from ((((`action` `a` join `incident` `i` on((`a`.`IncidentID` = `i`.`IncidentID`))) join `employee` `e` on((`a`.`EmployeeID` = `e`.`EmployeeID`))) join `department` `d` on((`e`.`DepartmentID` = `d`.`DepartmentID`))) join `actiontype` `at` on((`a`.`ActionTypeID` = `at`.`ActionTypeID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `incident_details_view`
--

/*!50001 DROP VIEW IF EXISTS `incident_details_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `incident_details_view` AS select `i`.`IncidentID` AS `IncidentID`,`i`.`Description` AS `IncidentDescription`,`i`.`SubmissionDate` AS `SubmissionDate`,`i`.`Street` AS `Street`,`i`.`StreetNumber` AS `StreetNumber`,`it`.`TypeName` AS `IncidentType`,`it`.`Importance` AS `Importance`,`c`.`LastName` AS `CitizenLastName`,`c`.`Phone` AS `CitizenPhone` from ((`incident` `i` join `incidenttype` `it` on((`i`.`TypeID` = `it`.`TypeID`))) join `citizen` `c` on((`i`.`UserID` = `c`.`UserID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-05 15:22:38
