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
INSERT INTO `keywords` VALUES (1,1,'klima, FuÃŸball, ErnÃ¤hrung, Netflix, Studium, Fridays for Future, Sport, Upload-Filter, Bayern,j');
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
INSERT INTO `topic` VALUES (13549,1,'Möglicher Mietbetrug in Würzburg: Jetzt ermittelt die Staatsanwaltschaft','Ein Vermieter hat falsche Quadratmeterangaben an das Jobcenter übermittelt. Aufgrund von Recherchen dieser Redaktion hat die Staatsanwaltschaft nun ein Verfahren eingeleitet.','https://www.mainpost.de/10766003?wt_mc=rss','2022-04-04 20:33:02','Demo'),(13550,1,'Mit dem Dampfzug &quot;Bodensee-Express&quot; von Würzburg nach Lindau','Für den 14. Mai bietet der Verein Eisenbahn-Nostalgiefahrten-Bebra eine historische Sonderzugfahrt von Würzburg über Augsburg nach Lindau an den Bodensee und zurück an. Ab Augsburg kommt die Dampflok 41 018 der Dampflok-Gesellschaft München e. V. zum Einsatz. Gebaut im Jahr 1939 ist sie inzwischen Technisches Denkmal des Freistaates Bayern. Für die Dampflok ist es die erste öffentliche Sonderfahrt nach 2,5-jährigem Werkstattaufenthalt. Die Fahrt führt ab Augsburg über die reizvolle Ludwig-Süd-Nord-Bahn durch das Allgäu nach Lindau. In Lindau wird der Dampfzug wieder für die Rückfahrt vorbereitet, hier beträgt der Aufenthalt etwa fünf Stunden. Buchungen sind ab sofort möglich. Eventuell bereits bezahlte Fahrkarten werden bei Ausfall des Zuges erstattet.','https://www.mainpost.de/10765993?wt_mc=rss','2022-04-04 20:08:29','Demo'),(13551,1,'Würzburger Quellenbach-Parkhaus: Was den Abriss so teuer macht','Mindestens 1,6 Millionen Euro sollen Abriss und Entsorgung des Quellenbach-Parkhauses die Stadt kosten. Grund für die hohen Kosten ist die nahegelegene Pleichach.','https://www.mainpost.de/10765872?wt_mc=rss','2022-04-04 18:03:10','Demo'),(13555,1,'Freiwilliger Schutz vor Corona: Hat die Maske an Unterfrankens Schulen ausgedient?','Seit Montag müssen Schüler in Bayern keine Maske mehr im Unterricht tragen. Kritik kommt von Lehrerverbänden. Schulleiter aus der Region berichten, wie der erste Tag lief.','https://www.mainpost.de/10765953?wt_mc=rss','2022-04-04 19:06:40','Demo'),(13557,1,'Hilfe für Familien wird ausgebaut','Der Landkreis Würzburg baut seine Hilfen für Familien, Kinder und Jugendliche weiter aus. In der vergangenen Sitzung des Jugendhilfeausschusses beschlossen die Mitglieder die Förderung von zwei neuen Stellen für Jugendsozialarbeit an Schulen (JaS) mit jeweils einer halben Vollzeitstelle an der Eichendorff-Grundschule in Gerbrunn und der Grundschule Reichenberg. Des Weiteren wurde der Antrag auf Einrichtung eines Familienstützpunktes in Kist positiv beschieden. Eine Förderung wäre bereits ab September 2022 möglich. An den Kreistag erging die jeweils Empfehlung, entsprechende Mittel im Jugendhilfehaushalt bereitzustellen.','https://www.mainpost.de/10765995?wt_mc=rss','2022-04-04 20:15:26','Demo'),(13558,1,'Wolfgang Tammen gestorben','Am 20. März starb der Ehrenchorleiter des Sängervereins Margetshöchheim. Wolfgang Tammen war seit über 30 Jahren Mitglied des Sängervereins und hat den Verein als Chorleiter nachhaltig geprägt. Folgende Informationen sind einer Pressemitteilung des Sängervereins Margetshöchheim entnommen.','https://www.mainpost.de/10765927?wt_mc=rss','2022-04-04 18:40:11','Demo'),(13559,1,'Katastrophenhilfe aus dem Landkreis Würzburg: Freiwillige sägen knapp 600 Ster Holz im Ahrtal','Und auch ein dreiviertel Jahr nach der Flutkatastrophe kämpfen die Menschen im Ahrtal noch mit den Folgen. Landrat Thomas Eberth besuchte das Katastrophengebiet und unterstützte Helferinnen und Helfer vor Ort mit Verpflegung und Treibstoff. Darüber informiert das Landratsamt Würzburg in einer Pressemitteilung, der folgender Text entnommen ist.','https://www.mainpost.de/10765925?wt_mc=rss','2022-04-04 18:36:30','Demo'),(13560,1,'Mauer und Spiegel angefahren','Eine Mauer im Rebenweg wurde nach Angaben der Polizei am Sontag, zwischen 15 und 16 Uhr von einem unbekannten Verkehrsteilnehmer beschädigt. Den Schaden schätzen die Beamten auf circa 1000 Euro.','https://www.mainpost.de/10765882?wt_mc=rss','2022-04-04 18:10:43','Demo'),(13561,1,'Ernennung zum Ehrenmitglieder','Auf der diesjährigen Jahres-Mitgliederversammlung der SG Margetshöchheim wurden Oskar Ulsamer und Werner Stadler als Ehrenmitglieder ernannt. Beide haben sich durch langjährige ehrenamtliche Aufgaben im Verein ausgezeichnet. So war Oskar Ulsamer 23 Jahre im Vorstand in verschiedenen Funktionen tätig  und 37 Jahre aktiver Fußball-Schiedsrichter für die SG. Werner Stadler war lange Jahre in der Fußballabteilung für den Jugendfußball unter anderem 24 Jahre als Jugendleiter tätig. Beide bringen sich auch weiterhin für den Verein ein und unterstützen, wo es nur geht. Auf dem Foto Oskar Ulsamer (Ehrenmitglied), Simon Haupt (Vorsitzender) und Werner Stadler (Ehrenmitglied).','https://www.mainpost.de/10765773?wt_mc=rss','2022-04-04 16:55:46','Demo'),(13562,1,'Tausche bemalte Eier gegen Osterüberraschung','Im Markt Reichenberg wurde fleißig getauscht: wunderschöne und kunterbunt bemalte Eier gegen eine tolle Osterüberraschung. An sogenannten \"Austauschstationen\" in allen fünf Gemeindeteilen standen zwei Körbe bereit. In den einen konnten die Kinder ihr Papier-Ei hineinlegen und sich anschließend aus dem anderen eine Mappe mit Malvorlagen und einem Kreidestift aussuchen. Etwas Süßes für den Nachhauseweg gab es natürlich auch für die kleinen Künstler.','https://www.mainpost.de/10765761?wt_mc=rss','2022-04-04 16:51:40','Demo');
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
