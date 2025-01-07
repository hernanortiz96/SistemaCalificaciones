-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 12-12-2024 a las 17:51:43
-- Versión del servidor: 10.6.20-MariaDB-cll-lve-log
-- Versión de PHP: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ortizher_Colegio`
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
  `Espec_ID` int(3) NOT NULL,
  `Cuatrimestre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calificaciones`
--

INSERT INTO `calificaciones` (`Boletin_ID`, `Calificacion`, `Materia_ID`, `DNI_Est`, `DNI_Doc`, `Curso_ID`, `Espec_ID`, `Cuatrimestre`) VALUES
(1, 10, 1, 49324658, 14325698, 2, 1, 1),
(2, 10, 1, 49324658, 14325698, 1, 1, 2),
(3, 7, 13, 51654892, 39911172, 13, 2, 1),
(4, 7, 21, 40365462, 14325698, 1, 1, 1),
(5, 5, 21, 49324658, 14325698, 1, 1, 1),
(6, 9, 21, 40365462, 14325698, 1, 1, 2),
(7, 10, 21, 56321452, 14325698, 1, 1, 2),
(8, 10, 21, 49324658, 14325698, 1, 1, 2),
(9, 4, 21, 56321452, 14325698, 1, 1, 1),
(10, 9, 12, 51654892, 39911172, 13, 2, 1),
(11, 7, 12, 51654892, 39911172, 13, 2, 2),
(14, 8, 12, 56321468, 39911172, 13, 2, 1),
(15, 10, 12, 56321468, 39911172, 13, 2, 2),
(16, 10, 13, 51654892, 39911172, 13, 2, 2),
(17, 6, 13, 56321468, 39911172, 13, 2, 1),
(18, 6, 13, 56321468, 39911172, 13, 2, 2),
(19, 7, 14, 56326514, 39911172, 14, 2, 1),
(20, 7, 14, 56326514, 39911172, 14, 2, 2),
(21, 10, 11, 56326514, 39911172, 14, 2, 1),
(22, 5, 11, 56326514, 39911172, 14, 2, 2),
(23, 9, 14, 49324652, 39911172, 14, 2, 1),
(24, 4, 14, 49324652, 39911172, 14, 2, 2),
(25, 9, 11, 49324652, 39911172, 14, 2, 1),
(26, 8, 11, 49324652, 39911172, 14, 2, 2),
(27, 7, 1, 56321452, 14325698, 1, 1, 1),
(28, 6, 1, 56321452, 14325698, 1, 1, 2),
(29, 8, 1, 40365462, 14325698, 1, 1, 1),
(30, 8, 1, 40365462, 14325698, 1, 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `Curso_ID` int(3) NOT NULL,
  `Curso_Desc` varchar(30) NOT NULL,
  `Espec_ID` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`Curso_ID`, `Curso_Desc`, `Espec_ID`) VALUES
(1, 'Primero \"A\"', 1),
(2, 'Primero \"B\"', 1),
(3, 'Primero \"C\"', 1),
(4, 'Segundo \"A\"', 1),
(5, 'Segundo \"B\"', 1),
(6, 'Segundo \"C\"', 1),
(11, 'Primero \"A\"', 2),
(12, 'Primero \"B\"', 2),
(13, 'Primero \"C\"', 2),
(14, 'Segundo \"A\"', 2),
(15, 'Segundo \"B\"', 2),
(16, 'Segundo \"C\"', 2),
(21, 'Primero \"A\"', 3),
(22, 'Primero \"B\"', 3),
(23, 'Primero \"C\"', 3),
(24, 'Segundo \"A\"', 3),
(25, 'Segundo \"B\"', 3),
(26, 'Segundo \"C\"', 3),
(31, 'Primero \"A\"', 4),
(32, 'Primero \"B\"', 4),
(33, 'Primero \"C\"', 4),
(34, 'Segundo \"A\"', 4),
(35, 'Segundo \"B\"', 4),
(36, 'Segundo \"C\"', 4);

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
  `Nomb_Doc` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `docentes`
--

INSERT INTO `docentes` (`DNI_Doc`, `Apel_Doc`, `Nomb_Doc`) VALUES
(14325698, 'Storti', 'Guillermo'),
(24658962, 'Aquino', 'Dylan'),
(33561205, 'Ruiz', 'Joaquin'),
(38956321, 'Lozada', 'Martin'),
(39911172, 'Ortiz', 'Hernan Rodolfo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especializacion`
--

