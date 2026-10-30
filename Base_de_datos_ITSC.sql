-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: itsc_academico_v3
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

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
-- Current Database: `itsc_academico_v3`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `itsc_academico_v3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `itsc_academico_v3`;

--
-- Table structure for table `app_auditoria`
--

DROP TABLE IF EXISTS `app_auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_auditoria` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id` int(10) unsigned NOT NULL,
  `accion` varchar(60) NOT NULL,
  `entidad` varchar(80) NOT NULL,
  `registro_id` varchar(50) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `app_auditoria_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `app_usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_auditoria`
--

LOCK TABLES `app_auditoria` WRITE;
/*!40000 ALTER TABLE `app_auditoria` DISABLE KEYS */;

/*!40000 ALTER TABLE `app_auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_intentos`
--

DROP TABLE IF EXISTS `app_intentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_intentos` (
  `clave` char(64) NOT NULL,
  `fallos` int(11) NOT NULL DEFAULT 0,
  `ultimo` datetime NOT NULL,
  PRIMARY KEY (`clave`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_intentos`
--

LOCK TABLES `app_intentos` WRITE;
/*!40000 ALTER TABLE `app_intentos` DISABLE KEYS */;

/*!40000 ALTER TABLE `app_intentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_usuarios`
--

DROP TABLE IF EXISTS `app_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_usuarios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usuario` varchar(60) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `rol` enum('ADMIN','DOCENTE','CAJA') NOT NULL,
  `docente_id` int(10) unsigned DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario` (`usuario`),
  KEY `docente_id` (`docente_id`),
  CONSTRAINT `app_usuarios_ibfk_1` FOREIGN KEY (`docente_id`) REFERENCES `docentes` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`rol` <> 'DOCENTE' or `docente_id` is not null)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_usuarios`
--

LOCK TABLES `app_usuarios` WRITE;
/*!40000 ALTER TABLE `app_usuarios` DISABLE KEYS */;

