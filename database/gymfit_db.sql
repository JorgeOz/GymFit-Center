CREATE DATABASE  IF NOT EXISTS `bdgimnasio` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `bdgimnasio`;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: bdgimnasio
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `actividad`
--

DROP TABLE IF EXISTS `actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actividad` (
  `id_actividad` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `Instalacion_id_instalacion` int NOT NULL,
  PRIMARY KEY (`id_actividad`),
  KEY `fk_Actividad_Instalacion1_idx` (`Instalacion_id_instalacion`),
  CONSTRAINT `fk_Actividad_Instalacion1` FOREIGN KEY (`Instalacion_id_instalacion`) REFERENCES `instalacion` (`id_instalacion`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE;
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
INSERT INTO `actividad` VALUES (1,'Yoga','Clase suave',1),(2,'Pilates','Nivel medio',2),(3,'Natacion','Piscina',3),(4,'Crossfit','Alta intensidad',4),(5,'Running','Exterior',5),(6,'HIIT','Alta intensidad',2);
/*!40000 ALTER TABLE `actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contrata`
--

DROP TABLE IF EXISTS `contrata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contrata` (
  `id_contrato` int NOT NULL AUTO_INCREMENT,
  `fecha_inicio` date NOT NULL,
  `estado` enum('confirmada','cancelada') NOT NULL,
  `Socio_id_socio` int NOT NULL,
  `Oferta_id_oferta` int NOT NULL,
  `fecha_fin` date NOT NULL,
  PRIMARY KEY (`id_contrato`),
  KEY `fk_Reserva_Socio1_idx` (`Socio_id_socio`),
  KEY `fk_Reserva_Oferta1_idx` (`Oferta_id_oferta`),
  CONSTRAINT `fk_Reserva_Oferta1` FOREIGN KEY (`Oferta_id_oferta`) REFERENCES `oferta` (`id_oferta`),
  CONSTRAINT `fk_Reserva_Socio1` FOREIGN KEY (`Socio_id_socio`) REFERENCES `socio` (`id_socio`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contrata`
--

LOCK TABLES `contrata` WRITE;
/*!40000 ALTER TABLE `contrata` DISABLE KEYS */;
INSERT INTO `contrata` VALUES (1,'2025-01-01','confirmada',1,1,'2025-12-31'),(2,'2025-01-01','confirmada',2,2,'2025-12-31'),(3,'2025-01-01','confirmada',3,3,'2025-12-31'),(4,'2025-01-01','confirmada',4,4,'2025-12-31'),(5,'2025-01-01','confirmada',5,5,'2025-12-31'),(6,'2025-01-01','confirmada',6,6,'2025-12-31');
/*!40000 ALTER TABLE `contrata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especialidad`
--

DROP TABLE IF EXISTS `especialidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especialidad` (
  `id_especialidad` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_especialidad`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especialidad`
--

LOCK TABLES `especialidad` WRITE;
/*!40000 ALTER TABLE `especialidad` DISABLE KEYS */;
INSERT INTO `especialidad` VALUES (1,'Yoga','Especialidad yoga'),(2,'Crossfit','Alta intensidad');
/*!40000 ALTER TABLE `especialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horario`
--

DROP TABLE IF EXISTS `horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horario` (
  `id_horario` int NOT NULL AUTO_INCREMENT,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id_horario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horario`
--

LOCK TABLES `horario` WRITE;
/*!40000 ALTER TABLE `horario` DISABLE KEYS */;
INSERT INTO `horario` VALUES (1,'08:00:00','09:00:00','2025-01-10'),(2,'09:00:00','10:00:00','2025-01-10'),(3,'10:00:00','11:00:00','2025-01-10'),(4,'11:00:00','12:00:00','2025-01-10'),(5,'12:00:00','13:00:00','2025-01-10'),(6,'16:00:00','17:00:00','2025-01-10'),(7,'17:00:00','18:00:00','2025-01-10'),(8,'18:00:00','19:00:00','2025-01-10'),(9,'19:00:00','20:00:00','2025-01-10'),(10,'20:00:00','21:00:00','2025-01-10');
/*!40000 ALTER TABLE `horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horario_has_actividad`
--

DROP TABLE IF EXISTS `horario_has_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horario_has_actividad` (
  `Horario_id_horario` int DEFAULT NULL,
  `Actividad_id_actividad` int DEFAULT NULL,
  `id_horario` varchar(45) NOT NULL,
  `aforo_max` int DEFAULT NULL,
  `Monitor_id_monitor` int NOT NULL,
  PRIMARY KEY (`id_horario`),
  KEY `fk_Horario_has_Actividad_Actividad1_idx` (`Actividad_id_actividad`),
  KEY `fk_Horario_has_Actividad_Horario1_idx` (`Horario_id_horario`),
  KEY `fk_Horario_has_Actividad_Monitor1_idx` (`Monitor_id_monitor`),
  CONSTRAINT `fk_Horario_has_Actividad_Actividad1` FOREIGN KEY (`Actividad_id_actividad`) REFERENCES `actividad` (`id_actividad`),
  CONSTRAINT `fk_Horario_has_Actividad_Horario1` FOREIGN KEY (`Horario_id_horario`) REFERENCES `horario` (`id_horario`),
  CONSTRAINT `fk_Horario_has_Actividad_Monitor1` FOREIGN KEY (`Monitor_id_monitor`) REFERENCES `monitor` (`id_monitor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horario_has_actividad`
--

LOCK TABLES `horario_has_actividad` WRITE;
/*!40000 ALTER TABLE `horario_has_actividad` DISABLE KEYS */;
INSERT INTO `horario_has_actividad` VALUES (1,1,'1',20,1),(10,4,'10',12,2),(2,2,'2',15,2),(3,3,'3',10,3),(4,4,'4',12,4),(5,5,'5',25,1),(6,6,'6',18,2),(7,1,'7',20,3),(8,2,'8',15,4),(9,3,'9',10,1);
/*!40000 ALTER TABLE `horario_has_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instalacion`
--

DROP TABLE IF EXISTS `instalacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instalacion` (
  `id_instalacion` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `aforo_max` int NOT NULL,
  `tipo` varchar(30) NOT NULL,
  PRIMARY KEY (`id_instalacion`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instalacion`
--

LOCK TABLES `instalacion` WRITE;
/*!40000 ALTER TABLE `instalacion` DISABLE KEYS */;
INSERT INTO `instalacion` VALUES (1,'Sala 1','Sala principal',30,'sala'),(2,'Sala 2','Sala secundaria',25,'sala'),(3,'Piscina','Piscina climatizada',20,'agua'),(4,'Box','Zona crossfit',15,'box'),(5,'Exterior','Zona aire libre',30,'exterior');
/*!40000 ALTER TABLE `instalacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitor`
--

DROP TABLE IF EXISTS `monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monitor` (
  `id_monitor` int NOT NULL AUTO_INCREMENT,
  `telefono` varchar(20) DEFAULT NULL,
  `Usuario_id_usuario` int NOT NULL,
  PRIMARY KEY (`id_monitor`),
  KEY `fk_Monitor_Usuario1_idx` (`Usuario_id_usuario`),
  CONSTRAINT `fk_Monitor_Usuario1` FOREIGN KEY (`Usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitor`
--

LOCK TABLES `monitor` WRITE;
/*!40000 ALTER TABLE `monitor` DISABLE KEYS */;
INSERT INTO `monitor` VALUES (1,'611111111',4),(2,'622222222',5),(3,'633333333',13),(4,'644444444',15);
/*!40000 ALTER TABLE `monitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `monitor_has_especialidad`
--

DROP TABLE IF EXISTS `monitor_has_especialidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `monitor_has_especialidad` (
  `Monitor_id_monitor` int NOT NULL,
  `Especialidad_id_especialidad` int NOT NULL,
  PRIMARY KEY (`Monitor_id_monitor`,`Especialidad_id_especialidad`),
  KEY `fk_Monitor_has_Especialidad_Especialidad1_idx` (`Especialidad_id_especialidad`),
  KEY `fk_Monitor_has_Especialidad_Monitor1_idx` (`Monitor_id_monitor`),
  CONSTRAINT `fk_Monitor_has_Especialidad_Especialidad1` FOREIGN KEY (`Especialidad_id_especialidad`) REFERENCES `especialidad` (`id_especialidad`),
  CONSTRAINT `fk_Monitor_has_Especialidad_Monitor1` FOREIGN KEY (`Monitor_id_monitor`) REFERENCES `monitor` (`id_monitor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `monitor_has_especialidad`
--

LOCK TABLES `monitor_has_especialidad` WRITE;
/*!40000 ALTER TABLE `monitor_has_especialidad` DISABLE KEYS */;
INSERT INTO `monitor_has_especialidad` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `monitor_has_especialidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oferta`
--

DROP TABLE IF EXISTS `oferta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oferta` (
  `id_oferta` int NOT NULL AUTO_INCREMENT,
  `Actividad_id_actividad` int NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `descuento` decimal(5,2) NOT NULL,
  `plazas_disponibles` int NOT NULL,
  PRIMARY KEY (`id_oferta`),
  KEY `fk_Oferta_Actividad1_idx` (`Actividad_id_actividad`),
  CONSTRAINT `fk_Oferta_Actividad1` FOREIGN KEY (`Actividad_id_actividad`) REFERENCES `actividad` (`id_actividad`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oferta`
--

LOCK TABLES `oferta` WRITE;
/*!40000 ALTER TABLE `oferta` DISABLE KEYS */;
INSERT INTO `oferta` VALUES (1,1,50.00,10.00,20),(2,2,60.00,15.00,15),(3,3,40.00,5.00,10),(4,4,70.00,20.00,12),(5,5,30.00,5.00,25),(6,6,55.00,10.00,18);
/*!40000 ALTER TABLE `oferta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permiso`
--

DROP TABLE IF EXISTS `permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permiso` (
  `id_permiso` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id_permiso`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permiso`
--

LOCK TABLES `permiso` WRITE;
/*!40000 ALTER TABLE `permiso` DISABLE KEYS */;
INSERT INTO `permiso` VALUES (1,'Acceso total','ALL');
/*!40000 ALTER TABLE `permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promocion`
--

DROP TABLE IF EXISTS `promocion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promocion` (
  `id_promocion` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `descuento` decimal(5,2) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  PRIMARY KEY (`id_promocion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promocion`
--

LOCK TABLES `promocion` WRITE;
/*!40000 ALTER TABLE `promocion` DISABLE KEYS */;
INSERT INTO `promocion` VALUES (1,'Promo Enero','Descuento',10.00,'2025-01-01','2025-01-31');
/*!40000 ALTER TABLE `promocion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva` (
  `fecha` date NOT NULL,
  `estado` varchar(45) NOT NULL,
  `id_reserva` int NOT NULL AUTO_INCREMENT,
  `Socio_id_socio` int NOT NULL,
  `Horario_has_Actividad_id_horario` varchar(45) NOT NULL,
  PRIMARY KEY (`id_reserva`),
  KEY `fk_Reserva_Socio2_idx` (`Socio_id_socio`),
  KEY `fk_Reserva_Horario_has_Actividad1_idx` (`Horario_has_Actividad_id_horario`),
  CONSTRAINT `fk_Reserva_Horario_has_Actividad1` FOREIGN KEY (`Horario_has_Actividad_id_horario`) REFERENCES `horario_has_actividad` (`id_horario`),
  CONSTRAINT `fk_Reserva_Socio2` FOREIGN KEY (`Socio_id_socio`) REFERENCES `socio` (`id_socio`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
INSERT INTO `reserva` VALUES ('2025-01-10','confirmada',1,1,'1'),('2025-01-10','confirmada',2,2,'2'),('2025-01-10','confirmada',3,3,'3'),('2025-01-10','confirmada',4,4,'4'),('2025-01-10','confirmada',5,5,'5'),('2025-01-10','confirmada',6,6,'6'),('2025-01-10','confirmada',7,7,'7'),('2025-01-10','confirmada',8,8,'8'),('2025-01-10','confirmada',9,9,'9'),('2025-01-10','confirmada',10,10,'10');
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'admin','Administrador'),(2,'socio','Cliente'),(3,'monitor','Entrenador');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_tiene_permiso`
--

DROP TABLE IF EXISTS `rol_tiene_permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol_tiene_permiso` (
  `Rol_id_rol` int NOT NULL,
  `Permiso_id_permiso` int NOT NULL,
  PRIMARY KEY (`Rol_id_rol`,`Permiso_id_permiso`),
  KEY `fk_Rol_has_Permiso_Permiso1_idx` (`Permiso_id_permiso`),
  KEY `fk_Rol_has_Permiso_Rol1_idx` (`Rol_id_rol`),
  CONSTRAINT `fk_Rol_has_Permiso_Permiso1` FOREIGN KEY (`Permiso_id_permiso`) REFERENCES `permiso` (`id_permiso`),
  CONSTRAINT `fk_Rol_has_Permiso_Rol1` FOREIGN KEY (`Rol_id_rol`) REFERENCES `rol` (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_tiene_permiso`
--

LOCK TABLES `rol_tiene_permiso` WRITE;
/*!40000 ALTER TABLE `rol_tiene_permiso` DISABLE KEYS */;
INSERT INTO `rol_tiene_permiso` VALUES (1,1);
/*!40000 ALTER TABLE `rol_tiene_permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socio`
--

DROP TABLE IF EXISTS `socio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socio` (
  `id_socio` int NOT NULL AUTO_INCREMENT,
  `telefono` varchar(20) DEFAULT NULL,
  `dni` varchar(9) NOT NULL,
  `fecha_alta` date NOT NULL,
  `tipo_cuota` varchar(45) NOT NULL,
  `estado` enum('activo','inactivo') NOT NULL DEFAULT 'activo',
  `Usuario_id_usuario` int NOT NULL,
  PRIMARY KEY (`id_socio`),
  UNIQUE KEY `dni_UNIQUE` (`dni`),
  KEY `fk_Socio_Usuario1_idx` (`Usuario_id_usuario`),
  CONSTRAINT `fk_Socio_Usuario1` FOREIGN KEY (`Usuario_id_usuario`) REFERENCES `usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socio`
--

LOCK TABLES `socio` WRITE;
/*!40000 ALTER TABLE `socio` DISABLE KEYS */;
INSERT INTO `socio` VALUES (1,'600111111','11111111A','2024-01-10','mensual','activo',1),(2,'600222222','22222222B','2024-01-11','mensual','activo',2),(3,'600333333','33333333C','2024-01-12','trimestral','activo',6),(4,'600444444','44444444D','2024-01-13','mensual','activo',7),(5,'600555555','55555555E','2024-01-14','anual','activo',8),(6,'600666666','66666666F','2024-01-15','mensual','activo',9),(7,'600777777','77777777G','2024-01-16','mensual','activo',10),(8,'600888888','88888888H','2024-01-17','mensual','activo',11),(9,'600999999','99999999I','2024-01-18','trimestral','activo',12),(10,'601000000','10101010J','2024-01-19','anual','activo',14);
/*!40000 ALTER TABLE `socio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socio_tiene_promocion`
--

DROP TABLE IF EXISTS `socio_tiene_promocion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `socio_tiene_promocion` (
  `Socio_id_socio` int NOT NULL,
  `Promocion_id_promocion` int NOT NULL,
  PRIMARY KEY (`Socio_id_socio`,`Promocion_id_promocion`),
  KEY `fk_Socio_has_Promocion_Promocion1_idx` (`Promocion_id_promocion`),
  KEY `fk_Socio_has_Promocion_Socio1_idx` (`Socio_id_socio`),
  CONSTRAINT `fk_Socio_has_Promocion_Promocion1` FOREIGN KEY (`Promocion_id_promocion`) REFERENCES `promocion` (`id_promocion`),
  CONSTRAINT `fk_Socio_has_Promocion_Socio1` FOREIGN KEY (`Socio_id_socio`) REFERENCES `socio` (`id_socio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socio_tiene_promocion`
--

LOCK TABLES `socio_tiene_promocion` WRITE;
/*!40000 ALTER TABLE `socio_tiene_promocion` DISABLE KEYS */;
INSERT INTO `socio_tiene_promocion` VALUES (1,1),(2,1),(3,1);
/*!40000 ALTER TABLE `socio_tiene_promocion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  `password` varchar(45) NOT NULL,
  `tipo` varchar(45) NOT NULL,
  `apellido1` varchar(45) NOT NULL,
  `apellido2` varchar(45) DEFAULT NULL,
  `correo` varchar(50) NOT NULL,
  `fecha_registro` date NOT NULL,
  `Rol_id_rol` int NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo_UNIQUE` (`correo`),
  KEY `fk_Usuario_Rol1_idx` (`Rol_id_rol`),
  CONSTRAINT `fk_Usuario_Rol1` FOREIGN KEY (`Rol_id_rol`) REFERENCES `rol` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Juan','1234','socio','Perez','Lopez','juan1@gmail.com','2024-01-01',2),(2,'Maria','1234','socio','Gomez','Ruiz','maria2@gmail.com','2024-01-02',2),(3,'Luis','1234','admin','Martinez','Sanz','luis3@gmail.com','2024-01-03',1),(4,'Ana','1234','monitor','Garcia','Diaz','ana4@gmail.com','2024-01-04',3),(5,'Carlos','1234','monitor','Lopez','Vega','carlos5@gmail.com','2024-01-05',3),(6,'Elena','1234','socio','Torres','Mora','elena6@gmail.com','2024-01-06',2),(7,'David','1234','socio','Navarro','Soto','david7@gmail.com','2024-01-07',2),(8,'Laura','1234','socio','Moreno','Vidal','laura8@gmail.com','2024-01-08',2),(9,'Pablo','1234','socio','Castro','Iglesias','pablo9@gmail.com','2024-01-09',2),(10,'Carmen','1234','socio','Mendez','Fuentes','carmen10@gmail.com','2024-01-10',2),(11,'Raul','1234','socio','Blanco','Paz','raul11@gmail.com','2024-01-11',2),(12,'Sara','1234','socio','Ortega','Luna','sara12@gmail.com','2024-01-12',2),(13,'Jorge','1234','monitor','Delgado','Cano','jorge13@gmail.com','2024-01-13',3),(14,'Irene','1234','socio','Prieto','Marin','irene14@gmail.com','2024-01-14',2),(15,'Alberto','1234','monitor','Herrera','Sanz','alberto15@gmail.com','2024-01-15',3);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-26 13:19:28
