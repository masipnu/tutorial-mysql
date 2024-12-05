/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.10-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: buku_db
-- ------------------------------------------------------
-- Server version	10.11.10-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `buku`
--

DROP TABLE IF EXISTS `buku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buku` (
  `buku_isbn` char(13) NOT NULL,
  `buku_judul` varchar(75) DEFAULT NULL,
  `penerbit_id` char(4) DEFAULT NULL,
  `buku_tglterbit` date DEFAULT NULL,
  `buku_jmlhalaman` int(11) DEFAULT NULL,
  `buku_deskripsi` text DEFAULT NULL,
  `buku_harga` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`buku_isbn`),
  KEY `penerbit_id` (`penerbit_id`),
  CONSTRAINT `buku_ibfk_1` FOREIGN KEY (`penerbit_id`) REFERENCES `penerbit` (`penerbit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buku`
--

LOCK TABLES `buku` WRITE;
/*!40000 ALTER TABLE `buku` DISABLE KEYS */;
INSERT INTO `buku` VALUES
('222-34222-1-0','Belajar Photoshop','PB01','2019-07-02',300,NULL,42000),
('222-34222-1-1','Panduan CorelDRAW','PB02','2020-03-15',400,NULL,55000),
('666-96771-2-0','Panduan Membangun Jaringan TCP/IP','PB08','2016-08-02',200,NULL,60000),
('666-96771-2-1','Implementasi TCP/IP di Linux','PB08','2018-11-21',230,NULL,350000),
('777-76723-5-0','Belajar PHP 8','PB07','2020-05-02',600,NULL,95000),
('777-76723-5-1','Aplikasi Web dengan Python','PB07','2014-08-01',180,NULL,30000),
('777-76723-5-2','Internet Marketing','PB07','2017-01-24',150,NULL,38500),
('777-76723-5-3','Panduan Menjadi Youtuber','PB07','2017-01-24',243,NULL,38500),
('888-96771-3-0','Pemrograman Pascal','PB08','2014-11-01',350,NULL,50000),
('888-96771-3-1','Pemrograman Java','PB06','2017-01-23',450,NULL,72000),
('888-96771-3-2','Pemrograman C untuk Hardware','PB05','2016-12-25',398,NULL,47000),
('888-96771-3-3','Panduan C++','PB06','2015-07-15',490,NULL,65000),
('888-96771-3-4','Belajar Delphi','PB05','2018-08-11',328,NULL,50000),
('888-96771-3-5','Visual Basic','PB02','2017-10-14',250,NULL,50000),
('979-96446-9-0','Belajar SQL','PB06','2019-10-12',346,NULL,45000),
('979-96446-9-1','Panduan Basis Data','PB01','2017-03-02',257,NULL,37000),
('979-96446-9-2','Perancangan Sistem','PB03','2013-09-20',403,NULL,37000),
('979-96446-9-3','Microsoft Access','PB06','2015-07-13',400,NULL,48500),
('999-11555-2-0','Microsoft Power Point','PB06','2018-11-23',300,NULL,57500),
('999-11555-2-1','Microsoft Word','PB04','2017-12-01',270,NULL,60000);
/*!40000 ALTER TABLE `buku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategori`
--

DROP TABLE IF EXISTS `kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kategori` (
  `kategori_id` int(11) NOT NULL AUTO_INCREMENT,
  `kategori_nama` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`kategori_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategori`
--

LOCK TABLES `kategori` WRITE;
/*!40000 ALTER TABLE `kategori` DISABLE KEYS */;
INSERT INTO `kategori` VALUES
(1,'Database'),
(2,'Desain Grafis'),
(3,'Jaringan Komputer'),
(4,'Pemrograman'),
(5,'Web dan Internet'),
(6,'Office Application');
/*!40000 ALTER TABLE `kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_buku_kategori`
--

DROP TABLE IF EXISTS `link_buku_kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_buku_kategori` (
  `buku_isbn` char(13) NOT NULL,
  `kategori_id` int(11) NOT NULL,
  PRIMARY KEY (`buku_isbn`,`kategori_id`),
  KEY `kategori_id` (`kategori_id`),
  CONSTRAINT `link_buku_kategori_ibfk_1` FOREIGN KEY (`buku_isbn`) REFERENCES `buku` (`buku_isbn`),
  CONSTRAINT `link_buku_kategori_ibfk_2` FOREIGN KEY (`kategori_id`) REFERENCES `kategori` (`kategori_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_buku_kategori`
--

LOCK TABLES `link_buku_kategori` WRITE;
/*!40000 ALTER TABLE `link_buku_kategori` DISABLE KEYS */;
INSERT INTO `link_buku_kategori` VALUES
('222-34222-1-0',2),
('222-34222-1-1',2),
('666-96771-2-0',3),
('666-96771-2-1',3),
('777-76723-5-0',4),
('777-76723-5-0',5),
('777-76723-5-1',4),
('777-76723-5-1',5),
('777-76723-5-2',5),
('777-76723-5-3',5),
('888-96771-3-0',4),
('888-96771-3-1',4),
('888-96771-3-2',4),
('888-96771-3-3',4),
('888-96771-3-4',4),
('888-96771-3-5',4),
('979-96446-9-0',1),
('979-96446-9-1',1),
('979-96446-9-2',1),
('979-96446-9-2',4),
('979-96446-9-3',1),
('999-11555-2-0',6),
('999-11555-2-1',6);
/*!40000 ALTER TABLE `link_buku_kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `link_buku_pengarang`
--

DROP TABLE IF EXISTS `link_buku_pengarang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `link_buku_pengarang` (
  `buku_isbn` char(13) NOT NULL,
  `pengarang_id` char(3) NOT NULL,
  PRIMARY KEY (`buku_isbn`,`pengarang_id`),
  KEY `pengarang_id` (`pengarang_id`),
  CONSTRAINT `link_buku_pengarang_ibfk_1` FOREIGN KEY (`buku_isbn`) REFERENCES `buku` (`buku_isbn`),
  CONSTRAINT `link_buku_pengarang_ibfk_2` FOREIGN KEY (`pengarang_id`) REFERENCES `pengarang` (`pengarang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `link_buku_pengarang`
--

LOCK TABLES `link_buku_pengarang` WRITE;
/*!40000 ALTER TABLE `link_buku_pengarang` DISABLE KEYS */;
INSERT INTO `link_buku_pengarang` VALUES
('222-34222-1-0','P01'),
('222-34222-1-1','P04'),
('666-96771-2-0','P04'),
('666-96771-2-0','P06'),
('666-96771-2-0','P07'),
('666-96771-2-1','P01'),
('666-96771-2-1','P04'),
('777-76723-5-0','P02'),
('777-76723-5-0','P04'),
('777-76723-5-1','P03'),
('777-76723-5-1','P10'),
('777-76723-5-1','P12'),
('777-76723-5-2','P13'),
('777-76723-5-3','P08'),
('777-76723-5-3','P09'),
('888-96771-3-0','P04'),
('888-96771-3-1','P02'),
('888-96771-3-1','P11'),
('888-96771-3-2','P01'),
('888-96771-3-2','P06'),
('888-96771-3-3','P02'),
('888-96771-3-4','P09'),
('888-96771-3-4','P10'),
('888-96771-3-5','P02'),
('979-96446-9-0','P02'),
('979-96446-9-0','P11'),
('979-96446-9-1','P07'),
('979-96446-9-2','P03'),
('979-96446-9-2','P10'),
('979-96446-9-2','P12'),
('979-96446-9-2','P13'),
('979-96446-9-3','P11'),
('999-11555-2-0','P11'),
('999-11555-2-0','P13'),
('999-11555-2-1','P06'),
('999-11555-2-1','P08'),
('999-11555-2-1','P09'),
('999-11555-2-1','P10');
/*!40000 ALTER TABLE `link_buku_pengarang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `penerbit`
--

DROP TABLE IF EXISTS `penerbit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `penerbit` (
  `penerbit_id` char(4) NOT NULL,
  `penerbit_nama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`penerbit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `penerbit`
--

LOCK TABLES `penerbit` WRITE;
/*!40000 ALTER TABLE `penerbit` DISABLE KEYS */;
INSERT INTO `penerbit` VALUES
('PB01','Angkasa Raya'),
('PB02','Cahaya Ilmu Persada'),
('PB03','Sinar Ilmu Perkasa'),
('PB04','Intan'),
('PB05','Sinar Raya'),
('PB06','Informatika'),
('PB07','Tiga Sekawan'),
('PB08','Cipta Ilmu');
/*!40000 ALTER TABLE `penerbit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pengarang`
--

DROP TABLE IF EXISTS `pengarang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pengarang` (
  `pengarang_id` char(3) NOT NULL,
  `pengarang_nama` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`pengarang_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pengarang`
--

LOCK TABLES `pengarang` WRITE;
/*!40000 ALTER TABLE `pengarang` DISABLE KEYS */;
INSERT INTO `pengarang` VALUES
('P01','Andi Setiawan'),
('P02','Rudi Wicaksono'),
('P03','Beni Tito'),
('P04','Prasetya'),
('P05','Erik Rusdianto'),
('P06','Rosdiana'),
('P07','Fredi Hidayat'),
('P08','Hasanudin'),
('P09','Ahmad hanafi'),
('P10','Iwan Gunardi'),
('P11','Iman Teguh'),
('P12','Abdul Ghozali'),
('P13','Tegar Sanjaya');
/*!40000 ALTER TABLE `pengarang` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-05 21:49:38
