-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: sqldb3
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `bookNo` varchar(30) NOT NULL,
  `bookName` varchar(30) DEFAULT NULL,
  `bookAuthor` varchar(30) DEFAULT NULL,
  `bookPrice` int DEFAULT NULL,
  `bookDate` date DEFAULT NULL,
  `bookStock` int DEFAULT NULL,
  `pubNo` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`bookNo`),
  KEY `FK_publisher_book` (`pubNo`),
  CONSTRAINT `FK_publisher_book` FOREIGN KEY (`pubNo`) REFERENCES `publisher` (`pubNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('1001','데이터베이스 이론','홍길동',22000,'2018-11-11',5,'3'),('1002','자바 프로그래밍','이몽룡',25000,'2020-12-12',4,'1'),('1003','인터넷프로그래밍','성춘향',30000,'2019-02-10',10,'2'),('1004','안드로이드 프로그래밍','변학도',23000,'2017-10-10',2,'1'),('1005','안드로이드 앱','강길동',26000,'2019-01-11',5,'2'),('1006','MS SQL SERVER 2014','박지성',35000,'2019-03-25',7,'3'),('1007','HTML & CSS','손홍민',18000,'2021-01-30',3,'1'),('1008','MFC 입문','류현진',20000,'2014-12-12',5,'1'),('1009','안드로이드 게임 제작','나길동',33000,'2017-10-31',5,'2'),('1010','C++객체지향 프로그래밍','추신수',24000,'2018-04-20',2,'3'),('1011','JSP 웹 프로그래밍','김연아',27000,'2019-10-23',8,'1'),('1012','해커들의 해킹 기법','손연재',32000,'2017-07-07',1,'2'),('1013','자료구조','홍길동',19000,'2019-01-20',4,'1'),('1014','웹 해킹과 침해사고 분석','성춘향',35000,'2017-11-25',5,'2'),('1015','자바스크립 & jQuery','홍길동',27000,'2018-10-22',2,'2');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booksale`
--

DROP TABLE IF EXISTS `booksale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booksale` (
  `bsNo` varchar(30) NOT NULL,
  `bsDate` date DEFAULT NULL,
  `bsQty` int DEFAULT NULL,
  `clientNo` varchar(30) NOT NULL,
  `bookNo` varchar(30) NOT NULL,
  PRIMARY KEY (`bsNo`),
  KEY `FK_client_bookSale` (`clientNo`),
  KEY `FK_book_bookSale` (`bookNo`),
  CONSTRAINT `FK_book_bookSale` FOREIGN KEY (`bookNo`) REFERENCES `book` (`bookNo`),
  CONSTRAINT `FK_client_bookSale` FOREIGN KEY (`clientNo`) REFERENCES `client` (`clientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booksale`
--

LOCK TABLES `booksale` WRITE;
/*!40000 ALTER TABLE `booksale` DISABLE KEYS */;
INSERT INTO `booksale` VALUES ('1','2018-04-05',2,'3','1006'),('2','2018-10-11',1,'7','1004'),('3','2019-02-20',5,'2','1009'),('4','2019-07-10',4,'1','1011'),('5','2020-02-09',2,'2','1002'),('6','2020-07-09',2,'4','1003'),('7','2020-11-16',2,'2','1002'),('8','2021-01-02',9,'7','1005'),('9','2021-03-25',1,'8','1004');
/*!40000 ALTER TABLE `booksale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `clientNo` varchar(30) NOT NULL,
  `clientName` varchar(30) DEFAULT NULL,
  `clientphone` varchar(30) DEFAULT NULL,
  `clientAddress` varchar(30) DEFAULT NULL,
  `clientBirth` date DEFAULT NULL,
  `clientHobby` varchar(30) DEFAULT NULL,
  `clientGender` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`clientNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES ('1','메시','010-1111-1111','서울','1987-06-24','축구','남'),('2','호날두','010-2222-2222','천안','1984-02-05',NULL,'남'),('3','샤라포바','010-3333-3333','제주','1987-04-19',NULL,'여'),('4','베컴','010-4444-4444','안양','1994-05-02','영화','남'),('5','네이마르','010-5555-5555','수원','1992-02-05','게임','남'),('6','윌리엄스','010-6666-6666','서울','1981-09-26','테니스','여'),('7','아자르','010-7777-7777','천안','1991-01-07',' ','남'),('8','살라','010-8888-8888','부산','1982-04-22','','남'),('9','루니','010-9999-9999','서울','1996-10-24','등산','남');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher` (
  `pubNo` varchar(30) NOT NULL,
  `pubName` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`pubNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES ('1','서울 출판사'),('2','도서출판 강남'),('3','정보출판사');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-03 17:49:41
