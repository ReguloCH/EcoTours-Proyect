-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-11-2025 a las 21:40:33
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
-- Base de datos: `ecotours_bd`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad_base`
--

CREATE TABLE `ciudad_base` (
  `id_ciudad_base` int(11) NOT NULL,
  `nombre_ciudad_base` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ciudad_base`
--

INSERT INTO `ciudad_base` (`id_ciudad_base`, `nombre_ciudad_base`) VALUES
(1, 'BARQUISIMETO'),
(2, 'VALENCIA'),
(3, 'MARACAIBO'),
(4, 'CARACAS');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad_hospedaje`
--

CREATE TABLE `ciudad_hospedaje` (
  `id_ciudad_hospedaje` int(11) NOT NULL,
  `ciudad_hospedaje` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ciudad_hospedaje`
--

INSERT INTO `ciudad_hospedaje` (`id_ciudad_hospedaje`, `ciudad_hospedaje`) VALUES
(1, 'Caracas'),
(2, 'Porlamar'),
(3, 'Mérida'),
(4, 'Canaima');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ciudad_restaurante`
--

CREATE TABLE `ciudad_restaurante` (
  `id_ciudad_restaurante` int(11) NOT NULL,
  `ciudad_restaurante` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ciudad_restaurante`
--

INSERT INTO `ciudad_restaurante` (`id_ciudad_restaurante`, `ciudad_restaurante`) VALUES
(1, 'Caracas'),
(2, 'Porlamar'),
(3, 'Mérida'),
(4, 'Canaima');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `destinos_manejados`
--

