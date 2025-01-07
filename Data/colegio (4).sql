-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-11-2024 a las 03:53:32
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `colegio`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificaciones`
--

CREATE TABLE `calificaciones` (
  `Boletin_ID` int(3) NOT NULL,
  `Calificacion` int(2) NOT NULL,
  `Materia_ID` int(3) NOT NULL,
  `DNI_Est` int(8) NOT NULL,
  `DNI_Doc` int(8) NOT NULL,
  `Curso_ID` int(3) NOT NULL,
  `Espec_ID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `Curso_ID` int(3) NOT NULL,
  `Curso_Desc` int(30) NOT NULL,
  `Espec_ID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `directivos`
--

CREATE TABLE `directivos` (
  `DNI_Direc` int(8) NOT NULL,
  `Apel_Direc` varchar(30) NOT NULL,
  `Nomb_Direc` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docentes`
--

CREATE TABLE `docentes` (
  `DNI_Doc` int(8) NOT NULL,
  `Apel_Doc` varchar(30) NOT NULL,
  `Nomb_Doc` varchar(30) NOT NULL,
  `Materia_ID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especializacion`
--

CREATE TABLE `especializacion` (
  `Espec_ID` int(3) NOT NULL,
  `Espec_Desc` varchar(30) NOT NULL,
  `Materia_ID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estudiantes`
--

CREATE TABLE `estudiantes` (
  `DNI_Est` int(8) NOT NULL,
  `Apel_Est` varchar(30) NOT NULL,
  `Nomb_Est` varchar(30) NOT NULL,
  `FNAC` date NOT NULL,
  `Genero` varchar(1) NOT NULL,
  `Curso_ID` int(1) NOT NULL,
  `Espec_ID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

CREATE TABLE `materias` (
  `Materia_ID` int(3) NOT NULL,
  `Materia_Desc` varchar(30) NOT NULL,
  `DNI_Doc` int(8) NOT NULL,
  `Curso_ID` int(3) NOT NULL,
  `Espec_ID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `Rol_ID` int(1) NOT NULL,
  `Rol_Desc` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `User_ID` varchar(30) NOT NULL,
  `contrasenia` varchar(30) NOT NULL,
  `Rol_ID` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD PRIMARY KEY (`Boletin_ID`),
  ADD KEY `Boletin_ID` (`Boletin_ID`),
  ADD KEY `Curso_ID` (`Curso_ID`),
  ADD KEY `Espec_ID` (`Espec_ID`),
  ADD KEY `DNI_Est` (`DNI_Est`),
  ADD KEY `DNI_Doc` (`DNI_Doc`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`Curso_ID`),
  ADD KEY `Curso_ID` (`Curso_ID`),
  ADD KEY `Espec_ID` (`Espec_ID`);

--
-- Indices de la tabla `directivos`
--
ALTER TABLE `directivos`
  ADD PRIMARY KEY (`DNI_Direc`),
  ADD KEY `DNI_Direc` (`DNI_Direc`);

--
-- Indices de la tabla `docentes`
--
ALTER TABLE `docentes`
  ADD PRIMARY KEY (`DNI_Doc`),
  ADD KEY `DNI_Doc` (`DNI_Doc`),
  ADD KEY `Materia_ID` (`Materia_ID`);

--
-- Indices de la tabla `especializacion`
--
ALTER TABLE `especializacion`
  ADD PRIMARY KEY (`Espec_ID`),
  ADD KEY `Espec_ID` (`Espec_ID`),
  ADD KEY `Materia_ID` (`Materia_ID`);

--
-- Indices de la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD PRIMARY KEY (`DNI_Est`),
  ADD KEY `DNI_Est` (`DNI_Est`),
  ADD KEY `Curso_ID` (`Curso_ID`),
  ADD KEY `Espec_ID` (`Espec_ID`);

--
-- Indices de la tabla `materias`
--
ALTER TABLE `materias`
  ADD PRIMARY KEY (`Materia_ID`),
  ADD KEY `Materia_ID` (`Materia_ID`),
  ADD KEY `DNI_Doc` (`DNI_Doc`),
  ADD KEY `Curso_ID` (`Curso_ID`),
  ADD KEY `Espec_ID` (`Espec_ID`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`Rol_ID`),
  ADD KEY `Rol_ID` (`Rol_ID`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`User_ID`),
  ADD KEY `User_ID` (`User_ID`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`Curso_ID`) REFERENCES `curso` (`Curso_ID`),
  ADD CONSTRAINT `calificaciones_ibfk_2` FOREIGN KEY (`Espec_ID`) REFERENCES `especializacion` (`Espec_ID`),
  ADD CONSTRAINT `calificaciones_ibfk_3` FOREIGN KEY (`DNI_Est`) REFERENCES `estudiantes` (`DNI_Est`),
  ADD CONSTRAINT `calificaciones_ibfk_4` FOREIGN KEY (`DNI_Doc`) REFERENCES `estudiantes` (`DNI_Est`);

--
-- Filtros para la tabla `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `curso_ibfk_1` FOREIGN KEY (`Espec_ID`) REFERENCES `especializacion` (`Espec_ID`);

--
-- Filtros para la tabla `docentes`
--
ALTER TABLE `docentes`
  ADD CONSTRAINT `docentes_ibfk_1` FOREIGN KEY (`Materia_ID`) REFERENCES `materias` (`Materia_ID`);

--
-- Filtros para la tabla `especializacion`
--
ALTER TABLE `especializacion`
  ADD CONSTRAINT `especializacion_ibfk_1` FOREIGN KEY (`Materia_ID`) REFERENCES `materias` (`Materia_ID`);

--
-- Filtros para la tabla `estudiantes`
--
ALTER TABLE `estudiantes`
  ADD CONSTRAINT `estudiantes_ibfk_1` FOREIGN KEY (`Curso_ID`) REFERENCES `curso` (`Curso_ID`),
  ADD CONSTRAINT `estudiantes_ibfk_2` FOREIGN KEY (`Espec_ID`) REFERENCES `especializacion` (`Espec_ID`);

--
-- Filtros para la tabla `materias`
--
ALTER TABLE `materias`
  ADD CONSTRAINT `materias_ibfk_1` FOREIGN KEY (`DNI_Doc`) REFERENCES `docentes` (`DNI_Doc`),
  ADD CONSTRAINT `materias_ibfk_2` FOREIGN KEY (`Curso_ID`) REFERENCES `curso` (`Curso_ID`),
  ADD CONSTRAINT `materias_ibfk_3` FOREIGN KEY (`Espec_ID`) REFERENCES `especializacion` (`Espec_ID`);

--
-- Filtros para la tabla `roles`
--
ALTER TABLE `roles`
  ADD CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`Rol_ID`) REFERENCES `roles` (`Rol_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
