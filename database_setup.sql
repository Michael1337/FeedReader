CREATE DATABASE  IF NOT EXISTS `feedreader` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `feedreader`;
-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: feedreader
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `board` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `count_roommates` int(11) NOT NULL,
  `link` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `english` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `link` (`link`),
  UNIQUE KEY `password` (`password`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
INSERT INTO `board` VALUES (1,1,'demo','demo',1);
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keywords`
--

DROP TABLE IF EXISTS `keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `keywords` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `board_ID` int(11) NOT NULL,
  `words` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `board_board_id` (`board_ID`) USING BTREE,
  CONSTRAINT `board_board_id` FOREIGN KEY (`board_ID`) REFERENCES `board` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keywords`
--

LOCK TABLES `keywords` WRITE;
/*!40000 ALTER TABLE `keywords` DISABLE KEYS */;
INSERT INTO `keywords` VALUES (1,1,'klima, Fu????ball, Ern????hrung, Netflix, Studium, Fridays for Future, Sport, Upload-Filter, Bayern,j');
/*!40000 ALTER TABLE `keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roommates`
--

DROP TABLE IF EXISTS `roommates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `roommates` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `board_ID` int(11) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `color` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `board_roommates` (`board_ID`),
  CONSTRAINT `board_roommates` FOREIGN KEY (`board_ID`) REFERENCES `board` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roommates`
--

LOCK TABLES `roommates` WRITE;
/*!40000 ALTER TABLE `roommates` DISABLE KEYS */;
INSERT INTO `roommates` VALUES (1,1,'Michael','#FF00FF');
/*!40000 ALTER TABLE `roommates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topic`
--

DROP TABLE IF EXISTS `topic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `topic` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `board_ID` int(11) NOT NULL,
  `title` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `source` tinytext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sender` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `topic_board` (`board_ID`),
  CONSTRAINT `topic_board` FOREIGN KEY (`board_ID`) REFERENCES `board` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13567 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topic`
--

LOCK TABLES `topic` WRITE;
/*!40000 ALTER TABLE `topic` DISABLE KEYS */;
INSERT INTO `topic` VALUES (13549,1,'M??glicher Mietbetrug in W??rzburg: Jetzt ermittelt die Staatsanwaltschaft','Ein Vermieter hat falsche Quadratmeterangaben an das Jobcenter ??bermittelt. Aufgrund von Recherchen dieser Redaktion hat die Staatsanwaltschaft nun ein Verfahren eingeleitet.','https://www.mainpost.de/10766003?wt_mc=rss','2022-04-04 20:33:02','Demo'),(13550,1,'Mit dem Dampfzug &quot;Bodensee-Express&quot; von W??rzburg nach Lindau','F??r den 14. Mai bietet der Verein Eisenbahn-Nostalgiefahrten-Bebra eine historische Sonderzugfahrt von W??rzburg ??ber Augsburg nach Lindau an den Bodensee und zur??ck an. Ab Augsburg kommt die Dampflok 41 018 der Dampflok-Gesellschaft M??nchen e. V. zum Einsatz. Gebaut im Jahr 1939 ist sie inzwischen Technisches Denkmal des Freistaates Bayern. F??r die Dampflok ist es die erste ??ffentliche Sonderfahrt nach 2,5-j??hrigem Werkstattaufenthalt. Die Fahrt f??hrt ab Augsburg ??ber die reizvolle Ludwig-S??d-Nord-Bahn durch das Allg??u nach Lindau. In Lindau wird der Dampfzug wieder f??r die R??ckfahrt vorbereitet, hier betr??gt der Aufenthalt etwa f??nf Stunden. Buchungen sind ab sofort m??glich. Eventuell bereits bezahlte Fahrkarten werden bei Ausfall des Zuges erstattet.','https://www.mainpost.de/10765993?wt_mc=rss','2022-04-04 20:08:29','Demo'),(13551,1,'W??rzburger Quellenbach-Parkhaus: Was den Abriss so teuer macht','Mindestens 1,6 Millionen Euro sollen Abriss und Entsorgung des Quellenbach-Parkhauses die Stadt kosten. Grund f??r die hohen Kosten ist die nahegelegene Pleichach.','https://www.mainpost.de/10765872?wt_mc=rss','2022-04-04 18:03:10','Demo'),(13555,1,'Freiwilliger Schutz vor Corona: Hat die Maske an Unterfrankens Schulen ausgedient?','Seit Montag m??ssen Sch??ler in Bayern keine Maske mehr im Unterricht tragen. Kritik kommt von Lehrerverb??nden. Schulleiter aus der Region berichten, wie der erste Tag lief.','https://www.mainpost.de/10765953?wt_mc=rss','2022-04-04 19:06:40','Demo'),(13557,1,'Hilfe f??r Familien wird ausgebaut','Der Landkreis W??rzburg baut seine Hilfen f??r Familien, Kinder und Jugendliche weiter aus. In der vergangenen Sitzung des Jugendhilfeausschusses beschlossen die Mitglieder die F??rderung von zwei neuen Stellen f??r Jugendsozialarbeit an Schulen (JaS) mit jeweils einer halben Vollzeitstelle an der Eichendorff-Grundschule in Gerbrunn und der Grundschule Reichenberg. Des Weiteren wurde der Antrag auf Einrichtung eines Familienst??tzpunktes in Kist positiv beschieden. Eine F??rderung w??re bereits ab September 2022 m??glich.??An den Kreistag erging die jeweils Empfehlung, entsprechende Mittel im Jugendhilfehaushalt bereitzustellen.','https://www.mainpost.de/10765995?wt_mc=rss','2022-04-04 20:15:26','Demo'),(13558,1,'Wolfgang Tammen gestorben','Am 20. M??rz starb der Ehrenchorleiter des S??ngervereins Margetsh??chheim. Wolfgang Tammen war seit ??ber 30 Jahren Mitglied des S??ngervereins und hat den Verein als Chorleiter nachhaltig gepr??gt.??Folgende Informationen sind einer Pressemitteilung des S??ngervereins Margetsh??chheim entnommen.','https://www.mainpost.de/10765927?wt_mc=rss','2022-04-04 18:40:11','Demo'),(13559,1,'Katastrophenhilfe aus dem Landkreis W??rzburg: Freiwillige s??gen knapp 600 Ster Holz im Ahrtal','Und auch ein dreiviertel Jahr nach der Flutkatastrophe k??mpfen die Menschen im Ahrtal noch mit den Folgen.??Landrat Thomas Eberth besuchte das Katastrophengebiet und unterst??tzte Helferinnen und Helfer vor Ort mit Verpflegung und Treibstoff. Dar??ber informiert das Landratsamt W??rzburg in einer Pressemitteilung, der folgender Text entnommen ist.','https://www.mainpost.de/10765925?wt_mc=rss','2022-04-04 18:36:30','Demo'),(13560,1,'Mauer und Spiegel angefahren','Eine Mauer im Rebenweg wurde nach Angaben der Polizei am Sontag, zwischen 15 und 16 Uhr von einem unbekannten Verkehrsteilnehmer besch??digt. Den Schaden sch??tzen die Beamten auf circa 1000 Euro.','https://www.mainpost.de/10765882?wt_mc=rss','2022-04-04 18:10:43','Demo'),(13561,1,'Ernennung zum Ehrenmitglieder','Auf der diesj??hrigen Jahres-Mitgliederversammlung der SG Margetsh??chheim wurden Oskar Ulsamer und Werner Stadler als Ehrenmitglieder ernannt. Beide haben sich durch langj??hrige ehrenamtliche Aufgaben im Verein ausgezeichnet. So war Oskar Ulsamer 23 Jahre im Vorstand in verschiedenen Funktionen t??tig  und 37 Jahre aktiver Fu??ball-Schiedsrichter f??r die SG. Werner Stadler war lange Jahre in der Fu??ballabteilung f??r den Jugendfu??ball unter anderem 24 Jahre als Jugendleiter t??tig. Beide bringen sich auch weiterhin f??r den Verein ein und unterst??tzen, wo es nur geht. Auf dem Foto Oskar Ulsamer (Ehrenmitglied), Simon Haupt (Vorsitzender) und Werner Stadler (Ehrenmitglied).','https://www.mainpost.de/10765773?wt_mc=rss','2022-04-04 16:55:46','Demo'),(13562,1,'Tausche bemalte Eier gegen Oster??berraschung','Im Markt Reichenberg wurde flei??ig getauscht: wundersch??ne und kunterbunt bemalte Eier gegen eine tolle Oster??berraschung. An sogenannten \"Austauschstationen\" in allen f??nf Gemeindeteilen standen zwei K??rbe bereit. In den einen konnten die Kinder ihr Papier-Ei hineinlegen und sich anschlie??end aus dem anderen eine Mappe mit Malvorlagen und einem Kreidestift aussuchen. Etwas S????es f??r den Nachhauseweg gab es nat??rlich auch f??r die kleinen K??nstler.','https://www.mainpost.de/10765761?wt_mc=rss','2022-04-04 16:51:40','Demo');
/*!40000 ALTER TABLE `topic` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-05  1:05:45
