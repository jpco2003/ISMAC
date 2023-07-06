-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-07-2023 a las 22:51:33
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

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

CREATE TABLE `moderadores` (
  `ID_M` int(11) NOT NULL,
  `NOMBRE_M` varchar(255) DEFAULT NULL,
  `CORREO_M` varchar(255) DEFAULT NULL,
  `CONTRASENA_M` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `moderadores`
--

INSERT INTO `moderadores` (`ID_M`, `NOMBRE_M`, `CORREO_M`, `CONTRASENA_M`) VALUES
(1, 'admin', 'jpcarrion19@gmail.com', 'admin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tesis`
--

CREATE TABLE `tesis` (
  `ID_T` int(11) NOT NULL,
  `ID_M` int(11) NOT NULL,
  `TITULO_T` varchar(255) DEFAULT NULL,
  `AUTORES_T` varchar(255) DEFAULT NULL,
  `PROFESOR_T` varchar(255) DEFAULT NULL,
  `ANIO_T` int(11) DEFAULT NULL,
  `ARCHIVO_T` varchar(255) DEFAULT NULL,
  `TITULO_OPTADO_T` char(100) DEFAULT NULL,
  `TEMA_T` varchar(255) DEFAULT NULL,
  `MAIL_T` varchar(255) DEFAULT NULL,
  `CONTACTO_T` int(11) DEFAULT NULL,
  `EGRESADO_T` varchar(255) DEFAULT NULL,
  `DOCENTE_T` varchar(255) DEFAULT NULL,
  `ACTIVE_T` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tesis`
--

INSERT INTO `tesis` (`ID_T`, `ID_M`, `TITULO_T`, `AUTORES_T`, `PROFESOR_T`, `ANIO_T`, `ARCHIVO_T`, `TITULO_OPTADO_T`, `TEMA_T`, `MAIL_T`, `CONTACTO_T`, `EGRESADO_T`, `DOCENTE_T`, `ACTIVE_T`) VALUES
(23, 1, 'Pruebas', 'Juan Pablo', 'Diego Maikes', 2021, '2023181906_CertificadoTituloEnLinea.pdf', 'Tecnologo en Desarrollo de Software', 'Desarrollo de Software', 'jpcarrion19@gmail.com', 994825836, '2023181906_ejemplo 1.jpg', '2023181906_ejemplo 2.jpg', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `moderadores`
--
ALTER TABLE `moderadores`
  ADD PRIMARY KEY (`ID_M`),
  ADD UNIQUE KEY `MODERADORES_PK` (`ID_M`),
  ADD UNIQUE KEY `CORREO_M` (`CORREO_M`);

--
-- Indices de la tabla `tesis`
--
ALTER TABLE `tesis`
  ADD PRIMARY KEY (`ID_T`),
  ADD UNIQUE KEY `TESIS_PK` (`ID_T`),
  ADD UNIQUE KEY `ARCHIVO_T` (`ARCHIVO_T`),
  ADD UNIQUE KEY `TITULO_T` (`TITULO_T`),
  ADD KEY `ADMINISTRAR_FK` (`ID_M`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `moderadores`
--
ALTER TABLE `moderadores`
  MODIFY `ID_M` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `tesis`
--
ALTER TABLE `tesis`
  MODIFY `ID_T` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tesis`
--
ALTER TABLE `tesis`
  ADD CONSTRAINT `FK_TESIS_ADMINISTR_MODERADO` FOREIGN KEY (`ID_M`) REFERENCES `moderadores` (`ID_M`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
