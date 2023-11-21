-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-12-2019 a las 19:39:51
-- Versión del servidor: 10.4.6-MariaDB
-- Versión de PHP: 7.3.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `Pañoltech`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiante`
--

CREATE TABLE `estudiante` (
  `idestudiante` int(11) NOT NULL,
  `codigo` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `dni` varchar(8) COLLATE utf8_spanish2_ci NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `carrera` varchar(30) COLLATE utf8_spanish2_ci NOT NULL,
  `direccion` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono` varchar(15) COLLATE utf8_spanish2_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `estudiante`
--

INSERT INTO `estudiante` (`idestudiante`, `codigo`, `dni`, `nombre`, `carrera`, `direccion`, `telefono`, `email`, `condicion`) VALUES
(1, '12345671', '75111111', 'José ', 'Desarrollo de Software', 'Av. Saenz Peña - Lambayeque - santiago', '922222222', '', 1),
(2, '12345672', '76222222', 'Yas', 'Enfermeria Técnica', 'Av. santiago 123 -  santiago', '9711111111', '', 1),
(3, '12345673', '77333333', 'Luis ', 'Desarrollo de Software', 'Av. 09 De Octubre - santiago', '927777778', '', 1),
(4, '12345674', '75218965', 'Yeison', 'Soldador Estructural', 'santiago', '928888889', '', 1),
(5, '12345675', '49028556', 'Cesy', 'Enfermeria Técnica', 'santiago', '961245895', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `herramienta`
--

CREATE TABLE `herramienta` (
  `idherramienta` int(11) NOT NULL,
  `cantidad_disponible` int(11) NOT NULL,
  `idmateria` int(11) NOT NULL,
  `descripcion` varchar(800) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `imagen` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `herramienta`
--

INSERT INTO `herramienta` (`idherramienta`, `cantidad_disponible`, `idmateria`, `descripcion`, `imagen`, `condicion`) VALUES
(1, 0, 1, '', '1577216903.PNG', 1),
(2, 10, 3, '', '1577325959.jpeg', 1),
(3, 10, 4, '', '1577326347.jpeg', 1),
(4, 1, 6, '', '1577325941.jpeg', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE `materia` (
  `idmateria` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `descripcion` varchar(500) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`idmateria`, `nombre`, `descripcion`, `condicion`) VALUES
(1, 'Introducción a la Ingeniería de Sistemas', '', 1),
(2, 'Fundamentos de la programación', '', 1),
(3, 'Lenguaje de la programación', '', 1),
(4, 'Matemática', '', 1),
(5, 'Programación', '', 1),
(6, 'Salud', '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo`
--

CREATE TABLE `prestamo` (
  `idprestamo` int(11) NOT NULL,
  `idherramienta` int(11) NOT NULL,
  `idestudiante` int(11) NOT NULL,
  `fecha_prestamo` date NOT NULL,
  `fecha_devolucion` date NOT NULL,
  `cantidad` int(11) NOT NULL,
  `observacion` varchar(200) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `condicion` varchar(20) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `prestamo`
--

INSERT INTO `prestamo` (`idprestamo`, `idherramienta`, `idestudiante`, `fecha_prestamo`, `fecha_devolucion`, `cantidad`, `observacion`, `condicion`) VALUES
(1, 2, 1, '2019-12-31', '2019-12-31', 1, NULL, 'Devuelto'),
(2, 4, 2, '2019-12-31', '2020-01-06', 2, NULL, 'Prestado');

--
-- Disparadores `prestamo`
--
DELIMITER $$
CREATE TRIGGER `tr_pr_devuelto` AFTER UPDATE ON `prestamo` FOR EACH ROW BEGIN
UPDATE herramienta SET cantidad_disponible = cantidad_disponible + NEW.cantidad
WHERE herramienta.idherramienta = NEW.idherramienta;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tr_pr_prestado` AFTER INSERT ON `prestamo` FOR EACH ROW BEGIN
UPDATE herramienta SET cantidad_disponible = cantidad_disponible - NEW.cantidad
WHERE herramienta.idherramienta = NEW.idherramienta;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `profesor` (
  `idprofesor` int(11) NOT NULL,
  `numero_trabajador` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `rut` varchar(8) COLLATE utf8_spanish2_ci NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `profesion` varchar(30) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cargo` varchar(30) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `direccion` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `login` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `clave` varchar(20) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`idprofesor`, `numero_trabajador`, `rut`, `nombre`, `profesion`, `cargo`, `direccion`, `telefono`, `email`, `login`, `clave`) VALUES
(1, '123562', '78945612', 'Valente Vergara', NULL, 'Administrador', 'Gaspar de toro', '921803285', NULL, 'admin', 'admin');

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `numero_trabajador` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `dni` varchar(8) COLLATE utf8_spanish2_ci NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `profesion` varchar(30) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `cargo` varchar(30) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `direccion` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `login` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `clave` varchar(20) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `numero_trabajador`, `dni`, `nombre`, `profesion`, `cargo`, `direccion`, `telefono`, `email`, `login`, `clave`) VALUES
(1, '123562', '78945612', 'Admin', NULL, 'Administrador', 'Santiago', '921803285', NULL, 'admin', 'admin');







-- Índices para tablas volcadas
--


--
-- Indices de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  ADD PRIMARY KEY (`idestudiante`);

--
-- Indices de la tabla `herramienta`
--
ALTER TABLE `herramienta`
  ADD PRIMARY KEY (`idherramienta`),
  ADD KEY `idmateria` (`idmateria`);

--
-- Indices de la tabla `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`idmateria`);

--
-- Indices de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD PRIMARY KEY (`idprestamo`),
  ADD KEY `idherramienta` (`idherramienta`),
  ADD KEY `idestudiante` (`idestudiante`);

--
-- Indices de la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD PRIMARY KEY (`idprofesor`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--

--
-- AUTO_INCREMENT de la tabla `estudiante`
--
ALTER TABLE `estudiante`
  MODIFY `idestudiante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

-- AUTO_INCREMENT de la tabla `herramienta`
--
ALTER TABLE `herramienta`
  MODIFY `idherramienta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `materia`
--
ALTER TABLE `materia`
  MODIFY `idmateria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  MODIFY `idprestamo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `profesor`
--
ALTER TABLE `profesor`
  MODIFY `idprofesor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;


-- Restricciones para tablas volcadas


--
-- Filtros para la tabla `herramienta`
--
ALTER TABLE `herramienta`
  ADD CONSTRAINT `fk_herramienta_materia` FOREIGN KEY (`idmateria`) REFERENCES `materia` (`idmateria`);

--
-- Filtros para la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD CONSTRAINT `fk_prestamo_estudiante` FOREIGN KEY (`idestudiante`) REFERENCES `estudiante` (`idestudiante`),
  ADD CONSTRAINT `fk_prestamo_herramienta` FOREIGN KEY (`idherramienta`) REFERENCES `herramienta` (`idherramienta`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