CREATE TABLE `destinos_manejados` (
  `id_destino` int(11) NOT NULL,
  `nombre_destino` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `destinos_manejados`
--

INSERT INTO `destinos_manejados` (`id_destino`, `nombre_destino`) VALUES
(1, 'Los Roques'),
(2, 'Margarita'),
(3, 'El Salto Ángel'),
(4, 'Mérida');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_proveedores`
--

CREATE TABLE `estado_proveedores` (
  `id_estado_proveedor` int(11) NOT NULL,
  `estado_proveedor` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado_proveedores`
--

INSERT INTO `estado_proveedores` (`id_estado_proveedor`, `estado_proveedor`) VALUES
(1, 'Activo'),
(2, 'Inactivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_transaccion`
--

CREATE TABLE `estado_transaccion` (
  `id_estado_transaccion` int(11) NOT NULL,
  `estado_transaccion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado_transaccion`
--

INSERT INTO `estado_transaccion` (`id_estado_transaccion`, `estado_transaccion`) VALUES
(1, 'Pendiente'),
(2, 'Confirmado'),
(3, 'Rechazado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_transaccion_prov`
--

CREATE TABLE `estado_transaccion_prov` (
  `id_estado_transaccion_PROV` int(11) NOT NULL,
  `estado_transaccion_PROV` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado_transaccion_prov`
--

INSERT INTO `estado_transaccion_prov` (`id_estado_transaccion_PROV`, `estado_transaccion_PROV`) VALUES
(1, 'Pendiente'),
(2, 'Pagado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura_cliente`
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
-- Estructura de tabla para la tabla `metodo_pago`
--

CREATE TABLE `metodo_pago` (
  `id_metodoP` int(11) NOT NULL,
  `tipo_metodo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `metodo_pago`
--

INSERT INTO `metodo_pago` (`id_metodoP`, `tipo_metodo`) VALUES
(1, 'Transferencia Bancaria'),
(2, 'Pago Móvil'),
(3, 'Zelle');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paquete_turistico`
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
-- Estructura de tabla para la tabla `proveedores_aerolineas`
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores_hospedaje`
--

CREATE TABLE `proveedores_hospedaje` (
  `id_hospedaje` int(11) NOT NULL,
  `nombre_hospedaje` varchar(150) NOT NULL,
  `id_tipo_hospedaje` int(11) NOT NULL,
  `id_ciudad_hospedaje` int(11) NOT NULL,
  `direccion_hospedaje` varchar(255) DEFAULT NULL,
  `telefono_hospedaje` varchar(20) DEFAULT NULL,
  `correo_hospedaje` varchar(100) DEFAULT NULL,
  `id_estado_proveedor` int(11) NOT NULL,
  `fecha_registro_hospedaje` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores_restaurantes`
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_egresos`
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
-- Estructura de tabla para la tabla `tarifa_hospedaje`
--

CREATE TABLE `tarifa_hospedaje` (
  `id_tarifa_hospedaje` int(11) NOT NULL,
  `id_hospedaje` int(11) NOT NULL,
  `precio_por_dia` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarifa_por_destino`
--

CREATE TABLE `tarifa_por_destino` (
  `id_tarifa_aerolinea` int(11) NOT NULL,
  `codigo_aerolinea` varchar(10) NOT NULL,
  `id_destino` int(11) NOT NULL,
  `precio_vuelos` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarifa_restaurante`
--

CREATE TABLE `tarifa_restaurante` (
  `id_tarifa_restaurante` int(11) NOT NULL,
  `id_restaurante` int(11) NOT NULL,
  `precio_por_dia` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_hospedaje`
--

CREATE TABLE `tipo_hospedaje` (
  `id_tipo_hospedaje` int(11) NOT NULL,
  `tipo_hospedaje` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_hospedaje`
--

INSERT INTO `tipo_hospedaje` (`id_tipo_hospedaje`, `tipo_hospedaje`) VALUES
(1, 'Hotel'),
(2, 'Posada'),
(3, 'Resort'),
(4, 'Cabaña');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `cédula_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `apellido_usuario` varchar(100) NOT NULL,
  `telefono_usuario` varchar(20) DEFAULT NULL,
  `correo_usuario` varchar(100) NOT NULL,
  `contraseña_usuario` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ciudad_base`
--
ALTER TABLE `ciudad_base`
  ADD PRIMARY KEY (`id_ciudad_base`);

--
-- Indices de la tabla `ciudad_hospedaje`
--
ALTER TABLE `ciudad_hospedaje`
  ADD PRIMARY KEY (`id_ciudad_hospedaje`);

--
-- Indices de la tabla `ciudad_restaurante`
--
ALTER TABLE `ciudad_restaurante`
  ADD PRIMARY KEY (`id_ciudad_restaurante`);

--
-- Indices de la tabla `destinos_manejados`
--
ALTER TABLE `destinos_manejados`
  ADD PRIMARY KEY (`id_destino`);

--
-- Indices de la tabla `estado_proveedores`
--
ALTER TABLE `estado_proveedores`
  ADD PRIMARY KEY (`id_estado_proveedor`);

--
-- Indices de la tabla `estado_transaccion`
--
ALTER TABLE `estado_transaccion`
  ADD PRIMARY KEY (`id_estado_transaccion`);

--
-- Indices de la tabla `estado_transaccion_prov`
--
ALTER TABLE `estado_transaccion_prov`
  ADD PRIMARY KEY (`id_estado_transaccion_PROV`);

--
-- Indices de la tabla `factura_cliente`
--
ALTER TABLE `factura_cliente`
  ADD PRIMARY KEY (`id_factura`),
  ADD KEY `cédula_usuario` (`cédula_usuario`),
  ADD KEY `id_paquete` (`id_paquete`),
  ADD KEY `id_metodoP` (`id_metodoP`),
  ADD KEY `id_estado_transaccion` (`id_estado_transaccion`);

--
-- Indices de la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  ADD PRIMARY KEY (`id_metodoP`);

--
-- Indices de la tabla `paquete_turistico`
--
ALTER TABLE `paquete_turistico`
  ADD PRIMARY KEY (`id_paquete`),
  ADD KEY `id_tarifa_aerolinea` (`id_tarifa_aerolinea`),
  ADD KEY `id_tarifa_hospedaje` (`id_tarifa_hospedaje`),
  ADD KEY `id_tarifa_restaurante` (`id_tarifa_restaurante`);

--
-- Indices de la tabla `proveedores_aerolineas`
--
ALTER TABLE `proveedores_aerolineas`
  ADD PRIMARY KEY (`codigo_aerolinea`),
  ADD KEY `id_estado_proveedor` (`id_estado_proveedor`),
  ADD KEY `id_ciudad_base` (`id_ciudad_base`);

--
-- Indices de la tabla `proveedores_hospedaje`
--
ALTER TABLE `proveedores_hospedaje`
  ADD PRIMARY KEY (`id_hospedaje`),
  ADD KEY `id_tipo_hospedaje` (`id_tipo_hospedaje`),
  ADD KEY `id_ciudad_hospedaje` (`id_ciudad_hospedaje`),
  ADD KEY `id_estado_proveedor` (`id_estado_proveedor`);

--
-- Indices de la tabla `proveedores_restaurantes`
--
ALTER TABLE `proveedores_restaurantes`
  ADD PRIMARY KEY (`id_restaurante`),
  ADD KEY `id_ciudad_restaurante` (`id_ciudad_restaurante`),
  ADD KEY `id_estado_proveedor` (`id_estado_proveedor`);

--
-- Indices de la tabla `registro_egresos`
--
ALTER TABLE `registro_egresos`
  ADD PRIMARY KEY (`id_egreso`),
  ADD KEY `id_factura` (`id_factura`),
  ADD KEY `id_estado_transaccion_PROV` (`id_estado_transaccion_PROV`);

--
-- Indices de la tabla `tarifa_hospedaje`
--
ALTER TABLE `tarifa_hospedaje`
  ADD PRIMARY KEY (`id_tarifa_hospedaje`),
  ADD KEY `id_hospedaje` (`id_hospedaje`);

--
-- Indices de la tabla `tarifa_por_destino`
--
ALTER TABLE `tarifa_por_destino`
  ADD PRIMARY KEY (`id_tarifa_aerolinea`),
  ADD KEY `codigo_aerolinea` (`codigo_aerolinea`),
  ADD KEY `id_destino` (`id_destino`);

--
-- Indices de la tabla `tarifa_restaurante`
--
ALTER TABLE `tarifa_restaurante`
  ADD PRIMARY KEY (`id_tarifa_restaurante`),
  ADD KEY `id_restaurante` (`id_restaurante`);

--
-- Indices de la tabla `tipo_hospedaje`
--
ALTER TABLE `tipo_hospedaje`
  ADD PRIMARY KEY (`id_tipo_hospedaje`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`cédula_usuario`),
  ADD UNIQUE KEY `correo_usuario` (`correo_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ciudad_base`
--
ALTER TABLE `ciudad_base`
  MODIFY `id_ciudad_base` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ciudad_hospedaje`
--
ALTER TABLE `ciudad_hospedaje`
  MODIFY `id_ciudad_hospedaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ciudad_restaurante`
--
ALTER TABLE `ciudad_restaurante`
  MODIFY `id_ciudad_restaurante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `destinos_manejados`
--
ALTER TABLE `destinos_manejados`
  MODIFY `id_destino` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `estado_proveedores`
--
ALTER TABLE `estado_proveedores`
  MODIFY `id_estado_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `estado_transaccion`
--
ALTER TABLE `estado_transaccion`
  MODIFY `id_estado_transaccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `estado_transaccion_prov`
--
ALTER TABLE `estado_transaccion_prov`
  MODIFY `id_estado_transaccion_PROV` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `factura_cliente`
--
ALTER TABLE `factura_cliente`
  MODIFY `id_factura` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  MODIFY `id_metodoP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `paquete_turistico`
--
ALTER TABLE `paquete_turistico`
  MODIFY `id_paquete` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedores_hospedaje`
--
ALTER TABLE `proveedores_hospedaje`
  MODIFY `id_hospedaje` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedores_restaurantes`
--
ALTER TABLE `proveedores_restaurantes`
  MODIFY `id_restaurante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registro_egresos`
--
ALTER TABLE `registro_egresos`
  MODIFY `id_egreso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tarifa_hospedaje`
--
ALTER TABLE `tarifa_hospedaje`
  MODIFY `id_tarifa_hospedaje` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tarifa_por_destino`
--
ALTER TABLE `tarifa_por_destino`
  MODIFY `id_tarifa_aerolinea` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tarifa_restaurante`
--
ALTER TABLE `tarifa_restaurante`
  MODIFY `id_tarifa_restaurante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_hospedaje`
--
ALTER TABLE `tipo_hospedaje`
  MODIFY `id_tipo_hospedaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `factura_cliente`
--
ALTER TABLE `factura_cliente`
  ADD CONSTRAINT `factura_cliente_ibfk_1` FOREIGN KEY (`cédula_usuario`) REFERENCES `usuario` (`cédula_usuario`),
  ADD CONSTRAINT `factura_cliente_ibfk_2` FOREIGN KEY (`id_paquete`) REFERENCES `paquete_turistico` (`id_paquete`),
  ADD CONSTRAINT `factura_cliente_ibfk_3` FOREIGN KEY (`id_metodoP`) REFERENCES `metodo_pago` (`id_metodoP`),
  ADD CONSTRAINT `factura_cliente_ibfk_4` FOREIGN KEY (`id_estado_transaccion`) REFERENCES `estado_transaccion` (`id_estado_transaccion`);

--
-- Filtros para la tabla `paquete_turistico`
--
ALTER TABLE `paquete_turistico`
  ADD CONSTRAINT `paquete_turistico_ibfk_1` FOREIGN KEY (`id_tarifa_aerolinea`) REFERENCES `tarifa_por_destino` (`id_tarifa_aerolinea`),
  ADD CONSTRAINT `paquete_turistico_ibfk_2` FOREIGN KEY (`id_tarifa_hospedaje`) REFERENCES `tarifa_hospedaje` (`id_tarifa_hospedaje`),
  ADD CONSTRAINT `paquete_turistico_ibfk_3` FOREIGN KEY (`id_tarifa_restaurante`) REFERENCES `tarifa_restaurante` (`id_tarifa_restaurante`);

--
-- Filtros para la tabla `proveedores_aerolineas`
--
ALTER TABLE `proveedores_aerolineas`
  ADD CONSTRAINT `proveedores_aerolineas_ibfk_1` FOREIGN KEY (`id_estado_proveedor`) REFERENCES `estado_proveedores` (`id_estado_proveedor`),
  ADD CONSTRAINT `proveedores_aerolineas_ibfk_2` FOREIGN KEY (`id_ciudad_base`) REFERENCES `ciudad_base` (`id_ciudad_base`);

--
-- Filtros para la tabla `proveedores_hospedaje`
--
ALTER TABLE `proveedores_hospedaje`
  ADD CONSTRAINT `proveedores_hospedaje_ibfk_1` FOREIGN KEY (`id_tipo_hospedaje`) REFERENCES `tipo_hospedaje` (`id_tipo_hospedaje`),
  ADD CONSTRAINT `proveedores_hospedaje_ibfk_2` FOREIGN KEY (`id_ciudad_hospedaje`) REFERENCES `ciudad_hospedaje` (`id_ciudad_hospedaje`),
  ADD CONSTRAINT `proveedores_hospedaje_ibfk_3` FOREIGN KEY (`id_estado_proveedor`) REFERENCES `estado_proveedores` (`id_estado_proveedor`);

--
-- Filtros para la tabla `proveedores_restaurantes`
--
ALTER TABLE `proveedores_restaurantes`
  ADD CONSTRAINT `proveedores_restaurantes_ibfk_1` FOREIGN KEY (`id_ciudad_restaurante`) REFERENCES `ciudad_restaurante` (`id_ciudad_restaurante`),
  ADD CONSTRAINT `proveedores_restaurantes_ibfk_2` FOREIGN KEY (`id_estado_proveedor`) REFERENCES `estado_proveedores` (`id_estado_proveedor`);

--
-- Filtros para la tabla `registro_egresos`
--
ALTER TABLE `registro_egresos`
  ADD CONSTRAINT `registro_egresos_ibfk_1` FOREIGN KEY (`id_factura`) REFERENCES `factura_cliente` (`id_factura`),
  ADD CONSTRAINT `registro_egresos_ibfk_2` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`);

--
-- Filtros para la tabla `tarifa_hospedaje`
--
ALTER TABLE `tarifa_hospedaje`
  ADD CONSTRAINT `tarifa_hospedaje_ibfk_1` FOREIGN KEY (`id_hospedaje`) REFERENCES `proveedores_hospedaje` (`id_hospedaje`);

--
-- Filtros para la tabla `tarifa_por_destino`
--
ALTER TABLE `tarifa_por_destino`
  ADD CONSTRAINT `tarifa_por_destino_ibfk_1` FOREIGN KEY (`codigo_aerolinea`) REFERENCES `proveedores_aerolineas` (`codigo_aerolinea`),
  ADD CONSTRAINT `tarifa_por_destino_ibfk_2` FOREIGN KEY (`id_destino`) REFERENCES `destinos_manejados` (`id_destino`);

--
-- Filtros para la tabla `tarifa_restaurante`
--
ALTER TABLE `tarifa_restaurante`
  ADD CONSTRAINT `tarifa_restaurante_ibfk_1` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