/*!40000 ALTER TABLE `app_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencias_demo_historicas`
--

DROP TABLE IF EXISTS `asistencias_demo_historicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asistencias_demo_historicas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inscripcion_id` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `estado` enum('PRESENTE','FALTA','ATRASO','JUSTIFICADA') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inscripcion_id` (`inscripcion_id`,`fecha`),
  CONSTRAINT `asistencias_demo_historicas_ibfk_1` FOREIGN KEY (`inscripcion_id`) REFERENCES `inscripciones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencias_demo_historicas`
--

LOCK TABLES `asistencias_demo_historicas` WRITE;
/*!40000 ALTER TABLE `asistencias_demo_historicas` DISABLE KEYS */;
INSERT INTO `asistencias_demo_historicas` VALUES (1,1,'2026-07-20','PRESENTE'),(2,3,'2026-07-20','PRESENTE'),(3,4,'2026-07-20','JUSTIFICADA');
/*!40000 ALTER TABLE `asistencias_demo_historicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencias_sesion`
--

DROP TABLE IF EXISTS `asistencias_sesion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asistencias_sesion` (
  `inscripcion_id` int(10) unsigned NOT NULL,
  `sesion_id` int(10) unsigned NOT NULL,
  `oferta_id` int(10) unsigned NOT NULL,
  `minutos_presentes` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`inscripcion_id`,`sesion_id`),
  KEY `inscripcion_id` (`inscripcion_id`,`oferta_id`),
  KEY `sesion_id` (`sesion_id`,`oferta_id`),
  CONSTRAINT `asistencias_sesion_ibfk_1` FOREIGN KEY (`inscripcion_id`, `oferta_id`) REFERENCES `inscripciones` (`id`, `oferta_id`),
  CONSTRAINT `asistencias_sesion_ibfk_2` FOREIGN KEY (`sesion_id`, `oferta_id`) REFERENCES `sesiones` (`id`, `oferta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencias_sesion`
--

LOCK TABLES `asistencias_sesion` WRITE;
/*!40000 ALTER TABLE `asistencias_sesion` DISABLE KEYS */;
INSERT INTO `asistencias_sesion` VALUES (1,1,1,120),(5,2,6,80);
/*!40000 ALTER TABLE `asistencias_sesion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER validar_asistencia_insert BEFORE INSERT ON asistencias_sesion FOR EACH ROW
BEGIN
 IF NEW.minutos_presentes>(SELECT TIMESTAMPDIFF(MINUTE,inicio,fin) FROM sesiones WHERE id=NEW.sesion_id) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Asistencia mayor a la duración de la sesión'; END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER validar_asistencia_update BEFORE UPDATE ON asistencias_sesion FOR EACH ROW
BEGIN
 IF NEW.minutos_presentes>(SELECT TIMESTAMPDIFF(MINUTE,inicio,fin) FROM sesiones WHERE id=NEW.sesion_id) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Asistencia mayor a la duración de la sesión'; END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `aulas`
--

DROP TABLE IF EXISTS `aulas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aulas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `capacidad` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aulas`
--

LOCK TABLES `aulas` WRITE;
/*!40000 ALTER TABLE `aulas` DISABLE KEYS */;
INSERT INTO `aulas` VALUES (1,'LAB-01',30),(2,'AULA-02',35),(3,'TALLER-01',25);
/*!40000 ALTER TABLE `aulas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `calificaciones`
--

DROP TABLE IF EXISTS `calificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calificaciones` (
  `inscripcion_id` int(10) unsigned NOT NULL,
  `evaluacion_id` int(10) unsigned NOT NULL,
  `oferta_id` int(10) unsigned NOT NULL,
  `nota` decimal(5,2) NOT NULL CHECK (`nota` between 1 and 100),
  PRIMARY KEY (`inscripcion_id`,`evaluacion_id`),
  KEY `inscripcion_id` (`inscripcion_id`,`oferta_id`),
  KEY `evaluacion_id` (`evaluacion_id`,`oferta_id`),
  CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`inscripcion_id`, `oferta_id`) REFERENCES `inscripciones` (`id`, `oferta_id`),
  CONSTRAINT `calificaciones_ibfk_2` FOREIGN KEY (`evaluacion_id`, `oferta_id`) REFERENCES `evaluaciones` (`id`, `oferta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificaciones`
--

LOCK TABLES `calificaciones` WRITE;
/*!40000 ALTER TABLE `calificaciones` DISABLE KEYS */;
INSERT INTO `calificaciones` VALUES (1,1,1,50.00),(1,2,1,60.00),(5,3,6,50.00),(5,4,6,50.00);
/*!40000 ALTER TABLE `calificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargos`
--

DROP TABLE IF EXISTS `cargos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cargos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `matricula_id` int(10) unsigned NOT NULL,
  `concepto` varchar(120) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `vencimiento` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `matricula_id` (`matricula_id`),
  CONSTRAINT `cargos_ibfk_1` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`monto` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargos`
--

LOCK TABLES `cargos` WRITE;
/*!40000 ALTER TABLE `cargos` DISABLE KEYS */;
INSERT INTO `cargos` VALUES (1,1,'Matrícula de ejemplo',100.00,'2026-07-20'),(2,2,'Matrícula de ejemplo',100.00,'2026-07-20'),(3,3,'Matrícula de ejemplo',100.00,'2026-07-20'),(4,5,'Aporte ficticio DEMO',100.00,'2026-10-30');
/*!40000 ALTER TABLE `cargos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carreras`
--

DROP TABLE IF EXISTS `carreras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carreras` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `nivel` varchar(50) NOT NULL DEFAULT 'Técnico Superior',
  `duracion_anios` tinyint(3) unsigned NOT NULL DEFAULT 3,
  `regimen` enum('ANUAL','SEMESTRAL') NOT NULL,
  `fuente_url` varchar(500) NOT NULL,
  `activa` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carreras`
--

LOCK TABLES `carreras` WRITE;
/*!40000 ALTER TABLE `carreras` DISABLE KEYS */;
INSERT INTO `carreras` VALUES (1,'SIS','Sistemas Informáticos','Técnico Superior',3,'ANUAL','https://www.itsc.edu.bo/index.php?Itemid=155',1),(2,'CON','Contaduría General','Técnico Superior',3,'ANUAL','https://www.itsc.edu.bo/index.php?Itemid=156',1),(3,'ELE','Electricidad Industrial','Técnico Superior',3,'SEMESTRAL','https://www.itsc.edu.bo/index.php?Itemid=160',1),(4,'QUI','Química Industrial','Técnico Superior',3,'SEMESTRAL','https://www.itsc.edu.bo/index.php?Itemid=157',1),(5,'MIN','Mecánica Industrial','Técnico Superior',3,'SEMESTRAL','https://www.itsc.edu.bo/index.php?Itemid=158',1),(6,'MAU','Mecánica Automotriz','Técnico Superior',3,'SEMESTRAL','https://www.itsc.edu.bo/index.php?Itemid=159',1),(7,'ELN','Electrónica','Técnico Superior',3,'SEMESTRAL','https://www.itsc.edu.bo/index.php?Itemid=161',1),(8,'CCV','Construcción Civil','Técnico Superior',3,'SEMESTRAL','https://www.itsc.edu.bo/index.php?Itemid=162',1),(9,'DEMO-C01','Redes y Telecomunicaciones (demostración)','Técnico Superior',3,'SEMESTRAL','urn:itsc:datos-ficticios',1),(10,'DEMO-C02','Diseño Gráfico (demostración)','Técnico Superior',3,'SEMESTRAL','urn:itsc:datos-ficticios',1),(11,'DEMO-C03','Administración de Empresas (demostración)','Técnico Superior',3,'SEMESTRAL','urn:itsc:datos-ficticios',1),(12,'DEMO-C04','Energías Renovables (demostración)','Técnico Superior',3,'SEMESTRAL','urn:itsc:datos-ficticios',1);
/*!40000 ALTER TABLE `carreras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cierres_oferta`
--

DROP TABLE IF EXISTS `cierres_oferta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cierres_oferta` (
  `oferta_id` int(10) unsigned NOT NULL,
  `minutos_carga` int(10) unsigned NOT NULL CHECK (`minutos_carga` > 0),
  `cerrado_por` varchar(120) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`oferta_id`),
  CONSTRAINT `cierres_oferta_ibfk_1` FOREIGN KEY (`oferta_id`) REFERENCES `ofertas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cierres_oferta`
--

LOCK TABLES `cierres_oferta` WRITE;
/*!40000 ALTER TABLE `cierres_oferta` DISABLE KEYS */;
INSERT INTO `cierres_oferta` VALUES (1,120,'Responsable ficticio DEMO','2026-10-16 20:37:33'),(6,100,'Administrador de práctica','2026-10-16 20:47:56');
/*!40000 ALTER TABLE `cierres_oferta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `defensas`
--

DROP TABLE IF EXISTS `defensas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `defensas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `proyecto_id` int(10) unsigned NOT NULL,
  `fecha` datetime NOT NULL,
  `aula_id` int(10) unsigned DEFAULT NULL,
  `nota` decimal(5,2) DEFAULT NULL CHECK (`nota` between 0 and 100),
  `acta` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acta` (`acta`),
  KEY `proyecto_id` (`proyecto_id`),
  KEY `aula_id` (`aula_id`),
  CONSTRAINT `defensas_ibfk_1` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos_graduacion` (`id`),
  CONSTRAINT `defensas_ibfk_2` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `defensas`
--

LOCK TABLES `defensas` WRITE;
/*!40000 ALTER TABLE `defensas` DISABLE KEYS */;
/*!40000 ALTER TABLE `defensas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docentes`
--

DROP TABLE IF EXISTS `docentes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `docentes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documento` varchar(25) NOT NULL,
  `nombres` varchar(80) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `especialidad` varchar(120) NOT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `correo` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `documento` (`documento`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docentes`
--

LOCK TABLES `docentes` WRITE;
/*!40000 ALTER TABLE `docentes` DISABLE KEYS */;
INSERT INTO `docentes` VALUES (1,'FICT-D01','Lucía','Vargas Molina','Informática','71000001','lucia@example.com'),(2,'FICT-D02','Andrés','Paredes Lima','Contabilidad','71000002','andres@example.com'),(3,'FICT-D03','Camila','Ortiz Rivas','Electricidad','71000003','camila@example.com'),(4,'DEMO-DOC-000001','Javier Adrián','Aguilar Ortega','Sistemas Informáticos',NULL,'docente00001@example.invalid'),(5,'DEMO-DOC-000002','Andrés Luis','Medina Torres','Contaduría General',NULL,'docente00002@example.invalid'),(6,'DEMO-DOC-000003','Valeria Javier','Navarro Gutiérrez','Electricidad Industrial',NULL,'docente00003@example.invalid'),(7,'DEMO-DOC-000004','Camila Camila','Ríos Apaza','Química Industrial',NULL,'docente00004@example.invalid'),(8,'DEMO-DOC-000005','Lucía Daniela','Rivera Montes','Mecánica Industrial',NULL,'docente00005@example.invalid'),(9,'DEMO-DOC-000006','Mariana Andrea','Apaza Mendoza','Mecánica Automotriz',NULL,'docente00006@example.invalid'),(10,'DEMO-DOC-000007','Daniela Carolina','Pinto Soto','Electrónica',NULL,'docente00007@example.invalid'),(11,'DEMO-DOC-000008','Sofía Victoria','Molina Vega','Construcción Civil',NULL,'docente00008@example.invalid'),(12,'DEMO-DOC-000009','Paola Mauricio','Aguilar Rivera','Redes y Telecomunicaciones',NULL,'docente00009@example.invalid'),(13,'DEMO-DOC-000010','Andrea Ricardo','Medina Mamani','Diseño Gráfico',NULL,'docente00010@example.invalid'),(14,'DEMO-DOC-000011','Gabriela Lorena','Navarro Villarroel','Administración de Empresas',NULL,'docente00011@example.invalid'),(15,'DEMO-DOC-000012','Natalia Gabriel','Ríos Castro','Energías Renovables',NULL,'docente00012@example.invalid'),(16,'DEMO-DOC-000013','Carolina Santiago','Rivera Morales','Sistemas Informáticos',NULL,'docente00013@example.invalid'),(17,'DEMO-DOC-000014','Fernanda Nicolás','Apaza Ríos','Contaduría General',NULL,'docente00014@example.invalid'),(18,'DEMO-DOC-000015','Isabel Alejandro','Pinto Escobar','Electricidad Industrial',NULL,'docente00015@example.invalid'),(19,'DEMO-DOC-000016','Victoria Carlos','Molina Soria','Química Industrial',NULL,'docente00016@example.invalid'),(20,'DEMO-DOC-000017','Elena Valeria','Aguilar Vargas','Mecánica Industrial',NULL,'docente00017@example.invalid'),(21,'DEMO-DOC-000018','Rodrigo Mariana','Medina Romero','Mecánica Automotriz',NULL,'docente00018@example.invalid'),(22,'DEMO-DOC-000019','Mauricio Paola','Navarro Navarro','Electrónica',NULL,'docente00019@example.invalid'),(23,'DEMO-DOC-000020','Eduardo Natalia','Ríos López','Construcción Civil',NULL,'docente00020@example.invalid'),(24,'DEMO-DOC-000021','Pablo Isabel','Rivera Quispe','Redes y Telecomunicaciones',NULL,'docente00021@example.invalid'),(25,'DEMO-DOC-000022','Ricardo Rodrigo','Apaza Arias','Diseño Gráfico',NULL,'docente00022@example.invalid'),(26,'DEMO-DOC-000023','Patricia Pablo','Pinto Flores','Administración de Empresas',NULL,'docente00023@example.invalid'),(27,'DEMO-DOC-000024','Claudia Claudia','Molina Medina','Energías Renovables',NULL,'docente00024@example.invalid'),(28,'DEMO-DOC-000025','Lorena Rosa','Aguilar Cabrera','Sistemas Informáticos',NULL,'docente00025@example.invalid'),(29,'DEMO-DOC-000026','Verónica Daniel','Medina Castillo','Contaduría General',NULL,'docente00026@example.invalid'),(30,'DEMO-DOC-000027','Rosa Diego','Navarro Condori','Electricidad Industrial',NULL,'docente00027@example.invalid'),(31,'DEMO-DOC-000028','Gabriel Sebastián','Ríos Delgado','Química Industrial',NULL,'docente00028@example.invalid'),(32,'DEMO-DOC-000029','Mateo Miguel','Rivera Aguilar','Mecánica Industrial',NULL,'docente00029@example.invalid'),(33,'DEMO-DOC-000030','Daniel Andrés','Apaza Herrera','Mecánica Automotriz',NULL,'docente00030@example.invalid'),(34,'DEMO-DOC-000031','Santiago Lucía','Pinto Suárez','Electrónica',NULL,'docente00031@example.invalid'),(35,'DEMO-DOC-000032','Samuel Sofía','Molina Valdez','Construcción Civil',NULL,'docente00032@example.invalid'),(36,'DEMO-DOC-000033','Diego Gabriela','Aguilar Choque','Redes y Telecomunicaciones',NULL,'docente00033@example.invalid'),(37,'DEMO-DOC-000034','Nicolás Fernanda','Medina Molina','Diseño Gráfico',NULL,'docente00034@example.invalid'),(38,'DEMO-DOC-000035','Adrián Elena','Navarro Salazar','Administración de Empresas',NULL,'docente00035@example.invalid'),(39,'DEMO-DOC-000036','Sebastián Eduardo','Ríos Paredes','Energías Renovables',NULL,'docente00036@example.invalid'),(40,'DEMO-DOC-000037','Alejandro Patricia','Rivera Cruz','Sistemas Informáticos',NULL,'docente00037@example.invalid'),(41,'DEMO-DOC-000038','Luis Verónica','Apaza Fernández','Contaduría General',NULL,'docente00038@example.invalid'),(42,'DEMO-DOC-000039','Miguel Mateo','Pinto Pinto','Electricidad Industrial',NULL,'docente00039@example.invalid'),(43,'DEMO-DOC-000040','Carlos Samuel','Molina Rojas','Química Industrial',NULL,'docente00040@example.invalid'),(44,'DEMO-DOC-000041','Javier Adrián','Aguilar Ortega','Mecánica Industrial',NULL,'docente00041@example.invalid'),(45,'DEMO-DOC-000042','Andrés Luis','Medina Torres','Mecánica Automotriz',NULL,'docente00042@example.invalid'),(46,'DEMO-DOC-000043','Valeria Javier','Navarro Gutiérrez','Electrónica',NULL,'docente00043@example.invalid'),(47,'DEMO-DOC-000044','Camila Camila','Ríos Apaza','Construcción Civil',NULL,'docente00044@example.invalid'),(48,'DEMO-DOC-000045','Lucía Daniela','Rivera Montes','Redes y Telecomunicaciones',NULL,'docente00045@example.invalid'),(49,'DEMO-DOC-000046','Mariana Andrea','Apaza Mendoza','Diseño Gráfico',NULL,'docente00046@example.invalid'),(50,'DEMO-DOC-000047','Daniela Carolina','Pinto Soto','Administración de Empresas',NULL,'docente00047@example.invalid'),(51,'DEMO-DOC-000048','Sofía Victoria','Molina Vega','Energías Renovables',NULL,'docente00048@example.invalid'),(52,'DEMO-DOC-000049','Paola Mauricio','Aguilar Rivera','Sistemas Informáticos',NULL,'docente00049@example.invalid'),(53,'DEMO-DOC-000050','Andrea Ricardo','Medina Mamani','Contaduría General',NULL,'docente00050@example.invalid'),(54,'DEMO-DOC-000051','Gabriela Lorena','Navarro Villarroel','Electricidad Industrial',NULL,'docente00051@example.invalid'),(55,'DEMO-DOC-000052','Natalia Gabriel','Ríos Castro','Química Industrial',NULL,'docente00052@example.invalid'),(56,'DEMO-DOC-000053','Carolina Santiago','Rivera Morales','Mecánica Industrial',NULL,'docente00053@example.invalid'),(57,'DEMO-DOC-000054','Fernanda Nicolás','Apaza Ríos','Mecánica Automotriz',NULL,'docente00054@example.invalid'),(58,'DEMO-DOC-000055','Isabel Alejandro','Pinto Escobar','Electrónica',NULL,'docente00055@example.invalid'),(59,'DEMO-DOC-000056','Victoria Carlos','Molina Soria','Construcción Civil',NULL,'docente00056@example.invalid'),(60,'DEMO-DOC-000057','Elena Valeria','Aguilar Vargas','Redes y Telecomunicaciones',NULL,'docente00057@example.invalid'),(61,'DEMO-DOC-000058','Rodrigo Mariana','Medina Romero','Diseño Gráfico',NULL,'docente00058@example.invalid'),(62,'DEMO-DOC-000059','Mauricio Paola','Navarro Navarro','Administración de Empresas',NULL,'docente00059@example.invalid'),(63,'DEMO-DOC-000060','Eduardo Natalia','Ríos López','Energías Renovables',NULL,'docente00060@example.invalid'),(64,'DEMO-DOC-000061','Pablo Isabel','Rivera Quispe','Sistemas Informáticos',NULL,'docente00061@example.invalid'),(65,'DEMO-DOC-000062','Ricardo Rodrigo','Apaza Arias','Contaduría General',NULL,'docente00062@example.invalid'),(66,'DEMO-DOC-000063','Patricia Pablo','Pinto Flores','Electricidad Industrial',NULL,'docente00063@example.invalid'),(67,'DEMO-DOC-000064','Claudia Claudia','Molina Medina','Química Industrial',NULL,'docente00064@example.invalid'),(68,'DEMO-DOC-000065','Lorena Rosa','Aguilar Cabrera','Mecánica Industrial',NULL,'docente00065@example.invalid'),(69,'DEMO-DOC-000066','Verónica Daniel','Medina Castillo','Mecánica Automotriz',NULL,'docente00066@example.invalid'),(70,'DEMO-DOC-000067','Rosa Diego','Navarro Condori','Electrónica',NULL,'docente00067@example.invalid'),(71,'DEMO-DOC-000068','Gabriel Sebastián','Ríos Delgado','Construcción Civil',NULL,'docente00068@example.invalid'),(72,'DEMO-DOC-000069','Mateo Miguel','Rivera Aguilar','Redes y Telecomunicaciones',NULL,'docente00069@example.invalid'),(73,'DEMO-DOC-000070','Daniel Andrés','Apaza Herrera','Diseño Gráfico',NULL,'docente00070@example.invalid'),(74,'DEMO-DOC-000071','Santiago Lucía','Pinto Suárez','Administración de Empresas',NULL,'docente00071@example.invalid'),(75,'DEMO-DOC-000072','Samuel Sofía','Molina Valdez','Energías Renovables',NULL,'docente00072@example.invalid'),(76,'DEMO-DOC-000073','Diego Gabriela','Aguilar Choque','Sistemas Informáticos',NULL,'docente00073@example.invalid'),(77,'DEMO-DOC-000074','Nicolás Fernanda','Medina Molina','Contaduría General',NULL,'docente00074@example.invalid'),(78,'DEMO-DOC-000075','Adrián Elena','Navarro Salazar','Electricidad Industrial',NULL,'docente00075@example.invalid'),(79,'DEMO-DOC-000076','Sebastián Eduardo','Ríos Paredes','Química Industrial',NULL,'docente00076@example.invalid'),(80,'DEMO-DOC-000077','Alejandro Patricia','Rivera Cruz','Mecánica Industrial',NULL,'docente00077@example.invalid');
/*!40000 ALTER TABLE `docentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentos_matricula`
--

DROP TABLE IF EXISTS `documentos_matricula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentos_matricula` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `matricula_id` int(10) unsigned NOT NULL,
  `tipo_documento_id` int(10) unsigned NOT NULL,
  `estado` enum('PENDIENTE','RECIBIDO','OBSERVADO') NOT NULL DEFAULT 'PENDIENTE',
  `fecha_recepcion` date DEFAULT NULL,
  `observacion` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `matricula_id` (`matricula_id`,`tipo_documento_id`),
  KEY `tipo_documento_id` (`tipo_documento_id`),
  CONSTRAINT `documentos_matricula_ibfk_1` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id`),
  CONSTRAINT `documentos_matricula_ibfk_2` FOREIGN KEY (`tipo_documento_id`) REFERENCES `tipos_documento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentos_matricula`
--

LOCK TABLES `documentos_matricula` WRITE;
/*!40000 ALTER TABLE `documentos_matricula` DISABLE KEYS */;
INSERT INTO `documentos_matricula` VALUES (1,1,1,'RECIBIDO','2026-07-15',NULL),(2,1,2,'RECIBIDO','2026-07-15',NULL),(3,1,3,'PENDIENTE',NULL,NULL),(4,1,4,'PENDIENTE',NULL,NULL),(5,5,1,'RECIBIDO','2026-10-16','Ejemplo ficticio');
/*!40000 ALTER TABLE `documentos_matricula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiantes`
--

DROP TABLE IF EXISTS `estudiantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estudiantes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `registro` varchar(20) NOT NULL,
  `documento` varchar(25) NOT NULL,
  `nombres` varchar(80) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `telefono` varchar(25) DEFAULT NULL,
  `correo` varchar(150) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `registro` (`registro`),
  UNIQUE KEY `documento` (`documento`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiantes`
--

LOCK TABLES `estudiantes` WRITE;
/*!40000 ALTER TABLE `estudiantes` DISABLE KEYS */;
INSERT INTO `estudiantes` VALUES (1,'EST-001','FICT-1001','Mateo','Rojas Salvatierra','2005-03-12','70000001','mateo@example.com','Calle Ficticia 10','2026-10-16 20:37:32'),(2,'EST-002','FICT-1002','Valeria','Méndez Suárez','2004-08-21','70000002','valeria@example.com','Calle Ficticia 20','2026-10-16 20:37:32'),(3,'EST-003','FICT-1003','Bruno','Castro Aguilar','2005-11-04','70000003','bruno@example.com','Calle Ficticia 30','2026-10-16 20:37:32'),(5,'DEMO-fbc571','FICT-fbc571','Elena','Salvatierra Demo','2005-02-15','70000009',NULL,NULL,'2026-10-16 20:47:53'),(6,'DEMO-E-00001','DEMO-EST-000001','Gabriel Adrián','Molina Flores','2001-12-01',NULL,'estudiante00001@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(7,'DEMO-E-00002','DEMO-EST-000002','Mateo Adrián','Molina Medina','2006-10-10',NULL,'estudiante00002@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(8,'DEMO-E-00003','DEMO-EST-000003','Daniel Adrián','Molina Cabrera','1998-08-21',NULL,'estudiante00003@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(9,'DEMO-E-00004','DEMO-EST-000004','Santiago Adrián','Molina Castillo','2006-12-26',NULL,'estudiante00004@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(10,'DEMO-E-00005','DEMO-EST-000005','Samuel Adrián','Molina Condori','2007-07-23',NULL,'estudiante00005@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(11,'DEMO-E-00006','DEMO-EST-000006','Diego Adrián','Molina Delgado','2006-05-10',NULL,'estudiante00006@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(12,'DEMO-E-00007','DEMO-EST-000007','Nicolás Adrián','Molina Aguilar','2004-10-19',NULL,'estudiante00007@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(13,'DEMO-E-00008','DEMO-EST-000008','Adrián Adrián','Molina Herrera','2000-10-09',NULL,'estudiante00008@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(14,'DEMO-E-00009','DEMO-EST-000009','Sebastián Adrián','Molina Suárez','2003-06-19',NULL,'estudiante00009@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(15,'DEMO-E-00010','DEMO-EST-000010','Alejandro Adrián','Molina Valdez','2002-10-09',NULL,'estudiante00010@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(16,'DEMO-E-00011','DEMO-EST-000011','Luis Adrián','Molina Choque','1997-03-29',NULL,'estudiante00011@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(17,'DEMO-E-00012','DEMO-EST-000012','Miguel Adrián','Molina Molina','2001-02-22',NULL,'estudiante00012@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(18,'DEMO-E-00013','DEMO-EST-000013','Carlos Adrián','Molina Salazar','2003-04-10',NULL,'estudiante00013@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(19,'DEMO-E-00014','DEMO-EST-000014','Javier Adrián','Molina Paredes','2001-02-14',NULL,'estudiante00014@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(20,'DEMO-E-00015','DEMO-EST-000015','Andrés Adrián','Molina Cruz','2004-03-24',NULL,'estudiante00015@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(21,'DEMO-E-00016','DEMO-EST-000016','Valeria Adrián','Molina Fernández','2007-01-28',NULL,'estudiante00016@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(22,'DEMO-E-00017','DEMO-EST-000017','Camila Adrián','Molina Pinto','2005-10-17',NULL,'estudiante00017@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(23,'DEMO-E-00018','DEMO-EST-000018','Lucía Adrián','Molina Rojas','2002-04-11',NULL,'estudiante00018@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(24,'DEMO-E-00019','DEMO-EST-000019','Mariana Adrián','Molina Ortega','2006-05-11',NULL,'estudiante00019@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(25,'DEMO-E-00020','DEMO-EST-000020','Daniela Adrián','Molina Torres','2005-02-11',NULL,'estudiante00020@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(26,'DEMO-E-00021','DEMO-EST-000021','Sofía Adrián','Molina Gutiérrez','1997-10-04',NULL,'estudiante00021@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(27,'DEMO-E-00022','DEMO-EST-000022','Paola Adrián','Molina Apaza','2005-12-27',NULL,'estudiante00022@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(28,'DEMO-E-00023','DEMO-EST-000023','Andrea Adrián','Molina Montes','1999-06-11',NULL,'estudiante00023@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(29,'DEMO-E-00024','DEMO-EST-000024','Gabriela Adrián','Molina Mendoza','1995-01-05',NULL,'estudiante00024@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(30,'DEMO-E-00025','DEMO-EST-000025','Natalia Adrián','Molina Soto','2000-08-18',NULL,'estudiante00025@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(31,'DEMO-E-00026','DEMO-EST-000026','Carolina Adrián','Molina Vega','1995-05-22',NULL,'estudiante00026@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(32,'DEMO-E-00027','DEMO-EST-000027','Fernanda Adrián','Molina Rivera','1995-02-18',NULL,'estudiante00027@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(33,'DEMO-E-00028','DEMO-EST-000028','Isabel Adrián','Molina Mamani','2002-08-14',NULL,'estudiante00028@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(34,'DEMO-E-00029','DEMO-EST-000029','Victoria Adrián','Molina Villarroel','1998-02-08',NULL,'estudiante00029@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(35,'DEMO-E-00030','DEMO-EST-000030','Elena Adrián','Molina Castro','1995-08-16',NULL,'estudiante00030@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(36,'DEMO-E-00031','DEMO-EST-000031','Rodrigo Adrián','Molina Morales','1998-05-13',NULL,'estudiante00031@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(37,'DEMO-E-00032','DEMO-EST-000032','Mauricio Adrián','Molina Ríos','2006-12-12',NULL,'estudiante00032@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(38,'DEMO-E-00033','DEMO-EST-000033','Eduardo Adrián','Molina Escobar','2002-12-21',NULL,'estudiante00033@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(39,'DEMO-E-00034','DEMO-EST-000034','Pablo Adrián','Molina Soria','2006-11-20',NULL,'estudiante00034@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(40,'DEMO-E-00035','DEMO-EST-000035','Ricardo Adrián','Molina Vargas','2002-08-24',NULL,'estudiante00035@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(41,'DEMO-E-00036','DEMO-EST-000036','Patricia Adrián','Molina Romero','1997-12-17',NULL,'estudiante00036@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(42,'DEMO-E-00037','DEMO-EST-000037','Claudia Adrián','Molina Navarro','1999-09-05',NULL,'estudiante00037@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(43,'DEMO-E-00038','DEMO-EST-000038','Lorena Adrián','Molina López','1998-01-17',NULL,'estudiante00038@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(44,'DEMO-E-00039','DEMO-EST-000039','Verónica Adrián','Molina Quispe','2007-09-06',NULL,'estudiante00039@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(45,'DEMO-E-00040','DEMO-EST-000040','Rosa Adrián','Molina Arias','2000-08-20',NULL,'estudiante00040@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(46,'DEMO-E-00041','DEMO-EST-000041','Gabriel Sebastián','Vargas Flores','1996-12-09',NULL,'estudiante00041@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(47,'DEMO-E-00042','DEMO-EST-000042','Mateo Sebastián','Vargas Medina','2000-11-03',NULL,'estudiante00042@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(48,'DEMO-E-00043','DEMO-EST-000043','Daniel Sebastián','Vargas Cabrera','2003-01-12',NULL,'estudiante00043@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(49,'DEMO-E-00044','DEMO-EST-000044','Santiago Sebastián','Vargas Castillo','1996-09-23',NULL,'estudiante00044@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(50,'DEMO-E-00045','DEMO-EST-000045','Samuel Sebastián','Vargas Condori','2006-12-06',NULL,'estudiante00045@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(51,'DEMO-E-00046','DEMO-EST-000046','Diego Sebastián','Vargas Delgado','2007-10-10',NULL,'estudiante00046@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(52,'DEMO-E-00047','DEMO-EST-000047','Nicolás Sebastián','Vargas Aguilar','1995-09-21',NULL,'estudiante00047@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(53,'DEMO-E-00048','DEMO-EST-000048','Adrián Sebastián','Vargas Herrera','1997-07-06',NULL,'estudiante00048@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(54,'DEMO-E-00049','DEMO-EST-000049','Sebastián Sebastián','Vargas Suárez','1999-05-31',NULL,'estudiante00049@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(55,'DEMO-E-00050','DEMO-EST-000050','Alejandro Sebastián','Vargas Valdez','2003-01-30',NULL,'estudiante00050@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(56,'DEMO-E-00051','DEMO-EST-000051','Luis Sebastián','Vargas Choque','1996-06-23',NULL,'estudiante00051@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(57,'DEMO-E-00052','DEMO-EST-000052','Miguel Sebastián','Vargas Molina','1995-02-25',NULL,'estudiante00052@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(58,'DEMO-E-00053','DEMO-EST-000053','Carlos Sebastián','Vargas Salazar','1996-02-03',NULL,'estudiante00053@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(59,'DEMO-E-00054','DEMO-EST-000054','Javier Sebastián','Vargas Paredes','1995-08-23',NULL,'estudiante00054@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(60,'DEMO-E-00055','DEMO-EST-000055','Andrés Sebastián','Vargas Cruz','2006-10-27',NULL,'estudiante00055@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(61,'DEMO-E-00056','DEMO-EST-000056','Valeria Sebastián','Vargas Fernández','2006-11-22',NULL,'estudiante00056@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(62,'DEMO-E-00057','DEMO-EST-000057','Camila Sebastián','Vargas Pinto','1996-02-15',NULL,'estudiante00057@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(63,'DEMO-E-00058','DEMO-EST-000058','Lucía Sebastián','Vargas Rojas','1997-12-13',NULL,'estudiante00058@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(64,'DEMO-E-00059','DEMO-EST-000059','Mariana Sebastián','Vargas Ortega','2001-05-31',NULL,'estudiante00059@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(65,'DEMO-E-00060','DEMO-EST-000060','Daniela Sebastián','Vargas Torres','1999-11-17',NULL,'estudiante00060@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(66,'DEMO-E-00061','DEMO-EST-000061','Sofía Sebastián','Vargas Gutiérrez','2006-06-30',NULL,'estudiante00061@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(67,'DEMO-E-00062','DEMO-EST-000062','Paola Sebastián','Vargas Apaza','2003-03-19',NULL,'estudiante00062@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(68,'DEMO-E-00063','DEMO-EST-000063','Andrea Sebastián','Vargas Montes','1999-03-11',NULL,'estudiante00063@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(69,'DEMO-E-00064','DEMO-EST-000064','Gabriela Sebastián','Vargas Mendoza','1996-03-08',NULL,'estudiante00064@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(70,'DEMO-E-00065','DEMO-EST-000065','Natalia Sebastián','Vargas Soto','2007-02-09',NULL,'estudiante00065@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(71,'DEMO-E-00066','DEMO-EST-000066','Carolina Sebastián','Vargas Vega','2004-11-07',NULL,'estudiante00066@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(72,'DEMO-E-00067','DEMO-EST-000067','Fernanda Sebastián','Vargas Rivera','2000-03-14',NULL,'estudiante00067@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(73,'DEMO-E-00068','DEMO-EST-000068','Isabel Sebastián','Vargas Mamani','1996-09-27',NULL,'estudiante00068@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(74,'DEMO-E-00069','DEMO-EST-000069','Victoria Sebastián','Vargas Villarroel','2004-12-06',NULL,'estudiante00069@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(75,'DEMO-E-00070','DEMO-EST-000070','Elena Sebastián','Vargas Castro','2007-01-23',NULL,'estudiante00070@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(76,'DEMO-E-00071','DEMO-EST-000071','Rodrigo Sebastián','Vargas Morales','1996-04-15',NULL,'estudiante00071@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(77,'DEMO-E-00072','DEMO-EST-000072','Mauricio Sebastián','Vargas Ríos','2000-09-19',NULL,'estudiante00072@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(78,'DEMO-E-00073','DEMO-EST-000073','Eduardo Sebastián','Vargas Escobar','2004-04-12',NULL,'estudiante00073@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(79,'DEMO-E-00074','DEMO-EST-000074','Pablo Sebastián','Vargas Soria','1999-04-05',NULL,'estudiante00074@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(80,'DEMO-E-00075','DEMO-EST-000075','Ricardo Sebastián','Vargas Vargas','2003-12-17',NULL,'estudiante00075@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(81,'DEMO-E-00076','DEMO-EST-000076','Patricia Sebastián','Vargas Romero','1996-03-10',NULL,'estudiante00076@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(82,'DEMO-E-00077','DEMO-EST-000077','Claudia Sebastián','Vargas Navarro','2002-03-05',NULL,'estudiante00077@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(83,'DEMO-E-00078','DEMO-EST-000078','Lorena Sebastián','Vargas López','2001-03-20',NULL,'estudiante00078@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(84,'DEMO-E-00079','DEMO-EST-000079','Verónica Sebastián','Vargas Quispe','1997-09-29',NULL,'estudiante00079@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(85,'DEMO-E-00080','DEMO-EST-000080','Rosa Sebastián','Vargas Arias','2000-03-08',NULL,'estudiante00080@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(86,'DEMO-E-00081','DEMO-EST-000081','Gabriel Alejandro','Rojas Flores','1995-09-30',NULL,'estudiante00081@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(87,'DEMO-E-00082','DEMO-EST-000082','Mateo Alejandro','Rojas Medina','1996-01-19',NULL,'estudiante00082@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(88,'DEMO-E-00083','DEMO-EST-000083','Daniel Alejandro','Rojas Cabrera','1995-05-22',NULL,'estudiante00083@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(89,'DEMO-E-00084','DEMO-EST-000084','Santiago Alejandro','Rojas Castillo','2005-01-07',NULL,'estudiante00084@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(90,'DEMO-E-00085','DEMO-EST-000085','Samuel Alejandro','Rojas Condori','2004-06-29',NULL,'estudiante00085@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(91,'DEMO-E-00086','DEMO-EST-000086','Diego Alejandro','Rojas Delgado','1999-08-18',NULL,'estudiante00086@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(92,'DEMO-E-00087','DEMO-EST-000087','Nicolás Alejandro','Rojas Aguilar','1998-05-08',NULL,'estudiante00087@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(93,'DEMO-E-00088','DEMO-EST-000088','Adrián Alejandro','Rojas Herrera','2004-12-06',NULL,'estudiante00088@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(94,'DEMO-E-00089','DEMO-EST-000089','Sebastián Alejandro','Rojas Suárez','1997-01-27',NULL,'estudiante00089@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(95,'DEMO-E-00090','DEMO-EST-000090','Alejandro Alejandro','Rojas Valdez','2004-07-05',NULL,'estudiante00090@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(96,'DEMO-E-00091','DEMO-EST-000091','Luis Alejandro','Rojas Choque','2000-09-17',NULL,'estudiante00091@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(97,'DEMO-E-00092','DEMO-EST-000092','Miguel Alejandro','Rojas Molina','2002-08-03',NULL,'estudiante00092@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(98,'DEMO-E-00093','DEMO-EST-000093','Carlos Alejandro','Rojas Salazar','2001-12-09',NULL,'estudiante00093@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(99,'DEMO-E-00094','DEMO-EST-000094','Javier Alejandro','Rojas Paredes','2000-11-23',NULL,'estudiante00094@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(100,'DEMO-E-00095','DEMO-EST-000095','Andrés Alejandro','Rojas Cruz','1996-10-27',NULL,'estudiante00095@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(101,'DEMO-E-00096','DEMO-EST-000096','Valeria Alejandro','Rojas Fernández','2002-04-20',NULL,'estudiante00096@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(102,'DEMO-E-00097','DEMO-EST-000097','Camila Alejandro','Rojas Pinto','1997-03-03',NULL,'estudiante00097@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(103,'DEMO-E-00098','DEMO-EST-000098','Lucía Alejandro','Rojas Rojas','2000-01-01',NULL,'estudiante00098@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(104,'DEMO-E-00099','DEMO-EST-000099','Mariana Alejandro','Rojas Ortega','2000-01-09',NULL,'estudiante00099@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(105,'DEMO-E-00100','DEMO-EST-000100','Daniela Alejandro','Rojas Torres','2005-01-15',NULL,'estudiante00100@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(106,'DEMO-E-00101','DEMO-EST-000101','Sofía Alejandro','Rojas Gutiérrez','2005-02-08',NULL,'estudiante00101@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(107,'DEMO-E-00102','DEMO-EST-000102','Paola Alejandro','Rojas Apaza','2000-09-14',NULL,'estudiante00102@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(108,'DEMO-E-00103','DEMO-EST-000103','Andrea Alejandro','Rojas Montes','1997-08-25',NULL,'estudiante00103@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(109,'DEMO-E-00104','DEMO-EST-000104','Gabriela Alejandro','Rojas Mendoza','2001-08-27',NULL,'estudiante00104@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(110,'DEMO-E-00105','DEMO-EST-000105','Natalia Alejandro','Rojas Soto','2001-01-11',NULL,'estudiante00105@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(111,'DEMO-E-00106','DEMO-EST-000106','Carolina Alejandro','Rojas Vega','2001-01-30',NULL,'estudiante00106@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(112,'DEMO-E-00107','DEMO-EST-000107','Fernanda Alejandro','Rojas Rivera','2002-11-08',NULL,'estudiante00107@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(113,'DEMO-E-00108','DEMO-EST-000108','Isabel Alejandro','Rojas Mamani','1997-05-08',NULL,'estudiante00108@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(114,'DEMO-E-00109','DEMO-EST-000109','Victoria Alejandro','Rojas Villarroel','2005-02-14',NULL,'estudiante00109@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(115,'DEMO-E-00110','DEMO-EST-000110','Elena Alejandro','Rojas Castro','2000-02-04',NULL,'estudiante00110@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(116,'DEMO-E-00111','DEMO-EST-000111','Rodrigo Alejandro','Rojas Morales','2000-04-16',NULL,'estudiante00111@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(117,'DEMO-E-00112','DEMO-EST-000112','Mauricio Alejandro','Rojas Ríos','2000-04-03',NULL,'estudiante00112@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(118,'DEMO-E-00113','DEMO-EST-000113','Eduardo Alejandro','Rojas Escobar','1998-06-10',NULL,'estudiante00113@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(119,'DEMO-E-00114','DEMO-EST-000114','Pablo Alejandro','Rojas Soria','2007-07-18',NULL,'estudiante00114@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(120,'DEMO-E-00115','DEMO-EST-000115','Ricardo Alejandro','Rojas Vargas','1999-02-24',NULL,'estudiante00115@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(121,'DEMO-E-00116','DEMO-EST-000116','Patricia Alejandro','Rojas Romero','2000-01-25',NULL,'estudiante00116@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(122,'DEMO-E-00117','DEMO-EST-000117','Claudia Alejandro','Rojas Navarro','1998-12-01',NULL,'estudiante00117@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(123,'DEMO-E-00118','DEMO-EST-000118','Lorena Alejandro','Rojas López','2002-04-09',NULL,'estudiante00118@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(124,'DEMO-E-00119','DEMO-EST-000119','Verónica Alejandro','Rojas Quispe','2000-09-03',NULL,'estudiante00119@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(125,'DEMO-E-00120','DEMO-EST-000120','Rosa Alejandro','Rojas Arias','1997-10-11',NULL,'estudiante00120@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(126,'DEMO-E-00121','DEMO-EST-000121','Gabriel Luis','Flores Flores','2004-10-06',NULL,'estudiante00121@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(127,'DEMO-E-00122','DEMO-EST-000122','Mateo Luis','Flores Medina','1996-11-04',NULL,'estudiante00122@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(128,'DEMO-E-00123','DEMO-EST-000123','Daniel Luis','Flores Cabrera','1999-10-04',NULL,'estudiante00123@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(129,'DEMO-E-00124','DEMO-EST-000124','Santiago Luis','Flores Castillo','2004-02-15',NULL,'estudiante00124@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(130,'DEMO-E-00125','DEMO-EST-000125','Samuel Luis','Flores Condori','2007-09-28',NULL,'estudiante00125@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(131,'DEMO-E-00126','DEMO-EST-000126','Diego Luis','Flores Delgado','1995-12-02',NULL,'estudiante00126@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(132,'DEMO-E-00127','DEMO-EST-000127','Nicolás Luis','Flores Aguilar','2006-01-25',NULL,'estudiante00127@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(133,'DEMO-E-00128','DEMO-EST-000128','Adrián Luis','Flores Herrera','2007-08-05',NULL,'estudiante00128@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(134,'DEMO-E-00129','DEMO-EST-000129','Sebastián Luis','Flores Suárez','2002-11-01',NULL,'estudiante00129@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(135,'DEMO-E-00130','DEMO-EST-000130','Alejandro Luis','Flores Valdez','2003-03-31',NULL,'estudiante00130@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(136,'DEMO-E-00131','DEMO-EST-000131','Luis Luis','Flores Choque','1996-11-27',NULL,'estudiante00131@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(137,'DEMO-E-00132','DEMO-EST-000132','Miguel Luis','Flores Molina','1996-10-08',NULL,'estudiante00132@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(138,'DEMO-E-00133','DEMO-EST-000133','Carlos Luis','Flores Salazar','2007-08-17',NULL,'estudiante00133@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(139,'DEMO-E-00134','DEMO-EST-000134','Javier Luis','Flores Paredes','1995-04-12',NULL,'estudiante00134@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(140,'DEMO-E-00135','DEMO-EST-000135','Andrés Luis','Flores Cruz','1999-09-12',NULL,'estudiante00135@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(141,'DEMO-E-00136','DEMO-EST-000136','Valeria Luis','Flores Fernández','2005-09-22',NULL,'estudiante00136@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(142,'DEMO-E-00137','DEMO-EST-000137','Camila Luis','Flores Pinto','1998-09-02',NULL,'estudiante00137@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(143,'DEMO-E-00138','DEMO-EST-000138','Lucía Luis','Flores Rojas','1999-09-27',NULL,'estudiante00138@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(144,'DEMO-E-00139','DEMO-EST-000139','Mariana Luis','Flores Ortega','2004-01-19',NULL,'estudiante00139@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(145,'DEMO-E-00140','DEMO-EST-000140','Daniela Luis','Flores Torres','1998-06-21',NULL,'estudiante00140@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(146,'DEMO-E-00141','DEMO-EST-000141','Sofía Luis','Flores Gutiérrez','1995-11-30',NULL,'estudiante00141@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(147,'DEMO-E-00142','DEMO-EST-000142','Paola Luis','Flores Apaza','2001-09-09',NULL,'estudiante00142@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(148,'DEMO-E-00143','DEMO-EST-000143','Andrea Luis','Flores Montes','1997-10-11',NULL,'estudiante00143@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(149,'DEMO-E-00144','DEMO-EST-000144','Gabriela Luis','Flores Mendoza','1997-03-28',NULL,'estudiante00144@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(150,'DEMO-E-00145','DEMO-EST-000145','Natalia Luis','Flores Soto','1997-02-21',NULL,'estudiante00145@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(151,'DEMO-E-00146','DEMO-EST-000146','Carolina Luis','Flores Vega','2000-04-28',NULL,'estudiante00146@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(152,'DEMO-E-00147','DEMO-EST-000147','Fernanda Luis','Flores Rivera','1997-03-31',NULL,'estudiante00147@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(153,'DEMO-E-00148','DEMO-EST-000148','Isabel Luis','Flores Mamani','2002-08-01',NULL,'estudiante00148@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(154,'DEMO-E-00149','DEMO-EST-000149','Victoria Luis','Flores Villarroel','1997-10-10',NULL,'estudiante00149@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(155,'DEMO-E-00150','DEMO-EST-000150','Elena Luis','Flores Castro','1998-04-24',NULL,'estudiante00150@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(156,'DEMO-E-00151','DEMO-EST-000151','Rodrigo Luis','Flores Morales','2000-10-01',NULL,'estudiante00151@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(157,'DEMO-E-00152','DEMO-EST-000152','Mauricio Luis','Flores Ríos','1998-06-05',NULL,'estudiante00152@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(158,'DEMO-E-00153','DEMO-EST-000153','Eduardo Luis','Flores Escobar','2003-05-27',NULL,'estudiante00153@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(159,'DEMO-E-00154','DEMO-EST-000154','Pablo Luis','Flores Soria','1995-11-28',NULL,'estudiante00154@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(160,'DEMO-E-00155','DEMO-EST-000155','Ricardo Luis','Flores Vargas','2000-02-03',NULL,'estudiante00155@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(161,'DEMO-E-00156','DEMO-EST-000156','Patricia Luis','Flores Romero','2006-01-31',NULL,'estudiante00156@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(162,'DEMO-E-00157','DEMO-EST-000157','Claudia Luis','Flores Navarro','2005-12-20',NULL,'estudiante00157@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(163,'DEMO-E-00158','DEMO-EST-000158','Lorena Luis','Flores López','2004-08-06',NULL,'estudiante00158@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(164,'DEMO-E-00159','DEMO-EST-000159','Verónica Luis','Flores Quispe','1995-07-15',NULL,'estudiante00159@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(165,'DEMO-E-00160','DEMO-EST-000160','Rosa Luis','Flores Arias','2001-07-14',NULL,'estudiante00160@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(166,'DEMO-E-00161','DEMO-EST-000161','Gabriel Miguel','Mendoza Flores','2005-02-05',NULL,'estudiante00161@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(167,'DEMO-E-00162','DEMO-EST-000162','Mateo Miguel','Mendoza Medina','2005-02-17',NULL,'estudiante00162@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(168,'DEMO-E-00163','DEMO-EST-000163','Daniel Miguel','Mendoza Cabrera','2000-01-18',NULL,'estudiante00163@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(169,'DEMO-E-00164','DEMO-EST-000164','Santiago Miguel','Mendoza Castillo','2004-05-20',NULL,'estudiante00164@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(170,'DEMO-E-00165','DEMO-EST-000165','Samuel Miguel','Mendoza Condori','2000-05-23',NULL,'estudiante00165@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(171,'DEMO-E-00166','DEMO-EST-000166','Diego Miguel','Mendoza Delgado','2006-06-30',NULL,'estudiante00166@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(172,'DEMO-E-00167','DEMO-EST-000167','Nicolás Miguel','Mendoza Aguilar','2004-01-05',NULL,'estudiante00167@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(173,'DEMO-E-00168','DEMO-EST-000168','Adrián Miguel','Mendoza Herrera','1998-03-16',NULL,'estudiante00168@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(174,'DEMO-E-00169','DEMO-EST-000169','Sebastián Miguel','Mendoza Suárez','1999-04-15',NULL,'estudiante00169@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(175,'DEMO-E-00170','DEMO-EST-000170','Alejandro Miguel','Mendoza Valdez','2005-08-11',NULL,'estudiante00170@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(176,'DEMO-E-00171','DEMO-EST-000171','Luis Miguel','Mendoza Choque','2005-01-10',NULL,'estudiante00171@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(177,'DEMO-E-00172','DEMO-EST-000172','Miguel Miguel','Mendoza Molina','1999-04-14',NULL,'estudiante00172@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(178,'DEMO-E-00173','DEMO-EST-000173','Carlos Miguel','Mendoza Salazar','2000-07-18',NULL,'estudiante00173@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(179,'DEMO-E-00174','DEMO-EST-000174','Javier Miguel','Mendoza Paredes','2003-07-02',NULL,'estudiante00174@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(180,'DEMO-E-00175','DEMO-EST-000175','Andrés Miguel','Mendoza Cruz','1996-09-25',NULL,'estudiante00175@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(181,'DEMO-E-00176','DEMO-EST-000176','Valeria Miguel','Mendoza Fernández','2002-11-18',NULL,'estudiante00176@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(182,'DEMO-E-00177','DEMO-EST-000177','Camila Miguel','Mendoza Pinto','2007-08-27',NULL,'estudiante00177@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(183,'DEMO-E-00178','DEMO-EST-000178','Lucía Miguel','Mendoza Rojas','2007-09-23',NULL,'estudiante00178@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(184,'DEMO-E-00179','DEMO-EST-000179','Mariana Miguel','Mendoza Ortega','1995-03-18',NULL,'estudiante00179@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(185,'DEMO-E-00180','DEMO-EST-000180','Daniela Miguel','Mendoza Torres','1999-04-18',NULL,'estudiante00180@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(186,'DEMO-E-00181','DEMO-EST-000181','Sofía Miguel','Mendoza Gutiérrez','2003-08-05',NULL,'estudiante00181@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(187,'DEMO-E-00182','DEMO-EST-000182','Paola Miguel','Mendoza Apaza','1999-03-15',NULL,'estudiante00182@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(188,'DEMO-E-00183','DEMO-EST-000183','Andrea Miguel','Mendoza Montes','2000-07-20',NULL,'estudiante00183@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(189,'DEMO-E-00184','DEMO-EST-000184','Gabriela Miguel','Mendoza Mendoza','1999-06-21',NULL,'estudiante00184@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(190,'DEMO-E-00185','DEMO-EST-000185','Natalia Miguel','Mendoza Soto','2005-03-27',NULL,'estudiante00185@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(191,'DEMO-E-00186','DEMO-EST-000186','Carolina Miguel','Mendoza Vega','2006-10-11',NULL,'estudiante00186@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(192,'DEMO-E-00187','DEMO-EST-000187','Fernanda Miguel','Mendoza Rivera','2003-02-14',NULL,'estudiante00187@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(193,'DEMO-E-00188','DEMO-EST-000188','Isabel Miguel','Mendoza Mamani','2006-04-17',NULL,'estudiante00188@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(194,'DEMO-E-00189','DEMO-EST-000189','Victoria Miguel','Mendoza Villarroel','2007-08-09',NULL,'estudiante00189@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(195,'DEMO-E-00190','DEMO-EST-000190','Elena Miguel','Mendoza Castro','2007-10-19',NULL,'estudiante00190@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(196,'DEMO-E-00191','DEMO-EST-000191','Rodrigo Miguel','Mendoza Morales','2000-04-15',NULL,'estudiante00191@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(197,'DEMO-E-00192','DEMO-EST-000192','Mauricio Miguel','Mendoza Ríos','2004-01-12',NULL,'estudiante00192@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(198,'DEMO-E-00193','DEMO-EST-000193','Eduardo Miguel','Mendoza Escobar','1995-10-19',NULL,'estudiante00193@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(199,'DEMO-E-00194','DEMO-EST-000194','Pablo Miguel','Mendoza Soria','2000-05-03',NULL,'estudiante00194@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(200,'DEMO-E-00195','DEMO-EST-000195','Ricardo Miguel','Mendoza Vargas','2002-10-03',NULL,'estudiante00195@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(201,'DEMO-E-00196','DEMO-EST-000196','Patricia Miguel','Mendoza Romero','2001-01-06',NULL,'estudiante00196@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(202,'DEMO-E-00197','DEMO-EST-000197','Claudia Miguel','Mendoza Navarro','1999-08-22',NULL,'estudiante00197@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(203,'DEMO-E-00198','DEMO-EST-000198','Lorena Miguel','Mendoza López','1995-04-09',NULL,'estudiante00198@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(204,'DEMO-E-00199','DEMO-EST-000199','Verónica Miguel','Mendoza Quispe','2004-05-16',NULL,'estudiante00199@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(205,'DEMO-E-00200','DEMO-EST-000200','Rosa Miguel','Mendoza Arias','1997-09-20',NULL,'estudiante00200@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(206,'DEMO-E-00201','DEMO-EST-000201','Gabriel Carlos','Aguilar Flores','2002-06-07',NULL,'estudiante00201@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(207,'DEMO-E-00202','DEMO-EST-000202','Mateo Carlos','Aguilar Medina','2003-04-23',NULL,'estudiante00202@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(208,'DEMO-E-00203','DEMO-EST-000203','Daniel Carlos','Aguilar Cabrera','2006-04-25',NULL,'estudiante00203@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(209,'DEMO-E-00204','DEMO-EST-000204','Santiago Carlos','Aguilar Castillo','2007-11-30',NULL,'estudiante00204@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(210,'DEMO-E-00205','DEMO-EST-000205','Samuel Carlos','Aguilar Condori','2000-08-31',NULL,'estudiante00205@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(211,'DEMO-E-00206','DEMO-EST-000206','Diego Carlos','Aguilar Delgado','2002-07-07',NULL,'estudiante00206@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(212,'DEMO-E-00207','DEMO-EST-000207','Nicolás Carlos','Aguilar Aguilar','1997-10-26',NULL,'estudiante00207@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(213,'DEMO-E-00208','DEMO-EST-000208','Adrián Carlos','Aguilar Herrera','1999-09-17',NULL,'estudiante00208@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(214,'DEMO-E-00209','DEMO-EST-000209','Sebastián Carlos','Aguilar Suárez','1999-08-04',NULL,'estudiante00209@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(215,'DEMO-E-00210','DEMO-EST-000210','Alejandro Carlos','Aguilar Valdez','1996-02-07',NULL,'estudiante00210@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(216,'DEMO-E-00211','DEMO-EST-000211','Luis Carlos','Aguilar Choque','2003-12-31',NULL,'estudiante00211@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(217,'DEMO-E-00212','DEMO-EST-000212','Miguel Carlos','Aguilar Molina','1997-08-07',NULL,'estudiante00212@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(218,'DEMO-E-00213','DEMO-EST-000213','Carlos Carlos','Aguilar Salazar','2003-08-17',NULL,'estudiante00213@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(219,'DEMO-E-00214','DEMO-EST-000214','Javier Carlos','Aguilar Paredes','1997-11-11',NULL,'estudiante00214@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(220,'DEMO-E-00215','DEMO-EST-000215','Andrés Carlos','Aguilar Cruz','2002-06-09',NULL,'estudiante00215@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(221,'DEMO-E-00216','DEMO-EST-000216','Valeria Carlos','Aguilar Fernández','2000-10-22',NULL,'estudiante00216@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(222,'DEMO-E-00217','DEMO-EST-000217','Camila Carlos','Aguilar Pinto','2002-02-13',NULL,'estudiante00217@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(223,'DEMO-E-00218','DEMO-EST-000218','Lucía Carlos','Aguilar Rojas','1998-10-19',NULL,'estudiante00218@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(224,'DEMO-E-00219','DEMO-EST-000219','Mariana Carlos','Aguilar Ortega','1998-08-06',NULL,'estudiante00219@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(225,'DEMO-E-00220','DEMO-EST-000220','Daniela Carlos','Aguilar Torres','2005-01-26',NULL,'estudiante00220@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(226,'DEMO-E-00221','DEMO-EST-000221','Sofía Carlos','Aguilar Gutiérrez','2003-08-19',NULL,'estudiante00221@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(227,'DEMO-E-00222','DEMO-EST-000222','Paola Carlos','Aguilar Apaza','2004-01-03',NULL,'estudiante00222@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(228,'DEMO-E-00223','DEMO-EST-000223','Andrea Carlos','Aguilar Montes','1998-01-22',NULL,'estudiante00223@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(229,'DEMO-E-00224','DEMO-EST-000224','Gabriela Carlos','Aguilar Mendoza','2003-05-02',NULL,'estudiante00224@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(230,'DEMO-E-00225','DEMO-EST-000225','Natalia Carlos','Aguilar Soto','2006-01-05',NULL,'estudiante00225@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(231,'DEMO-E-00226','DEMO-EST-000226','Carolina Carlos','Aguilar Vega','1996-06-09',NULL,'estudiante00226@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(232,'DEMO-E-00227','DEMO-EST-000227','Fernanda Carlos','Aguilar Rivera','2006-06-24',NULL,'estudiante00227@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(233,'DEMO-E-00228','DEMO-EST-000228','Isabel Carlos','Aguilar Mamani','1995-04-14',NULL,'estudiante00228@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(234,'DEMO-E-00229','DEMO-EST-000229','Victoria Carlos','Aguilar Villarroel','2006-06-28',NULL,'estudiante00229@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(235,'DEMO-E-00230','DEMO-EST-000230','Elena Carlos','Aguilar Castro','2005-06-08',NULL,'estudiante00230@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(236,'DEMO-E-00231','DEMO-EST-000231','Rodrigo Carlos','Aguilar Morales','1996-01-31',NULL,'estudiante00231@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(237,'DEMO-E-00232','DEMO-EST-000232','Mauricio Carlos','Aguilar Ríos','1999-11-29',NULL,'estudiante00232@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(238,'DEMO-E-00233','DEMO-EST-000233','Eduardo Carlos','Aguilar Escobar','2004-07-23',NULL,'estudiante00233@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(239,'DEMO-E-00234','DEMO-EST-000234','Pablo Carlos','Aguilar Soria','2006-12-04',NULL,'estudiante00234@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(240,'DEMO-E-00235','DEMO-EST-000235','Ricardo Carlos','Aguilar Vargas','1996-04-15',NULL,'estudiante00235@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(241,'DEMO-E-00236','DEMO-EST-000236','Patricia Carlos','Aguilar Romero','1998-12-28',NULL,'estudiante00236@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(242,'DEMO-E-00237','DEMO-EST-000237','Claudia Carlos','Aguilar Navarro','2002-12-17',NULL,'estudiante00237@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(243,'DEMO-E-00238','DEMO-EST-000238','Lorena Carlos','Aguilar López','1995-12-03',NULL,'estudiante00238@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(244,'DEMO-E-00239','DEMO-EST-000239','Verónica Carlos','Aguilar Quispe','1998-05-23',NULL,'estudiante00239@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(245,'DEMO-E-00240','DEMO-EST-000240','Rosa Carlos','Aguilar Arias','1997-02-03',NULL,'estudiante00240@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(246,'DEMO-E-00241','DEMO-EST-000241','Gabriel Javier','Castro Flores','2006-05-28',NULL,'estudiante00241@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(247,'DEMO-E-00242','DEMO-EST-000242','Mateo Javier','Castro Medina','2002-09-30',NULL,'estudiante00242@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(248,'DEMO-E-00243','DEMO-EST-000243','Daniel Javier','Castro Cabrera','2003-06-04',NULL,'estudiante00243@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(249,'DEMO-E-00244','DEMO-EST-000244','Santiago Javier','Castro Castillo','1995-08-07',NULL,'estudiante00244@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(250,'DEMO-E-00245','DEMO-EST-000245','Samuel Javier','Castro Condori','2007-07-12',NULL,'estudiante00245@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(251,'DEMO-E-00246','DEMO-EST-000246','Diego Javier','Castro Delgado','2007-05-15',NULL,'estudiante00246@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(252,'DEMO-E-00247','DEMO-EST-000247','Nicolás Javier','Castro Aguilar','1998-02-28',NULL,'estudiante00247@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(253,'DEMO-E-00248','DEMO-EST-000248','Adrián Javier','Castro Herrera','1999-11-24',NULL,'estudiante00248@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(254,'DEMO-E-00249','DEMO-EST-000249','Sebastián Javier','Castro Suárez','2003-08-07',NULL,'estudiante00249@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(255,'DEMO-E-00250','DEMO-EST-000250','Alejandro Javier','Castro Valdez','2006-05-31',NULL,'estudiante00250@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(256,'DEMO-E-00251','DEMO-EST-000251','Luis Javier','Castro Choque','2001-05-02',NULL,'estudiante00251@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(257,'DEMO-E-00252','DEMO-EST-000252','Miguel Javier','Castro Molina','1998-10-15',NULL,'estudiante00252@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(258,'DEMO-E-00253','DEMO-EST-000253','Carlos Javier','Castro Salazar','2004-03-31',NULL,'estudiante00253@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(259,'DEMO-E-00254','DEMO-EST-000254','Javier Javier','Castro Paredes','2005-04-01',NULL,'estudiante00254@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(260,'DEMO-E-00255','DEMO-EST-000255','Andrés Javier','Castro Cruz','2004-11-21',NULL,'estudiante00255@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(261,'DEMO-E-00256','DEMO-EST-000256','Valeria Javier','Castro Fernández','2002-03-28',NULL,'estudiante00256@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(262,'DEMO-E-00257','DEMO-EST-000257','Camila Javier','Castro Pinto','1999-06-15',NULL,'estudiante00257@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(263,'DEMO-E-00258','DEMO-EST-000258','Lucía Javier','Castro Rojas','1995-02-16',NULL,'estudiante00258@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(264,'DEMO-E-00259','DEMO-EST-000259','Mariana Javier','Castro Ortega','1995-04-17',NULL,'estudiante00259@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(265,'DEMO-E-00260','DEMO-EST-000260','Daniela Javier','Castro Torres','2006-08-22',NULL,'estudiante00260@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(266,'DEMO-E-00261','DEMO-EST-000261','Sofía Javier','Castro Gutiérrez','1997-09-22',NULL,'estudiante00261@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(267,'DEMO-E-00262','DEMO-EST-000262','Paola Javier','Castro Apaza','1998-02-08',NULL,'estudiante00262@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(268,'DEMO-E-00263','DEMO-EST-000263','Andrea Javier','Castro Montes','2005-11-29',NULL,'estudiante00263@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(269,'DEMO-E-00264','DEMO-EST-000264','Gabriela Javier','Castro Mendoza','2002-08-04',NULL,'estudiante00264@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(270,'DEMO-E-00265','DEMO-EST-000265','Natalia Javier','Castro Soto','2006-11-03',NULL,'estudiante00265@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(271,'DEMO-E-00266','DEMO-EST-000266','Carolina Javier','Castro Vega','2007-08-28',NULL,'estudiante00266@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(272,'DEMO-E-00267','DEMO-EST-000267','Fernanda Javier','Castro Rivera','1995-10-31',NULL,'estudiante00267@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(273,'DEMO-E-00268','DEMO-EST-000268','Isabel Javier','Castro Mamani','1995-09-09',NULL,'estudiante00268@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(274,'DEMO-E-00269','DEMO-EST-000269','Victoria Javier','Castro Villarroel','1999-06-19',NULL,'estudiante00269@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(275,'DEMO-E-00270','DEMO-EST-000270','Elena Javier','Castro Castro','2002-07-01',NULL,'estudiante00270@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(276,'DEMO-E-00271','DEMO-EST-000271','Rodrigo Javier','Castro Morales','2001-03-17',NULL,'estudiante00271@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(277,'DEMO-E-00272','DEMO-EST-000272','Mauricio Javier','Castro Ríos','1998-04-23',NULL,'estudiante00272@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(278,'DEMO-E-00273','DEMO-EST-000273','Eduardo Javier','Castro Escobar','2006-12-26',NULL,'estudiante00273@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(279,'DEMO-E-00274','DEMO-EST-000274','Pablo Javier','Castro Soria','1997-11-23',NULL,'estudiante00274@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(280,'DEMO-E-00275','DEMO-EST-000275','Ricardo Javier','Castro Vargas','2003-12-27',NULL,'estudiante00275@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(281,'DEMO-E-00276','DEMO-EST-000276','Patricia Javier','Castro Romero','1998-03-09',NULL,'estudiante00276@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(282,'DEMO-E-00277','DEMO-EST-000277','Claudia Javier','Castro Navarro','2000-10-19',NULL,'estudiante00277@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(283,'DEMO-E-00278','DEMO-EST-000278','Lorena Javier','Castro López','1999-08-06',NULL,'estudiante00278@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(284,'DEMO-E-00279','DEMO-EST-000279','Verónica Javier','Castro Quispe','2006-07-13',NULL,'estudiante00279@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(285,'DEMO-E-00280','DEMO-EST-000280','Rosa Javier','Castro Arias','2006-12-09',NULL,'estudiante00280@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(286,'DEMO-E-00281','DEMO-EST-000281','Gabriel Andrés','Salazar Flores','2004-03-21',NULL,'estudiante00281@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(287,'DEMO-E-00282','DEMO-EST-000282','Mateo Andrés','Salazar Medina','2000-05-30',NULL,'estudiante00282@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(288,'DEMO-E-00283','DEMO-EST-000283','Daniel Andrés','Salazar Cabrera','2003-09-30',NULL,'estudiante00283@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(289,'DEMO-E-00284','DEMO-EST-000284','Santiago Andrés','Salazar Castillo','1995-08-28',NULL,'estudiante00284@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(290,'DEMO-E-00285','DEMO-EST-000285','Samuel Andrés','Salazar Condori','2004-01-10',NULL,'estudiante00285@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(291,'DEMO-E-00286','DEMO-EST-000286','Diego Andrés','Salazar Delgado','2000-09-30',NULL,'estudiante00286@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(292,'DEMO-E-00287','DEMO-EST-000287','Nicolás Andrés','Salazar Aguilar','2002-09-03',NULL,'estudiante00287@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(293,'DEMO-E-00288','DEMO-EST-000288','Adrián Andrés','Salazar Herrera','1996-11-09',NULL,'estudiante00288@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(294,'DEMO-E-00289','DEMO-EST-000289','Sebastián Andrés','Salazar Suárez','2002-02-17',NULL,'estudiante00289@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(295,'DEMO-E-00290','DEMO-EST-000290','Alejandro Andrés','Salazar Valdez','2006-10-11',NULL,'estudiante00290@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(296,'DEMO-E-00291','DEMO-EST-000291','Luis Andrés','Salazar Choque','2003-12-01',NULL,'estudiante00291@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(297,'DEMO-E-00292','DEMO-EST-000292','Miguel Andrés','Salazar Molina','2002-06-23',NULL,'estudiante00292@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(298,'DEMO-E-00293','DEMO-EST-000293','Carlos Andrés','Salazar Salazar','1995-10-20',NULL,'estudiante00293@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(299,'DEMO-E-00294','DEMO-EST-000294','Javier Andrés','Salazar Paredes','2004-12-20',NULL,'estudiante00294@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(300,'DEMO-E-00295','DEMO-EST-000295','Andrés Andrés','Salazar Cruz','1998-12-04',NULL,'estudiante00295@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(301,'DEMO-E-00296','DEMO-EST-000296','Valeria Andrés','Salazar Fernández','2004-06-11',NULL,'estudiante00296@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(302,'DEMO-E-00297','DEMO-EST-000297','Camila Andrés','Salazar Pinto','1997-07-13',NULL,'estudiante00297@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(303,'DEMO-E-00298','DEMO-EST-000298','Lucía Andrés','Salazar Rojas','1997-04-20',NULL,'estudiante00298@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(304,'DEMO-E-00299','DEMO-EST-000299','Mariana Andrés','Salazar Ortega','2005-07-13',NULL,'estudiante00299@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(305,'DEMO-E-00300','DEMO-EST-000300','Daniela Andrés','Salazar Torres','2004-06-28',NULL,'estudiante00300@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(306,'DEMO-E-00301','DEMO-EST-000301','Sofía Andrés','Salazar Gutiérrez','1998-01-31',NULL,'estudiante00301@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(307,'DEMO-E-00302','DEMO-EST-000302','Paola Andrés','Salazar Apaza','1998-03-21',NULL,'estudiante00302@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(308,'DEMO-E-00303','DEMO-EST-000303','Andrea Andrés','Salazar Montes','1999-01-19',NULL,'estudiante00303@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(309,'DEMO-E-00304','DEMO-EST-000304','Gabriela Andrés','Salazar Mendoza','2006-02-02',NULL,'estudiante00304@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(310,'DEMO-E-00305','DEMO-EST-000305','Natalia Andrés','Salazar Soto','2007-06-13',NULL,'estudiante00305@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(311,'DEMO-E-00306','DEMO-EST-000306','Carolina Andrés','Salazar Vega','2000-07-23',NULL,'estudiante00306@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(312,'DEMO-E-00307','DEMO-EST-000307','Fernanda Andrés','Salazar Rivera','1996-05-11',NULL,'estudiante00307@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(313,'DEMO-E-00308','DEMO-EST-000308','Isabel Andrés','Salazar Mamani','2001-07-19',NULL,'estudiante00308@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(314,'DEMO-E-00309','DEMO-EST-000309','Victoria Andrés','Salazar Villarroel','2004-06-13',NULL,'estudiante00309@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(315,'DEMO-E-00310','DEMO-EST-000310','Elena Andrés','Salazar Castro','2005-04-14',NULL,'estudiante00310@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(316,'DEMO-E-00311','DEMO-EST-000311','Rodrigo Andrés','Salazar Morales','2006-06-19',NULL,'estudiante00311@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(317,'DEMO-E-00312','DEMO-EST-000312','Mauricio Andrés','Salazar Ríos','1996-12-21',NULL,'estudiante00312@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(318,'DEMO-E-00313','DEMO-EST-000313','Eduardo Andrés','Salazar Escobar','1995-04-28',NULL,'estudiante00313@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(319,'DEMO-E-00314','DEMO-EST-000314','Pablo Andrés','Salazar Soria','1998-01-15',NULL,'estudiante00314@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(320,'DEMO-E-00315','DEMO-EST-000315','Ricardo Andrés','Salazar Vargas','1995-05-11',NULL,'estudiante00315@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(321,'DEMO-E-00316','DEMO-EST-000316','Patricia Andrés','Salazar Romero','1997-03-09',NULL,'estudiante00316@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(322,'DEMO-E-00317','DEMO-EST-000317','Claudia Andrés','Salazar Navarro','1998-04-23',NULL,'estudiante00317@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(323,'DEMO-E-00318','DEMO-EST-000318','Lorena Andrés','Salazar López','1999-11-02',NULL,'estudiante00318@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(324,'DEMO-E-00319','DEMO-EST-000319','Verónica Andrés','Salazar Quispe','1997-01-05',NULL,'estudiante00319@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(325,'DEMO-E-00320','DEMO-EST-000320','Rosa Andrés','Salazar Arias','1998-02-12',NULL,'estudiante00320@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(326,'DEMO-E-00321','DEMO-EST-000321','Gabriel Valeria','Romero Flores','2007-04-17',NULL,'estudiante00321@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(327,'DEMO-E-00322','DEMO-EST-000322','Mateo Valeria','Romero Medina','2005-09-21',NULL,'estudiante00322@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(328,'DEMO-E-00323','DEMO-EST-000323','Daniel Valeria','Romero Cabrera','2005-07-19',NULL,'estudiante00323@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(329,'DEMO-E-00324','DEMO-EST-000324','Santiago Valeria','Romero Castillo','2001-05-31',NULL,'estudiante00324@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(330,'DEMO-E-00325','DEMO-EST-000325','Samuel Valeria','Romero Condori','2005-08-14',NULL,'estudiante00325@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(331,'DEMO-E-00326','DEMO-EST-000326','Diego Valeria','Romero Delgado','2006-08-23',NULL,'estudiante00326@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(332,'DEMO-E-00327','DEMO-EST-000327','Nicolás Valeria','Romero Aguilar','2004-07-31',NULL,'estudiante00327@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(333,'DEMO-E-00328','DEMO-EST-000328','Adrián Valeria','Romero Herrera','2001-12-07',NULL,'estudiante00328@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(334,'DEMO-E-00329','DEMO-EST-000329','Sebastián Valeria','Romero Suárez','2000-03-28',NULL,'estudiante00329@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(335,'DEMO-E-00330','DEMO-EST-000330','Alejandro Valeria','Romero Valdez','1999-05-17',NULL,'estudiante00330@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(336,'DEMO-E-00331','DEMO-EST-000331','Luis Valeria','Romero Choque','2003-07-07',NULL,'estudiante00331@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(337,'DEMO-E-00332','DEMO-EST-000332','Miguel Valeria','Romero Molina','2001-10-17',NULL,'estudiante00332@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(338,'DEMO-E-00333','DEMO-EST-000333','Carlos Valeria','Romero Salazar','2002-06-18',NULL,'estudiante00333@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(339,'DEMO-E-00334','DEMO-EST-000334','Javier Valeria','Romero Paredes','2007-06-04',NULL,'estudiante00334@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(340,'DEMO-E-00335','DEMO-EST-000335','Andrés Valeria','Romero Cruz','2002-10-18',NULL,'estudiante00335@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(341,'DEMO-E-00336','DEMO-EST-000336','Valeria Valeria','Romero Fernández','2000-04-10',NULL,'estudiante00336@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(342,'DEMO-E-00337','DEMO-EST-000337','Camila Valeria','Romero Pinto','2000-09-13',NULL,'estudiante00337@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(343,'DEMO-E-00338','DEMO-EST-000338','Lucía Valeria','Romero Rojas','2006-07-07',NULL,'estudiante00338@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(344,'DEMO-E-00339','DEMO-EST-000339','Mariana Valeria','Romero Ortega','1997-11-29',NULL,'estudiante00339@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(345,'DEMO-E-00340','DEMO-EST-000340','Daniela Valeria','Romero Torres','1998-01-20',NULL,'estudiante00340@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(346,'DEMO-E-00341','DEMO-EST-000341','Sofía Valeria','Romero Gutiérrez','1999-02-27',NULL,'estudiante00341@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(347,'DEMO-E-00342','DEMO-EST-000342','Paola Valeria','Romero Apaza','2004-09-04',NULL,'estudiante00342@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(348,'DEMO-E-00343','DEMO-EST-000343','Andrea Valeria','Romero Montes','2000-08-17',NULL,'estudiante00343@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(349,'DEMO-E-00344','DEMO-EST-000344','Gabriela Valeria','Romero Mendoza','1997-05-21',NULL,'estudiante00344@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(350,'DEMO-E-00345','DEMO-EST-000345','Natalia Valeria','Romero Soto','2001-09-10',NULL,'estudiante00345@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(351,'DEMO-E-00346','DEMO-EST-000346','Carolina Valeria','Romero Vega','2000-02-13',NULL,'estudiante00346@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(352,'DEMO-E-00347','DEMO-EST-000347','Fernanda Valeria','Romero Rivera','1997-11-06',NULL,'estudiante00347@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(353,'DEMO-E-00348','DEMO-EST-000348','Isabel Valeria','Romero Mamani','1996-06-23',NULL,'estudiante00348@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(354,'DEMO-E-00349','DEMO-EST-000349','Victoria Valeria','Romero Villarroel','1998-11-29',NULL,'estudiante00349@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(355,'DEMO-E-00350','DEMO-EST-000350','Elena Valeria','Romero Castro','1995-07-03',NULL,'estudiante00350@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(356,'DEMO-E-00351','DEMO-EST-000351','Rodrigo Valeria','Romero Morales','2002-09-02',NULL,'estudiante00351@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(357,'DEMO-E-00352','DEMO-EST-000352','Mauricio Valeria','Romero Ríos','2002-03-18',NULL,'estudiante00352@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(358,'DEMO-E-00353','DEMO-EST-000353','Eduardo Valeria','Romero Escobar','2003-07-27',NULL,'estudiante00353@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(359,'DEMO-E-00354','DEMO-EST-000354','Pablo Valeria','Romero Soria','2002-10-01',NULL,'estudiante00354@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(360,'DEMO-E-00355','DEMO-EST-000355','Ricardo Valeria','Romero Vargas','1999-12-25',NULL,'estudiante00355@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(361,'DEMO-E-00356','DEMO-EST-000356','Patricia Valeria','Romero Romero','2000-10-21',NULL,'estudiante00356@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(362,'DEMO-E-00357','DEMO-EST-000357','Claudia Valeria','Romero Navarro','2002-06-07',NULL,'estudiante00357@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(363,'DEMO-E-00358','DEMO-EST-000358','Lorena Valeria','Romero López','2002-01-10',NULL,'estudiante00358@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(364,'DEMO-E-00359','DEMO-EST-000359','Verónica Valeria','Romero Quispe','2005-03-16',NULL,'estudiante00359@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(365,'DEMO-E-00360','DEMO-EST-000360','Rosa Valeria','Romero Arias','1999-12-31',NULL,'estudiante00360@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(366,'DEMO-E-00361','DEMO-EST-000361','Gabriel Camila','Ortega Flores','2007-04-07',NULL,'estudiante00361@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(367,'DEMO-E-00362','DEMO-EST-000362','Mateo Camila','Ortega Medina','2000-12-15',NULL,'estudiante00362@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(368,'DEMO-E-00363','DEMO-EST-000363','Daniel Camila','Ortega Cabrera','2000-05-28',NULL,'estudiante00363@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(369,'DEMO-E-00364','DEMO-EST-000364','Santiago Camila','Ortega Castillo','2002-05-28',NULL,'estudiante00364@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(370,'DEMO-E-00365','DEMO-EST-000365','Samuel Camila','Ortega Condori','1997-12-11',NULL,'estudiante00365@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(371,'DEMO-E-00366','DEMO-EST-000366','Diego Camila','Ortega Delgado','2006-09-26',NULL,'estudiante00366@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(372,'DEMO-E-00367','DEMO-EST-000367','Nicolás Camila','Ortega Aguilar','2000-09-08',NULL,'estudiante00367@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(373,'DEMO-E-00368','DEMO-EST-000368','Adrián Camila','Ortega Herrera','2002-08-08',NULL,'estudiante00368@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(374,'DEMO-E-00369','DEMO-EST-000369','Sebastián Camila','Ortega Suárez','2004-11-08',NULL,'estudiante00369@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(375,'DEMO-E-00370','DEMO-EST-000370','Alejandro Camila','Ortega Valdez','2007-11-25',NULL,'estudiante00370@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(376,'DEMO-E-00371','DEMO-EST-000371','Luis Camila','Ortega Choque','2007-12-14',NULL,'estudiante00371@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(377,'DEMO-E-00372','DEMO-EST-000372','Miguel Camila','Ortega Molina','2006-10-26',NULL,'estudiante00372@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(378,'DEMO-E-00373','DEMO-EST-000373','Carlos Camila','Ortega Salazar','2004-10-21',NULL,'estudiante00373@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(379,'DEMO-E-00374','DEMO-EST-000374','Javier Camila','Ortega Paredes','2006-01-04',NULL,'estudiante00374@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(380,'DEMO-E-00375','DEMO-EST-000375','Andrés Camila','Ortega Cruz','2005-06-21',NULL,'estudiante00375@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(381,'DEMO-E-00376','DEMO-EST-000376','Valeria Camila','Ortega Fernández','1995-01-30',NULL,'estudiante00376@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(382,'DEMO-E-00377','DEMO-EST-000377','Camila Camila','Ortega Pinto','1995-08-26',NULL,'estudiante00377@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(383,'DEMO-E-00378','DEMO-EST-000378','Lucía Camila','Ortega Rojas','2002-08-19',NULL,'estudiante00378@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(384,'DEMO-E-00379','DEMO-EST-000379','Mariana Camila','Ortega Ortega','1997-10-02',NULL,'estudiante00379@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(385,'DEMO-E-00380','DEMO-EST-000380','Daniela Camila','Ortega Torres','2000-04-21',NULL,'estudiante00380@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(386,'DEMO-E-00381','DEMO-EST-000381','Sofía Camila','Ortega Gutiérrez','2001-10-02',NULL,'estudiante00381@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(387,'DEMO-E-00382','DEMO-EST-000382','Paola Camila','Ortega Apaza','2002-01-23',NULL,'estudiante00382@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(388,'DEMO-E-00383','DEMO-EST-000383','Andrea Camila','Ortega Montes','1997-06-05',NULL,'estudiante00383@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(389,'DEMO-E-00384','DEMO-EST-000384','Gabriela Camila','Ortega Mendoza','2004-10-13',NULL,'estudiante00384@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(390,'DEMO-E-00385','DEMO-EST-000385','Natalia Camila','Ortega Soto','2005-02-02',NULL,'estudiante00385@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(391,'DEMO-E-00386','DEMO-EST-000386','Carolina Camila','Ortega Vega','2002-07-23',NULL,'estudiante00386@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(392,'DEMO-E-00387','DEMO-EST-000387','Fernanda Camila','Ortega Rivera','2000-04-07',NULL,'estudiante00387@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(393,'DEMO-E-00388','DEMO-EST-000388','Isabel Camila','Ortega Mamani','2007-01-12',NULL,'estudiante00388@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(394,'DEMO-E-00389','DEMO-EST-000389','Victoria Camila','Ortega Villarroel','1996-03-21',NULL,'estudiante00389@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(395,'DEMO-E-00390','DEMO-EST-000390','Elena Camila','Ortega Castro','1996-03-29',NULL,'estudiante00390@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(396,'DEMO-E-00391','DEMO-EST-000391','Rodrigo Camila','Ortega Morales','1995-06-01',NULL,'estudiante00391@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(397,'DEMO-E-00392','DEMO-EST-000392','Mauricio Camila','Ortega Ríos','2004-07-10',NULL,'estudiante00392@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(398,'DEMO-E-00393','DEMO-EST-000393','Eduardo Camila','Ortega Escobar','1997-04-13',NULL,'estudiante00393@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(399,'DEMO-E-00394','DEMO-EST-000394','Pablo Camila','Ortega Soria','2000-02-28',NULL,'estudiante00394@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(400,'DEMO-E-00395','DEMO-EST-000395','Ricardo Camila','Ortega Vargas','2006-02-14',NULL,'estudiante00395@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(401,'DEMO-E-00396','DEMO-EST-000396','Patricia Camila','Ortega Romero','2001-08-02',NULL,'estudiante00396@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(402,'DEMO-E-00397','DEMO-EST-000397','Claudia Camila','Ortega Navarro','2007-07-11',NULL,'estudiante00397@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(403,'DEMO-E-00398','DEMO-EST-000398','Lorena Camila','Ortega López','2006-10-12',NULL,'estudiante00398@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(404,'DEMO-E-00399','DEMO-EST-000399','Verónica Camila','Ortega Quispe','1996-02-11',NULL,'estudiante00399@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(405,'DEMO-E-00400','DEMO-EST-000400','Rosa Camila','Ortega Arias','2002-03-13',NULL,'estudiante00400@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(406,'DEMO-E-00401','DEMO-EST-000401','Gabriel Lucía','Medina Flores','2002-09-06',NULL,'estudiante00401@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(407,'DEMO-E-00402','DEMO-EST-000402','Mateo Lucía','Medina Medina','1999-01-14',NULL,'estudiante00402@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(408,'DEMO-E-00403','DEMO-EST-000403','Daniel Lucía','Medina Cabrera','1997-07-06',NULL,'estudiante00403@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(409,'DEMO-E-00404','DEMO-EST-000404','Santiago Lucía','Medina Castillo','2002-02-22',NULL,'estudiante00404@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(410,'DEMO-E-00405','DEMO-EST-000405','Samuel Lucía','Medina Condori','2003-11-08',NULL,'estudiante00405@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(411,'DEMO-E-00406','DEMO-EST-000406','Diego Lucía','Medina Delgado','2004-06-10',NULL,'estudiante00406@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(412,'DEMO-E-00407','DEMO-EST-000407','Nicolás Lucía','Medina Aguilar','2001-11-11',NULL,'estudiante00407@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(413,'DEMO-E-00408','DEMO-EST-000408','Adrián Lucía','Medina Herrera','2006-12-28',NULL,'estudiante00408@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(414,'DEMO-E-00409','DEMO-EST-000409','Sebastián Lucía','Medina Suárez','2001-06-29',NULL,'estudiante00409@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(415,'DEMO-E-00410','DEMO-EST-000410','Alejandro Lucía','Medina Valdez','1995-05-17',NULL,'estudiante00410@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(416,'DEMO-E-00411','DEMO-EST-000411','Luis Lucía','Medina Choque','2004-07-29',NULL,'estudiante00411@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(417,'DEMO-E-00412','DEMO-EST-000412','Miguel Lucía','Medina Molina','1996-03-18',NULL,'estudiante00412@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(418,'DEMO-E-00413','DEMO-EST-000413','Carlos Lucía','Medina Salazar','2003-04-24',NULL,'estudiante00413@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(419,'DEMO-E-00414','DEMO-EST-000414','Javier Lucía','Medina Paredes','1999-02-11',NULL,'estudiante00414@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(420,'DEMO-E-00415','DEMO-EST-000415','Andrés Lucía','Medina Cruz','2007-11-03',NULL,'estudiante00415@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(421,'DEMO-E-00416','DEMO-EST-000416','Valeria Lucía','Medina Fernández','1999-12-30',NULL,'estudiante00416@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(422,'DEMO-E-00417','DEMO-EST-000417','Camila Lucía','Medina Pinto','1998-02-11',NULL,'estudiante00417@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(423,'DEMO-E-00418','DEMO-EST-000418','Lucía Lucía','Medina Rojas','2001-02-12',NULL,'estudiante00418@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(424,'DEMO-E-00419','DEMO-EST-000419','Mariana Lucía','Medina Ortega','2007-12-27',NULL,'estudiante00419@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(425,'DEMO-E-00420','DEMO-EST-000420','Daniela Lucía','Medina Torres','1998-03-04',NULL,'estudiante00420@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(426,'DEMO-E-00421','DEMO-EST-000421','Sofía Lucía','Medina Gutiérrez','1996-12-04',NULL,'estudiante00421@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(427,'DEMO-E-00422','DEMO-EST-000422','Paola Lucía','Medina Apaza','2004-09-30',NULL,'estudiante00422@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(428,'DEMO-E-00423','DEMO-EST-000423','Andrea Lucía','Medina Montes','2007-12-12',NULL,'estudiante00423@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(429,'DEMO-E-00424','DEMO-EST-000424','Gabriela Lucía','Medina Mendoza','2002-07-30',NULL,'estudiante00424@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(430,'DEMO-E-00425','DEMO-EST-000425','Natalia Lucía','Medina Soto','1995-01-05',NULL,'estudiante00425@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(431,'DEMO-E-00426','DEMO-EST-000426','Carolina Lucía','Medina Vega','2002-08-22',NULL,'estudiante00426@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(432,'DEMO-E-00427','DEMO-EST-000427','Fernanda Lucía','Medina Rivera','1995-06-23',NULL,'estudiante00427@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(433,'DEMO-E-00428','DEMO-EST-000428','Isabel Lucía','Medina Mamani','2001-12-21',NULL,'estudiante00428@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(434,'DEMO-E-00429','DEMO-EST-000429','Victoria Lucía','Medina Villarroel','2001-09-12',NULL,'estudiante00429@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(435,'DEMO-E-00430','DEMO-EST-000430','Elena Lucía','Medina Castro','2000-10-17',NULL,'estudiante00430@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(436,'DEMO-E-00431','DEMO-EST-000431','Rodrigo Lucía','Medina Morales','2000-08-12',NULL,'estudiante00431@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(437,'DEMO-E-00432','DEMO-EST-000432','Mauricio Lucía','Medina Ríos','1995-06-05',NULL,'estudiante00432@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(438,'DEMO-E-00433','DEMO-EST-000433','Eduardo Lucía','Medina Escobar','1997-10-24',NULL,'estudiante00433@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(439,'DEMO-E-00434','DEMO-EST-000434','Pablo Lucía','Medina Soria','2007-09-30',NULL,'estudiante00434@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(440,'DEMO-E-00435','DEMO-EST-000435','Ricardo Lucía','Medina Vargas','2006-09-22',NULL,'estudiante00435@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(441,'DEMO-E-00436','DEMO-EST-000436','Patricia Lucía','Medina Romero','1997-09-16',NULL,'estudiante00436@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(442,'DEMO-E-00437','DEMO-EST-000437','Claudia Lucía','Medina Navarro','2002-03-23',NULL,'estudiante00437@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(443,'DEMO-E-00438','DEMO-EST-000438','Lorena Lucía','Medina López','1995-04-07',NULL,'estudiante00438@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(444,'DEMO-E-00439','DEMO-EST-000439','Verónica Lucía','Medina Quispe','2007-08-13',NULL,'estudiante00439@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(445,'DEMO-E-00440','DEMO-EST-000440','Rosa Lucía','Medina Arias','2007-09-24',NULL,'estudiante00440@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(446,'DEMO-E-00441','DEMO-EST-000441','Gabriel Mariana','Soto Flores','2004-03-02',NULL,'estudiante00441@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(447,'DEMO-E-00442','DEMO-EST-000442','Mateo Mariana','Soto Medina','1995-03-04',NULL,'estudiante00442@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(448,'DEMO-E-00443','DEMO-EST-000443','Daniel Mariana','Soto Cabrera','2005-02-10',NULL,'estudiante00443@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(449,'DEMO-E-00444','DEMO-EST-000444','Santiago Mariana','Soto Castillo','2005-12-08',NULL,'estudiante00444@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(450,'DEMO-E-00445','DEMO-EST-000445','Samuel Mariana','Soto Condori','2001-04-29',NULL,'estudiante00445@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(451,'DEMO-E-00446','DEMO-EST-000446','Diego Mariana','Soto Delgado','2006-09-10',NULL,'estudiante00446@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(452,'DEMO-E-00447','DEMO-EST-000447','Nicolás Mariana','Soto Aguilar','2006-05-02',NULL,'estudiante00447@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(453,'DEMO-E-00448','DEMO-EST-000448','Adrián Mariana','Soto Herrera','2002-01-23',NULL,'estudiante00448@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(454,'DEMO-E-00449','DEMO-EST-000449','Sebastián Mariana','Soto Suárez','2005-04-02',NULL,'estudiante00449@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(455,'DEMO-E-00450','DEMO-EST-000450','Alejandro Mariana','Soto Valdez','1999-11-12',NULL,'estudiante00450@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(456,'DEMO-E-00451','DEMO-EST-000451','Luis Mariana','Soto Choque','2001-09-23',NULL,'estudiante00451@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(457,'DEMO-E-00452','DEMO-EST-000452','Miguel Mariana','Soto Molina','2005-08-26',NULL,'estudiante00452@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(458,'DEMO-E-00453','DEMO-EST-000453','Carlos Mariana','Soto Salazar','2000-06-14',NULL,'estudiante00453@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(459,'DEMO-E-00454','DEMO-EST-000454','Javier Mariana','Soto Paredes','1996-09-18',NULL,'estudiante00454@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(460,'DEMO-E-00455','DEMO-EST-000455','Andrés Mariana','Soto Cruz','1995-12-12',NULL,'estudiante00455@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(461,'DEMO-E-00456','DEMO-EST-000456','Valeria Mariana','Soto Fernández','2007-03-15',NULL,'estudiante00456@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(462,'DEMO-E-00457','DEMO-EST-000457','Camila Mariana','Soto Pinto','2005-05-08',NULL,'estudiante00457@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(463,'DEMO-E-00458','DEMO-EST-000458','Lucía Mariana','Soto Rojas','1996-08-31',NULL,'estudiante00458@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(464,'DEMO-E-00459','DEMO-EST-000459','Mariana Mariana','Soto Ortega','1997-05-18',NULL,'estudiante00459@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(465,'DEMO-E-00460','DEMO-EST-000460','Daniela Mariana','Soto Torres','2003-05-14',NULL,'estudiante00460@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(466,'DEMO-E-00461','DEMO-EST-000461','Sofía Mariana','Soto Gutiérrez','1998-08-21',NULL,'estudiante00461@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(467,'DEMO-E-00462','DEMO-EST-000462','Paola Mariana','Soto Apaza','1998-01-22',NULL,'estudiante00462@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(468,'DEMO-E-00463','DEMO-EST-000463','Andrea Mariana','Soto Montes','2002-07-19',NULL,'estudiante00463@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(469,'DEMO-E-00464','DEMO-EST-000464','Gabriela Mariana','Soto Mendoza','2000-01-21',NULL,'estudiante00464@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(470,'DEMO-E-00465','DEMO-EST-000465','Natalia Mariana','Soto Soto','1999-07-30',NULL,'estudiante00465@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(471,'DEMO-E-00466','DEMO-EST-000466','Carolina Mariana','Soto Vega','1998-05-07',NULL,'estudiante00466@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(472,'DEMO-E-00467','DEMO-EST-000467','Fernanda Mariana','Soto Rivera','1995-01-04',NULL,'estudiante00467@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(473,'DEMO-E-00468','DEMO-EST-000468','Isabel Mariana','Soto Mamani','1999-07-27',NULL,'estudiante00468@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(474,'DEMO-E-00469','DEMO-EST-000469','Victoria Mariana','Soto Villarroel','2007-01-12',NULL,'estudiante00469@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(475,'DEMO-E-00470','DEMO-EST-000470','Elena Mariana','Soto Castro','2004-06-26',NULL,'estudiante00470@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(476,'DEMO-E-00471','DEMO-EST-000471','Rodrigo Mariana','Soto Morales','2007-05-09',NULL,'estudiante00471@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(477,'DEMO-E-00472','DEMO-EST-000472','Mauricio Mariana','Soto Ríos','2007-08-02',NULL,'estudiante00472@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(478,'DEMO-E-00473','DEMO-EST-000473','Eduardo Mariana','Soto Escobar','2007-12-01',NULL,'estudiante00473@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(479,'DEMO-E-00474','DEMO-EST-000474','Pablo Mariana','Soto Soria','1997-10-17',NULL,'estudiante00474@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(480,'DEMO-E-00475','DEMO-EST-000475','Ricardo Mariana','Soto Vargas','1996-11-23',NULL,'estudiante00475@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(481,'DEMO-E-00476','DEMO-EST-000476','Patricia Mariana','Soto Romero','2007-02-12',NULL,'estudiante00476@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(482,'DEMO-E-00477','DEMO-EST-000477','Claudia Mariana','Soto Navarro','2005-11-19',NULL,'estudiante00477@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(483,'DEMO-E-00478','DEMO-EST-000478','Lorena Mariana','Soto López','2003-02-12',NULL,'estudiante00478@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(484,'DEMO-E-00479','DEMO-EST-000479','Verónica Mariana','Soto Quispe','2006-05-24',NULL,'estudiante00479@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(485,'DEMO-E-00480','DEMO-EST-000480','Rosa Mariana','Soto Arias','2006-01-08',NULL,'estudiante00480@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(486,'DEMO-E-00481','DEMO-EST-000481','Gabriel Daniela','Herrera Flores','1998-01-29',NULL,'estudiante00481@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(487,'DEMO-E-00482','DEMO-EST-000482','Mateo Daniela','Herrera Medina','2004-05-07',NULL,'estudiante00482@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(488,'DEMO-E-00483','DEMO-EST-000483','Daniel Daniela','Herrera Cabrera','2002-01-11',NULL,'estudiante00483@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(489,'DEMO-E-00484','DEMO-EST-000484','Santiago Daniela','Herrera Castillo','2005-07-01',NULL,'estudiante00484@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(490,'DEMO-E-00485','DEMO-EST-000485','Samuel Daniela','Herrera Condori','2000-04-22',NULL,'estudiante00485@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(491,'DEMO-E-00486','DEMO-EST-000486','Diego Daniela','Herrera Delgado','1999-07-30',NULL,'estudiante00486@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:09'),(492,'DEMO-E-00487','DEMO-EST-000487','Nicolás Daniela','Herrera Aguilar','2004-07-22',NULL,'estudiante00487@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(493,'DEMO-E-00488','DEMO-EST-000488','Adrián Daniela','Herrera Herrera','2006-09-30',NULL,'estudiante00488@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(494,'DEMO-E-00489','DEMO-EST-000489','Sebastián Daniela','Herrera Suárez','1998-09-17',NULL,'estudiante00489@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(495,'DEMO-E-00490','DEMO-EST-000490','Alejandro Daniela','Herrera Valdez','2004-07-16',NULL,'estudiante00490@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(496,'DEMO-E-00491','DEMO-EST-000491','Luis Daniela','Herrera Choque','2003-12-26',NULL,'estudiante00491@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(497,'DEMO-E-00492','DEMO-EST-000492','Miguel Daniela','Herrera Molina','2000-06-10',NULL,'estudiante00492@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(498,'DEMO-E-00493','DEMO-EST-000493','Carlos Daniela','Herrera Salazar','2001-01-26',NULL,'estudiante00493@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(499,'DEMO-E-00494','DEMO-EST-000494','Javier Daniela','Herrera Paredes','2004-06-08',NULL,'estudiante00494@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(500,'DEMO-E-00495','DEMO-EST-000495','Andrés Daniela','Herrera Cruz','1996-03-09',NULL,'estudiante00495@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(501,'DEMO-E-00496','DEMO-EST-000496','Valeria Daniela','Herrera Fernández','1995-02-25',NULL,'estudiante00496@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(502,'DEMO-E-00497','DEMO-EST-000497','Camila Daniela','Herrera Pinto','1996-10-26',NULL,'estudiante00497@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(503,'DEMO-E-00498','DEMO-EST-000498','Lucía Daniela','Herrera Rojas','2001-09-16',NULL,'estudiante00498@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(504,'DEMO-E-00499','DEMO-EST-000499','Mariana Daniela','Herrera Ortega','2003-11-13',NULL,'estudiante00499@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(505,'DEMO-E-00500','DEMO-EST-000500','Daniela Daniela','Herrera Torres','1999-03-02',NULL,'estudiante00500@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(506,'DEMO-E-00501','DEMO-EST-000501','Sofía Daniela','Herrera Gutiérrez','2006-10-22',NULL,'estudiante00501@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(507,'DEMO-E-00502','DEMO-EST-000502','Paola Daniela','Herrera Apaza','2000-04-22',NULL,'estudiante00502@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(508,'DEMO-E-00503','DEMO-EST-000503','Andrea Daniela','Herrera Montes','2000-12-19',NULL,'estudiante00503@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(509,'DEMO-E-00504','DEMO-EST-000504','Gabriela Daniela','Herrera Mendoza','2005-09-07',NULL,'estudiante00504@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(510,'DEMO-E-00505','DEMO-EST-000505','Natalia Daniela','Herrera Soto','2001-06-16',NULL,'estudiante00505@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(511,'DEMO-E-00506','DEMO-EST-000506','Carolina Daniela','Herrera Vega','2004-02-24',NULL,'estudiante00506@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(512,'DEMO-E-00507','DEMO-EST-000507','Fernanda Daniela','Herrera Rivera','2002-07-08',NULL,'estudiante00507@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(513,'DEMO-E-00508','DEMO-EST-000508','Isabel Daniela','Herrera Mamani','2007-04-28',NULL,'estudiante00508@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(514,'DEMO-E-00509','DEMO-EST-000509','Victoria Daniela','Herrera Villarroel','2000-08-14',NULL,'estudiante00509@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(515,'DEMO-E-00510','DEMO-EST-000510','Elena Daniela','Herrera Castro','1995-02-17',NULL,'estudiante00510@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(516,'DEMO-E-00511','DEMO-EST-000511','Rodrigo Daniela','Herrera Morales','2003-12-01',NULL,'estudiante00511@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(517,'DEMO-E-00512','DEMO-EST-000512','Mauricio Daniela','Herrera Ríos','2007-05-15',NULL,'estudiante00512@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(518,'DEMO-E-00513','DEMO-EST-000513','Eduardo Daniela','Herrera Escobar','1995-02-11',NULL,'estudiante00513@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(519,'DEMO-E-00514','DEMO-EST-000514','Pablo Daniela','Herrera Soria','1996-09-25',NULL,'estudiante00514@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(520,'DEMO-E-00515','DEMO-EST-000515','Ricardo Daniela','Herrera Vargas','2002-05-28',NULL,'estudiante00515@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(521,'DEMO-E-00516','DEMO-EST-000516','Patricia Daniela','Herrera Romero','1996-07-30',NULL,'estudiante00516@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(522,'DEMO-E-00517','DEMO-EST-000517','Claudia Daniela','Herrera Navarro','2002-05-17',NULL,'estudiante00517@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(523,'DEMO-E-00518','DEMO-EST-000518','Lorena Daniela','Herrera López','2002-01-19',NULL,'estudiante00518@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(524,'DEMO-E-00519','DEMO-EST-000519','Verónica Daniela','Herrera Quispe','1996-05-15',NULL,'estudiante00519@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(525,'DEMO-E-00520','DEMO-EST-000520','Rosa Daniela','Herrera Arias','2007-07-07',NULL,'estudiante00520@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(526,'DEMO-E-00521','DEMO-EST-000521','Gabriel Sofía','Morales Flores','2007-08-27',NULL,'estudiante00521@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(527,'DEMO-E-00522','DEMO-EST-000522','Mateo Sofía','Morales Medina','2003-11-29',NULL,'estudiante00522@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(528,'DEMO-E-00523','DEMO-EST-000523','Daniel Sofía','Morales Cabrera','1997-05-04',NULL,'estudiante00523@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(529,'DEMO-E-00524','DEMO-EST-000524','Santiago Sofía','Morales Castillo','1996-03-04',NULL,'estudiante00524@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(530,'DEMO-E-00525','DEMO-EST-000525','Samuel Sofía','Morales Condori','1996-09-11',NULL,'estudiante00525@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(531,'DEMO-E-00526','DEMO-EST-000526','Diego Sofía','Morales Delgado','2004-08-03',NULL,'estudiante00526@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(532,'DEMO-E-00527','DEMO-EST-000527','Nicolás Sofía','Morales Aguilar','2006-10-21',NULL,'estudiante00527@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(533,'DEMO-E-00528','DEMO-EST-000528','Adrián Sofía','Morales Herrera','2003-08-02',NULL,'estudiante00528@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(534,'DEMO-E-00529','DEMO-EST-000529','Sebastián Sofía','Morales Suárez','2002-01-20',NULL,'estudiante00529@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(535,'DEMO-E-00530','DEMO-EST-000530','Alejandro Sofía','Morales Valdez','2005-11-17',NULL,'estudiante00530@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(536,'DEMO-E-00531','DEMO-EST-000531','Luis Sofía','Morales Choque','2001-10-02',NULL,'estudiante00531@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(537,'DEMO-E-00532','DEMO-EST-000532','Miguel Sofía','Morales Molina','2004-04-01',NULL,'estudiante00532@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(538,'DEMO-E-00533','DEMO-EST-000533','Carlos Sofía','Morales Salazar','2001-06-26',NULL,'estudiante00533@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(539,'DEMO-E-00534','DEMO-EST-000534','Javier Sofía','Morales Paredes','2005-10-10',NULL,'estudiante00534@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(540,'DEMO-E-00535','DEMO-EST-000535','Andrés Sofía','Morales Cruz','2001-06-18',NULL,'estudiante00535@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(541,'DEMO-E-00536','DEMO-EST-000536','Valeria Sofía','Morales Fernández','2001-10-10',NULL,'estudiante00536@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(542,'DEMO-E-00537','DEMO-EST-000537','Camila Sofía','Morales Pinto','1998-05-06',NULL,'estudiante00537@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(543,'DEMO-E-00538','DEMO-EST-000538','Lucía Sofía','Morales Rojas','2007-06-01',NULL,'estudiante00538@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(544,'DEMO-E-00539','DEMO-EST-000539','Mariana Sofía','Morales Ortega','2007-02-25',NULL,'estudiante00539@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(545,'DEMO-E-00540','DEMO-EST-000540','Daniela Sofía','Morales Torres','1997-01-23',NULL,'estudiante00540@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(546,'DEMO-E-00541','DEMO-EST-000541','Sofía Sofía','Morales Gutiérrez','2002-04-13',NULL,'estudiante00541@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(547,'DEMO-E-00542','DEMO-EST-000542','Paola Sofía','Morales Apaza','2004-10-23',NULL,'estudiante00542@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(548,'DEMO-E-00543','DEMO-EST-000543','Andrea Sofía','Morales Montes','1996-08-27',NULL,'estudiante00543@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(549,'DEMO-E-00544','DEMO-EST-000544','Gabriela Sofía','Morales Mendoza','1995-03-01',NULL,'estudiante00544@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(550,'DEMO-E-00545','DEMO-EST-000545','Natalia Sofía','Morales Soto','2004-05-05',NULL,'estudiante00545@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(551,'DEMO-E-00546','DEMO-EST-000546','Carolina Sofía','Morales Vega','1997-09-09',NULL,'estudiante00546@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(552,'DEMO-E-00547','DEMO-EST-000547','Fernanda Sofía','Morales Rivera','2006-09-29',NULL,'estudiante00547@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(553,'DEMO-E-00548','DEMO-EST-000548','Isabel Sofía','Morales Mamani','1995-11-20',NULL,'estudiante00548@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(554,'DEMO-E-00549','DEMO-EST-000549','Victoria Sofía','Morales Villarroel','2007-09-03',NULL,'estudiante00549@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(555,'DEMO-E-00550','DEMO-EST-000550','Elena Sofía','Morales Castro','1999-11-02',NULL,'estudiante00550@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(556,'DEMO-E-00551','DEMO-EST-000551','Rodrigo Sofía','Morales Morales','1998-06-25',NULL,'estudiante00551@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(557,'DEMO-E-00552','DEMO-EST-000552','Mauricio Sofía','Morales Ríos','1996-06-17',NULL,'estudiante00552@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(558,'DEMO-E-00553','DEMO-EST-000553','Eduardo Sofía','Morales Escobar','2005-03-29',NULL,'estudiante00553@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(559,'DEMO-E-00554','DEMO-EST-000554','Pablo Sofía','Morales Soria','2000-09-16',NULL,'estudiante00554@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(560,'DEMO-E-00555','DEMO-EST-000555','Ricardo Sofía','Morales Vargas','2000-01-16',NULL,'estudiante00555@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(561,'DEMO-E-00556','DEMO-EST-000556','Patricia Sofía','Morales Romero','2001-10-15',NULL,'estudiante00556@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(562,'DEMO-E-00557','DEMO-EST-000557','Claudia Sofía','Morales Navarro','2006-05-15',NULL,'estudiante00557@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(563,'DEMO-E-00558','DEMO-EST-000558','Lorena Sofía','Morales López','1996-12-09',NULL,'estudiante00558@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(564,'DEMO-E-00559','DEMO-EST-000559','Verónica Sofía','Morales Quispe','1999-08-17',NULL,'estudiante00559@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(565,'DEMO-E-00560','DEMO-EST-000560','Rosa Sofía','Morales Arias','2004-12-10',NULL,'estudiante00560@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(566,'DEMO-E-00561','DEMO-EST-000561','Gabriel Paola','Paredes Flores','2003-12-05',NULL,'estudiante00561@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(567,'DEMO-E-00562','DEMO-EST-000562','Mateo Paola','Paredes Medina','1995-10-18',NULL,'estudiante00562@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(568,'DEMO-E-00563','DEMO-EST-000563','Daniel Paola','Paredes Cabrera','2004-05-13',NULL,'estudiante00563@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(569,'DEMO-E-00564','DEMO-EST-000564','Santiago Paola','Paredes Castillo','1998-01-10',NULL,'estudiante00564@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(570,'DEMO-E-00565','DEMO-EST-000565','Samuel Paola','Paredes Condori','1998-06-16',NULL,'estudiante00565@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(571,'DEMO-E-00566','DEMO-EST-000566','Diego Paola','Paredes Delgado','1999-06-05',NULL,'estudiante00566@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(572,'DEMO-E-00567','DEMO-EST-000567','Nicolás Paola','Paredes Aguilar','2004-03-14',NULL,'estudiante00567@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(573,'DEMO-E-00568','DEMO-EST-000568','Adrián Paola','Paredes Herrera','1999-08-09',NULL,'estudiante00568@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(574,'DEMO-E-00569','DEMO-EST-000569','Sebastián Paola','Paredes Suárez','2007-02-08',NULL,'estudiante00569@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(575,'DEMO-E-00570','DEMO-EST-000570','Alejandro Paola','Paredes Valdez','2003-09-25',NULL,'estudiante00570@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(576,'DEMO-E-00571','DEMO-EST-000571','Luis Paola','Paredes Choque','2000-06-11',NULL,'estudiante00571@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(577,'DEMO-E-00572','DEMO-EST-000572','Miguel Paola','Paredes Molina','1998-03-16',NULL,'estudiante00572@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(578,'DEMO-E-00573','DEMO-EST-000573','Carlos Paola','Paredes Salazar','2006-05-30',NULL,'estudiante00573@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(579,'DEMO-E-00574','DEMO-EST-000574','Javier Paola','Paredes Paredes','2007-05-18',NULL,'estudiante00574@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(580,'DEMO-E-00575','DEMO-EST-000575','Andrés Paola','Paredes Cruz','1999-02-01',NULL,'estudiante00575@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(581,'DEMO-E-00576','DEMO-EST-000576','Valeria Paola','Paredes Fernández','2006-03-09',NULL,'estudiante00576@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(582,'DEMO-E-00577','DEMO-EST-000577','Camila Paola','Paredes Pinto','1996-07-29',NULL,'estudiante00577@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(583,'DEMO-E-00578','DEMO-EST-000578','Lucía Paola','Paredes Rojas','2005-04-03',NULL,'estudiante00578@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(584,'DEMO-E-00579','DEMO-EST-000579','Mariana Paola','Paredes Ortega','2000-02-21',NULL,'estudiante00579@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(585,'DEMO-E-00580','DEMO-EST-000580','Daniela Paola','Paredes Torres','1999-12-16',NULL,'estudiante00580@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(586,'DEMO-E-00581','DEMO-EST-000581','Sofía Paola','Paredes Gutiérrez','2004-01-25',NULL,'estudiante00581@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(587,'DEMO-E-00582','DEMO-EST-000582','Paola Paola','Paredes Apaza','2006-09-08',NULL,'estudiante00582@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(588,'DEMO-E-00583','DEMO-EST-000583','Andrea Paola','Paredes Montes','2000-06-11',NULL,'estudiante00583@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(589,'DEMO-E-00584','DEMO-EST-000584','Gabriela Paola','Paredes Mendoza','2005-04-25',NULL,'estudiante00584@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(590,'DEMO-E-00585','DEMO-EST-000585','Natalia Paola','Paredes Soto','1998-04-03',NULL,'estudiante00585@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(591,'DEMO-E-00586','DEMO-EST-000586','Carolina Paola','Paredes Vega','2000-08-06',NULL,'estudiante00586@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(592,'DEMO-E-00587','DEMO-EST-000587','Fernanda Paola','Paredes Rivera','2002-08-17',NULL,'estudiante00587@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(593,'DEMO-E-00588','DEMO-EST-000588','Isabel Paola','Paredes Mamani','1999-01-29',NULL,'estudiante00588@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(594,'DEMO-E-00589','DEMO-EST-000589','Victoria Paola','Paredes Villarroel','2007-04-19',NULL,'estudiante00589@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(595,'DEMO-E-00590','DEMO-EST-000590','Elena Paola','Paredes Castro','2003-08-19',NULL,'estudiante00590@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(596,'DEMO-E-00591','DEMO-EST-000591','Rodrigo Paola','Paredes Morales','2003-04-04',NULL,'estudiante00591@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(597,'DEMO-E-00592','DEMO-EST-000592','Mauricio Paola','Paredes Ríos','2006-11-27',NULL,'estudiante00592@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(598,'DEMO-E-00593','DEMO-EST-000593','Eduardo Paola','Paredes Escobar','2005-03-04',NULL,'estudiante00593@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(599,'DEMO-E-00594','DEMO-EST-000594','Pablo Paola','Paredes Soria','1999-09-28',NULL,'estudiante00594@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(600,'DEMO-E-00595','DEMO-EST-000595','Ricardo Paola','Paredes Vargas','2006-12-10',NULL,'estudiante00595@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(601,'DEMO-E-00596','DEMO-EST-000596','Patricia Paola','Paredes Romero','1996-11-12',NULL,'estudiante00596@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(602,'DEMO-E-00597','DEMO-EST-000597','Claudia Paola','Paredes Navarro','2000-07-30',NULL,'estudiante00597@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(603,'DEMO-E-00598','DEMO-EST-000598','Lorena Paola','Paredes López','1997-01-05',NULL,'estudiante00598@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(604,'DEMO-E-00599','DEMO-EST-000599','Verónica Paola','Paredes Quispe','1995-06-04',NULL,'estudiante00599@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(605,'DEMO-E-00600','DEMO-EST-000600','Rosa Paola','Paredes Arias','1995-10-11',NULL,'estudiante00600@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(606,'DEMO-E-00601','DEMO-EST-000601','Gabriel Andrea','Navarro Flores','1995-05-24',NULL,'estudiante00601@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(607,'DEMO-E-00602','DEMO-EST-000602','Mateo Andrea','Navarro Medina','2000-10-13',NULL,'estudiante00602@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(608,'DEMO-E-00603','DEMO-EST-000603','Daniel Andrea','Navarro Cabrera','2003-03-12',NULL,'estudiante00603@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(609,'DEMO-E-00604','DEMO-EST-000604','Santiago Andrea','Navarro Castillo','2006-05-08',NULL,'estudiante00604@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(610,'DEMO-E-00605','DEMO-EST-000605','Samuel Andrea','Navarro Condori','2002-02-03',NULL,'estudiante00605@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(611,'DEMO-E-00606','DEMO-EST-000606','Diego Andrea','Navarro Delgado','1999-05-20',NULL,'estudiante00606@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(612,'DEMO-E-00607','DEMO-EST-000607','Nicolás Andrea','Navarro Aguilar','1995-01-19',NULL,'estudiante00607@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(613,'DEMO-E-00608','DEMO-EST-000608','Adrián Andrea','Navarro Herrera','2001-01-06',NULL,'estudiante00608@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(614,'DEMO-E-00609','DEMO-EST-000609','Sebastián Andrea','Navarro Suárez','2006-09-25',NULL,'estudiante00609@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(615,'DEMO-E-00610','DEMO-EST-000610','Alejandro Andrea','Navarro Valdez','2006-09-14',NULL,'estudiante00610@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(616,'DEMO-E-00611','DEMO-EST-000611','Luis Andrea','Navarro Choque','2007-12-20',NULL,'estudiante00611@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(617,'DEMO-E-00612','DEMO-EST-000612','Miguel Andrea','Navarro Molina','2000-04-15',NULL,'estudiante00612@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(618,'DEMO-E-00613','DEMO-EST-000613','Carlos Andrea','Navarro Salazar','2000-06-01',NULL,'estudiante00613@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(619,'DEMO-E-00614','DEMO-EST-000614','Javier Andrea','Navarro Paredes','1997-03-02',NULL,'estudiante00614@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(620,'DEMO-E-00615','DEMO-EST-000615','Andrés Andrea','Navarro Cruz','2007-05-26',NULL,'estudiante00615@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(621,'DEMO-E-00616','DEMO-EST-000616','Valeria Andrea','Navarro Fernández','1997-04-19',NULL,'estudiante00616@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(622,'DEMO-E-00617','DEMO-EST-000617','Camila Andrea','Navarro Pinto','2007-09-22',NULL,'estudiante00617@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(623,'DEMO-E-00618','DEMO-EST-000618','Lucía Andrea','Navarro Rojas','2006-06-16',NULL,'estudiante00618@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(624,'DEMO-E-00619','DEMO-EST-000619','Mariana Andrea','Navarro Ortega','2005-04-07',NULL,'estudiante00619@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(625,'DEMO-E-00620','DEMO-EST-000620','Daniela Andrea','Navarro Torres','2005-12-16',NULL,'estudiante00620@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(626,'DEMO-E-00621','DEMO-EST-000621','Sofía Andrea','Navarro Gutiérrez','2005-03-04',NULL,'estudiante00621@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(627,'DEMO-E-00622','DEMO-EST-000622','Paola Andrea','Navarro Apaza','1995-04-03',NULL,'estudiante00622@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(628,'DEMO-E-00623','DEMO-EST-000623','Andrea Andrea','Navarro Montes','2002-05-02',NULL,'estudiante00623@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(629,'DEMO-E-00624','DEMO-EST-000624','Gabriela Andrea','Navarro Mendoza','2007-03-23',NULL,'estudiante00624@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(630,'DEMO-E-00625','DEMO-EST-000625','Natalia Andrea','Navarro Soto','2007-09-21',NULL,'estudiante00625@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(631,'DEMO-E-00626','DEMO-EST-000626','Carolina Andrea','Navarro Vega','2006-02-15',NULL,'estudiante00626@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(632,'DEMO-E-00627','DEMO-EST-000627','Fernanda Andrea','Navarro Rivera','2006-03-08',NULL,'estudiante00627@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(633,'DEMO-E-00628','DEMO-EST-000628','Isabel Andrea','Navarro Mamani','2001-06-18',NULL,'estudiante00628@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(634,'DEMO-E-00629','DEMO-EST-000629','Victoria Andrea','Navarro Villarroel','1995-06-15',NULL,'estudiante00629@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(635,'DEMO-E-00630','DEMO-EST-000630','Elena Andrea','Navarro Castro','1998-06-12',NULL,'estudiante00630@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(636,'DEMO-E-00631','DEMO-EST-000631','Rodrigo Andrea','Navarro Morales','2003-09-14',NULL,'estudiante00631@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(637,'DEMO-E-00632','DEMO-EST-000632','Mauricio Andrea','Navarro Ríos','2006-01-21',NULL,'estudiante00632@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(638,'DEMO-E-00633','DEMO-EST-000633','Eduardo Andrea','Navarro Escobar','2000-11-03',NULL,'estudiante00633@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(639,'DEMO-E-00634','DEMO-EST-000634','Pablo Andrea','Navarro Soria','2001-08-23',NULL,'estudiante00634@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(640,'DEMO-E-00635','DEMO-EST-000635','Ricardo Andrea','Navarro Vargas','1996-02-28',NULL,'estudiante00635@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(641,'DEMO-E-00636','DEMO-EST-000636','Patricia Andrea','Navarro Romero','1996-02-18',NULL,'estudiante00636@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(642,'DEMO-E-00637','DEMO-EST-000637','Claudia Andrea','Navarro Navarro','2005-09-09',NULL,'estudiante00637@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(643,'DEMO-E-00638','DEMO-EST-000638','Lorena Andrea','Navarro López','1996-05-20',NULL,'estudiante00638@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(644,'DEMO-E-00639','DEMO-EST-000639','Verónica Andrea','Navarro Quispe','2005-09-14',NULL,'estudiante00639@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(645,'DEMO-E-00640','DEMO-EST-000640','Rosa Andrea','Navarro Arias','1999-09-06',NULL,'estudiante00640@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(646,'DEMO-E-00641','DEMO-EST-000641','Gabriel Gabriela','Torres Flores','1997-02-10',NULL,'estudiante00641@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(647,'DEMO-E-00642','DEMO-EST-000642','Mateo Gabriela','Torres Medina','1995-08-30',NULL,'estudiante00642@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(648,'DEMO-E-00643','DEMO-EST-000643','Daniel Gabriela','Torres Cabrera','2005-09-25',NULL,'estudiante00643@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(649,'DEMO-E-00644','DEMO-EST-000644','Santiago Gabriela','Torres Castillo','2001-07-27',NULL,'estudiante00644@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(650,'DEMO-E-00645','DEMO-EST-000645','Samuel Gabriela','Torres Condori','1997-01-15',NULL,'estudiante00645@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(651,'DEMO-E-00646','DEMO-EST-000646','Diego Gabriela','Torres Delgado','2001-12-10',NULL,'estudiante00646@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(652,'DEMO-E-00647','DEMO-EST-000647','Nicolás Gabriela','Torres Aguilar','1995-10-23',NULL,'estudiante00647@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(653,'DEMO-E-00648','DEMO-EST-000648','Adrián Gabriela','Torres Herrera','1997-05-24',NULL,'estudiante00648@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(654,'DEMO-E-00649','DEMO-EST-000649','Sebastián Gabriela','Torres Suárez','2007-04-08',NULL,'estudiante00649@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(655,'DEMO-E-00650','DEMO-EST-000650','Alejandro Gabriela','Torres Valdez','1998-11-18',NULL,'estudiante00650@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(656,'DEMO-E-00651','DEMO-EST-000651','Luis Gabriela','Torres Choque','2007-01-25',NULL,'estudiante00651@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(657,'DEMO-E-00652','DEMO-EST-000652','Miguel Gabriela','Torres Molina','1999-02-05',NULL,'estudiante00652@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(658,'DEMO-E-00653','DEMO-EST-000653','Carlos Gabriela','Torres Salazar','1996-01-15',NULL,'estudiante00653@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(659,'DEMO-E-00654','DEMO-EST-000654','Javier Gabriela','Torres Paredes','2006-12-06',NULL,'estudiante00654@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(660,'DEMO-E-00655','DEMO-EST-000655','Andrés Gabriela','Torres Cruz','2004-07-11',NULL,'estudiante00655@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(661,'DEMO-E-00656','DEMO-EST-000656','Valeria Gabriela','Torres Fernández','2001-03-07',NULL,'estudiante00656@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(662,'DEMO-E-00657','DEMO-EST-000657','Camila Gabriela','Torres Pinto','1997-05-12',NULL,'estudiante00657@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(663,'DEMO-E-00658','DEMO-EST-000658','Lucía Gabriela','Torres Rojas','2004-06-03',NULL,'estudiante00658@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(664,'DEMO-E-00659','DEMO-EST-000659','Mariana Gabriela','Torres Ortega','2004-03-30',NULL,'estudiante00659@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(665,'DEMO-E-00660','DEMO-EST-000660','Daniela Gabriela','Torres Torres','1999-12-30',NULL,'estudiante00660@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(666,'DEMO-E-00661','DEMO-EST-000661','Sofía Gabriela','Torres Gutiérrez','2001-10-19',NULL,'estudiante00661@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(667,'DEMO-E-00662','DEMO-EST-000662','Paola Gabriela','Torres Apaza','2003-04-29',NULL,'estudiante00662@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(668,'DEMO-E-00663','DEMO-EST-000663','Andrea Gabriela','Torres Montes','2005-08-08',NULL,'estudiante00663@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(669,'DEMO-E-00664','DEMO-EST-000664','Gabriela Gabriela','Torres Mendoza','1995-09-20',NULL,'estudiante00664@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(670,'DEMO-E-00665','DEMO-EST-000665','Natalia Gabriela','Torres Soto','1995-11-04',NULL,'estudiante00665@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(671,'DEMO-E-00666','DEMO-EST-000666','Carolina Gabriela','Torres Vega','1998-01-17',NULL,'estudiante00666@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(672,'DEMO-E-00667','DEMO-EST-000667','Fernanda Gabriela','Torres Rivera','2004-02-01',NULL,'estudiante00667@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(673,'DEMO-E-00668','DEMO-EST-000668','Isabel Gabriela','Torres Mamani','1998-06-01',NULL,'estudiante00668@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(674,'DEMO-E-00669','DEMO-EST-000669','Victoria Gabriela','Torres Villarroel','2005-02-08',NULL,'estudiante00669@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(675,'DEMO-E-00670','DEMO-EST-000670','Elena Gabriela','Torres Castro','2004-09-29',NULL,'estudiante00670@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(676,'DEMO-E-00671','DEMO-EST-000671','Rodrigo Gabriela','Torres Morales','2006-02-19',NULL,'estudiante00671@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(677,'DEMO-E-00672','DEMO-EST-000672','Mauricio Gabriela','Torres Ríos','1999-03-12',NULL,'estudiante00672@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(678,'DEMO-E-00673','DEMO-EST-000673','Eduardo Gabriela','Torres Escobar','1996-06-27',NULL,'estudiante00673@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(679,'DEMO-E-00674','DEMO-EST-000674','Pablo Gabriela','Torres Soria','2005-07-14',NULL,'estudiante00674@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(680,'DEMO-E-00675','DEMO-EST-000675','Ricardo Gabriela','Torres Vargas','1995-07-21',NULL,'estudiante00675@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(681,'DEMO-E-00676','DEMO-EST-000676','Patricia Gabriela','Torres Romero','2002-12-25',NULL,'estudiante00676@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(682,'DEMO-E-00677','DEMO-EST-000677','Claudia Gabriela','Torres Navarro','2005-12-31',NULL,'estudiante00677@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(683,'DEMO-E-00678','DEMO-EST-000678','Lorena Gabriela','Torres López','2006-09-10',NULL,'estudiante00678@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(684,'DEMO-E-00679','DEMO-EST-000679','Verónica Gabriela','Torres Quispe','2005-09-25',NULL,'estudiante00679@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(685,'DEMO-E-00680','DEMO-EST-000680','Rosa Gabriela','Torres Arias','1995-02-21',NULL,'estudiante00680@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(686,'DEMO-E-00681','DEMO-EST-000681','Gabriel Natalia','Cabrera Flores','1998-07-30',NULL,'estudiante00681@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(687,'DEMO-E-00682','DEMO-EST-000682','Mateo Natalia','Cabrera Medina','1997-07-19',NULL,'estudiante00682@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(688,'DEMO-E-00683','DEMO-EST-000683','Daniel Natalia','Cabrera Cabrera','2001-06-24',NULL,'estudiante00683@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(689,'DEMO-E-00684','DEMO-EST-000684','Santiago Natalia','Cabrera Castillo','1995-03-11',NULL,'estudiante00684@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(690,'DEMO-E-00685','DEMO-EST-000685','Samuel Natalia','Cabrera Condori','2004-01-19',NULL,'estudiante00685@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(691,'DEMO-E-00686','DEMO-EST-000686','Diego Natalia','Cabrera Delgado','2000-03-22',NULL,'estudiante00686@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(692,'DEMO-E-00687','DEMO-EST-000687','Nicolás Natalia','Cabrera Aguilar','2000-08-16',NULL,'estudiante00687@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(693,'DEMO-E-00688','DEMO-EST-000688','Adrián Natalia','Cabrera Herrera','1999-01-03',NULL,'estudiante00688@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(694,'DEMO-E-00689','DEMO-EST-000689','Sebastián Natalia','Cabrera Suárez','2001-02-18',NULL,'estudiante00689@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(695,'DEMO-E-00690','DEMO-EST-000690','Alejandro Natalia','Cabrera Valdez','2006-10-30',NULL,'estudiante00690@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(696,'DEMO-E-00691','DEMO-EST-000691','Luis Natalia','Cabrera Choque','2001-04-04',NULL,'estudiante00691@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(697,'DEMO-E-00692','DEMO-EST-000692','Miguel Natalia','Cabrera Molina','1997-08-31',NULL,'estudiante00692@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(698,'DEMO-E-00693','DEMO-EST-000693','Carlos Natalia','Cabrera Salazar','1995-04-25',NULL,'estudiante00693@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(699,'DEMO-E-00694','DEMO-EST-000694','Javier Natalia','Cabrera Paredes','2003-07-18',NULL,'estudiante00694@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(700,'DEMO-E-00695','DEMO-EST-000695','Andrés Natalia','Cabrera Cruz','2006-07-19',NULL,'estudiante00695@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(701,'DEMO-E-00696','DEMO-EST-000696','Valeria Natalia','Cabrera Fernández','1998-06-20',NULL,'estudiante00696@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(702,'DEMO-E-00697','DEMO-EST-000697','Camila Natalia','Cabrera Pinto','1998-11-27',NULL,'estudiante00697@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(703,'DEMO-E-00698','DEMO-EST-000698','Lucía Natalia','Cabrera Rojas','2007-01-17',NULL,'estudiante00698@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(704,'DEMO-E-00699','DEMO-EST-000699','Mariana Natalia','Cabrera Ortega','2000-05-23',NULL,'estudiante00699@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(705,'DEMO-E-00700','DEMO-EST-000700','Daniela Natalia','Cabrera Torres','1996-05-27',NULL,'estudiante00700@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(706,'DEMO-E-00701','DEMO-EST-000701','Sofía Natalia','Cabrera Gutiérrez','2000-06-14',NULL,'estudiante00701@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(707,'DEMO-E-00702','DEMO-EST-000702','Paola Natalia','Cabrera Apaza','2001-03-20',NULL,'estudiante00702@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(708,'DEMO-E-00703','DEMO-EST-000703','Andrea Natalia','Cabrera Montes','1995-05-04',NULL,'estudiante00703@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(709,'DEMO-E-00704','DEMO-EST-000704','Gabriela Natalia','Cabrera Mendoza','2005-04-21',NULL,'estudiante00704@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(710,'DEMO-E-00705','DEMO-EST-000705','Natalia Natalia','Cabrera Soto','2006-02-05',NULL,'estudiante00705@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(711,'DEMO-E-00706','DEMO-EST-000706','Carolina Natalia','Cabrera Vega','1996-08-20',NULL,'estudiante00706@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(712,'DEMO-E-00707','DEMO-EST-000707','Fernanda Natalia','Cabrera Rivera','1999-06-24',NULL,'estudiante00707@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(713,'DEMO-E-00708','DEMO-EST-000708','Isabel Natalia','Cabrera Mamani','1999-12-22',NULL,'estudiante00708@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(714,'DEMO-E-00709','DEMO-EST-000709','Victoria Natalia','Cabrera Villarroel','2005-11-12',NULL,'estudiante00709@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(715,'DEMO-E-00710','DEMO-EST-000710','Elena Natalia','Cabrera Castro','2001-09-26',NULL,'estudiante00710@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(716,'DEMO-E-00711','DEMO-EST-000711','Rodrigo Natalia','Cabrera Morales','2004-12-20',NULL,'estudiante00711@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(717,'DEMO-E-00712','DEMO-EST-000712','Mauricio Natalia','Cabrera Ríos','2004-12-02',NULL,'estudiante00712@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(718,'DEMO-E-00713','DEMO-EST-000713','Eduardo Natalia','Cabrera Escobar','1996-04-26',NULL,'estudiante00713@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(719,'DEMO-E-00714','DEMO-EST-000714','Pablo Natalia','Cabrera Soria','1996-01-12',NULL,'estudiante00714@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(720,'DEMO-E-00715','DEMO-EST-000715','Ricardo Natalia','Cabrera Vargas','1997-06-22',NULL,'estudiante00715@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(721,'DEMO-E-00716','DEMO-EST-000716','Patricia Natalia','Cabrera Romero','1996-01-14',NULL,'estudiante00716@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(722,'DEMO-E-00717','DEMO-EST-000717','Claudia Natalia','Cabrera Navarro','1999-12-16',NULL,'estudiante00717@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(723,'DEMO-E-00718','DEMO-EST-000718','Lorena Natalia','Cabrera López','2005-02-28',NULL,'estudiante00718@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(724,'DEMO-E-00719','DEMO-EST-000719','Verónica Natalia','Cabrera Quispe','2004-05-13',NULL,'estudiante00719@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(725,'DEMO-E-00720','DEMO-EST-000720','Rosa Natalia','Cabrera Arias','1995-09-03',NULL,'estudiante00720@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(726,'DEMO-E-00721','DEMO-EST-000721','Gabriel Carolina','Vega Flores','1997-12-10',NULL,'estudiante00721@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(727,'DEMO-E-00722','DEMO-EST-000722','Mateo Carolina','Vega Medina','2004-08-29',NULL,'estudiante00722@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(728,'DEMO-E-00723','DEMO-EST-000723','Daniel Carolina','Vega Cabrera','2005-05-23',NULL,'estudiante00723@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(729,'DEMO-E-00724','DEMO-EST-000724','Santiago Carolina','Vega Castillo','1999-12-26',NULL,'estudiante00724@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(730,'DEMO-E-00725','DEMO-EST-000725','Samuel Carolina','Vega Condori','1996-07-13',NULL,'estudiante00725@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(731,'DEMO-E-00726','DEMO-EST-000726','Diego Carolina','Vega Delgado','1995-11-23',NULL,'estudiante00726@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(732,'DEMO-E-00727','DEMO-EST-000727','Nicolás Carolina','Vega Aguilar','2004-12-30',NULL,'estudiante00727@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(733,'DEMO-E-00728','DEMO-EST-000728','Adrián Carolina','Vega Herrera','2005-02-18',NULL,'estudiante00728@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(734,'DEMO-E-00729','DEMO-EST-000729','Sebastián Carolina','Vega Suárez','2000-11-05',NULL,'estudiante00729@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(735,'DEMO-E-00730','DEMO-EST-000730','Alejandro Carolina','Vega Valdez','2003-12-12',NULL,'estudiante00730@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(736,'DEMO-E-00731','DEMO-EST-000731','Luis Carolina','Vega Choque','1997-07-25',NULL,'estudiante00731@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(737,'DEMO-E-00732','DEMO-EST-000732','Miguel Carolina','Vega Molina','2005-09-25',NULL,'estudiante00732@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(738,'DEMO-E-00733','DEMO-EST-000733','Carlos Carolina','Vega Salazar','2003-12-19',NULL,'estudiante00733@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(739,'DEMO-E-00734','DEMO-EST-000734','Javier Carolina','Vega Paredes','1998-10-10',NULL,'estudiante00734@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(740,'DEMO-E-00735','DEMO-EST-000735','Andrés Carolina','Vega Cruz','1999-09-29',NULL,'estudiante00735@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(741,'DEMO-E-00736','DEMO-EST-000736','Valeria Carolina','Vega Fernández','2005-08-08',NULL,'estudiante00736@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(742,'DEMO-E-00737','DEMO-EST-000737','Camila Carolina','Vega Pinto','2000-01-25',NULL,'estudiante00737@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(743,'DEMO-E-00738','DEMO-EST-000738','Lucía Carolina','Vega Rojas','2006-10-01',NULL,'estudiante00738@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(744,'DEMO-E-00739','DEMO-EST-000739','Mariana Carolina','Vega Ortega','1997-06-25',NULL,'estudiante00739@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(745,'DEMO-E-00740','DEMO-EST-000740','Daniela Carolina','Vega Torres','2002-04-07',NULL,'estudiante00740@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(746,'DEMO-E-00741','DEMO-EST-000741','Sofía Carolina','Vega Gutiérrez','2002-04-09',NULL,'estudiante00741@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(747,'DEMO-E-00742','DEMO-EST-000742','Paola Carolina','Vega Apaza','2005-05-31',NULL,'estudiante00742@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(748,'DEMO-E-00743','DEMO-EST-000743','Andrea Carolina','Vega Montes','1997-10-07',NULL,'estudiante00743@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(749,'DEMO-E-00744','DEMO-EST-000744','Gabriela Carolina','Vega Mendoza','2005-08-15',NULL,'estudiante00744@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(750,'DEMO-E-00745','DEMO-EST-000745','Natalia Carolina','Vega Soto','1999-01-25',NULL,'estudiante00745@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(751,'DEMO-E-00746','DEMO-EST-000746','Carolina Carolina','Vega Vega','1996-07-16',NULL,'estudiante00746@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(752,'DEMO-E-00747','DEMO-EST-000747','Fernanda Carolina','Vega Rivera','2007-10-01',NULL,'estudiante00747@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(753,'DEMO-E-00748','DEMO-EST-000748','Isabel Carolina','Vega Mamani','2002-11-06',NULL,'estudiante00748@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(754,'DEMO-E-00749','DEMO-EST-000749','Victoria Carolina','Vega Villarroel','2005-10-12',NULL,'estudiante00749@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(755,'DEMO-E-00750','DEMO-EST-000750','Elena Carolina','Vega Castro','2006-01-09',NULL,'estudiante00750@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(756,'DEMO-E-00751','DEMO-EST-000751','Rodrigo Carolina','Vega Morales','2005-11-04',NULL,'estudiante00751@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(757,'DEMO-E-00752','DEMO-EST-000752','Mauricio Carolina','Vega Ríos','2003-08-07',NULL,'estudiante00752@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(758,'DEMO-E-00753','DEMO-EST-000753','Eduardo Carolina','Vega Escobar','1996-04-05',NULL,'estudiante00753@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(759,'DEMO-E-00754','DEMO-EST-000754','Pablo Carolina','Vega Soria','1997-09-23',NULL,'estudiante00754@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(760,'DEMO-E-00755','DEMO-EST-000755','Ricardo Carolina','Vega Vargas','1995-12-22',NULL,'estudiante00755@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(761,'DEMO-E-00756','DEMO-EST-000756','Patricia Carolina','Vega Romero','2006-03-24',NULL,'estudiante00756@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(762,'DEMO-E-00757','DEMO-EST-000757','Claudia Carolina','Vega Navarro','2001-11-17',NULL,'estudiante00757@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(763,'DEMO-E-00758','DEMO-EST-000758','Lorena Carolina','Vega López','2004-12-27',NULL,'estudiante00758@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(764,'DEMO-E-00759','DEMO-EST-000759','Verónica Carolina','Vega Quispe','2003-10-17',NULL,'estudiante00759@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(765,'DEMO-E-00760','DEMO-EST-000760','Rosa Carolina','Vega Arias','2006-04-19',NULL,'estudiante00760@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(766,'DEMO-E-00761','DEMO-EST-000761','Gabriel Fernanda','Suárez Flores','2006-12-05',NULL,'estudiante00761@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(767,'DEMO-E-00762','DEMO-EST-000762','Mateo Fernanda','Suárez Medina','2004-12-03',NULL,'estudiante00762@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(768,'DEMO-E-00763','DEMO-EST-000763','Daniel Fernanda','Suárez Cabrera','2003-04-03',NULL,'estudiante00763@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(769,'DEMO-E-00764','DEMO-EST-000764','Santiago Fernanda','Suárez Castillo','1997-11-25',NULL,'estudiante00764@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(770,'DEMO-E-00765','DEMO-EST-000765','Samuel Fernanda','Suárez Condori','1999-10-04',NULL,'estudiante00765@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(771,'DEMO-E-00766','DEMO-EST-000766','Diego Fernanda','Suárez Delgado','2006-01-23',NULL,'estudiante00766@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(772,'DEMO-E-00767','DEMO-EST-000767','Nicolás Fernanda','Suárez Aguilar','2002-12-20',NULL,'estudiante00767@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(773,'DEMO-E-00768','DEMO-EST-000768','Adrián Fernanda','Suárez Herrera','2003-03-09',NULL,'estudiante00768@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(774,'DEMO-E-00769','DEMO-EST-000769','Sebastián Fernanda','Suárez Suárez','2003-04-17',NULL,'estudiante00769@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(775,'DEMO-E-00770','DEMO-EST-000770','Alejandro Fernanda','Suárez Valdez','1998-10-06',NULL,'estudiante00770@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(776,'DEMO-E-00771','DEMO-EST-000771','Luis Fernanda','Suárez Choque','2002-01-20',NULL,'estudiante00771@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(777,'DEMO-E-00772','DEMO-EST-000772','Miguel Fernanda','Suárez Molina','2006-12-04',NULL,'estudiante00772@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(778,'DEMO-E-00773','DEMO-EST-000773','Carlos Fernanda','Suárez Salazar','2000-01-03',NULL,'estudiante00773@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(779,'DEMO-E-00774','DEMO-EST-000774','Javier Fernanda','Suárez Paredes','2004-04-16',NULL,'estudiante00774@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(780,'DEMO-E-00775','DEMO-EST-000775','Andrés Fernanda','Suárez Cruz','2000-06-28',NULL,'estudiante00775@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(781,'DEMO-E-00776','DEMO-EST-000776','Valeria Fernanda','Suárez Fernández','2004-12-17',NULL,'estudiante00776@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(782,'DEMO-E-00777','DEMO-EST-000777','Camila Fernanda','Suárez Pinto','2006-08-31',NULL,'estudiante00777@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(783,'DEMO-E-00778','DEMO-EST-000778','Lucía Fernanda','Suárez Rojas','1995-07-12',NULL,'estudiante00778@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(784,'DEMO-E-00779','DEMO-EST-000779','Mariana Fernanda','Suárez Ortega','2006-06-10',NULL,'estudiante00779@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(785,'DEMO-E-00780','DEMO-EST-000780','Daniela Fernanda','Suárez Torres','2002-04-25',NULL,'estudiante00780@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(786,'DEMO-E-00781','DEMO-EST-000781','Sofía Fernanda','Suárez Gutiérrez','2003-01-25',NULL,'estudiante00781@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(787,'DEMO-E-00782','DEMO-EST-000782','Paola Fernanda','Suárez Apaza','1996-10-01',NULL,'estudiante00782@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(788,'DEMO-E-00783','DEMO-EST-000783','Andrea Fernanda','Suárez Montes','1996-02-02',NULL,'estudiante00783@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(789,'DEMO-E-00784','DEMO-EST-000784','Gabriela Fernanda','Suárez Mendoza','2002-03-28',NULL,'estudiante00784@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(790,'DEMO-E-00785','DEMO-EST-000785','Natalia Fernanda','Suárez Soto','1996-08-24',NULL,'estudiante00785@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(791,'DEMO-E-00786','DEMO-EST-000786','Carolina Fernanda','Suárez Vega','1997-05-16',NULL,'estudiante00786@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(792,'DEMO-E-00787','DEMO-EST-000787','Fernanda Fernanda','Suárez Rivera','1999-08-28',NULL,'estudiante00787@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(793,'DEMO-E-00788','DEMO-EST-000788','Isabel Fernanda','Suárez Mamani','2004-03-22',NULL,'estudiante00788@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(794,'DEMO-E-00789','DEMO-EST-000789','Victoria Fernanda','Suárez Villarroel','2003-07-22',NULL,'estudiante00789@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(795,'DEMO-E-00790','DEMO-EST-000790','Elena Fernanda','Suárez Castro','1997-09-20',NULL,'estudiante00790@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(796,'DEMO-E-00791','DEMO-EST-000791','Rodrigo Fernanda','Suárez Morales','2006-08-01',NULL,'estudiante00791@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(797,'DEMO-E-00792','DEMO-EST-000792','Mauricio Fernanda','Suárez Ríos','2000-11-17',NULL,'estudiante00792@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(798,'DEMO-E-00793','DEMO-EST-000793','Eduardo Fernanda','Suárez Escobar','1999-10-17',NULL,'estudiante00793@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(799,'DEMO-E-00794','DEMO-EST-000794','Pablo Fernanda','Suárez Soria','1995-06-11',NULL,'estudiante00794@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(800,'DEMO-E-00795','DEMO-EST-000795','Ricardo Fernanda','Suárez Vargas','2001-10-21',NULL,'estudiante00795@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(801,'DEMO-E-00796','DEMO-EST-000796','Patricia Fernanda','Suárez Romero','2007-05-13',NULL,'estudiante00796@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(802,'DEMO-E-00797','DEMO-EST-000797','Claudia Fernanda','Suárez Navarro','1997-01-08',NULL,'estudiante00797@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(803,'DEMO-E-00798','DEMO-EST-000798','Lorena Fernanda','Suárez López','1995-01-17',NULL,'estudiante00798@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(804,'DEMO-E-00799','DEMO-EST-000799','Verónica Fernanda','Suárez Quispe','2001-08-30',NULL,'estudiante00799@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(805,'DEMO-E-00800','DEMO-EST-000800','Rosa Fernanda','Suárez Arias','2007-05-31',NULL,'estudiante00800@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(806,'DEMO-E-00801','DEMO-EST-000801','Gabriel Isabel','Ríos Flores','2000-02-26',NULL,'estudiante00801@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(807,'DEMO-E-00802','DEMO-EST-000802','Mateo Isabel','Ríos Medina','2006-07-08',NULL,'estudiante00802@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(808,'DEMO-E-00803','DEMO-EST-000803','Daniel Isabel','Ríos Cabrera','1996-03-04',NULL,'estudiante00803@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(809,'DEMO-E-00804','DEMO-EST-000804','Santiago Isabel','Ríos Castillo','2002-09-24',NULL,'estudiante00804@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(810,'DEMO-E-00805','DEMO-EST-000805','Samuel Isabel','Ríos Condori','2003-02-22',NULL,'estudiante00805@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(811,'DEMO-E-00806','DEMO-EST-000806','Diego Isabel','Ríos Delgado','2001-12-31',NULL,'estudiante00806@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(812,'DEMO-E-00807','DEMO-EST-000807','Nicolás Isabel','Ríos Aguilar','1996-03-09',NULL,'estudiante00807@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(813,'DEMO-E-00808','DEMO-EST-000808','Adrián Isabel','Ríos Herrera','2005-02-05',NULL,'estudiante00808@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(814,'DEMO-E-00809','DEMO-EST-000809','Sebastián Isabel','Ríos Suárez','1999-09-01',NULL,'estudiante00809@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(815,'DEMO-E-00810','DEMO-EST-000810','Alejandro Isabel','Ríos Valdez','1998-12-03',NULL,'estudiante00810@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(816,'DEMO-E-00811','DEMO-EST-000811','Luis Isabel','Ríos Choque','2002-09-07',NULL,'estudiante00811@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(817,'DEMO-E-00812','DEMO-EST-000812','Miguel Isabel','Ríos Molina','2001-01-10',NULL,'estudiante00812@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(818,'DEMO-E-00813','DEMO-EST-000813','Carlos Isabel','Ríos Salazar','2000-12-01',NULL,'estudiante00813@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(819,'DEMO-E-00814','DEMO-EST-000814','Javier Isabel','Ríos Paredes','2006-11-22',NULL,'estudiante00814@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(820,'DEMO-E-00815','DEMO-EST-000815','Andrés Isabel','Ríos Cruz','2006-09-18',NULL,'estudiante00815@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(821,'DEMO-E-00816','DEMO-EST-000816','Valeria Isabel','Ríos Fernández','1995-06-18',NULL,'estudiante00816@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(822,'DEMO-E-00817','DEMO-EST-000817','Camila Isabel','Ríos Pinto','1996-06-18',NULL,'estudiante00817@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(823,'DEMO-E-00818','DEMO-EST-000818','Lucía Isabel','Ríos Rojas','2004-01-02',NULL,'estudiante00818@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(824,'DEMO-E-00819','DEMO-EST-000819','Mariana Isabel','Ríos Ortega','2006-06-21',NULL,'estudiante00819@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(825,'DEMO-E-00820','DEMO-EST-000820','Daniela Isabel','Ríos Torres','2001-03-03',NULL,'estudiante00820@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(826,'DEMO-E-00821','DEMO-EST-000821','Sofía Isabel','Ríos Gutiérrez','2004-09-04',NULL,'estudiante00821@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(827,'DEMO-E-00822','DEMO-EST-000822','Paola Isabel','Ríos Apaza','1998-04-07',NULL,'estudiante00822@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(828,'DEMO-E-00823','DEMO-EST-000823','Andrea Isabel','Ríos Montes','2002-09-18',NULL,'estudiante00823@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(829,'DEMO-E-00824','DEMO-EST-000824','Gabriela Isabel','Ríos Mendoza','1996-10-08',NULL,'estudiante00824@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(830,'DEMO-E-00825','DEMO-EST-000825','Natalia Isabel','Ríos Soto','1998-12-28',NULL,'estudiante00825@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(831,'DEMO-E-00826','DEMO-EST-000826','Carolina Isabel','Ríos Vega','2003-11-15',NULL,'estudiante00826@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(832,'DEMO-E-00827','DEMO-EST-000827','Fernanda Isabel','Ríos Rivera','1997-11-01',NULL,'estudiante00827@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(833,'DEMO-E-00828','DEMO-EST-000828','Isabel Isabel','Ríos Mamani','2001-05-02',NULL,'estudiante00828@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(834,'DEMO-E-00829','DEMO-EST-000829','Victoria Isabel','Ríos Villarroel','1995-08-04',NULL,'estudiante00829@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(835,'DEMO-E-00830','DEMO-EST-000830','Elena Isabel','Ríos Castro','2006-01-20',NULL,'estudiante00830@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(836,'DEMO-E-00831','DEMO-EST-000831','Rodrigo Isabel','Ríos Morales','2006-06-03',NULL,'estudiante00831@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(837,'DEMO-E-00832','DEMO-EST-000832','Mauricio Isabel','Ríos Ríos','2000-11-05',NULL,'estudiante00832@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(838,'DEMO-E-00833','DEMO-EST-000833','Eduardo Isabel','Ríos Escobar','2004-10-02',NULL,'estudiante00833@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(839,'DEMO-E-00834','DEMO-EST-000834','Pablo Isabel','Ríos Soria','1995-08-25',NULL,'estudiante00834@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(840,'DEMO-E-00835','DEMO-EST-000835','Ricardo Isabel','Ríos Vargas','1995-03-30',NULL,'estudiante00835@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(841,'DEMO-E-00836','DEMO-EST-000836','Patricia Isabel','Ríos Romero','1998-12-11',NULL,'estudiante00836@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(842,'DEMO-E-00837','DEMO-EST-000837','Claudia Isabel','Ríos Navarro','2005-10-26',NULL,'estudiante00837@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(843,'DEMO-E-00838','DEMO-EST-000838','Lorena Isabel','Ríos López','1997-08-23',NULL,'estudiante00838@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(844,'DEMO-E-00839','DEMO-EST-000839','Verónica Isabel','Ríos Quispe','2004-04-10',NULL,'estudiante00839@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(845,'DEMO-E-00840','DEMO-EST-000840','Rosa Isabel','Ríos Arias','2002-12-21',NULL,'estudiante00840@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(846,'DEMO-E-00841','DEMO-EST-000841','Gabriel Victoria','Cruz Flores','2002-05-24',NULL,'estudiante00841@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(847,'DEMO-E-00842','DEMO-EST-000842','Mateo Victoria','Cruz Medina','2000-01-16',NULL,'estudiante00842@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(848,'DEMO-E-00843','DEMO-EST-000843','Daniel Victoria','Cruz Cabrera','1996-12-20',NULL,'estudiante00843@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(849,'DEMO-E-00844','DEMO-EST-000844','Santiago Victoria','Cruz Castillo','2001-04-12',NULL,'estudiante00844@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(850,'DEMO-E-00845','DEMO-EST-000845','Samuel Victoria','Cruz Condori','1995-02-01',NULL,'estudiante00845@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(851,'DEMO-E-00846','DEMO-EST-000846','Diego Victoria','Cruz Delgado','1998-07-23',NULL,'estudiante00846@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(852,'DEMO-E-00847','DEMO-EST-000847','Nicolás Victoria','Cruz Aguilar','2004-05-31',NULL,'estudiante00847@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(853,'DEMO-E-00848','DEMO-EST-000848','Adrián Victoria','Cruz Herrera','2006-01-06',NULL,'estudiante00848@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(854,'DEMO-E-00849','DEMO-EST-000849','Sebastián Victoria','Cruz Suárez','1999-11-29',NULL,'estudiante00849@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(855,'DEMO-E-00850','DEMO-EST-000850','Alejandro Victoria','Cruz Valdez','1999-01-03',NULL,'estudiante00850@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(856,'DEMO-E-00851','DEMO-EST-000851','Luis Victoria','Cruz Choque','2002-04-08',NULL,'estudiante00851@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(857,'DEMO-E-00852','DEMO-EST-000852','Miguel Victoria','Cruz Molina','1997-02-19',NULL,'estudiante00852@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(858,'DEMO-E-00853','DEMO-EST-000853','Carlos Victoria','Cruz Salazar','2007-04-02',NULL,'estudiante00853@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(859,'DEMO-E-00854','DEMO-EST-000854','Javier Victoria','Cruz Paredes','2005-08-09',NULL,'estudiante00854@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(860,'DEMO-E-00855','DEMO-EST-000855','Andrés Victoria','Cruz Cruz','2000-08-08',NULL,'estudiante00855@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(861,'DEMO-E-00856','DEMO-EST-000856','Valeria Victoria','Cruz Fernández','2003-07-25',NULL,'estudiante00856@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(862,'DEMO-E-00857','DEMO-EST-000857','Camila Victoria','Cruz Pinto','1998-11-15',NULL,'estudiante00857@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(863,'DEMO-E-00858','DEMO-EST-000858','Lucía Victoria','Cruz Rojas','2006-03-22',NULL,'estudiante00858@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(864,'DEMO-E-00859','DEMO-EST-000859','Mariana Victoria','Cruz Ortega','1998-06-18',NULL,'estudiante00859@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(865,'DEMO-E-00860','DEMO-EST-000860','Daniela Victoria','Cruz Torres','1996-04-02',NULL,'estudiante00860@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(866,'DEMO-E-00861','DEMO-EST-000861','Sofía Victoria','Cruz Gutiérrez','2002-08-14',NULL,'estudiante00861@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(867,'DEMO-E-00862','DEMO-EST-000862','Paola Victoria','Cruz Apaza','2007-08-16',NULL,'estudiante00862@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(868,'DEMO-E-00863','DEMO-EST-000863','Andrea Victoria','Cruz Montes','2002-06-25',NULL,'estudiante00863@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(869,'DEMO-E-00864','DEMO-EST-000864','Gabriela Victoria','Cruz Mendoza','2005-08-21',NULL,'estudiante00864@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(870,'DEMO-E-00865','DEMO-EST-000865','Natalia Victoria','Cruz Soto','1997-01-30',NULL,'estudiante00865@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(871,'DEMO-E-00866','DEMO-EST-000866','Carolina Victoria','Cruz Vega','1997-07-13',NULL,'estudiante00866@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(872,'DEMO-E-00867','DEMO-EST-000867','Fernanda Victoria','Cruz Rivera','2002-07-29',NULL,'estudiante00867@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(873,'DEMO-E-00868','DEMO-EST-000868','Isabel Victoria','Cruz Mamani','1998-02-06',NULL,'estudiante00868@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(874,'DEMO-E-00869','DEMO-EST-000869','Victoria Victoria','Cruz Villarroel','2003-11-06',NULL,'estudiante00869@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(875,'DEMO-E-00870','DEMO-EST-000870','Elena Victoria','Cruz Castro','2005-11-21',NULL,'estudiante00870@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(876,'DEMO-E-00871','DEMO-EST-000871','Rodrigo Victoria','Cruz Morales','2000-07-01',NULL,'estudiante00871@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(877,'DEMO-E-00872','DEMO-EST-000872','Mauricio Victoria','Cruz Ríos','1996-02-29',NULL,'estudiante00872@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(878,'DEMO-E-00873','DEMO-EST-000873','Eduardo Victoria','Cruz Escobar','1999-11-20',NULL,'estudiante00873@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(879,'DEMO-E-00874','DEMO-EST-000874','Pablo Victoria','Cruz Soria','2000-12-26',NULL,'estudiante00874@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(880,'DEMO-E-00875','DEMO-EST-000875','Ricardo Victoria','Cruz Vargas','1996-06-18',NULL,'estudiante00875@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(881,'DEMO-E-00876','DEMO-EST-000876','Patricia Victoria','Cruz Romero','2002-08-25',NULL,'estudiante00876@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(882,'DEMO-E-00877','DEMO-EST-000877','Claudia Victoria','Cruz Navarro','2000-11-24',NULL,'estudiante00877@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(883,'DEMO-E-00878','DEMO-EST-000878','Lorena Victoria','Cruz López','1999-06-27',NULL,'estudiante00878@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(884,'DEMO-E-00879','DEMO-EST-000879','Verónica Victoria','Cruz Quispe','2003-08-12',NULL,'estudiante00879@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(885,'DEMO-E-00880','DEMO-EST-000880','Rosa Victoria','Cruz Arias','2000-04-22',NULL,'estudiante00880@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(886,'DEMO-E-00881','DEMO-EST-000881','Gabriel Elena','López Flores','1997-08-16',NULL,'estudiante00881@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(887,'DEMO-E-00882','DEMO-EST-000882','Mateo Elena','López Medina','2007-12-25',NULL,'estudiante00882@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(888,'DEMO-E-00883','DEMO-EST-000883','Daniel Elena','López Cabrera','2002-08-03',NULL,'estudiante00883@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(889,'DEMO-E-00884','DEMO-EST-000884','Santiago Elena','López Castillo','2000-10-05',NULL,'estudiante00884@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(890,'DEMO-E-00885','DEMO-EST-000885','Samuel Elena','López Condori','2004-05-30',NULL,'estudiante00885@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(891,'DEMO-E-00886','DEMO-EST-000886','Diego Elena','López Delgado','1997-03-27',NULL,'estudiante00886@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(892,'DEMO-E-00887','DEMO-EST-000887','Nicolás Elena','López Aguilar','2003-01-04',NULL,'estudiante00887@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(893,'DEMO-E-00888','DEMO-EST-000888','Adrián Elena','López Herrera','2006-10-09',NULL,'estudiante00888@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(894,'DEMO-E-00889','DEMO-EST-000889','Sebastián Elena','López Suárez','2001-09-17',NULL,'estudiante00889@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(895,'DEMO-E-00890','DEMO-EST-000890','Alejandro Elena','López Valdez','1999-11-04',NULL,'estudiante00890@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(896,'DEMO-E-00891','DEMO-EST-000891','Luis Elena','López Choque','1998-05-07',NULL,'estudiante00891@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(897,'DEMO-E-00892','DEMO-EST-000892','Miguel Elena','López Molina','1998-05-06',NULL,'estudiante00892@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(898,'DEMO-E-00893','DEMO-EST-000893','Carlos Elena','López Salazar','2004-06-22',NULL,'estudiante00893@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(899,'DEMO-E-00894','DEMO-EST-000894','Javier Elena','López Paredes','2004-03-13',NULL,'estudiante00894@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(900,'DEMO-E-00895','DEMO-EST-000895','Andrés Elena','López Cruz','2003-12-14',NULL,'estudiante00895@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(901,'DEMO-E-00896','DEMO-EST-000896','Valeria Elena','López Fernández','1999-04-29',NULL,'estudiante00896@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(902,'DEMO-E-00897','DEMO-EST-000897','Camila Elena','López Pinto','1996-05-15',NULL,'estudiante00897@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(903,'DEMO-E-00898','DEMO-EST-000898','Lucía Elena','López Rojas','2002-12-08',NULL,'estudiante00898@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(904,'DEMO-E-00899','DEMO-EST-000899','Mariana Elena','López Ortega','1997-04-05',NULL,'estudiante00899@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(905,'DEMO-E-00900','DEMO-EST-000900','Daniela Elena','López Torres','2007-03-30',NULL,'estudiante00900@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(906,'DEMO-E-00901','DEMO-EST-000901','Sofía Elena','López Gutiérrez','1997-06-18',NULL,'estudiante00901@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(907,'DEMO-E-00902','DEMO-EST-000902','Paola Elena','López Apaza','1996-07-03',NULL,'estudiante00902@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(908,'DEMO-E-00903','DEMO-EST-000903','Andrea Elena','López Montes','1995-10-25',NULL,'estudiante00903@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(909,'DEMO-E-00904','DEMO-EST-000904','Gabriela Elena','López Mendoza','2001-10-16',NULL,'estudiante00904@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(910,'DEMO-E-00905','DEMO-EST-000905','Natalia Elena','López Soto','1998-11-26',NULL,'estudiante00905@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(911,'DEMO-E-00906','DEMO-EST-000906','Carolina Elena','López Vega','1996-01-16',NULL,'estudiante00906@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(912,'DEMO-E-00907','DEMO-EST-000907','Fernanda Elena','López Rivera','1996-12-24',NULL,'estudiante00907@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(913,'DEMO-E-00908','DEMO-EST-000908','Isabel Elena','López Mamani','2002-03-13',NULL,'estudiante00908@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(914,'DEMO-E-00909','DEMO-EST-000909','Victoria Elena','López Villarroel','1995-11-08',NULL,'estudiante00909@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(915,'DEMO-E-00910','DEMO-EST-000910','Elena Elena','López Castro','2004-11-26',NULL,'estudiante00910@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(916,'DEMO-E-00911','DEMO-EST-000911','Rodrigo Elena','López Morales','2007-06-27',NULL,'estudiante00911@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(917,'DEMO-E-00912','DEMO-EST-000912','Mauricio Elena','López Ríos','1995-05-05',NULL,'estudiante00912@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(918,'DEMO-E-00913','DEMO-EST-000913','Eduardo Elena','López Escobar','2001-04-20',NULL,'estudiante00913@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(919,'DEMO-E-00914','DEMO-EST-000914','Pablo Elena','López Soria','2006-08-29',NULL,'estudiante00914@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(920,'DEMO-E-00915','DEMO-EST-000915','Ricardo Elena','López Vargas','1998-12-30',NULL,'estudiante00915@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(921,'DEMO-E-00916','DEMO-EST-000916','Patricia Elena','López Romero','2004-10-21',NULL,'estudiante00916@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(922,'DEMO-E-00917','DEMO-EST-000917','Claudia Elena','López Navarro','2000-05-20',NULL,'estudiante00917@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(923,'DEMO-E-00918','DEMO-EST-000918','Lorena Elena','López López','1999-11-30',NULL,'estudiante00918@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(924,'DEMO-E-00919','DEMO-EST-000919','Verónica Elena','López Quispe','2001-12-20',NULL,'estudiante00919@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(925,'DEMO-E-00920','DEMO-EST-000920','Rosa Elena','López Arias','1999-05-13',NULL,'estudiante00920@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(926,'DEMO-E-00921','DEMO-EST-000921','Gabriel Rodrigo','Gutiérrez Flores','2005-01-15',NULL,'estudiante00921@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(927,'DEMO-E-00922','DEMO-EST-000922','Mateo Rodrigo','Gutiérrez Medina','1998-09-08',NULL,'estudiante00922@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(928,'DEMO-E-00923','DEMO-EST-000923','Daniel Rodrigo','Gutiérrez Cabrera','2007-01-23',NULL,'estudiante00923@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(929,'DEMO-E-00924','DEMO-EST-000924','Santiago Rodrigo','Gutiérrez Castillo','2005-08-16',NULL,'estudiante00924@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(930,'DEMO-E-00925','DEMO-EST-000925','Samuel Rodrigo','Gutiérrez Condori','1999-08-02',NULL,'estudiante00925@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(931,'DEMO-E-00926','DEMO-EST-000926','Diego Rodrigo','Gutiérrez Delgado','1999-02-05',NULL,'estudiante00926@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(932,'DEMO-E-00927','DEMO-EST-000927','Nicolás Rodrigo','Gutiérrez Aguilar','2001-02-16',NULL,'estudiante00927@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(933,'DEMO-E-00928','DEMO-EST-000928','Adrián Rodrigo','Gutiérrez Herrera','2005-11-12',NULL,'estudiante00928@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(934,'DEMO-E-00929','DEMO-EST-000929','Sebastián Rodrigo','Gutiérrez Suárez','2006-01-21',NULL,'estudiante00929@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(935,'DEMO-E-00930','DEMO-EST-000930','Alejandro Rodrigo','Gutiérrez Valdez','2005-07-25',NULL,'estudiante00930@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(936,'DEMO-E-00931','DEMO-EST-000931','Luis Rodrigo','Gutiérrez Choque','2007-01-05',NULL,'estudiante00931@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(937,'DEMO-E-00932','DEMO-EST-000932','Miguel Rodrigo','Gutiérrez Molina','1997-08-17',NULL,'estudiante00932@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(938,'DEMO-E-00933','DEMO-EST-000933','Carlos Rodrigo','Gutiérrez Salazar','2003-03-16',NULL,'estudiante00933@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(939,'DEMO-E-00934','DEMO-EST-000934','Javier Rodrigo','Gutiérrez Paredes','2003-11-30',NULL,'estudiante00934@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(940,'DEMO-E-00935','DEMO-EST-000935','Andrés Rodrigo','Gutiérrez Cruz','2001-03-17',NULL,'estudiante00935@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(941,'DEMO-E-00936','DEMO-EST-000936','Valeria Rodrigo','Gutiérrez Fernández','1999-10-03',NULL,'estudiante00936@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(942,'DEMO-E-00937','DEMO-EST-000937','Camila Rodrigo','Gutiérrez Pinto','1995-02-25',NULL,'estudiante00937@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(943,'DEMO-E-00938','DEMO-EST-000938','Lucía Rodrigo','Gutiérrez Rojas','2000-04-30',NULL,'estudiante00938@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(944,'DEMO-E-00939','DEMO-EST-000939','Mariana Rodrigo','Gutiérrez Ortega','1998-07-06',NULL,'estudiante00939@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(945,'DEMO-E-00940','DEMO-EST-000940','Daniela Rodrigo','Gutiérrez Torres','2005-03-03',NULL,'estudiante00940@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(946,'DEMO-E-00941','DEMO-EST-000941','Sofía Rodrigo','Gutiérrez Gutiérrez','2004-01-20',NULL,'estudiante00941@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(947,'DEMO-E-00942','DEMO-EST-000942','Paola Rodrigo','Gutiérrez Apaza','2006-08-22',NULL,'estudiante00942@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(948,'DEMO-E-00943','DEMO-EST-000943','Andrea Rodrigo','Gutiérrez Montes','2002-06-13',NULL,'estudiante00943@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(949,'DEMO-E-00944','DEMO-EST-000944','Gabriela Rodrigo','Gutiérrez Mendoza','2005-11-10',NULL,'estudiante00944@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(950,'DEMO-E-00945','DEMO-EST-000945','Natalia Rodrigo','Gutiérrez Soto','2003-09-22',NULL,'estudiante00945@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(951,'DEMO-E-00946','DEMO-EST-000946','Carolina Rodrigo','Gutiérrez Vega','2000-11-20',NULL,'estudiante00946@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(952,'DEMO-E-00947','DEMO-EST-000947','Fernanda Rodrigo','Gutiérrez Rivera','2002-04-09',NULL,'estudiante00947@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(953,'DEMO-E-00948','DEMO-EST-000948','Isabel Rodrigo','Gutiérrez Mamani','1996-05-21',NULL,'estudiante00948@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(954,'DEMO-E-00949','DEMO-EST-000949','Victoria Rodrigo','Gutiérrez Villarroel','2000-12-07',NULL,'estudiante00949@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(955,'DEMO-E-00950','DEMO-EST-000950','Elena Rodrigo','Gutiérrez Castro','2003-04-30',NULL,'estudiante00950@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(956,'DEMO-E-00951','DEMO-EST-000951','Rodrigo Rodrigo','Gutiérrez Morales','2005-07-02',NULL,'estudiante00951@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(957,'DEMO-E-00952','DEMO-EST-000952','Mauricio Rodrigo','Gutiérrez Ríos','2003-02-10',NULL,'estudiante00952@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(958,'DEMO-E-00953','DEMO-EST-000953','Eduardo Rodrigo','Gutiérrez Escobar','2003-08-25',NULL,'estudiante00953@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(959,'DEMO-E-00954','DEMO-EST-000954','Pablo Rodrigo','Gutiérrez Soria','1995-07-03',NULL,'estudiante00954@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(960,'DEMO-E-00955','DEMO-EST-000955','Ricardo Rodrigo','Gutiérrez Vargas','2001-11-09',NULL,'estudiante00955@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(961,'DEMO-E-00956','DEMO-EST-000956','Patricia Rodrigo','Gutiérrez Romero','2006-07-26',NULL,'estudiante00956@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(962,'DEMO-E-00957','DEMO-EST-000957','Claudia Rodrigo','Gutiérrez Navarro','2000-09-08',NULL,'estudiante00957@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(963,'DEMO-E-00958','DEMO-EST-000958','Lorena Rodrigo','Gutiérrez López','2002-12-14',NULL,'estudiante00958@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(964,'DEMO-E-00959','DEMO-EST-000959','Verónica Rodrigo','Gutiérrez Quispe','1996-07-01',NULL,'estudiante00959@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(965,'DEMO-E-00960','DEMO-EST-000960','Rosa Rodrigo','Gutiérrez Arias','1996-05-09',NULL,'estudiante00960@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(966,'DEMO-E-00961','DEMO-EST-000961','Gabriel Mauricio','Castillo Flores','2003-06-22',NULL,'estudiante00961@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(967,'DEMO-E-00962','DEMO-EST-000962','Mateo Mauricio','Castillo Medina','2001-05-24',NULL,'estudiante00962@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(968,'DEMO-E-00963','DEMO-EST-000963','Daniel Mauricio','Castillo Cabrera','2000-02-19',NULL,'estudiante00963@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(969,'DEMO-E-00964','DEMO-EST-000964','Santiago Mauricio','Castillo Castillo','2004-08-04',NULL,'estudiante00964@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(970,'DEMO-E-00965','DEMO-EST-000965','Samuel Mauricio','Castillo Condori','2000-02-28',NULL,'estudiante00965@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(971,'DEMO-E-00966','DEMO-EST-000966','Diego Mauricio','Castillo Delgado','2005-04-02',NULL,'estudiante00966@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(972,'DEMO-E-00967','DEMO-EST-000967','Nicolás Mauricio','Castillo Aguilar','1997-06-30',NULL,'estudiante00967@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(973,'DEMO-E-00968','DEMO-EST-000968','Adrián Mauricio','Castillo Herrera','2005-01-23',NULL,'estudiante00968@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(974,'DEMO-E-00969','DEMO-EST-000969','Sebastián Mauricio','Castillo Suárez','1996-03-15',NULL,'estudiante00969@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(975,'DEMO-E-00970','DEMO-EST-000970','Alejandro Mauricio','Castillo Valdez','1999-06-07',NULL,'estudiante00970@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(976,'DEMO-E-00971','DEMO-EST-000971','Luis Mauricio','Castillo Choque','1995-04-17',NULL,'estudiante00971@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(977,'DEMO-E-00972','DEMO-EST-000972','Miguel Mauricio','Castillo Molina','2003-03-28',NULL,'estudiante00972@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(978,'DEMO-E-00973','DEMO-EST-000973','Carlos Mauricio','Castillo Salazar','2006-11-18',NULL,'estudiante00973@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(979,'DEMO-E-00974','DEMO-EST-000974','Javier Mauricio','Castillo Paredes','2001-02-25',NULL,'estudiante00974@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(980,'DEMO-E-00975','DEMO-EST-000975','Andrés Mauricio','Castillo Cruz','1996-06-11',NULL,'estudiante00975@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(981,'DEMO-E-00976','DEMO-EST-000976','Valeria Mauricio','Castillo Fernández','2005-03-27',NULL,'estudiante00976@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(982,'DEMO-E-00977','DEMO-EST-000977','Camila Mauricio','Castillo Pinto','1995-06-28',NULL,'estudiante00977@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(983,'DEMO-E-00978','DEMO-EST-000978','Lucía Mauricio','Castillo Rojas','1999-02-01',NULL,'estudiante00978@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(984,'DEMO-E-00979','DEMO-EST-000979','Mariana Mauricio','Castillo Ortega','2003-01-08',NULL,'estudiante00979@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(985,'DEMO-E-00980','DEMO-EST-000980','Daniela Mauricio','Castillo Torres','2000-08-20',NULL,'estudiante00980@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(986,'DEMO-E-00981','DEMO-EST-000981','Sofía Mauricio','Castillo Gutiérrez','1998-09-20',NULL,'estudiante00981@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(987,'DEMO-E-00982','DEMO-EST-000982','Paola Mauricio','Castillo Apaza','2006-02-05',NULL,'estudiante00982@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(988,'DEMO-E-00983','DEMO-EST-000983','Andrea Mauricio','Castillo Montes','1996-07-11',NULL,'estudiante00983@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(989,'DEMO-E-00984','DEMO-EST-000984','Gabriela Mauricio','Castillo Mendoza','2001-05-23',NULL,'estudiante00984@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(990,'DEMO-E-00985','DEMO-EST-000985','Natalia Mauricio','Castillo Soto','1997-02-06',NULL,'estudiante00985@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(991,'DEMO-E-00986','DEMO-EST-000986','Carolina Mauricio','Castillo Vega','1998-12-05',NULL,'estudiante00986@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(992,'DEMO-E-00987','DEMO-EST-000987','Fernanda Mauricio','Castillo Rivera','1999-01-03',NULL,'estudiante00987@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(993,'DEMO-E-00988','DEMO-EST-000988','Isabel Mauricio','Castillo Mamani','2001-05-20',NULL,'estudiante00988@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(994,'DEMO-E-00989','DEMO-EST-000989','Victoria Mauricio','Castillo Villarroel','2000-07-30',NULL,'estudiante00989@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(995,'DEMO-E-00990','DEMO-EST-000990','Elena Mauricio','Castillo Castro','2000-11-07',NULL,'estudiante00990@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(996,'DEMO-E-00991','DEMO-EST-000991','Rodrigo Mauricio','Castillo Morales','1996-04-16',NULL,'estudiante00991@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(997,'DEMO-E-00992','DEMO-EST-000992','Mauricio Mauricio','Castillo Ríos','1998-11-18',NULL,'estudiante00992@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(998,'DEMO-E-00993','DEMO-EST-000993','Eduardo Mauricio','Castillo Escobar','1996-10-01',NULL,'estudiante00993@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(999,'DEMO-E-00994','DEMO-EST-000994','Pablo Mauricio','Castillo Soria','2002-09-16',NULL,'estudiante00994@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(1000,'DEMO-E-00995','DEMO-EST-000995','Ricardo Mauricio','Castillo Vargas','2002-04-04',NULL,'estudiante00995@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10'),(1001,'DEMO-E-00996','DEMO-EST-000996','Patricia Mauricio','Castillo Romero','1997-11-06',NULL,'estudiante00996@example.invalid','Dirección ficticia de demostración','2026-10-30 00:43:10');
/*!40000 ALTER TABLE `estudiantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evaluaciones`
--

DROP TABLE IF EXISTS `evaluaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluaciones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oferta_id` int(10) unsigned NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `componente` enum('PRACTICA','TEORIA') NOT NULL,
  `peso` decimal(6,3) NOT NULL CHECK (`peso` > 0 and `peso` <= 100),
  PRIMARY KEY (`id`),
  UNIQUE KEY `oferta_id` (`oferta_id`,`nombre`),
  UNIQUE KEY `id` (`id`,`oferta_id`),
  CONSTRAINT `evaluaciones_ibfk_1` FOREIGN KEY (`oferta_id`) REFERENCES `ofertas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluaciones`
--

LOCK TABLES `evaluaciones` WRITE;
/*!40000 ALTER TABLE `evaluaciones` DISABLE KEYS */;
INSERT INTO `evaluaciones` VALUES (1,1,'Práctica final DEMO','PRACTICA',100.000),(2,1,'Teoría final DEMO','TEORIA',100.000),(3,6,'Evaluación demo PRACTICA','PRACTICA',100.000),(4,6,'Evaluación demo TEORIA','TEORIA',100.000);
/*!40000 ALTER TABLE `evaluaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `excepciones_asistencia`
--

DROP TABLE IF EXISTS `excepciones_asistencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `excepciones_asistencia` (
  `inscripcion_id` int(10) unsigned NOT NULL,
  `documento` varchar(250) NOT NULL,
  `resolucion` varchar(100) NOT NULL,
  `aprobada_por` varchar(120) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`inscripcion_id`),
  CONSTRAINT `excepciones_asistencia_ibfk_1` FOREIGN KEY (`inscripcion_id`) REFERENCES `inscripciones` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (octet_length(trim(`documento`)) > 0 and octet_length(trim(`resolucion`)) > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `excepciones_asistencia`
--

LOCK TABLES `excepciones_asistencia` WRITE;
/*!40000 ALTER TABLE `excepciones_asistencia` DISABLE KEYS */;
/*!40000 ALTER TABLE `excepciones_asistencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horarios`
--

DROP TABLE IF EXISTS `horarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horarios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oferta_id` int(10) unsigned NOT NULL,
  `aula_id` int(10) unsigned NOT NULL,
  `dia` tinyint(3) unsigned NOT NULL COMMENT '1=lunes, 7=domingo',
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `oferta_id` (`oferta_id`),
  KEY `aula_id` (`aula_id`),
  CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`oferta_id`) REFERENCES `ofertas` (`id`),
  CONSTRAINT `horarios_ibfk_2` FOREIGN KEY (`aula_id`) REFERENCES `aulas` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`dia` between 1 and 7),
  CONSTRAINT `CONSTRAINT_2` CHECK (`hora_fin` > `hora_inicio`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horarios`
--

LOCK TABLES `horarios` WRITE;
/*!40000 ALTER TABLE `horarios` DISABLE KEYS */;
INSERT INTO `horarios` VALUES (1,1,1,1,'08:00:00','10:00:00'),(2,2,1,2,'08:00:00','10:00:00'),(3,3,2,1,'19:00:00','21:00:00'),(4,4,3,1,'14:00:00','16:00:00');
/*!40000 ALTER TABLE `horarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inscripciones`
--

DROP TABLE IF EXISTS `inscripciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inscripciones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `matricula_id` int(10) unsigned NOT NULL,
  `oferta_id` int(10) unsigned NOT NULL,
  `carrera_id` int(10) unsigned NOT NULL,
  `periodo_id` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `estado` enum('ACTIVA','RETIRADA','CONCLUIDA') NOT NULL DEFAULT 'ACTIVA',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matricula_id` (`matricula_id`,`oferta_id`),
  UNIQUE KEY `id` (`id`,`oferta_id`),
  KEY `matricula_id_2` (`matricula_id`,`carrera_id`,`periodo_id`),
  KEY `oferta_id` (`oferta_id`,`carrera_id`,`periodo_id`),
  CONSTRAINT `inscripciones_ibfk_1` FOREIGN KEY (`matricula_id`, `carrera_id`, `periodo_id`) REFERENCES `matriculas` (`id`, `carrera_id`, `periodo_id`),
  CONSTRAINT `inscripciones_ibfk_2` FOREIGN KEY (`oferta_id`, `carrera_id`, `periodo_id`) REFERENCES `ofertas` (`id`, `carrera_id`, `periodo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inscripciones`
--

LOCK TABLES `inscripciones` WRITE;
/*!40000 ALTER TABLE `inscripciones` DISABLE KEYS */;
INSERT INTO `inscripciones` VALUES (1,1,1,1,1,'2026-07-17','ACTIVA'),(2,1,2,1,1,'2026-07-17','ACTIVA'),(3,2,3,2,1,'2026-07-17','ACTIVA'),(4,3,4,3,1,'2026-07-17','ACTIVA'),(5,5,6,1,1,'2026-10-16','ACTIVA');
/*!40000 ALTER TABLE `inscripciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materias`
--

DROP TABLE IF EXISTS `materias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `carrera_id` int(10) unsigned NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `nivel_curso` tinyint(3) unsigned NOT NULL,
  `horas_semanales` tinyint(3) unsigned DEFAULT NULL,
  `fuente_url` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carrera_id` (`carrera_id`,`codigo`),
  UNIQUE KEY `id` (`id`,`carrera_id`),
  CONSTRAINT `materias_ibfk_1` FOREIGN KEY (`carrera_id`) REFERENCES `carreras` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=268 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materias`
--

LOCK TABLES `materias` WRITE;
/*!40000 ALTER TABLE `materias` DISABLE KEYS */;
INSERT INTO `materias` VALUES (1,1,'MPI-101','MATEMÁTICA PARA LA INFORMÁTICA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(2,1,'PRG-102','PROGRAMACIÓN I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(3,1,'INT-103','INGLES TÉCNICO',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(4,1,'HDC-104','HARDWARE DE COMPUTADORAS',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(5,1,'TSO-105','TALLLER DE SISTEMAS OPERATIVOS',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(6,1,'OTM-106','OFIMATICA Y TECNOLOGÍA MULTIMEDIA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(7,1,'DPW-107','DISEÑO Y PROGRAMACIÓN WEB I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(8,1,'ETD-201','ESTADÍSTICA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(9,1,'PRG-202','PROGRAMACIÓN II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(10,1,'EDD-203','ESTRUCTURA DE DATOS',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(11,1,'RDC-204','REDES DE COMPUTADORAS I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(12,1,'PDM-205','PROGRAMACIÓN PARA DISPOSITIVOS MÓVILES I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(13,1,'ADS-206','ANÁLISIS Y DISEÑO DE SISTEMAS I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(14,1,'DPW-207','DISEÑO Y PROGRAMACIÓN WEB II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(15,1,'BDD-208','BASE DE DATOS I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(16,1,'EMP-301','EMPRENDIMIENTO PRODUCTIVO',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(17,1,'DPW-302','DISEÑO Y PROGRAMACIÓN WEB III',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(18,1,'GMC-303','GESTIÓN Y MEJORAMIENTO DE LA CALIDAD DEL SOFTWARE',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(19,1,'RDC-304','REDES DE COMPUTADORAS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(20,1,'TMG-305','TALLER MODALIDAD DE GRADUACIÓN',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(21,1,'ADS-306','ANÁLISIS Y DISEÑO DE SISTEMAS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(22,1,'PDM-307','PROGRAMACIÓN PARA DISPOSITIVOS MÓVILES II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(23,1,'BDD-308','BASE DE DATOS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=155'),(24,2,'CON-101','CONTABILIDAD I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(25,2,'MAF-102','MATEMÁTICA FINANCIERA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(26,2,'ICO-103','INFORMÁTICA CONTABLE',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(27,2,'ADG-104','ADMINISTRACION GENERAL',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(28,2,'LSA-105','LEGISLACION LABORAL Y SEGURIDAD SOCIAL APLICADA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(29,2,'EGA-106','ECONOMIA GENERAL APLICADA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(30,2,'DCM-107','DOCUMENTOS COMERCIALES Y MERCANTILES',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(31,2,'ESA-108','ESTADISTICA APLICADA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(32,2,'INT-109','INGLES TECNICO',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(33,2,'CON-201','CONTABILIDAD II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(34,2,'COC-202','CONTABILIDAD DE COSTOS I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(35,2,'COS-203','CONTABILIDAD DE SOCIEDADES',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(36,2,'CDS-204','CONTABILIDAD DE SEGUROS',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(37,2,'CBC-205','CONTABILIDAD BANCARIA Y COOPERATIVAS',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(38,2,'EMP-206','EMPRENDIMIENTO PRODUCTIVO',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(39,2,'SIT-207','SISTEMA TRIBUTARIO',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(40,2,'COA-301','CONTABILIDAD AGROPECUARIA',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(41,2,'COC-302','CONTABILIDAD DE COSTOS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(42,2,'COG-303','CONTABILIAD GUBERNAMENTAL',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(43,2,'CEP-304','CONTABILIDAD EXTRACTIVA (MINERA, PETROLERA Y FORESTAL)',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(44,2,'CHS-305','CONTABILIDAD DE SERVICIOS (CONSTRUCCION, HOTELERIA Y TRANSPORTE)',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(45,2,'GCI-306','GABINETE CONTABLE INFORMATICO',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(46,2,'AEF-307','ANALISIS E INTERPRETACIONES DE ESTADOS FINANCIEROS',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(47,2,'TMG-308','TALLER DE MODALIDAD DE GRADUACION',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=156'),(48,3,'SIM-100','SEGURIDAD OCUPACIONAL Y MEDIO AMBIENTE',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(49,3,'CEL-100','CIRCUITOS ELECTRICOS Y LABORATORIO I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(50,3,'IET-100','INSTALACIONES ELECTRICAS Y TALLER I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(51,3,'DIE-100','DIBUJO DE ESPECIALIDAD',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(52,3,'TEM-100','TALLER ELECTROMECANICO',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(53,3,'MAA-100','MATEMATICA APLICADA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(54,3,'CEL-200','CIRCUITOS ELECTRICOS Y LABORATORIO II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(55,3,'IET-200','INSTALACIONES ELECTRICAS Y TALLER II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(56,3,'MLT-200','MAQUINAS ELECTRICAS, LABORATORIO Y TALLER I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(57,3,'FIA-200','FISICA APLICADA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(58,3,'INT-200','INGLES TECNICO I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(59,3,'AUE-300','AUTOMATISMOS ELECTRICOS I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(60,3,'INM-300','INSTRUMENTACION Y MEDIDAS',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(61,3,'MLT-300','MAQUINAS ELECTRICAS, LABORATORIO Y TALLER II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(62,3,'ELA-300','ELECTRONICA ANALOGICA',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(63,3,'ENA-300','ENERGIAS ALTERNATIVAS I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(64,3,'EDA-300','ELECTRICIDAD DEL AUTOMOVIL',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(65,3,'EMP-300','EMPRENDIMIENTO PRODUCTIVO I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(66,3,'AUE-400','AUTOMATISMOS ELECTRICOS II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(67,3,'CEE-400','CENTRALES ELECTRICAS',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(68,3,'MLT-400','MAQUINAS ELECTRICAS, LABORATORIO Y TALLER III',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(69,3,'ELD-400','ELECTRONICA DIGITAL',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(70,3,'ENA-400','ENERGIAS ALTERNATIVAS II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(71,3,'SIR-400','SISTEMAS DE REFRIGERACION',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(72,3,'EMP-400','EMPRENDIMIENTO PRODUCTIVO II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(73,3,'CLP-500','CONTROLADORES LOGICOS PROGRAMABLES',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(74,3,'RED-500','REDES DE DISTRIBUCION',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(75,3,'MLT-500','MAQUINAS ELECTRICAS, LABORATORIO Y TALLER IV',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(76,3,'ELP-500','ELECTRONICA DE POTENCIA',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(77,3,'REI-500','REFRIGERACION INDUSTRIAL',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(78,3,'TMG-500','TALLER DE MODADLIDAD DE GRADUACION I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(79,3,'SIS-600','SISTEMAS SCADA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(80,3,'ELN-600','ELECTRONEUMATICA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(81,3,'LIT-600','LINEAS DE TRANSMISION',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(82,3,'SUP-600','SUBESTACIONES DE POTENCIA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(83,3,'MCC-600','MICROCONTROLADORES',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(84,3,'TMG-600','TALLER DE MODADLIDAD DE GRADUACION II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=160'),(85,4,'QCG-100','QUÍMICA GENERAL I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(86,4,'QCO-100','QUÍMICA ORGÁNICA I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(87,4,'EPQ-100','ELABORACIÓN DE PRODUCTOS QUÍMICOS I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(88,4,'FIA-100','FÍSICA APLICADA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(89,4,'MAA-100','MATEMÁTICA APLICADA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(90,4,'INT-100','INGLÉS TÉCNCIO I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(91,4,'HSI-200','HIGIENE, SEGURIDAD INDUSTRIAL Y MEDIO AMBIENTE',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(92,4,'QCG-200','QUÍMICA GENERAL II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(93,4,'QCO-200','QUÍMICA ORGÁNICA II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(94,4,'QCI-200','QUÍMICA INORGÁNICA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(95,4,'EDE-200','ESTADISTICA APLICADA Y DISEÑO DE EXPERIMENTOS',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(96,4,'INT-200','INGLÉS TÉCNCIO II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(97,4,'ANQ-300','ANÁLISIS QUÍMICO I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(98,4,'EPQ-300','ELABORACIÓN DE PRODUCTOS QUÍMICOS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(99,4,'BMI-300','BROMATOLOGÍA Y MICROBIOLOGÍA INDUSTRIAL I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(100,4,'ELQ-300','ELECTROQUÍMICA',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(101,4,'FIQ-300','FISICOQUÍMICA APLICADA',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(102,4,'EMP-300','EMPRENDIMIENTO PRODUCTIVO I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(103,4,'ANQ-400','ANÁLISIS QUÍMICO II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(104,4,'BMI-400','BROMATOLOGÍA Y MICROBIOLOGÍA INDUSTRIAL II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(105,4,'OPU-400','OPERACIONES UNITARIAS I',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(106,4,'TDI-400','TERMODINÁMICA INDUSTRIAL',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(107,4,'INC-400','INSTRUMENTACION Y CONTROL',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(108,4,'EMP-400','EMPRENDIMIENTO PRODUCTIVO II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(109,4,'AAI-500','ANÁLISIS APLICADO INORGÁNICO',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(110,4,'ANI-500','ANALISIS INSTRUMENTAL I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(111,4,'CCI-500','CONTROL DE CALIDAD EN LA INDUSTRIA',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(112,4,'OPU-500','OPERACIONES UNITARIAS II',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(113,4,'PQI-500','PROCESOS QUÍMICOS ORGANICOS E INORGÁNICOS',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(114,4,'AAO-600','ANALISIS APLICADO ORGÁNICO',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(115,4,'ANI-600','ANALISIS INSTRUMENTAL II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(116,4,'TPG-600','TECNOLOGÍA DEL PETROLEO Y GAS',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(117,4,'OPU-600','OPERACIONES UNITARIAS III',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(118,4,'TMG-600','TALLER DE MODALIDAD DE GRADUCIÓN',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=157'),(119,5,'SMA-100','SEGURIDAD OCUPACIONAL Y MEDIO AMBIENTE',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(120,5,'FAL-100','FISICA APLICADA Y LABORATORIO',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(121,5,'DIC-100','DIBUJO TECNICO Y CAD',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(122,5,'MAM-100','MATEMATICA APLICADA A LA MECANICA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(123,5,'MEI-100','METROLOGIA INDUSTRIAL',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(124,5,'TTM-100','TECNOLOGIA Y TALLER MECANICO I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(125,5,'ELE-200','ELECTROTECNIA Y ELECTRONICA BASICA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(126,5,'DCM-200','DIBUJO MECANICO EN CAD',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(127,5,'SOL-200','SOLDADURA INDUSTRIAL I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(128,5,'TTM-200','TECNOLOGIA Y TALLER MECANICO II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(129,5,'TTT-200','TRATAMIENTO TERMICO Y TECNOLOGIA DE LOS MATERIALES',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(130,5,'AEC-300','AUTOMATISMOS ELECTRICOS Y CONTROL',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(131,5,'REM-300','RESISTENCIA DE MATERIALES',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(132,5,'TTM-300','TECNOLOGIA Y TALLER MECANICO III',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(133,5,'SOL-300','SOLDADURA INDUSTRIAL II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(134,5,'MOC-300','MODELADO EN CAD',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(135,5,'INT-400','INGLES TECNICO',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(136,5,'EMM-400','ELEMENTOS Y MECANISMOS DE MAQUINAS',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(137,5,'NEH-400','NEUMATICA E HIDRAULICA',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(138,5,'TTM-400','TECNOLIGIA Y TALLER MECANICO IV',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(139,5,'SOL-400','SOLDADURA INDUSTRIAL III',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(140,5,'CNC-400','CONTROL NUMERICO COMPUTARIZADO I',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(141,5,'ENH-500','ELECTRONEUMATICA - ELECTROHIDRAULICA',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(142,5,'CNC-500','CONTROL NUMERICO COMPUTARIZADO II',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(143,5,'SOL-500','SOLDADURA INDUSTRIAL IV',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(144,5,'DIM-500','DISEÑO DE MAQUINAS',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(145,5,'PPM-500','PROCESOS DE MANUFACTURA Y MATRICERIA',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(146,5,'EMP-500','EMPRENDIMIENTO PRODUCTIVO I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(147,5,'TMG-500','TALLER DE MODALIDAD DE GRADUACION I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(148,5,'AII-600','AUTOMATIZACION E INSTRUMENTACION INDUSTRIAL',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(149,5,'SMR-600','SISTEMAS MECATRONICOS Y ROBOTICA INDUSTRIAL',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(150,5,'MEI-600','MANTENIMIENTO DE EQUIPOS INDUSTRIALES',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(151,5,'ESM-600','ESTRUCTURAS METALICAS',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(152,5,'MCM-600','MANUFACTURA Y CONSTRUCCION DE MAQUINAS',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(153,5,'EMP-600','EMPRENDIMIENTO PRODUCTIVO II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(154,5,'TMG-600','TALLER DE MODALIDAD DE GRADUACION II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=158'),(155,6,'SOM-100','SEGURIDAD OCUPACIONAL Y MEDIO AMBIENTE',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(156,6,'MOG-100','MOTORES A GASOLINA I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(157,6,'ELA-100','ELECTRICIDAD AUTOMOTRIZ I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(158,6,'MAA-100','MATEMATICA AUTOMOTRIZ',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(159,6,'MEA-100','METROLOGIA AUTOMOTRIZ',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(160,6,'DTA-100','DIBUJO TECNICO AUTOMOTRIZ I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(161,6,'QUA-100','QUIMICA AUTOMOTRIZ',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(162,6,'INT-200','INGLES TECNICO',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(163,6,'MOG-200','MOTORES A GASOLINA II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(164,6,'ELA-200','ELECTRICIDAD AUTOMOTRIZ II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(165,6,'CHS-200','CHAPERIA Y SOLDADURA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(166,6,'FIS-200','FISICA AUTOMOTRIZ',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(167,6,'DTA-200','DIBUJO TECNICO AUTOMOTRIZ II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(168,6,'MOG-300','MOTORES A GASOLINA III',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(169,6,'ELA-300','ELECTRICIDAD AUTOMOTRIZ III',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(170,6,'MOD-300','MOTORES DIESEL I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(171,6,'ETA-300','ELECTRONICA AUTOMOTRIZ I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(172,6,'TER-300','TERMODINAMICA',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(173,6,'TRA-300','TRANSMISIONES I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(174,6,'MOG-400','MOTORES A GASOLINA IV',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(175,6,'IAG-400','INYECCION A GASOLINA I',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(176,6,'MOD-400','MOTORES DIESEL II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(177,6,'ETA-400','ELECTRONICA AUTOMOTRIZ II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(178,6,'TRA-400','TRANSMISIONES II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(179,6,'EMP-400','EMPRENDIMIENTO PRODUCTIVO',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(180,6,'IED-500','INYECCION ELECTRONICA DIESEL I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(181,6,'IAG-500','INYECCION A GASOLINA II',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(182,6,'LAD-500','LABORATORIO DIESEL I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(183,6,'ETA-500','ELECTRONICA AUTOMOTRIZ III',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(184,6,'NEU-500','NEUMATICA',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(185,6,'TRA-500','TRANSMISIONES III',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(186,6,'TMG-500','TALLER DE MODALIDAD DE GRADUACION I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(187,6,'IED-600','INYECCION ELECTRONICA DIESEL II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(188,6,'DAU-600','DIAGNOSTICO DEL AUTOMOVIL',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(189,6,'LAD-600','LABORATORIO DIESEL II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(190,6,'HID-600','HIDRAULICA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(191,6,'MAP-600','MAQUINARIA AGRICOLA PESADA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(192,6,'IAG-600','INYECCION A GASOLINA III',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(193,6,'TRA-600','TRANSMISIONES IV',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(194,6,'TMG-600','TALLER DE MODALIDAD DE GRADUACION II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=159'),(195,7,'SIM-100','SEGURIDAD INDUSTRIAL Y MEDIO AMBIENTE I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(196,7,'ALC-100','ALGEBRA Y CALCULO',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(197,7,'ACC-100','ANALISIS DE CIRCUITOS DE CORRIENTE CONTINUA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(198,7,'FIS-100','FISICA',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(199,7,'INC-100','INSTRUMENTOS Y COMPONENTES',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(200,7,'INE-100','INSTALACIONES ELECTRICAS',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(201,7,'SIC-100','SISTEMAS CAD',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(202,7,'SIM-200','SEGURIDAD INDUSTRIAL Y MEDIO AMBIENTE II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(203,7,'ACC-200','ANALISIS DE CIRCUITOS DE CORRIENTE ALTERNA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(204,7,'ELA-200','ELECTRONICA ANALOGICA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(205,7,'ELD-200','ELECTRONICA DIGITAL',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(206,7,'ALE-200','ALGORITMOS Y ESTRUCTURAS',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(207,7,'INT-200','INGLES TECNICO',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(208,7,'LTA-300','LINEAS DE TRANSMISION Y ANTENAS',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(209,7,'MII-300','MAQUINAS E INSTALACIONES INDUSTRIALES',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(210,7,'OAP-300','OPERACIONES Y APLICAIONES',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(211,7,'SLP-300','SISTEMAS LOGICOS PROGRAMABLES',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(212,7,'PRO-300','PROGRAMACION',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(213,7,'EMP-300','EMPRENDIMIENTO PRODUCTIVO',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(214,7,'SIT-400','SISTEMAS DE TELECOMUNICACIONES',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(215,7,'ELE-400','ELECTROACUSTICA',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(216,7,'ELI-400','ELECTRONICA INDUSTRIAL',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(217,7,'MAE-400','MANTENIMIENTO DE EQUIPOS ELECTRONICOS',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(218,7,'ARD-400','ARQUITECTURA Y REDES DE COMPUTADORAS',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(219,7,'MIC-400','MICROCONTROLADORES',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(220,7,'SDC-500','SISTEMAS DE CONTROL',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(221,7,'AUP-500','AUTOMATAS PROGRAMABLES',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(222,7,'SIN-500','SISTEMAS NEUMATICOS',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(223,7,'SIT-500','SISTEMAS DE TELEFONIA',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(224,7,'RGD-500','REDES Y GESTION DE DATOS',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(225,7,'TMG-500','TALLER DE MODADLIDAD DE GRADUACION I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(226,7,'COD-600','CONTROL DIGITAL',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(227,7,'SIS-600','SISTEMAS SCADA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(228,7,'ROI-600','ROBOTICA INDUSTRIAL',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(229,7,'SEN-600','SISTEMAS ELECTRONEUMATICOS',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(230,7,'FIO-600','FIBRA OPTICA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(231,7,'TMG-600','TALLER DE MODADLIDAD DE GRADUACION II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=161'),(232,8,'INT-100','INGLES TECNICO I',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(233,8,'MAT-100','MATEMATICA PARA LA CONSTRUCCION',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(234,8,'DIB-100','DIBUJO TECNICO',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(235,8,'FIS-100','FISICA PARA LA CONSTRUCCION',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(236,8,'SIM-100','SEGURIDAD INDUSTRIAL Y MEDIO AMBIENTE',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(237,8,'MAC-100','MATERIALES DE CONSTRUCCION',1,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(238,8,'INT-200','INGLES TECNICO II',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(239,8,'DIB-200','DIBUJO CONSTRUCTIVO ASISTIDO POR COMPUTADORA I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(240,8,'EIS-200','ESTRUCTURAS ISOSTATICAS',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(241,8,'HID-200','HIDRAULICA',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(242,8,'MES-200','MECANICA DE SUELOS I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(243,8,'PCO-200','PROCESOS CONSTRUCTIVOS I',2,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(244,8,'THO-300','TECNOLOGIA DEL HORMIGON',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(245,8,'TOP-300','TOPOGRAFIA I',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(246,8,'DIB-300','DIBUJO CONSTRUCTIVO ASISTIDO POR COMPUTADORA II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(247,8,'RDM-300','RESISTENCIA DE MATERIALES',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(248,8,'MES-300','MECANICA DE SUELOS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(249,8,'PCO-300','PROCESOS CONSTRUCTIVOS II',3,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(250,8,'OSA-400','OBRAS SANITARIAS I',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(251,8,'TOP-400','TOPOGRAFIA II',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(252,8,'MEC-400','MAQUINARIA Y EQUIPO DE CONSTRUCCION',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(253,8,'COP-400','COSTOS Y PRESUPUESTOS',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(254,8,'HOA-400','HORMIGON ARMADO I',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(255,8,'PCO-400','PROCESOS CONSTRUCTIVOS III',4,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(256,8,'OSA-500','OBRAS SANITARIAS II',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(257,8,'OVI-500','OBRAS VIALES',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(258,8,'DAO-500','DIRECCION Y ADMINISTRACION DE OBRAS',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(259,8,'HOA-500','HORMIGON ARMADO II',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(260,8,'EMP-500','EMPRENDIMIENTO PRODUCTIVO I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(261,8,'TMG-500','TALLER DE MODALIDAD DE GRADUACION I',5,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(262,8,'SEO-600','SEGUIMIENTO DE OBRAS',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(263,8,'IOC-600','INSTALACIONES ESPECIALES EN OBRAS CIVILES',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(264,8,'EMA-600','ESTRUCTURAS EN MADERA',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(265,8,'ESM-600','ESTRUCTURAS METALICAS',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(266,8,'EMP-600','EMPRENDIMIENTO PRODUCTIVO II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162'),(267,8,'TMG-600','TALLER DE MODALIDAD DE GRADUACION II',6,NULL,'https://www.itsc.edu.bo/index.php?Itemid=162');
/*!40000 ALTER TABLE `materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matriculas`
--

DROP TABLE IF EXISTS `matriculas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matriculas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `estudiante_id` int(10) unsigned NOT NULL,
  `carrera_id` int(10) unsigned NOT NULL,
  `periodo_id` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `estado` enum('ACTIVA','RETIRADA','CONCLUIDA') NOT NULL DEFAULT 'ACTIVA',
  `plan_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `estudiante_id` (`estudiante_id`,`carrera_id`,`periodo_id`),
  UNIQUE KEY `id` (`id`,`carrera_id`,`periodo_id`),
  KEY `carrera_id` (`carrera_id`),
  KEY `periodo_id` (`periodo_id`),
  KEY `plan_id` (`plan_id`,`carrera_id`),
  CONSTRAINT `matriculas_ibfk_1` FOREIGN KEY (`estudiante_id`) REFERENCES `estudiantes` (`id`),
  CONSTRAINT `matriculas_ibfk_2` FOREIGN KEY (`carrera_id`) REFERENCES `carreras` (`id`),
  CONSTRAINT `matriculas_ibfk_3` FOREIGN KEY (`periodo_id`) REFERENCES `periodos` (`id`),
  CONSTRAINT `matriculas_ibfk_4` FOREIGN KEY (`plan_id`, `carrera_id`) REFERENCES `planes_estudio` (`id`, `carrera_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matriculas`
--

LOCK TABLES `matriculas` WRITE;
/*!40000 ALTER TABLE `matriculas` DISABLE KEYS */;
INSERT INTO `matriculas` VALUES (1,1,1,1,'2026-07-15','ACTIVA',8),(2,2,2,1,'2026-07-15','ACTIVA',2),(3,3,3,1,'2026-07-16','ACTIVA',3),(5,5,1,1,'2026-10-16','ACTIVA',8);
/*!40000 ALTER TABLE `matriculas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modalidades_graduacion`
--

DROP TABLE IF EXISTS `modalidades_graduacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modalidades_graduacion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modalidades_graduacion`
--

LOCK TABLES `modalidades_graduacion` WRITE;
/*!40000 ALTER TABLE `modalidades_graduacion` DISABLE KEYS */;
INSERT INTO `modalidades_graduacion` VALUES (2,'Examen de grado'),(6,'Excelencia académica'),(4,'Proyecto de emprendimiento productivo'),(1,'Proyecto de grado'),(3,'Proyecto sociocomunitario productivo'),(5,'Trabajo dirigido externo');
/*!40000 ALTER TABLE `modalidades_graduacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas_demo_historicas`
--

DROP TABLE IF EXISTS `notas_demo_historicas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notas_demo_historicas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `inscripcion_id` int(10) unsigned NOT NULL,
  `evaluacion` varchar(80) NOT NULL,
  `nota` decimal(5,2) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inscripcion_id` (`inscripcion_id`,`evaluacion`),
  CONSTRAINT `notas_demo_historicas_ibfk_1` FOREIGN KEY (`inscripcion_id`) REFERENCES `inscripciones` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`nota` between 0 and 100)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas_demo_historicas`
--

LOCK TABLES `notas_demo_historicas` WRITE;
/*!40000 ALTER TABLE `notas_demo_historicas` DISABLE KEYS */;
INSERT INTO `notas_demo_historicas` VALUES (1,1,'Primer parcial',78.00,'2026-09-01'),(2,2,'Primer parcial',85.00,'2026-09-02'),(3,3,'Primer parcial',90.00,'2026-09-01'),(4,4,'Primer parcial',72.00,'2026-09-01');
/*!40000 ALTER TABLE `notas_demo_historicas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ofertas`
--

DROP TABLE IF EXISTS `ofertas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ofertas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `materia_id` int(10) unsigned NOT NULL,
  `carrera_id` int(10) unsigned NOT NULL,
  `periodo_id` int(10) unsigned NOT NULL,
  `docente_id` int(10) unsigned NOT NULL,
  `paralelo` varchar(10) NOT NULL,
  `turno` enum('MAÑANA','TARDE','NOCHE') NOT NULL,
  `cupo` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `materia_id` (`materia_id`,`periodo_id`,`paralelo`),
  UNIQUE KEY `id` (`id`,`carrera_id`,`periodo_id`),
  KEY `materia_id_2` (`materia_id`,`carrera_id`),
  KEY `periodo_id` (`periodo_id`),
  KEY `docente_id` (`docente_id`),
  CONSTRAINT `ofertas_ibfk_1` FOREIGN KEY (`materia_id`, `carrera_id`) REFERENCES `materias` (`id`, `carrera_id`),
  CONSTRAINT `ofertas_ibfk_2` FOREIGN KEY (`periodo_id`) REFERENCES `periodos` (`id`),
  CONSTRAINT `ofertas_ibfk_3` FOREIGN KEY (`docente_id`) REFERENCES `docentes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ofertas`
--

LOCK TABLES `ofertas` WRITE;
/*!40000 ALTER TABLE `ofertas` DISABLE KEYS */;
INSERT INTO `ofertas` VALUES (1,2,1,1,1,'A','MAÑANA',30),(2,1,1,1,1,'A','MAÑANA',30),(3,24,2,1,2,'A','NOCHE',35),(4,48,3,1,3,'A','TARDE',25),(6,3,1,1,1,'Dfbc571','MAÑANA',10);
/*!40000 ALTER TABLE `ofertas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos`
--

DROP TABLE IF EXISTS `pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cargo_id` int(10) unsigned NOT NULL,
  `recibo` varchar(30) NOT NULL,
  `fecha` date NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `metodo` enum('EFECTIVO','TRANSFERENCIA','QR') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `recibo` (`recibo`),
  KEY `cargo_id` (`cargo_id`),
  CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`cargo_id`) REFERENCES `cargos` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`monto` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
INSERT INTO `pagos` VALUES (1,1,'DEMO-001','2026-07-18',100.00,'EFECTIVO'),(2,2,'DEMO-002','2026-07-18',60.00,'QR'),(3,4,'DEMO-fbc571','2026-10-16',40.00,'QR');
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pasantias`
--

DROP TABLE IF EXISTS `pasantias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pasantias` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `matricula_id` int(10) unsigned NOT NULL,
  `tutor_id` int(10) unsigned DEFAULT NULL,
  `empresa` varchar(150) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `horas` smallint(5) unsigned DEFAULT NULL,
  `estado` enum('SOLICITADA','EN_CURSO','CONCLUIDA') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `matricula_id` (`matricula_id`),
  KEY `tutor_id` (`tutor_id`),
  CONSTRAINT `pasantias_ibfk_1` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id`),
  CONSTRAINT `pasantias_ibfk_2` FOREIGN KEY (`tutor_id`) REFERENCES `docentes` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`fecha_fin` is null or `fecha_fin` >= `fecha_inicio`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pasantias`
--

LOCK TABLES `pasantias` WRITE;
/*!40000 ALTER TABLE `pasantias` DISABLE KEYS */;
INSERT INTO `pasantias` VALUES (1,5,1,'Empresa Ficticia Demo','2026-10-16',NULL,NULL,'SOLICITADA');
/*!40000 ALTER TABLE `pasantias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodos`
--

DROP TABLE IF EXISTS `periodos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periodos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`fecha_fin` >= `fecha_inicio`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodos`
--

LOCK TABLES `periodos` WRITE;
/*!40000 ALTER TABLE `periodos` DISABLE KEYS */;
INSERT INTO `periodos` VALUES (1,'DEMO-2026','2026-07-20','2026-12-04');
/*!40000 ALTER TABLE `periodos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plan_materias`
--

DROP TABLE IF EXISTS `plan_materias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_materias` (
  `plan_id` int(10) unsigned NOT NULL,
  `materia_id` int(10) unsigned NOT NULL,
  `carrera_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`plan_id`,`materia_id`),
  KEY `plan_id` (`plan_id`,`carrera_id`),
  KEY `materia_id` (`materia_id`,`carrera_id`),
  CONSTRAINT `plan_materias_ibfk_1` FOREIGN KEY (`plan_id`, `carrera_id`) REFERENCES `planes_estudio` (`id`, `carrera_id`),
  CONSTRAINT `plan_materias_ibfk_2` FOREIGN KEY (`materia_id`, `carrera_id`) REFERENCES `materias` (`id`, `carrera_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_materias`
--

LOCK TABLES `plan_materias` WRITE;
/*!40000 ALTER TABLE `plan_materias` DISABLE KEYS */;
INSERT INTO `plan_materias` VALUES (1,232,8),(1,233,8),(1,234,8),(1,235,8),(1,236,8),(1,237,8),(1,238,8),(1,239,8),(1,240,8),(1,241,8),(1,242,8),(1,243,8),(1,244,8),(1,245,8),(1,246,8),(1,247,8),(1,248,8),(1,249,8),(1,250,8),(1,251,8),(1,252,8),(1,253,8),(1,254,8),(1,255,8),(1,256,8),(1,257,8),(1,258,8),(1,259,8),(1,260,8),(1,261,8),(1,262,8),(1,263,8),(1,264,8),(1,265,8),(1,266,8),(1,267,8),(2,24,2),(2,25,2),(2,26,2),(2,27,2),(2,28,2),(2,29,2),(2,30,2),(2,31,2),(2,32,2),(2,33,2),(2,34,2),(2,35,2),(2,36,2),(2,37,2),(2,38,2),(2,39,2),(2,40,2),(2,41,2),(2,42,2),(2,43,2),(2,44,2),(2,45,2),(2,46,2),(2,47,2),(3,48,3),(3,49,3),(3,50,3),(3,51,3),(3,52,3),(3,53,3),(3,54,3),(3,55,3),(3,56,3),(3,57,3),(3,58,3),(3,59,3),(3,60,3),(3,61,3),(3,62,3),(3,63,3),(3,64,3),(3,65,3),(3,66,3),(3,67,3),(3,68,3),(3,69,3),(3,70,3),(3,71,3),(3,72,3),(3,73,3),(3,74,3),(3,75,3),(3,76,3),(3,77,3),(3,78,3),(3,79,3),(3,80,3),(3,81,3),(3,82,3),(3,83,3),(3,84,3),(4,195,7),(4,196,7),(4,197,7),(4,198,7),(4,199,7),(4,200,7),(4,201,7),(4,202,7),(4,203,7),(4,204,7),(4,205,7),(4,206,7),(4,207,7),(4,208,7),(4,209,7),(4,210,7),(4,211,7),(4,212,7),(4,213,7),(4,214,7),(4,215,7),(4,216,7),(4,217,7),(4,218,7),(4,219,7),(4,220,7),(4,221,7),(4,222,7),(4,223,7),(4,224,7),(4,225,7),(4,226,7),(4,227,7),(4,228,7),(4,229,7),(4,230,7),(4,231,7),(5,155,6),(5,156,6),(5,157,6),(5,158,6),(5,159,6),(5,160,6),(5,161,6),(5,162,6),(5,163,6),(5,164,6),(5,165,6),(5,166,6),(5,167,6),(5,168,6),(5,169,6),(5,170,6),(5,171,6),(5,172,6),(5,173,6),(5,174,6),(5,175,6),(5,176,6),(5,177,6),(5,178,6),(5,179,6),(5,180,6),(5,181,6),(5,182,6),(5,183,6),(5,184,6),(5,185,6),(5,186,6),(5,187,6),(5,188,6),(5,189,6),(5,190,6),(5,191,6),(5,192,6),(5,193,6),(5,194,6),(6,119,5),(6,120,5),(6,121,5),(6,122,5),(6,123,5),(6,124,5),(6,125,5),(6,126,5),(6,127,5),(6,128,5),(6,129,5),(6,130,5),(6,131,5),(6,132,5),(6,133,5),(6,134,5),(6,135,5),(6,136,5),(6,137,5),(6,138,5),(6,139,5),(6,140,5),(6,141,5),(6,142,5),(6,143,5),(6,144,5),(6,145,5),(6,146,5),(6,147,5),(6,148,5),(6,149,5),(6,150,5),(6,151,5),(6,152,5),(6,153,5),(6,154,5),(7,85,4),(7,86,4),(7,87,4),(7,88,4),(7,89,4),(7,90,4),(7,91,4),(7,92,4),(7,93,4),(7,94,4),(7,95,4),(7,96,4),(7,97,4),(7,98,4),(7,99,4),(7,100,4),(7,101,4),(7,102,4),(7,103,4),(7,104,4),(7,105,4),(7,106,4),(7,107,4),(7,108,4),(7,109,4),(7,110,4),(7,111,4),(7,112,4),(7,113,4),(7,114,4),(7,115,4),(7,116,4),(7,117,4),(7,118,4),(8,1,1),(8,2,1),(8,3,1),(8,4,1),(8,5,1),(8,6,1),(8,7,1),(8,8,1),(8,9,1),(8,10,1),(8,11,1),(8,12,1),(8,13,1),(8,14,1),(8,15,1),(8,16,1),(8,17,1),(8,18,1),(8,19,1),(8,20,1),(8,21,1),(8,22,1),(8,23,1);
/*!40000 ALTER TABLE `plan_materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planes_estudio`
--

DROP TABLE IF EXISTS `planes_estudio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planes_estudio` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `carrera_id` int(10) unsigned NOT NULL,
  `denominacion` varchar(100) NOT NULL,
  `cohorte` varchar(30) NOT NULL,
  `regla_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`,`carrera_id`),
  UNIQUE KEY `carrera_id` (`carrera_id`,`denominacion`,`cohorte`),
  KEY `regla_id` (`regla_id`),
  CONSTRAINT `planes_estudio_ibfk_1` FOREIGN KEY (`carrera_id`) REFERENCES `carreras` (`id`),
  CONSTRAINT `planes_estudio_ibfk_2` FOREIGN KEY (`regla_id`) REFERENCES `reglas_evaluacion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planes_estudio`
--

LOCK TABLES `planes_estudio` WRITE;
/*!40000 ALTER TABLE `planes_estudio` DISABLE KEYS */;
INSERT INTO `planes_estudio` VALUES (1,8,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(2,2,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(3,3,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(4,7,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(5,6,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(6,5,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(7,4,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1),(8,1,'Catálogo público RM 210/2023 - DEMO','DEMO-2026',1);
/*!40000 ALTER TABLE `planes_estudio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prerrequisitos`
--

DROP TABLE IF EXISTS `prerrequisitos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prerrequisitos` (
  `plan_id` int(10) unsigned NOT NULL,
  `materia_id` int(10) unsigned NOT NULL,
  `requerida_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`plan_id`,`materia_id`,`requerida_id`),
  KEY `plan_id` (`plan_id`,`requerida_id`),
  CONSTRAINT `prerrequisitos_ibfk_1` FOREIGN KEY (`plan_id`, `materia_id`) REFERENCES `plan_materias` (`plan_id`, `materia_id`),
  CONSTRAINT `prerrequisitos_ibfk_2` FOREIGN KEY (`plan_id`, `requerida_id`) REFERENCES `plan_materias` (`plan_id`, `materia_id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`materia_id` <> `requerida_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prerrequisitos`
--

LOCK TABLES `prerrequisitos` WRITE;
/*!40000 ALTER TABLE `prerrequisitos` DISABLE KEYS */;
/*!40000 ALTER TABLE `prerrequisitos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proyectos_graduacion`
--

DROP TABLE IF EXISTS `proyectos_graduacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proyectos_graduacion` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `matricula_id` int(10) unsigned NOT NULL,
  `modalidad_id` int(10) unsigned NOT NULL,
  `tutor_id` int(10) unsigned DEFAULT NULL,
  `titulo` varchar(250) NOT NULL,
  `estado` enum('PROPUESTO','EN_DESARROLLO','DEFENDIDO','APROBADO') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `matricula_id` (`matricula_id`),
  KEY `modalidad_id` (`modalidad_id`),
  KEY `tutor_id` (`tutor_id`),
  CONSTRAINT `proyectos_graduacion_ibfk_1` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id`),
  CONSTRAINT `proyectos_graduacion_ibfk_2` FOREIGN KEY (`modalidad_id`) REFERENCES `modalidades_graduacion` (`id`),
  CONSTRAINT `proyectos_graduacion_ibfk_3` FOREIGN KEY (`tutor_id`) REFERENCES `docentes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proyectos_graduacion`
--

LOCK TABLES `proyectos_graduacion` WRITE;
/*!40000 ALTER TABLE `proyectos_graduacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `proyectos_graduacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recuperaciones`
--

DROP TABLE IF EXISTS `recuperaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recuperaciones` (
  `inscripcion_id` int(10) unsigned NOT NULL,
  `matricula_id` int(10) unsigned NOT NULL,
  `nota_prueba` decimal(5,2) NOT NULL CHECK (`nota_prueba` between 1 and 100),
  `nota_registrada` decimal(5,2) NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`inscripcion_id`),
  KEY `matricula_id` (`matricula_id`),
  CONSTRAINT `recuperaciones_ibfk_1` FOREIGN KEY (`inscripcion_id`) REFERENCES `resultados_finales` (`inscripcion_id`),
  CONSTRAINT `recuperaciones_ibfk_2` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recuperaciones`
--

LOCK TABLES `recuperaciones` WRITE;
/*!40000 ALTER TABLE `recuperaciones` DISABLE KEYS */;
INSERT INTO `recuperaciones` VALUES (1,1,90.00,61.00,'2026-12-04'),(5,5,95.00,61.00,'2026-10-16');
/*!40000 ALTER TABLE `recuperaciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER validar_recuperacion BEFORE INSERT ON recuperaciones FOR EACH ROW
BEGIN
 DECLARE v_matricula INT; DECLARE v_limite INT; DECLARE v_lock INT;
 SELECT i.matricula_id,IF(c.regimen='ANUAL',3,2) INTO v_matricula,v_limite
 FROM inscripciones i JOIN carreras c ON c.id=i.carrera_id WHERE i.id=NEW.inscripcion_id;
 
 SELECT id INTO v_lock FROM matriculas WHERE id=v_matricula FOR UPDATE;
 IF NEW.matricula_id<>v_matricula THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Matrícula incorrecta'; END IF;
 IF NOT EXISTS(SELECT 1 FROM resultados_finales WHERE inscripcion_id=NEW.inscripcion_id AND estado='REPROBADO' AND promedio>=40 AND promedio<61) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='No cumple condiciones de recuperación'; END IF;
 IF (SELECT COUNT(*) FROM recuperaciones WHERE matricula_id=v_matricula)>=v_limite THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Supera el máximo de materias en recuperación'; END IF;
 SET NEW.nota_registrada=IF(NEW.nota_prueba>=61,61,NEW.nota_prueba);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER no_editar_recuperacion BEFORE UPDATE ON recuperaciones FOR EACH ROW
BEGIN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Recuperación cerrada: requiere rectificación administrativa'; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 */ /*!50003 TRIGGER no_borrar_recuperacion BEFORE DELETE ON recuperaciones FOR EACH ROW
BEGIN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Recuperación cerrada: requiere rectificación administrativa'; END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `reglas_evaluacion`
--

DROP TABLE IF EXISTS `reglas_evaluacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reglas_evaluacion` (
  `id` int(10) unsigned NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `fuente` varchar(500) NOT NULL,
  `minimo` decimal(5,2) NOT NULL DEFAULT 1.00 CHECK (`minimo` = 1),
  `maximo` decimal(5,2) NOT NULL DEFAULT 100.00 CHECK (`maximo` = 100),
  `aprobacion` decimal(5,2) NOT NULL DEFAULT 61.00 CHECK (`aprobacion` = 61),
  `practica` decimal(4,3) NOT NULL DEFAULT 0.700 CHECK (`practica` = 0.700),
  `teoria` decimal(4,3) NOT NULL DEFAULT 0.300 CHECK (`teoria` = 0.300),
  `asistencia` decimal(5,2) NOT NULL DEFAULT 80.00 CHECK (`asistencia` = 80),
  `acceso_recuperacion` decimal(5,2) NOT NULL DEFAULT 40.00 CHECK (`acceso_recuperacion` = 40),
  `max_rec_anual` tinyint(4) NOT NULL DEFAULT 3 CHECK (`max_rec_anual` = 3),
  `max_rec_semestral` tinyint(4) NOT NULL DEFAULT 2 CHECK (`max_rec_semestral` = 2),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reglas_evaluacion`
--

LOCK TABLES `reglas_evaluacion` WRITE;
/*!40000 ALTER TABLE `reglas_evaluacion` DISABLE KEYS */;
INSERT INTO `reglas_evaluacion` VALUES (1,'R.M. 0189/2023, artículos 13–18','https://www.minedu.gob.bo/files/documentos-normativos/VESFP/2023/resoluciones/RM_N_0189.pdf',1.00,100.00,61.00,0.700,0.300,80.00,40.00,3,2);
/*!40000 ALTER TABLE `reglas_evaluacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resultados_finales`
--

DROP TABLE IF EXISTS `resultados_finales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resultados_finales` (
  `inscripcion_id` int(10) unsigned NOT NULL,
  `regla_id` int(10) unsigned NOT NULL,
  `promedio` decimal(8,5) NOT NULL,
  `porcentaje_asistencia` decimal(8,5) NOT NULL,
  `excepcion_documentada` tinyint(1) NOT NULL,
  `estado` enum('APROBADO','REPROBADO','REPROBADO_ASISTENCIA') NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`inscripcion_id`),
  KEY `regla_id` (`regla_id`),
  CONSTRAINT `resultados_finales_ibfk_1` FOREIGN KEY (`inscripcion_id`) REFERENCES `inscripciones` (`id`),
  CONSTRAINT `resultados_finales_ibfk_2` FOREIGN KEY (`regla_id`) REFERENCES `reglas_evaluacion` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resultados_finales`
--

LOCK TABLES `resultados_finales` WRITE;
/*!40000 ALTER TABLE `resultados_finales` DISABLE KEYS */;
INSERT INTO `resultados_finales` VALUES (1,1,53.00000,100.00000,0,'REPROBADO','2026-10-16 20:37:33'),(5,1,50.00000,80.00000,0,'REPROBADO','2026-10-16 20:47:56');
/*!40000 ALTER TABLE `resultados_finales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sesiones`
--

DROP TABLE IF EXISTS `sesiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sesiones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oferta_id` int(10) unsigned NOT NULL,
  `inicio` datetime NOT NULL,
  `fin` datetime NOT NULL,
  `estado` enum('PROGRAMADA','REALIZADA','CANCELADA') NOT NULL DEFAULT 'PROGRAMADA',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`,`oferta_id`),
  UNIQUE KEY `oferta_id` (`oferta_id`,`inicio`),
  CONSTRAINT `sesiones_ibfk_1` FOREIGN KEY (`oferta_id`) REFERENCES `ofertas` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`fin` > `inicio`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sesiones`
--

LOCK TABLES `sesiones` WRITE;
/*!40000 ALTER TABLE `sesiones` DISABLE KEYS */;
INSERT INTO `sesiones` VALUES (1,1,'2026-07-20 08:00:00','2026-07-20 10:00:00','REALIZADA'),(2,6,'2026-10-16 08:00:00','2026-10-16 09:40:00','REALIZADA');
/*!40000 ALTER TABLE `sesiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_documento`
--

DROP TABLE IF EXISTS `tipos_documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipos_documento` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_documento`
--

LOCK TABLES `tipos_documento` WRITE;
/*!40000 ALTER TABLE `tipos_documento` DISABLE KEYS */;
INSERT INTO `tipos_documento` VALUES (5,'Boletín de calificación'),(6,'Carnet de estudiante'),(4,'Documento de tipo sanguíneo'),(2,'Fotocopia cédula de identidad'),(3,'Fotocopia certificado de nacimiento'),(1,'Fotocopia diploma de bachiller');
/*!40000 ALTER TABLE `tipos_documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tramites`
--

DROP TABLE IF EXISTS `tramites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tramites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `matricula_id` int(10) unsigned NOT NULL,
  `tipo` enum('CAMBIO_CARRERA','MATERIA_REPROBADA','PRORROGA_DIPLOMA','OTRO') NOT NULL,
  `fecha` date NOT NULL,
  `estado` enum('SOLICITADO','EN_REVISION','APROBADO','RECHAZADO') NOT NULL,
  `detalle` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `matricula_id` (`matricula_id`),
  CONSTRAINT `tramites_ibfk_1` FOREIGN KEY (`matricula_id`) REFERENCES `matriculas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tramites`
--

LOCK TABLES `tramites` WRITE;
/*!40000 ALTER TABLE `tramites` DISABLE KEYS */;
INSERT INTO `tramites` VALUES (1,1,'PRORROGA_DIPLOMA','2026-07-15','SOLICITADO','Ejemplo ficticio de trámite'),(2,5,'OTRO','2026-10-16','SOLICITADO','Solicitud ficticia de prueba');
/*!40000 ALTER TABLE `tramites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tribunales`
--

DROP TABLE IF EXISTS `tribunales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tribunales` (
  `defensa_id` int(10) unsigned NOT NULL,
  `docente_id` int(10) unsigned NOT NULL,
  `funcion` varchar(50) NOT NULL,
  PRIMARY KEY (`defensa_id`,`docente_id`),
  KEY `docente_id` (`docente_id`),
  CONSTRAINT `tribunales_ibfk_1` FOREIGN KEY (`defensa_id`) REFERENCES `defensas` (`id`),
  CONSTRAINT `tribunales_ibfk_2` FOREIGN KEY (`docente_id`) REFERENCES `docentes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tribunales`
--

LOCK TABLES `tribunales` WRITE;
/*!40000 ALTER TABLE `tribunales` DISABLE KEYS */;
/*!40000 ALTER TABLE `tribunales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `v_boletin_final`
--

DROP TABLE IF EXISTS `v_boletin_final`;
/*!50001 DROP VIEW IF EXISTS `v_boletin_final`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_boletin_final` AS SELECT
 1 AS `inscripcion_id`,
  1 AS `registro`,
  1 AS `estudiante`,
  1 AS `materia`,
  1 AS `promedio`,
  1 AS `porcentaje_asistencia`,
  1 AS `excepcion_documentada`,
  1 AS `nota_final`,
  1 AS `resultado`,
  1 AS `nota_prueba_recuperacion` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_listado_academico`
--

DROP TABLE IF EXISTS `v_listado_academico`;
/*!50001 DROP VIEW IF EXISTS `v_listado_academico`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_listado_academico` AS SELECT
 1 AS `registro`,
  1 AS `estudiante`,
  1 AS `carrera`,
  1 AS `periodo`,
  1 AS `materia`,
  1 AS `paralelo`,
  1 AS `turno`,
  1 AS `docente` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `v_saldos`
--

DROP TABLE IF EXISTS `v_saldos`;
/*!50001 DROP VIEW IF EXISTS `v_saldos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `v_saldos` AS SELECT
 1 AS `cargo_id`,
  1 AS `matricula_id`,
  1 AS `concepto`,
  1 AS `cargo`,
  1 AS `pagado`,
  1 AS `saldo` */;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'itsc_academico_v3'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `cerrar_resultado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE PROCEDURE `cerrar_resultado`(IN p_inscripcion INT UNSIGNED)
BEGIN
 DECLARE v_oferta INT; DECLARE v_regla INT; DECLARE v_practica DECIMAL(10,5); DECLARE v_teoria DECIMAL(10,5);
 DECLARE v_total INT; DECLARE v_presentes INT; DECLARE v_excepcion BOOLEAN;
 DECLARE v_nota DECIMAL(8,5); DECLARE v_asistencia DECIMAL(8,5);
 IF NOT EXISTS(SELECT 1 FROM inscripciones WHERE id=p_inscripcion AND estado<>'RETIRADA') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Inscripción inexistente o retirada'; END IF;
 SELECT i.oferta_id,p.regla_id INTO v_oferta,v_regla FROM inscripciones i
 JOIN matriculas m ON m.id=i.matricula_id JOIN planes_estudio p ON p.id=m.plan_id WHERE i.id=p_inscripcion;
 IF NOT EXISTS(SELECT 1 FROM cierres_oferta WHERE oferta_id=v_oferta) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Primero debe cerrarse la carga horaria de la oferta'; END IF;
 IF (SELECT COUNT(*) FROM (SELECT componente FROM evaluaciones WHERE oferta_id=v_oferta GROUP BY componente HAVING SUM(peso)=100) t)<>2 THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cada componente requiere pesos que sumen 100'; END IF;
 IF EXISTS(SELECT 1 FROM evaluaciones e LEFT JOIN calificaciones c ON c.evaluacion_id=e.id AND c.inscripcion_id=p_inscripcion WHERE e.oferta_id=v_oferta AND c.inscripcion_id IS NULL) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Faltan calificaciones'; END IF;
 SELECT SUM(CASE WHEN e.componente='PRACTICA' THEN c.nota*e.peso/100 ELSE 0 END),
 SUM(CASE WHEN e.componente='TEORIA' THEN c.nota*e.peso/100 ELSE 0 END)
 INTO v_practica,v_teoria FROM evaluaciones e JOIN calificaciones c ON c.evaluacion_id=e.id WHERE c.inscripcion_id=p_inscripcion;
 SELECT minutos_carga INTO v_total FROM cierres_oferta WHERE oferta_id=v_oferta;
 IF (SELECT COALESCE(SUM(TIMESTAMPDIFF(MINUTE,inicio,fin)),0) FROM sesiones WHERE oferta_id=v_oferta AND estado='REALIZADA')<>v_total
 OR EXISTS(SELECT 1 FROM sesiones WHERE oferta_id=v_oferta AND estado='PROGRAMADA') THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Sesiones realizadas deben completar la carga y no quedar pendientes'; END IF;
 IF EXISTS(SELECT 1 FROM sesiones s LEFT JOIN asistencias_sesion a ON a.sesion_id=s.id AND a.inscripcion_id=p_inscripcion
 WHERE s.oferta_id=v_oferta AND s.estado='REALIZADA' AND a.inscripcion_id IS NULL) THEN
 SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Faltan registros de asistencia'; END IF;
 SELECT COALESCE(SUM(a.minutos_presentes),0) INTO v_presentes FROM asistencias_sesion a JOIN sesiones s ON s.id=a.sesion_id
 WHERE a.inscripcion_id=p_inscripcion AND s.estado='REALIZADA';
 SET v_asistencia=100.0*v_presentes/v_total;
 SET v_excepcion=EXISTS(SELECT 1 FROM excepciones_asistencia WHERE inscripcion_id=p_inscripcion);
 SELECT v_practica*practica+v_teoria*teoria INTO v_nota FROM reglas_evaluacion WHERE id=v_regla;
 INSERT INTO resultados_finales(inscripcion_id,regla_id,promedio,porcentaje_asistencia,excepcion_documentada,estado)
 VALUES(p_inscripcion,v_regla,v_nota,v_asistencia,v_excepcion,
 CASE WHEN v_asistencia<80 AND NOT v_excepcion THEN 'REPROBADO_ASISTENCIA' WHEN v_nota>=61 THEN 'APROBADO' ELSE 'REPROBADO' END);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Current Database: `itsc_academico_v3`
--

USE `itsc_academico_v3`;

--
-- Final view structure for view `v_boletin_final`
--

/*!50001 DROP VIEW IF EXISTS `v_boletin_final`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_boletin_final` AS select `i`.`id` AS `inscripcion_id`,`e`.`registro` AS `registro`,concat(`e`.`nombres`,' ',`e`.`apellidos`) AS `estudiante`,`ma`.`nombre` AS `materia`,`r`.`promedio` AS `promedio`,`r`.`porcentaje_asistencia` AS `porcentaje_asistencia`,`r`.`excepcion_documentada` AS `excepcion_documentada`,case when `re`.`nota_prueba` >= 61 then 61 else `r`.`promedio` end AS `nota_final`,case when `re`.`nota_prueba` >= 61 then 'APROBADO_RECUPERACION' else `r`.`estado` end AS `resultado`,`re`.`nota_prueba` AS `nota_prueba_recuperacion` from ((((((`resultados_finales` `r` join `inscripciones` `i` on(`i`.`id` = `r`.`inscripcion_id`)) join `matriculas` `m` on(`m`.`id` = `i`.`matricula_id`)) join `estudiantes` `e` on(`e`.`id` = `m`.`estudiante_id`)) join `ofertas` `o` on(`o`.`id` = `i`.`oferta_id`)) join `materias` `ma` on(`ma`.`id` = `o`.`materia_id`)) left join `recuperaciones` `re` on(`re`.`inscripcion_id` = `i`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_listado_academico`
--

/*!50001 DROP VIEW IF EXISTS `v_listado_academico`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_listado_academico` AS select `e`.`registro` AS `registro`,concat(`e`.`nombres`,' ',`e`.`apellidos`) AS `estudiante`,`c`.`nombre` AS `carrera`,`p`.`nombre` AS `periodo`,`m`.`nombre` AS `materia`,`o`.`paralelo` AS `paralelo`,`o`.`turno` AS `turno`,concat(`d`.`nombres`,' ',`d`.`apellidos`) AS `docente` from (((((((`inscripciones` `i` join `matriculas` `mt` on(`mt`.`id` = `i`.`matricula_id`)) join `estudiantes` `e` on(`e`.`id` = `mt`.`estudiante_id`)) join `carreras` `c` on(`c`.`id` = `i`.`carrera_id`)) join `periodos` `p` on(`p`.`id` = `i`.`periodo_id`)) join `ofertas` `o` on(`o`.`id` = `i`.`oferta_id`)) join `materias` `m` on(`m`.`id` = `o`.`materia_id`)) join `docentes` `d` on(`d`.`id` = `o`.`docente_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_saldos`
--

/*!50001 DROP VIEW IF EXISTS `v_saldos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 SQL SECURITY DEFINER */
/*!50001 VIEW `v_saldos` AS select `c`.`id` AS `cargo_id`,`c`.`matricula_id` AS `matricula_id`,`c`.`concepto` AS `concepto`,`c`.`monto` AS `cargo`,coalesce(sum(`p`.`monto`),0) AS `pagado`,`c`.`monto` - coalesce(sum(`p`.`monto`),0) AS `saldo` from (`cargos` `c` left join `pagos` `p` on(`p`.`cargo_id` = `c`.`id`)) group by `c`.`id`,`c`.`matricula_id`,`c`.`concepto`,`c`.`monto` */;
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

-- Dump completed on 2026-10-29 20:48:29
