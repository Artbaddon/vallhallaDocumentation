-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-05-2025 a las 04:12:12
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
-- Base de datos: `vallhalladb`
--
CREATE DATABASE IF NOT EXISTS `vallhalladb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `vallhalladb`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `apartment`
--

DROP TABLE IF EXISTS `apartment`;
CREATE TABLE `apartment` (
  `Apartment_id` int(11) NOT NULL,
  `Apartment_number` varchar(4) NOT NULL,
  `Apartment_status_FK_ID` int(11) NOT NULL,
  `Tower_FK_ID` int(11) NOT NULL,
  `Owner_FK_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `apartment_status`
--

DROP TABLE IF EXISTS `apartment_status`;
CREATE TABLE `apartment_status` (
  `Apartment_status_id` int(11) NOT NULL,
  `Apartment_status_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `guard`
--

DROP TABLE IF EXISTS `guard`;
CREATE TABLE `guard` (
  `Guard_id` int(11) NOT NULL,
  `User_FK_ID` int(11) NOT NULL,
  `Guard_arl` varchar(30) NOT NULL,
  `Guard_eps` varchar(30) NOT NULL,
  `Guard_shift` varchar(30) NOT NULL,
  `Guard_createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `Guard_updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `module`
--

DROP TABLE IF EXISTS `module`;
CREATE TABLE `module` (
  `module_id` int(11) NOT NULL,
  `module_name` varchar(30) NOT NULL,
  `module_description` text NOT NULL,
  `module_createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `module_updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `module_role`
--

DROP TABLE IF EXISTS `module_role`;
CREATE TABLE `module_role` (
  `Module_role_id` int(11) NOT NULL,
  `Role_FK_ID` int(11) NOT NULL,
  `Module_FK_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notification`
--

DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `Notification_id` int(11) NOT NULL,
  `Notification_type_FK_ID` int(11) NOT NULL,
  `Notification_description` text NOT NULL,
  `Notification_User_FK_ID` int(11) DEFAULT NULL,
  `Notification_createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `Notification_updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notification_type`
--

DROP TABLE IF EXISTS `notification_type`;
CREATE TABLE `notification_type` (
  `Notification_type_id` int(11) NOT NULL,
  `Notification_type_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `owner`
--

DROP TABLE IF EXISTS `owner`;
CREATE TABLE `owner` (
  `Owner_id` int(11) NOT NULL,
  `User_FK_ID` int(11) NOT NULL,
  `Owner_is_tenant` tinyint(1) NOT NULL,
  `Owner_birth_date` datetime NOT NULL,
  `Owner_createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `Owner_updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parking`
--

DROP TABLE IF EXISTS `parking`;
CREATE TABLE `parking` (
  `Parking_id` int(11) NOT NULL,
  `Parking_number` varchar(5) DEFAULT NULL,
  `Parking_status_ID_FK` int(11) NOT NULL,
  `Vehicle_type_ID_FK` int(11) NOT NULL,
  `Parking_type_ID_FK` int(11) NOT NULL,
  `User_ID_FK` int(11) NOT NULL,
  `Parking_createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `Parking_updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parkingstatus`
--

DROP TABLE IF EXISTS `parkingstatus`;
CREATE TABLE `parkingstatus` (
  `id` int(11) NOT NULL,
  `status_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parking_status`
--

DROP TABLE IF EXISTS `parking_status`;
CREATE TABLE `parking_status` (
  `Parking_status_id` int(11) NOT NULL,
  `Parking_status_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parking_type`
--

DROP TABLE IF EXISTS `parking_type`;
CREATE TABLE `parking_type` (
  `Parking_type_id` int(11) NOT NULL,
  `Parking_type_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `Owner_ID_FK` int(11) NOT NULL,
  `Payment_total_payment` float NOT NULL,
  `Payment_Status_ID_FK` int(11) NOT NULL,
  `Payment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `Payment_method` varchar(30) NOT NULL,
  `Payment_reference_number` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `payment_status`
--

DROP TABLE IF EXISTS `payment_status`;
CREATE TABLE `payment_status` (
  `Payment_status_id` int(11) NOT NULL,
  `Payment_status_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `Permissions_id` int(11) NOT NULL,
  `Permissions_name` varchar(30) NOT NULL,
  `Permissions_description` text NOT NULL,
  `Permissions_createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `Permissions_updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions_module_role`
--

DROP TABLE IF EXISTS `permissions_module_role`;
CREATE TABLE `permissions_module_role` (
  `Permissions_module_role_id` int(11) NOT NULL,
  `Module_role_FK_ID` int(11) NOT NULL,
  `Permissions_FK_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pet`
--

DROP TABLE IF EXISTS `pet`;
CREATE TABLE `pet` (
  `Pet_id` int(11) NOT NULL,
  `Pet_name` varchar(30) NOT NULL,
  `Pet_species` varchar(30) NOT NULL,
  `Pet_Breed` varchar(30) NOT NULL,
  `Pet_vaccination_card` varchar(255) NOT NULL,
  `Pet_Photo` varchar(255) NOT NULL,
  `Owner_FK_ID` int(11) NOT NULL,
  `Pet_createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `Pet_updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pqrs`
--

DROP TABLE IF EXISTS `pqrs`;
CREATE TABLE `pqrs` (
  `PQRS_id` int(11) NOT NULL,
  `PQRS_category_FK_ID` int(11) NOT NULL,
  `PQRS_description` text NOT NULL,
  `PQRS_file` varchar(255) DEFAULT NULL,
  `PQRS_answer` text DEFAULT NULL,
  `PQRS_createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `PQRS_updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pqrs_category`
--

DROP TABLE IF EXISTS `pqrs_category`;
CREATE TABLE `pqrs_category` (
  `PQRS_category_id` int(11) NOT NULL,
  `PQRS_category_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pqrs_tracking`
--

DROP TABLE IF EXISTS `pqrs_tracking`;
CREATE TABLE `pqrs_tracking` (
  `PQRS_tracking_id` int(11) NOT NULL,
  `PQRS_tracking_PQRS_FK_ID` int(11) NOT NULL,
  `PQRS_tracking_user_FK_ID` int(11) NOT NULL,
  `PQRS_tracking_status_FK_ID` int(11) NOT NULL,
  `PQRS_tracking_date_update` timestamp NOT NULL DEFAULT current_timestamp(),
  `PQRS_tracking_createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `PQRS_tracking_updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pqrs_tracking_status`
--

DROP TABLE IF EXISTS `pqrs_tracking_status`;
CREATE TABLE `pqrs_tracking_status` (
  `PQRS_tracking_status_id` int(11) NOT NULL,
  `PQRS_tracking_status_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profile`
--

DROP TABLE IF EXISTS `profile`;
CREATE TABLE `profile` (
  `Profile_id` int(11) NOT NULL,
  `Profile_fullName` varchar(100) NOT NULL,
  `User_FK_ID` int(11) NOT NULL,
  `Profile_document_type` varchar(20) NOT NULL,
  `Profile_document_number` varchar(30) NOT NULL,
  `Profile_telephone_number` varchar(12) NOT NULL,
  `Profile_photo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `questions`
--

DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `Questions_id` int(11) NOT NULL,
  `Questions_type_FK_ID` int(11) NOT NULL,
  `Questions_description` text NOT NULL,
  `Questions_answer` text DEFAULT NULL,
  `Questions_createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `Questions_updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `question_type`
--

DROP TABLE IF EXISTS `question_type`;
CREATE TABLE `question_type` (
  `Question_type_id` int(11) NOT NULL,
  `Question_type_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservation`
--

DROP TABLE IF EXISTS `reservation`;
CREATE TABLE `reservation` (
  `Reservation_id` int(11) NOT NULL,
  `Reservation_type_FK_ID` int(11) NOT NULL,
  `Reservation_status_FK_ID` int(11) NOT NULL,
  `Reservation_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `Reservation_start_time` datetime NOT NULL,
  `Reservation_end_time` datetime NOT NULL,
  `Reservation_description` text NOT NULL,
  `Owner_FK_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservation_status`
--

DROP TABLE IF EXISTS `reservation_status`;
CREATE TABLE `reservation_status` (
  `Reservation_status_id` int(11) NOT NULL,
  `Reservation_status_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservation_type`
--

DROP TABLE IF EXISTS `reservation_type`;
CREATE TABLE `reservation_type` (
  `Reservation_type_id` int(11) NOT NULL,
  `Reservation_type_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `Role_id` int(11) NOT NULL,
  `Role_name` varchar(30) NOT NULL,
  `Role_description` text NOT NULL,
  `Role_createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `Role_updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `survey`
--

DROP TABLE IF EXISTS `survey`;
CREATE TABLE `survey` (
  `Survey_id` int(11) NOT NULL,
  `Survey_name` varchar(30) NOT NULL,
  `Survey_description` text NOT NULL,
  `Questions_FK_ID` int(11) NOT NULL,
  `Survey_result` text DEFAULT NULL,
  `User_FK_ID` int(11) NOT NULL,
  `Survey_createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `Survey_updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tower`
--

DROP TABLE IF EXISTS `tower`;
CREATE TABLE `tower` (
  `Tower_id` int(11) NOT NULL,
  `Tower_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `Users_id` int(11) NOT NULL,
  `Users_name` varchar(30) NOT NULL,
  `User_status_FK_ID` int(11) NOT NULL,
  `Role_FK_ID` int(11) NOT NULL,
  `Users_createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `Users_updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_status`
--

DROP TABLE IF EXISTS `user_status`;
CREATE TABLE `user_status` (
  `User_status_id` int(11) NOT NULL,
  `User_status_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehicle_type`
--

DROP TABLE IF EXISTS `vehicle_type`;
CREATE TABLE `vehicle_type` (
  `Vehicle_type_id` int(11) NOT NULL,
  `Vehicle_type_name` varchar(30) NOT NULL,
  `vehicle_plate` varchar(30) DEFAULT NULL,
  `vehicle_model` varchar(30) DEFAULT NULL,
  `vehicle_brand` varchar(30) DEFAULT NULL,
  `vehicle_color` varchar(30) DEFAULT NULL,
  `vehicle_engineCC` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `apartment`
--
ALTER TABLE `apartment`
  ADD PRIMARY KEY (`Apartment_id`),
  ADD KEY `Apartment_status_FK_ID` (`Apartment_status_FK_ID`),
  ADD KEY `Tower_FK_ID` (`Tower_FK_ID`),
  ADD KEY `Owner_FK_ID` (`Owner_FK_ID`);

--
-- Indices de la tabla `apartment_status`
--
ALTER TABLE `apartment_status`
  ADD PRIMARY KEY (`Apartment_status_id`),
  ADD UNIQUE KEY `Apartment_status_name` (`Apartment_status_name`);

--
-- Indices de la tabla `guard`
--
ALTER TABLE `guard`
  ADD PRIMARY KEY (`Guard_id`),
  ADD KEY `User_FK_ID` (`User_FK_ID`);

--
-- Indices de la tabla `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`module_id`),
  ADD UNIQUE KEY `module_name` (`module_name`);

--
-- Indices de la tabla `module_role`
--
ALTER TABLE `module_role`
  ADD PRIMARY KEY (`Module_role_id`),
  ADD KEY `Role_FK_ID` (`Role_FK_ID`),
  ADD KEY `Module_FK_ID` (`Module_FK_ID`);

--
-- Indices de la tabla `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`Notification_id`),
  ADD KEY `Notification_type_FK_ID` (`Notification_type_FK_ID`),
  ADD KEY `Notification_User_FK_ID` (`Notification_User_FK_ID`);

--
-- Indices de la tabla `notification_type`
--
ALTER TABLE `notification_type`
  ADD PRIMARY KEY (`Notification_type_id`),
  ADD UNIQUE KEY `Notification_type_name` (`Notification_type_name`);

--
-- Indices de la tabla `owner`
--
ALTER TABLE `owner`
  ADD PRIMARY KEY (`Owner_id`),
  ADD KEY `User_FK_ID` (`User_FK_ID`);

--
-- Indices de la tabla `parking`
--
ALTER TABLE `parking`
  ADD PRIMARY KEY (`Parking_id`),
  ADD KEY `Parking_status_ID_FK` (`Parking_status_ID_FK`),
  ADD KEY `Vehicle_type_ID_FK` (`Vehicle_type_ID_FK`),
  ADD KEY `Parking_type_ID_FK` (`Parking_type_ID_FK`),
  ADD KEY `User_ID_FK` (`User_ID_FK`);

--
-- Indices de la tabla `parkingstatus`
--
ALTER TABLE `parkingstatus`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `parking_status`
--
ALTER TABLE `parking_status`
  ADD PRIMARY KEY (`Parking_status_id`),
  ADD UNIQUE KEY `Parking_status_name` (`Parking_status_name`);

--
-- Indices de la tabla `parking_type`
--
ALTER TABLE `parking_type`
  ADD PRIMARY KEY (`Parking_type_id`),
  ADD UNIQUE KEY `Parking_type_name` (`Parking_type_name`);

--
-- Indices de la tabla `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `Payment_Status_ID_FK` (`Payment_Status_ID_FK`),
  ADD KEY `Owner_ID_FK` (`Owner_ID_FK`);

--
-- Indices de la tabla `payment_status`
--
ALTER TABLE `payment_status`
  ADD PRIMARY KEY (`Payment_status_id`),
  ADD UNIQUE KEY `Payment_status_name` (`Payment_status_name`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`Permissions_id`),
  ADD UNIQUE KEY `Permissions_name` (`Permissions_name`);

--
-- Indices de la tabla `permissions_module_role`
--
ALTER TABLE `permissions_module_role`
  ADD PRIMARY KEY (`Permissions_module_role_id`),
  ADD KEY `Module_role_FK_ID` (`Module_role_FK_ID`),
  ADD KEY `Permissions_FK_ID` (`Permissions_FK_ID`);

--
-- Indices de la tabla `pet`
--
ALTER TABLE `pet`
  ADD PRIMARY KEY (`Pet_id`),
  ADD KEY `Owner_FK_ID` (`Owner_FK_ID`);

--
-- Indices de la tabla `pqrs`
--
ALTER TABLE `pqrs`
  ADD PRIMARY KEY (`PQRS_id`),
  ADD KEY `PQRS_category_FK_ID` (`PQRS_category_FK_ID`);

--
-- Indices de la tabla `pqrs_category`
--
ALTER TABLE `pqrs_category`
  ADD PRIMARY KEY (`PQRS_category_id`),
  ADD UNIQUE KEY `PQRS_category_name` (`PQRS_category_name`);

--
-- Indices de la tabla `pqrs_tracking`
--
ALTER TABLE `pqrs_tracking`
  ADD PRIMARY KEY (`PQRS_tracking_id`),
  ADD KEY `PQRS_tracking_status_FK_ID` (`PQRS_tracking_status_FK_ID`),
  ADD KEY `PQRS_tracking_PQRS_FK_ID` (`PQRS_tracking_PQRS_FK_ID`),
  ADD KEY `PQRS_tracking_user_FK_ID` (`PQRS_tracking_user_FK_ID`);

--
-- Indices de la tabla `pqrs_tracking_status`
--
ALTER TABLE `pqrs_tracking_status`
  ADD PRIMARY KEY (`PQRS_tracking_status_id`),
  ADD UNIQUE KEY `PQRS_tracking_status_name` (`PQRS_tracking_status_name`);

--
-- Indices de la tabla `profile`
--
ALTER TABLE `profile`
  ADD PRIMARY KEY (`Profile_id`),
  ADD KEY `User_FK_ID` (`User_FK_ID`);

--
-- Indices de la tabla `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`Questions_id`),
  ADD KEY `Questions_type_FK_ID` (`Questions_type_FK_ID`);

--
-- Indices de la tabla `question_type`
--
ALTER TABLE `question_type`
  ADD PRIMARY KEY (`Question_type_id`),
  ADD UNIQUE KEY `Question_type_name` (`Question_type_name`);

--
-- Indices de la tabla `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`Reservation_id`),
  ADD KEY `Reservation_type_FK_ID` (`Reservation_type_FK_ID`),
  ADD KEY `Reservation_status_FK_ID` (`Reservation_status_FK_ID`),
  ADD KEY `Owner_FK_ID` (`Owner_FK_ID`);

--
-- Indices de la tabla `reservation_status`
--
ALTER TABLE `reservation_status`
  ADD PRIMARY KEY (`Reservation_status_id`),
  ADD UNIQUE KEY `Reservation_status_name` (`Reservation_status_name`);

--
-- Indices de la tabla `reservation_type`
--
ALTER TABLE `reservation_type`
  ADD PRIMARY KEY (`Reservation_type_id`),
  ADD UNIQUE KEY `Reservation_type_name` (`Reservation_type_name`);

--
-- Indices de la tabla `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`Role_id`),
  ADD UNIQUE KEY `Role_name` (`Role_name`);

--
-- Indices de la tabla `survey`
--
ALTER TABLE `survey`
  ADD PRIMARY KEY (`Survey_id`),
  ADD KEY `Questions_FK_ID` (`Questions_FK_ID`),
  ADD KEY `User_FK_ID` (`User_FK_ID`);

--
-- Indices de la tabla `tower`
--
ALTER TABLE `tower`
  ADD PRIMARY KEY (`Tower_id`),
  ADD UNIQUE KEY `Tower_name` (`Tower_name`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Users_id`),
  ADD UNIQUE KEY `Users_name` (`Users_name`),
  ADD KEY `User_status_FK_ID` (`User_status_FK_ID`),
  ADD KEY `Role_FK_ID` (`Role_FK_ID`);

--
-- Indices de la tabla `user_status`
--
ALTER TABLE `user_status`
  ADD PRIMARY KEY (`User_status_id`),
  ADD UNIQUE KEY `User_status_name` (`User_status_name`);

--
-- Indices de la tabla `vehicle_type`
--
ALTER TABLE `vehicle_type`
  ADD PRIMARY KEY (`Vehicle_type_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `apartment`
--
ALTER TABLE `apartment`
  MODIFY `Apartment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `apartment_status`
--
ALTER TABLE `apartment_status`
  MODIFY `Apartment_status_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `guard`
--
ALTER TABLE `guard`
  MODIFY `Guard_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `module`
--
ALTER TABLE `module`
  MODIFY `module_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `module_role`
--
ALTER TABLE `module_role`
  MODIFY `Module_role_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notification`
--
ALTER TABLE `notification`
  MODIFY `Notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notification_type`
--
ALTER TABLE `notification_type`
  MODIFY `Notification_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `owner`
--
ALTER TABLE `owner`
  MODIFY `Owner_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `parking`
--
ALTER TABLE `parking`
  MODIFY `Parking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `parkingstatus`
--
ALTER TABLE `parkingstatus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `parking_status`
--
ALTER TABLE `parking_status`
  MODIFY `Parking_status_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `parking_type`
--
ALTER TABLE `parking_type`
  MODIFY `Parking_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `payment_status`
--
ALTER TABLE `payment_status`
  MODIFY `Payment_status_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `Permissions_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `permissions_module_role`
--
ALTER TABLE `permissions_module_role`
  MODIFY `Permissions_module_role_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pet`
--
ALTER TABLE `pet`
  MODIFY `Pet_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pqrs`
--
ALTER TABLE `pqrs`
  MODIFY `PQRS_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pqrs_category`
--
ALTER TABLE `pqrs_category`
  MODIFY `PQRS_category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pqrs_tracking`
--
ALTER TABLE `pqrs_tracking`
  MODIFY `PQRS_tracking_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pqrs_tracking_status`
--
ALTER TABLE `pqrs_tracking_status`
  MODIFY `PQRS_tracking_status_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `profile`
--
ALTER TABLE `profile`
  MODIFY `Profile_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `questions`
--
ALTER TABLE `questions`
  MODIFY `Questions_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `question_type`
--
ALTER TABLE `question_type`
  MODIFY `Question_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reservation`
--
ALTER TABLE `reservation`
  MODIFY `Reservation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reservation_status`
--
ALTER TABLE `reservation_status`
  MODIFY `Reservation_status_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reservation_type`
--
ALTER TABLE `reservation_type`
  MODIFY `Reservation_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `role`
--
ALTER TABLE `role`
  MODIFY `Role_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `survey`
--
ALTER TABLE `survey`
  MODIFY `Survey_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tower`
--
ALTER TABLE `tower`
  MODIFY `Tower_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `Users_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `user_status`
--
ALTER TABLE `user_status`
  MODIFY `User_status_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `vehicle_type`
--
ALTER TABLE `vehicle_type`
  MODIFY `Vehicle_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `apartment`
--
ALTER TABLE `apartment`
  ADD CONSTRAINT `apartment_ibfk_1` FOREIGN KEY (`Apartment_status_FK_ID`) REFERENCES `apartment_status` (`Apartment_status_id`),
  ADD CONSTRAINT `apartment_ibfk_2` FOREIGN KEY (`Tower_FK_ID`) REFERENCES `tower` (`Tower_id`),
  ADD CONSTRAINT `apartment_ibfk_3` FOREIGN KEY (`Owner_FK_ID`) REFERENCES `owner` (`Owner_id`);

--
-- Filtros para la tabla `guard`
--
ALTER TABLE `guard`
  ADD CONSTRAINT `guard_ibfk_1` FOREIGN KEY (`User_FK_ID`) REFERENCES `users` (`Users_id`);

--
-- Filtros para la tabla `module_role`
--
ALTER TABLE `module_role`
  ADD CONSTRAINT `module_role_ibfk_1` FOREIGN KEY (`Role_FK_ID`) REFERENCES `role` (`Role_id`),
  ADD CONSTRAINT `module_role_ibfk_2` FOREIGN KEY (`Module_FK_ID`) REFERENCES `module` (`module_id`);

--
-- Filtros para la tabla `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`Notification_type_FK_ID`) REFERENCES `notification_type` (`Notification_type_id`),
  ADD CONSTRAINT `notification_ibfk_2` FOREIGN KEY (`Notification_User_FK_ID`) REFERENCES `users` (`Users_id`);

--
-- Filtros para la tabla `owner`
--
ALTER TABLE `owner`
  ADD CONSTRAINT `owner_ibfk_1` FOREIGN KEY (`User_FK_ID`) REFERENCES `users` (`Users_id`);

--
-- Filtros para la tabla `parking`
--
ALTER TABLE `parking`
  ADD CONSTRAINT `parking_ibfk_1` FOREIGN KEY (`Parking_status_ID_FK`) REFERENCES `parking_status` (`Parking_status_id`),
  ADD CONSTRAINT `parking_ibfk_2` FOREIGN KEY (`Vehicle_type_ID_FK`) REFERENCES `vehicle_type` (`Vehicle_type_id`),
  ADD CONSTRAINT `parking_ibfk_3` FOREIGN KEY (`Parking_type_ID_FK`) REFERENCES `parking_type` (`Parking_type_id`),
  ADD CONSTRAINT `parking_ibfk_4` FOREIGN KEY (`User_ID_FK`) REFERENCES `users` (`Users_id`);

--
-- Filtros para la tabla `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`Payment_Status_ID_FK`) REFERENCES `payment_status` (`Payment_status_id`),
  ADD CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`Owner_ID_FK`) REFERENCES `owner` (`Owner_id`);

--
-- Filtros para la tabla `permissions_module_role`
--
ALTER TABLE `permissions_module_role`
  ADD CONSTRAINT `permissions_module_role_ibfk_1` FOREIGN KEY (`Module_role_FK_ID`) REFERENCES `module_role` (`Module_role_id`),
  ADD CONSTRAINT `permissions_module_role_ibfk_2` FOREIGN KEY (`Permissions_FK_ID`) REFERENCES `permissions` (`Permissions_id`);

--
-- Filtros para la tabla `pet`
--
ALTER TABLE `pet`
  ADD CONSTRAINT `pet_ibfk_1` FOREIGN KEY (`Owner_FK_ID`) REFERENCES `owner` (`Owner_id`);

--
-- Filtros para la tabla `pqrs`
--
ALTER TABLE `pqrs`
  ADD CONSTRAINT `pqrs_ibfk_1` FOREIGN KEY (`PQRS_category_FK_ID`) REFERENCES `pqrs_category` (`PQRS_category_id`);

--
-- Filtros para la tabla `pqrs_tracking`
--
ALTER TABLE `pqrs_tracking`
  ADD CONSTRAINT `pqrs_tracking_ibfk_1` FOREIGN KEY (`PQRS_tracking_status_FK_ID`) REFERENCES `pqrs_tracking_status` (`PQRS_tracking_status_id`),
  ADD CONSTRAINT `pqrs_tracking_ibfk_2` FOREIGN KEY (`PQRS_tracking_PQRS_FK_ID`) REFERENCES `pqrs` (`PQRS_id`),
  ADD CONSTRAINT `pqrs_tracking_ibfk_3` FOREIGN KEY (`PQRS_tracking_user_FK_ID`) REFERENCES `users` (`Users_id`);

--
-- Filtros para la tabla `profile`
--
ALTER TABLE `profile`
  ADD CONSTRAINT `profile_ibfk_1` FOREIGN KEY (`User_FK_ID`) REFERENCES `users` (`Users_id`);

--
-- Filtros para la tabla `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`Questions_type_FK_ID`) REFERENCES `question_type` (`Question_type_id`);

--
-- Filtros para la tabla `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`Reservation_type_FK_ID`) REFERENCES `reservation_type` (`Reservation_type_id`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`Reservation_status_FK_ID`) REFERENCES `reservation_status` (`Reservation_status_id`),
  ADD CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`Owner_FK_ID`) REFERENCES `owner` (`Owner_id`);

--
-- Filtros para la tabla `survey`
--
ALTER TABLE `survey`
  ADD CONSTRAINT `survey_ibfk_1` FOREIGN KEY (`Questions_FK_ID`) REFERENCES `questions` (`Questions_id`),
  ADD CONSTRAINT `survey_ibfk_2` FOREIGN KEY (`User_FK_ID`) REFERENCES `users` (`Users_id`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`User_status_FK_ID`) REFERENCES `user_status` (`User_status_id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`Role_FK_ID`) REFERENCES `role` (`Role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