CREATE TABLE `especializacion` (
  `Espec_ID` int(3) NOT NULL,
  `Espec_Desc` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especializacion`
--

INSERT INTO `especializacion` (`Espec_ID`, `Espec_Desc`) VALUES
(1, 'Naturales'),
(2, 'Sociales'),
(3, 'Economia'),
(4, 'Arte');

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

--
-- Volcado de datos para la tabla `estudiantes`
--

INSERT INTO `estudiantes` (`DNI_Est`, `Apel_Est`, `Nomb_Est`, `FNAC`, `Genero`, `Curso_ID`, `Espec_ID`) VALUES
(40365462, 'Sofovich', 'Gerardo', '1996-07-09', 'M', 1, 1),
(49324652, 'Perez', 'Martin', '2014-09-30', 'M', 14, 2),
(49324658, 'Ramos', 'Paola', '2024-05-08', 'F', 1, 1),
(51654632, 'Gomez', 'Cristian', '2015-08-01', 'M', 16, 2),
(51654892, 'Ortiz', 'Sofia Ayelen', '2014-09-01', 'F', 13, 2),
(55621452, 'Aquino', 'Gonzalo', '2015-06-01', 'M', 6, 1),
(56321452, 'Ramos', 'Sergio', '2014-09-03', 'M', 1, 1),
(56321468, 'Gonzales', 'Roberto', '2004-07-08', 'M', 13, 2),
(56321943, 'Melia', 'Elida ', '2014-08-14', 'F', 5, 1),
(56326514, 'Giovani', 'Giordano', '2004-07-10', 'M', 14, 2);

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

--
-- Volcado de datos para la tabla `materias`
--

INSERT INTO `materias` (`Materia_ID`, `Materia_Desc`, `DNI_Doc`, `Curso_ID`, `Espec_ID`) VALUES
(1, 'Quimica 1', 14325698, 1, 1),
(11, 'Historia ', 39911172, 14, 2),
(12, 'Historia 1', 39911172, 13, 2),
(13, 'Geografia 1', 39911172, 13, 2),
(14, 'Geografia ', 39911172, 14, 2),
(21, 'Analisis matematico ', 14325698, 1, 3),
(31, 'Danza Clásica', 24658962, 33, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `Rol_ID` int(1) NOT NULL,
  `Rol_Desc` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`Rol_ID`, `Rol_Desc`) VALUES
(1, 'Estudiantes'),
(2, 'Docentes'),
(3, 'Directivos');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `User_ID` varchar(30) NOT NULL,
  `DNI` int(8) NOT NULL,
  `contrasenia` varchar(30) NOT NULL,
  `Rol_ID` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`User_ID`, `DNI`, `contrasenia`, `Rol_ID`) VALUES
('Eli_Melia', 24328939, 'elimeliacontrasenia1234', 3),
('Guistor_Profe', 14325698, 'contrasenia1234', 2),
('Hernan_Admin', 39911172, 'contrasenia1234', 2),
('Sofi_Ortiz', 51654892, 'contrasenia1234', 1);

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
  ADD KEY `Materia_ID` (`Materia_ID`),
  ADD KEY `calificaciones_ibfk_4` (`DNI_Doc`);

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
  ADD KEY `DNI_Doc` (`DNI_Doc`);

--
-- Indices de la tabla `especializacion`
--
ALTER TABLE `especializacion`
  ADD PRIMARY KEY (`Espec_ID`),
  ADD KEY `Espec_ID` (`Espec_ID`);

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
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  MODIFY `Boletin_ID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`Curso_ID`) REFERENCES `curso` (`Curso_ID`),
  ADD CONSTRAINT `calificaciones_ibfk_2` FOREIGN KEY (`Espec_ID`) REFERENCES `especializacion` (`Espec_ID`),
  ADD CONSTRAINT `calificaciones_ibfk_4` FOREIGN KEY (`DNI_Doc`) REFERENCES `docentes` (`DNI_Doc`),
  ADD CONSTRAINT `calificaciones_ibfk_5` FOREIGN KEY (`Materia_ID`) REFERENCES `materias` (`Materia_ID`),
  ADD CONSTRAINT `calificaciones_ibfk_6` FOREIGN KEY (`DNI_Est`) REFERENCES `estudiantes` (`DNI_Est`);

--
-- Filtros para la tabla `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `curso_ibfk_1` FOREIGN KEY (`Espec_ID`) REFERENCES `especializacion` (`Espec_ID`);

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
