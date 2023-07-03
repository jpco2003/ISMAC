-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 03-01-2023 a las 04:10:40
-- Versión del servidor: 8.0.31
-- Versión de PHP: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `repositorios`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `moderadores`
--

DROP TABLE IF EXISTS `moderadores`;
CREATE TABLE IF NOT EXISTS `moderadores` (
  `ID_M` int NOT NULL AUTO_INCREMENT,
  `NOMBRE_M` varchar(255) DEFAULT NULL,
  `CORREO_M` varchar(255) DEFAULT NULL,
  `CONTRASENA_M` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_M`),
  UNIQUE KEY `MODERADORES_PK` (`ID_M`),
  UNIQUE KEY `CORREO_M` (`CORREO_M`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `moderadores`
--

INSERT INTO `moderadores` (`ID_M`, `NOMBRE_M`, `CORREO_M`, `CONTRASENA_M`) VALUES
(1, 'Admini', 'admin@unap.cl', '1234'),
(4, 'Alan', 'alan@unap.cl', 'asdasd'),
(6, 'Koopa', 'koppa@unap.cl', '1234'),
(8, 'admini', 'admin@gmail.com', 'vadfXUefgmKWqq7'),
(10, 'malo', 'malo@unap.cl', 'qweqe'),
(11, 'Bruce Lee', 'Bruce@unap.cl', 'bruce123'),
(12, 'Alan', 'alan@estudiantesunap.cl', 'fff'),
(13, 'admini', 'alala@unap.cl', 'fghgjklñ'),
(14, 'Waldo', 'waldo@unap.cl', '123'),
(15, 'Juan', 'juan@gmail.cl', '3245'),
(16, 'Ester', 'sadasdsadasdsaa@hotmail.com', '22234'),
(17, 'Ash', 'pokemon@unap.cl', 'pikachu'),
(18, 'dios', 'dios@unap.cl', '123123'),
(19, 'asd', 'asd@unap.cl', 'asd');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tesis`
--

DROP TABLE IF EXISTS `tesis`;
CREATE TABLE IF NOT EXISTS `tesis` (
  `ID_T` int NOT NULL AUTO_INCREMENT,
  `ID_M` int NOT NULL,
  `TITULO_T` varchar(255) DEFAULT NULL,
  `AUTORES_T` varchar(255) DEFAULT NULL,
  `PROFESOR_T` varchar(255) DEFAULT NULL,
  `ANIO_T` int DEFAULT NULL,
  `ARCHIVO_T` varchar(255) DEFAULT NULL,
  `TITULO_OPTADO_T` char(100) DEFAULT NULL,
  `FACULTAD_T` char(100) DEFAULT NULL,
  `TEMA_T` varchar(255) DEFAULT NULL,
  `MAIL_T` varchar(255) DEFAULT NULL,
  `CONTACTO_T` int DEFAULT NULL,
  `EGRESADO_T` varchar(255) DEFAULT NULL,
  `DOCENTE_T` varchar(255) DEFAULT NULL,
  `ACTIVE_T` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID_T`),
  UNIQUE KEY `TESIS_PK` (`ID_T`),
  UNIQUE KEY `ARCHIVO_T` (`ARCHIVO_T`),
  UNIQUE KEY `TITULO_T` (`TITULO_T`),
  KEY `ADMINISTRAR_FK` (`ID_M`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tesis`
--

INSERT INTO `tesis` (`ID_T`, `ID_M`, `TITULO_T`, `AUTORES_T`, `PROFESOR_T`, `ANIO_T`, `ARCHIVO_T`, `TITULO_OPTADO_T`, `FACULTAD_T`, `TEMA_T`, `MAIL_T`, `CONTACTO_T`, `EGRESADO_T`, `DOCENTE_T`, `ACTIVE_T`) VALUES
(1, 1, 'El verdadero Avatar', 'Unapino Perez y Unapina Lobos', 'Aang', 1988, '2023225637_TESIS EL AVATAR Y EL DESARROLLO PSICOMOTOR.pdf', 'Doctorado', 'Arquitectura e Ingenieria', 'Entretención', 'avatar@estudiantesunap.cl', 99876754, '2023225637_Unapinos.jpg', '2023225637_aang.jpg', 1),
(2, 4, 'Banco de Nicaragua', 'Nicaraguayo', 'Rudolf', 2000, '2023001051_central-bank-of-nicaragua.pdf', 'Magister', 'Economia y Negocios', 'Investigación', 'mail@mail.cl', 0, '2023001051_aang.jpg', '2023001051_aang.jpg', 1),
(3, 18, 'La leyeda de aang', 'aang', 'aang', 2000, '2023095417_calendario-enero-2023.pdf', 'Magister', 'Arquitectura e Ingenieria', 'Serie', 'aang@gmail.com', 66743895, '2023095417_aang.jpg', '2023095417_aang.jpg', 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tesis`
--
ALTER TABLE `tesis`
  ADD CONSTRAINT `FK_TESIS_ADMINISTR_MODERADO` FOREIGN KEY (`ID_M`) REFERENCES `moderadores` (`ID_M`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
