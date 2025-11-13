-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 09, 2025 at 03:01 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ecotours_bd`
--

-- --------------------------------------------------------

--
-- Table structure for table `ciudad_base`
--

CREATE TABLE `ciudad_base` (
  `id_ciudad_base` int(11) NOT NULL,
  `nombre_ciudad_base` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ciudad_base`
--

INSERT INTO `ciudad_base` (`id_ciudad_base`, `nombre_ciudad_base`) VALUES
(1, 'BARQUISIMETO'),
(2, 'VALENCIA'),
(3, 'MARACAIBO'),
(4, 'CARACAS');

-- --------------------------------------------------------

--
-- Table structure for table `ciudad_hospedaje`
--

CREATE TABLE `ciudad_hospedaje` (
  `id_ciudad_hospedaje` int(11) NOT NULL,
  `ciudad_hospedaje` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ciudad_hospedaje`
--

INSERT INTO `ciudad_hospedaje` (`id_ciudad_hospedaje`, `ciudad_hospedaje`) VALUES
(1, 'Caracas'),
(2, 'Porlamar'),
(3, 'Mérida'),
(4, 'Canaima');

-- --------------------------------------------------------

--
-- Table structure for table `ciudad_restaurante`
--

CREATE TABLE `ciudad_restaurante` (
  `id_ciudad_restaurante` int(11) NOT NULL,
  `ciudad_restaurante` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ciudad_restaurante`
--

INSERT INTO `ciudad_restaurante` (`id_ciudad_restaurante`, `ciudad_restaurante`) VALUES
(1, 'Caracas'),
(2, 'Porlamar'),
(3, 'Mérida'),
(4, 'Canaima');

-- --------------------------------------------------------

--
-- Table structure for table `destinos_manejados`
--

CREATE TABLE `destinos_manejados` (
  `id_destino` int(11) NOT NULL,
  `nombre_destino` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `destinos_manejados`
--

INSERT INTO `destinos_manejados` (`id_destino`, `nombre_destino`) VALUES
(1, 'Los Roques'),
(2, 'Margarita'),
(3, 'El Salto Ángel'),
(4, 'Mérida');

-- --------------------------------------------------------

--
-- Table structure for table `estado_proveedores`
--

CREATE TABLE `estado_proveedores` (
  `id_estado_proveedor` int(11) NOT NULL,
  `estado_proveedor` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `estado_proveedores`
--

INSERT INTO `estado_proveedores` (`id_estado_proveedor`, `estado_proveedor`) VALUES
(1, 'Activo'),
(2, 'Inactivo');

-- --------------------------------------------------------

--
-- Table structure for table `estado_transaccion`
--

CREATE TABLE `estado_transaccion` (
  `id_estado_transaccion` int(11) NOT NULL,
  `estado_transaccion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `estado_transaccion`
--

INSERT INTO `estado_transaccion` (`id_estado_transaccion`, `estado_transaccion`) VALUES
(1, 'Pendiente'),
(2, 'Confirmado'),
(3, 'Rechazado');

-- --------------------------------------------------------

--
-- Table structure for table `estado_transaccion_prov`
--

CREATE TABLE `estado_transaccion_prov` (
  `id_estado_transaccion_PROV` int(11) NOT NULL,
  `estado_transaccion_PROV` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `estado_transaccion_prov`
--

INSERT INTO `estado_transaccion_prov` (`id_estado_transaccion_PROV`, `estado_transaccion_PROV`) VALUES
(1, 'Pendiente'),
(2, 'Pagado');

-- --------------------------------------------------------

--
-- Table structure for table `factura_cliente`
--

CREATE TABLE `factura_cliente` (
  `id_factura` int(11) NOT NULL,
  `cédula_usuario` int(11) NOT NULL,
  `id_paquete` int(11) NOT NULL,
  `id_metodoP` int(11) NOT NULL,
  `fecha_inicio_viaje` date DEFAULT NULL,
  `fecha_fin_viaje` date DEFAULT NULL,
  `monto_pagado` decimal(10,2) NOT NULL,
  `fecha_pago` date NOT NULL,
  `num_referencia` varchar(50) DEFAULT NULL,
  `banco_origen` varchar(100) DEFAULT NULL,
  `comentario_adicional` text DEFAULT NULL,
  `id_estado_transaccion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `metodo_pago`
--

CREATE TABLE `metodo_pago` (
  `id_metodoP` int(11) NOT NULL,
  `tipo_metodo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `metodo_pago`
--

INSERT INTO `metodo_pago` (`id_metodoP`, `tipo_metodo`) VALUES
(1, 'Transferencia Bancaria'),
(2, 'Pago Móvil'),
(3, 'Zelle');

-- --------------------------------------------------------

--
-- Table structure for table `paquete_turistico`
--

CREATE TABLE `paquete_turistico` (
  `id_paquete` int(11) NOT NULL,
  `cantidad_personas` int(11) NOT NULL,
  `destino_paquete` varchar(150) NOT NULL,
  `duracion_paquete` varchar(50) NOT NULL,
  `descripcion_paquete` text DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `total_con_iva` decimal(10,2) NOT NULL,
  `id_tarifa_aerolinea` int(11) DEFAULT NULL,
  `id_tarifa_hospedaje` int(11) DEFAULT NULL,
  `id_tarifa_restaurante` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proveedores_aerolineas`
--

CREATE TABLE `proveedores_aerolineas` (
  `codigo_aerolinea` varchar(10) NOT NULL,
  `nombre_aerolinea` varchar(100) NOT NULL,
  `correo_aerolinea` varchar(100) DEFAULT NULL,
  `telefono_aerolinea` varchar(20) DEFAULT NULL,
  `id_estado_proveedor` int(11) NOT NULL,
  `fecha_registro_aerolinea` date DEFAULT NULL,
  `id_ciudad_base` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proveedores_aerolineas`
--

INSERT INTO `proveedores_aerolineas` (`codigo_aerolinea`, `nombre_aerolinea`, `correo_aerolinea`, `telefono_aerolinea`, `id_estado_proveedor`, `fecha_registro_aerolinea`, `id_ciudad_base`) VALUES
('AA01', 'AeroAndes', 'contacto@aeroandes.com', '04141234567', 1, '2025-11-08', 1),
('AA03', 'Fly', 'contacto@fly.com', '04146662552', 1, '2025-07-08', 3);

-- --------------------------------------------------------

--
-- Table structure for table `proveedores_hospedaje`
--

CREATE TABLE `proveedores_hospedaje` (
  `id_hospedaje` int(11) NOT NULL,
  `nombre_hospedaje` varchar(150) NOT NULL,
  `id_tipo_hospedaje` int(11) NOT NULL,
  `id_ciudad_hospedaje` int(11) NOT NULL,
  `direccion_hospedaje` varchar(255) DEFAULT NULL,
  `id_estado_proveedor` int(11) NOT NULL,
  `fecha_registro_hospedaje` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proveedores_hospedaje`
--

INSERT INTO `proveedores_hospedaje` (`id_hospedaje`, `nombre_hospedaje`, `id_tipo_hospedaje`, `id_ciudad_hospedaje`, `direccion_hospedaje`, `id_estado_proveedor`, `fecha_registro_hospedaje`) VALUES
(1, 'Waka Wená', 1, 4, 'Parque Nacional Canaima, Laguna de Canaima, Canaima 8001, Bolivar', 1, '2024-10-06'),
(2, 'El arroyo', 1, 1, 'Av. Lecuna, Caracas 1014, Distrito Capital', 1, '2022-01-12'),
(3, 'Hotel Plaza', 1, 3, 'Av. 5 entre calles 23 y 24, Mérida 5101, Mérida', 2, '2022-03-25'),
(4, 'Queseyo', 1, 4, 'Una Direccion ', 2, '2022-03-25');

-- --------------------------------------------------------

--
-- Table structure for table `proveedores_restaurantes`
--

CREATE TABLE `proveedores_restaurantes` (
  `id_restaurante` int(11) NOT NULL,
  `nombre_restaurante` varchar(150) NOT NULL,
  `horario_servicio` varchar(50) DEFAULT NULL,
  `incluye_bebidas` tinyint(1) DEFAULT NULL,
  `id_ciudad_restaurante` int(11) NOT NULL,
  `direccion_restaurante` varchar(255) DEFAULT NULL,
  `telefono_restaurante` varchar(20) DEFAULT NULL,
  `correo_restaurante` varchar(100) DEFAULT NULL,
  `id_estado_proveedor` int(11) NOT NULL,
  `fecha_registro_restaurante` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proveedores_restaurantes`
--

INSERT INTO `proveedores_restaurantes` (`id_restaurante`, `nombre_restaurante`, `horario_servicio`, `incluye_bebidas`, `id_ciudad_restaurante`, `direccion_restaurante`, `telefono_restaurante`, `correo_restaurante`, `id_estado_proveedor`, `fecha_registro_restaurante`) VALUES
(1, 'Arepa Planet', '08:00 - 22:00', 1, 4, 'Parque Nacional Canaima, Laguna de Canaima, Canaima 8001, Bolivar', '04141234567', 'contacto@arepaplanet.com', 1, '2025-11-08'),
(2, 'cacao', '10:00 - 20:00', 1, 2, 'Av. Porlamar, entre calles 1 y 2', '04141234567', 'contacto@cacao.com', 1, '2025-11-08'),
(3, 'Lucas', NULL, NULL, 1, 'CC. Líder, 1er nivel ', NULL, 'contacto@lucas.com', 1, '2025-08-31');

-- --------------------------------------------------------

--
-- Table structure for table `registro_egresos`
--

CREATE TABLE `registro_egresos` (
  `id_egreso` int(11) NOT NULL,
  `id_factura` int(11) NOT NULL,
  `tipo_PROV` varchar(20) NOT NULL,
  `proveedor_id_fk` varchar(10) NOT NULL,
  `monto_A_pagar` decimal(10,2) NOT NULL,
  `fecha_generacion` date NOT NULL,
  `fecha_pago_real` date DEFAULT NULL,
  `numReferenciaPago` varchar(50) DEFAULT NULL,
  `id_estado_transaccion_PROV` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tarifa_hospedaje`
--

CREATE TABLE `tarifa_hospedaje` (
  `id_tarifa_hospedaje` int(11) NOT NULL,
  `id_hospedaje` int(11) NOT NULL,
  `precio_por_dia` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tarifa_hospedaje`
--

INSERT INTO `tarifa_hospedaje` (`id_tarifa_hospedaje`, `id_hospedaje`, `precio_por_dia`) VALUES
(1, 1, 45.00),
(2, 3, 80.00);

-- --------------------------------------------------------

--
-- Table structure for table `tarifa_por_destino`
--

CREATE TABLE `tarifa_por_destino` (
  `id_tarifa_aerolinea` int(11) NOT NULL,
  `codigo_aerolinea` varchar(10) NOT NULL,
  `id_destino` int(11) NOT NULL,
  `precio_vuelos` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tarifa_por_destino`
--

INSERT INTO `tarifa_por_destino` (`id_tarifa_aerolinea`, `codigo_aerolinea`, `id_destino`, `precio_vuelos`) VALUES
(2, 'AA01', 2, 120.00),
(3, 'AA03', 1, 85.00);

-- --------------------------------------------------------

--
-- Table structure for table `tarifa_restaurante`
--

CREATE TABLE `tarifa_restaurante` (
  `id_tarifa_restaurante` int(11) NOT NULL,
  `id_restaurante` int(11) NOT NULL,
  `precio_por_dia` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tarifa_restaurante`
--

INSERT INTO `tarifa_restaurante` (`id_tarifa_restaurante`, `id_restaurante`, `precio_por_dia`) VALUES
(1, 2, 18.00),
(2, 3, 20.00);

-- --------------------------------------------------------

--
-- Table structure for table `tipo_hospedaje`
--

CREATE TABLE `tipo_hospedaje` (
  `id_tipo_hospedaje` int(11) NOT NULL,
  `tipo_hospedaje` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tipo_hospedaje`
--

INSERT INTO `tipo_hospedaje` (`id_tipo_hospedaje`, `tipo_hospedaje`) VALUES
(1, 'Hotel'),
(2, 'Posada'),
(3, 'Resort'),
(4, 'Cabaña');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `cedula_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `apellido_usuario` varchar(100) NOT NULL,
  `telefono_usuario` varchar(20) DEFAULT NULL,
  `correo_usuario` varchar(100) NOT NULL,
  `contraseña_usuario` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`cedula_usuario`, `nombre_usuario`, `apellido_usuario`, `telefono_usuario`, `correo_usuario`, `contraseña_usuario`) VALUES
(28281234, 'José Daniel', 'Colmenarez', '04245793109', 'dalto@gmail.com', '$2b$10$pEqxCgDkGLQNs1kk7OszZeFqtbqOqEY5rahsf5RUSligKcSCg1inK'),
(31930239, 'Sarath', 'Mendoza', '04145589714', 'sarath@gmail.com', 'cama123$');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ciudad_base`
--
ALTER TABLE `ciudad_base`
  ADD PRIMARY KEY (`id_ciudad_base`);

--
-- Indexes for table `ciudad_hospedaje`
--
ALTER TABLE `ciudad_hospedaje`
  ADD PRIMARY KEY (`id_ciudad_hospedaje`);

--
-- Indexes for table `ciudad_restaurante`
--
ALTER TABLE `ciudad_restaurante`
  ADD PRIMARY KEY (`id_ciudad_restaurante`);

--
-- Indexes for table `destinos_manejados`
--
ALTER TABLE `destinos_manejados`
  ADD PRIMARY KEY (`id_destino`);

--
-- Indexes for table `estado_proveedores`
--
ALTER TABLE `estado_proveedores`
  ADD PRIMARY KEY (`id_estado_proveedor`);

--
-- Indexes for table `estado_transaccion`
--
ALTER TABLE `estado_transaccion`
  ADD PRIMARY KEY (`id_estado_transaccion`);

--
-- Indexes for table `estado_transaccion_prov`
--
ALTER TABLE `estado_transaccion_prov`
  ADD PRIMARY KEY (`id_estado_transaccion_PROV`);

--
-- Indexes for table `factura_cliente`
--
ALTER TABLE `factura_cliente`
  ADD PRIMARY KEY (`id_factura`),
  ADD KEY `cédula_usuario` (`cédula_usuario`),
  ADD KEY `id_paquete` (`id_paquete`),
  ADD KEY `id_metodoP` (`id_metodoP`),
  ADD KEY `id_estado_transaccion` (`id_estado_transaccion`);

--
-- Indexes for table `metodo_pago`
--
ALTER TABLE `metodo_pago`
  ADD PRIMARY KEY (`id_metodoP`);

--
-- Indexes for table `paquete_turistico`
--
ALTER TABLE `paquete_turistico`
  ADD PRIMARY KEY (`id_paquete`),
  ADD KEY `id_tarifa_aerolinea` (`id_tarifa_aerolinea`),
  ADD KEY `id_tarifa_hospedaje` (`id_tarifa_hospedaje`),
  ADD KEY `id_tarifa_restaurante` (`id_tarifa_restaurante`);

--
-- Indexes for table `proveedores_aerolineas`
--
ALTER TABLE `proveedores_aerolineas`
  ADD PRIMARY KEY (`codigo_aerolinea`),
  ADD KEY `id_estado_proveedor` (`id_estado_proveedor`),
  ADD KEY `id_ciudad_base` (`id_ciudad_base`);

--
-- Indexes for table `proveedores_hospedaje`
--
ALTER TABLE `proveedores_hospedaje`
  ADD PRIMARY KEY (`id_hospedaje`),
  ADD KEY `id_tipo_hospedaje` (`id_tipo_hospedaje`),
  ADD KEY `id_ciudad_hospedaje` (`id_ciudad_hospedaje`),
  ADD KEY `id_estado_proveedor` (`id_estado_proveedor`);

--
-- Indexes for table `proveedores_restaurantes`
--
ALTER TABLE `proveedores_restaurantes`
  ADD PRIMARY KEY (`id_restaurante`),
  ADD KEY `id_ciudad_restaurante` (`id_ciudad_restaurante`),
  ADD KEY `id_estado_proveedor` (`id_estado_proveedor`);

--
-- Indexes for table `registro_egresos`
--
ALTER TABLE `registro_egresos`
  ADD PRIMARY KEY (`id_egreso`),
  ADD KEY `id_factura` (`id_factura`),
  ADD KEY `id_estado_transaccion_PROV` (`id_estado_transaccion_PROV`);

--
-- Indexes for table `tarifa_hospedaje`
--
ALTER TABLE `tarifa_hospedaje`
  ADD PRIMARY KEY (`id_tarifa_hospedaje`),
  ADD KEY `id_hospedaje` (`id_hospedaje`);

--
-- Indexes for table `tarifa_por_destino`
--
ALTER TABLE `tarifa_por_destino`
  ADD PRIMARY KEY (`id_tarifa_aerolinea`),
  ADD KEY `codigo_aerolinea` (`codigo_aerolinea`),
  ADD KEY `id_destino` (`id_destino`);

--
-- Indexes for table `tarifa_restaurante`
--
ALTER TABLE `tarifa_restaurante`
  ADD PRIMARY KEY (`id_tarifa_restaurante`),
  ADD KEY `id_restaurante` (`id_restaurante`);

--
-- Indexes for table `tipo_hospedaje`
--
ALTER TABLE `tipo_hospedaje`
  ADD PRIMARY KEY (`id_tipo_hospedaje`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`cedula_usuario`),
  ADD UNIQUE KEY `correo_usuario` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_2` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_3` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_4` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_5` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_6` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_7` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_8` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_9` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_10` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_11` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_12` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_13` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_14` (`correo_usuario`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ciudad_base`
--
ALTER TABLE `ciudad_base`
  MODIFY `id_ciudad_base` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ciudad_hospedaje`
--
ALTER TABLE `ciudad_hospedaje`
  MODIFY `id_ciudad_hospedaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ciudad_restaurante`
--
ALTER TABLE `ciudad_restaurante`
  MODIFY `id_ciudad_restaurante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `destinos_manejados`
--
ALTER TABLE `destinos_manejados`
  MODIFY `id_destino` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `estado_proveedores`
--
ALTER TABLE `estado_proveedores`
  MODIFY `id_estado_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `estado_transaccion`
--
ALTER TABLE `estado_transaccion`
  MODIFY `id_estado_transaccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `estado_transaccion_prov`
--
ALTER TABLE `estado_transaccion_prov`
  MODIFY `id_estado_transaccion_PROV` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `factura_cliente`
--
ALTER TABLE `factura_cliente`
  MODIFY `id_factura` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `metodo_pago`
--
ALTER TABLE `metodo_pago`
  MODIFY `id_metodoP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `paquete_turistico`
--
ALTER TABLE `paquete_turistico`
  MODIFY `id_paquete` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `proveedores_hospedaje`
--
ALTER TABLE `proveedores_hospedaje`
  MODIFY `id_hospedaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `proveedores_restaurantes`
--
ALTER TABLE `proveedores_restaurantes`
  MODIFY `id_restaurante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `registro_egresos`
--
ALTER TABLE `registro_egresos`
  MODIFY `id_egreso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tarifa_hospedaje`
--
ALTER TABLE `tarifa_hospedaje`
  MODIFY `id_tarifa_hospedaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tarifa_por_destino`
--
ALTER TABLE `tarifa_por_destino`
  MODIFY `id_tarifa_aerolinea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tarifa_restaurante`
--
ALTER TABLE `tarifa_restaurante`
  MODIFY `id_tarifa_restaurante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tipo_hospedaje`
--
ALTER TABLE `tipo_hospedaje`
  MODIFY `id_tipo_hospedaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `factura_cliente`
--
ALTER TABLE `factura_cliente`
  ADD CONSTRAINT `factura_cliente_ibfk_53` FOREIGN KEY (`cédula_usuario`) REFERENCES `usuario` (`cedula_usuario`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `factura_cliente_ibfk_54` FOREIGN KEY (`id_paquete`) REFERENCES `paquete_turistico` (`id_paquete`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `factura_cliente_ibfk_55` FOREIGN KEY (`id_metodoP`) REFERENCES `metodo_pago` (`id_metodoP`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `factura_cliente_ibfk_56` FOREIGN KEY (`id_estado_transaccion`) REFERENCES `estado_transaccion` (`id_estado_transaccion`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `paquete_turistico`
--
ALTER TABLE `paquete_turistico`
  ADD CONSTRAINT `paquete_turistico_ibfk_40` FOREIGN KEY (`id_tarifa_aerolinea`) REFERENCES `tarifa_por_destino` (`id_tarifa_aerolinea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paquete_turistico_ibfk_41` FOREIGN KEY (`id_tarifa_hospedaje`) REFERENCES `tarifa_hospedaje` (`id_tarifa_hospedaje`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paquete_turistico_ibfk_42` FOREIGN KEY (`id_tarifa_restaurante`) REFERENCES `tarifa_restaurante` (`id_tarifa_restaurante`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `proveedores_aerolineas`
--
ALTER TABLE `proveedores_aerolineas`
  ADD CONSTRAINT `proveedores_aerolineas_ibfk_27` FOREIGN KEY (`id_estado_proveedor`) REFERENCES `estado_proveedores` (`id_estado_proveedor`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `proveedores_aerolineas_ibfk_28` FOREIGN KEY (`id_ciudad_base`) REFERENCES `ciudad_base` (`id_ciudad_base`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `proveedores_hospedaje`
--
ALTER TABLE `proveedores_hospedaje`
  ADD CONSTRAINT `proveedores_hospedaje_ibfk_40` FOREIGN KEY (`id_tipo_hospedaje`) REFERENCES `tipo_hospedaje` (`id_tipo_hospedaje`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `proveedores_hospedaje_ibfk_41` FOREIGN KEY (`id_ciudad_hospedaje`) REFERENCES `ciudad_hospedaje` (`id_ciudad_hospedaje`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `proveedores_hospedaje_ibfk_42` FOREIGN KEY (`id_estado_proveedor`) REFERENCES `estado_proveedores` (`id_estado_proveedor`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `proveedores_restaurantes`
--
ALTER TABLE `proveedores_restaurantes`
  ADD CONSTRAINT `proveedores_restaurantes_ibfk_27` FOREIGN KEY (`id_ciudad_restaurante`) REFERENCES `ciudad_restaurante` (`id_ciudad_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `proveedores_restaurantes_ibfk_28` FOREIGN KEY (`id_estado_proveedor`) REFERENCES `estado_proveedores` (`id_estado_proveedor`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `registro_egresos`
--
ALTER TABLE `registro_egresos`
  ADD CONSTRAINT `registro_egresos_ibfk_10` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_12` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_14` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_16` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_18` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_2` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`),
  ADD CONSTRAINT `registro_egresos_ibfk_20` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_22` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_24` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_26` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_27` FOREIGN KEY (`id_factura`) REFERENCES `factura_cliente` (`id_factura`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_28` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_4` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_6` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_8` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `tarifa_hospedaje`
--
ALTER TABLE `tarifa_hospedaje`
  ADD CONSTRAINT `tarifa_hospedaje_ibfk_1` FOREIGN KEY (`id_hospedaje`) REFERENCES `proveedores_hospedaje` (`id_hospedaje`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `tarifa_por_destino`
--
ALTER TABLE `tarifa_por_destino`
  ADD CONSTRAINT `tarifa_por_destino_ibfk_27` FOREIGN KEY (`codigo_aerolinea`) REFERENCES `proveedores_aerolineas` (`codigo_aerolinea`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_por_destino_ibfk_28` FOREIGN KEY (`id_destino`) REFERENCES `destinos_manejados` (`id_destino`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `tarifa_restaurante`
--
ALTER TABLE `tarifa_restaurante`
  ADD CONSTRAINT `tarifa_restaurante_ibfk_1` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`),
  ADD CONSTRAINT `tarifa_restaurante_ibfk_10` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_11` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_12` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_13` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_14` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_2` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_3` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_4` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_5` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_6` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_7` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_8` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_9` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
