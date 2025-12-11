-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-12-2025 a las 07:47:08
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

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
(4, 'Canaima'),
(5, 'Margarita');

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
(4, 'Canaima'),
(5, 'Margarita');

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
  `id_paquete` int(11) NOT NULL,
  `id_metodoP` int(11) NOT NULL,
  `fecha_inicio_viaje` date DEFAULT NULL,
  `fecha_fin_viaje` date DEFAULT NULL,
  `monto_pagado` decimal(10,2) NOT NULL,
  `fecha_pago` date NOT NULL,
  `num_referencia` varchar(50) DEFAULT NULL,
  `banco_origen` varchar(100) DEFAULT NULL,
  `comentario_adicional` text DEFAULT NULL,
  `id_estado_transaccion` int(11) NOT NULL,
  `cedula_usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `factura_cliente`
--

INSERT INTO `factura_cliente` (`id_factura`, `id_paquete`, `id_metodoP`, `fecha_inicio_viaje`, `fecha_fin_viaje`, `monto_pagado`, `fecha_pago`, `num_referencia`, `banco_origen`, `comentario_adicional`, `id_estado_transaccion`, `cedula_usuario`) VALUES
(3, 1, 1, '2025-01-12', '2025-01-20', 1200.50, '2025-01-20', '123', 'Banesco', 'Prueba', 1, 28281234),
(4, 1, 3, '2025-02-12', '2025-02-20', 1200.50, '2025-01-20', '456', 'Provincial', 'Prueba', 2, 31930239),
(5, 1, 3, '2025-01-12', '2025-01-20', 1200.50, '2025-01-20', '555', 'Bancamiga', 'Prueba', 2, 30657836),
(9, 1, 1, NULL, NULL, 460.00, '2025-12-10', NULL, NULL, NULL, 1, 30657836),
(10, 1, 2, NULL, NULL, 920.00, '2025-12-10', NULL, NULL, NULL, 2, 30657836),
(11, 1, 1, NULL, NULL, 460.00, '2025-12-10', NULL, NULL, NULL, 2, 31930239),
(12, 1, 1, NULL, NULL, 1840.00, '2025-12-11', NULL, NULL, NULL, 1, 30657836),
(13, 1, 1, NULL, NULL, 3220.00, '2025-12-11', NULL, NULL, NULL, 1, 28281234),
(14, 3, 1, NULL, NULL, 202.80, '2025-12-11', NULL, NULL, NULL, 1, 30657836),
(15, 5, 1, NULL, NULL, 611.52, '2025-12-11', NULL, NULL, NULL, 1, 30657836),
(16, 6, 1, NULL, NULL, 1070.16, '2025-12-11', NULL, NULL, NULL, 1, 28281234),
(17, 7, 1, NULL, NULL, 312.00, '2025-12-11', NULL, NULL, NULL, 1, 15876543),
(18, 8, 1, NULL, NULL, 780.00, '2025-12-11', NULL, NULL, NULL, 1, 30657836),
(19, 9, 1, NULL, NULL, 975.00, '2025-12-11', NULL, NULL, NULL, 1, 28281234),
(20, 10, 2, NULL, NULL, 772.20, '2025-12-11', NULL, NULL, NULL, 1, 31930239),
(21, 11, 1, NULL, NULL, 468.00, '2025-12-11', '111', NULL, NULL, 1, 15876543),
(22, 12, 1, NULL, NULL, 1029.60, '2025-12-11', '333', NULL, NULL, 1, 30657836);

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
-- Estructura de tabla para la tabla `nombre_cuenta`
--

CREATE TABLE `nombre_cuenta` (
  `id_cuenta` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `codigo` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `nombre_cuenta`
--

INSERT INTO `nombre_cuenta` (`id_cuenta`, `nombre`, `tipo`, `codigo`) VALUES
(1, 'Caja', 'Activo', NULL),
(2, 'Banco', 'Activo', NULL),
(3, 'Ventas', 'Ingreso', NULL),
(4, 'Capital Social', 'Capital', NULL),
(5, 'Gastos diversos', 'Egreso', '6.1.30.21'),
(6, 'Efectivo en bancos', 'Activo', '1.1.10.20'),
(7, 'Venta de mercancía', 'Ingreso', '4.1.10.10'),
(8, 'Accionistas', 'Capital', '3.1.10.11'),
(9, 'Bienes y suministros', 'Gasto', '5.4');

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

--
-- Volcado de datos para la tabla `paquete_turistico`
--

INSERT INTO `paquete_turistico` (`id_paquete`, `cantidad_personas`, `destino_paquete`, `duracion_paquete`, `descripcion_paquete`, `subtotal`, `total_con_iva`, `id_tarifa_aerolinea`, `id_tarifa_hospedaje`, `id_tarifa_restaurante`) VALUES
(1, 3, '\"Caracas\"', '\"8 dias\"', 'Prueba', 400.00, 460.00, 2, 1, 1),
(2, 2, '\"Cancún\"', '\"7 dias\"', '\"Paquete completo todo incluido\"', 500.00, 560.00, 2, 1, 1),
(3, 2, 'Los Roques', '3 dias', 'hhhh', 65.00, 202.80, 2, 1, 2),
(4, 3, 'Margarita', '3 dias', 'hhh', 125.00, 585.00, 2, 2, 3),
(5, 4, 'El Salto Ángel', '3 dias', 'hhh', 98.00, 611.52, 2, 11, 1),
(6, 7, 'Los Roques', '3 dias', 'hh', 98.00, 1070.16, 2, 13, 1),
(7, 2, 'Mérida', '3 dias', 'hh', 100.00, 312.00, 2, 5, 2),
(8, 5, 'El Salto Ángel', '3 dias', 'kkkkkk', 100.00, 780.00, 2, 2, 2),
(9, 5, 'Los Roques', '3 dias', 'gg', 125.00, 975.00, 2, 6, 3),
(10, 3, 'Los Roques', '3 dias', 'jj', 165.00, 772.20, 2, 12, 3),
(11, 3, 'Margarita', '3 dias', 'ff', 100.00, 468.00, 2, 2, 2),
(12, 3, 'Los Roques', '3 dias', 'fff', 220.00, 1029.60, 2, 11, 2);

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

--
-- Volcado de datos para la tabla `proveedores_aerolineas`
--

INSERT INTO `proveedores_aerolineas` (`codigo_aerolinea`, `nombre_aerolinea`, `correo_aerolinea`, `telefono_aerolinea`, `id_estado_proveedor`, `fecha_registro_aerolinea`, `id_ciudad_base`) VALUES
('AA01', 'AeroAndes', 'contacto@aeroandes.com', '04141234567', 1, '2025-11-08', 1),
('AA03', 'Fly', 'contacto@fly.com', '04146662552', 1, '2025-07-08', 3);

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
  `id_estado_proveedor` int(11) NOT NULL,
  `fecha_registro_hospedaje` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores_hospedaje`
--

INSERT INTO `proveedores_hospedaje` (`id_hospedaje`, `nombre_hospedaje`, `id_tipo_hospedaje`, `id_ciudad_hospedaje`, `direccion_hospedaje`, `id_estado_proveedor`, `fecha_registro_hospedaje`) VALUES
(1, 'Waka Wená', 1, 4, 'Parque Nacional Canaima, Laguna de Canaima, Canaima 8001, Bolivar', 1, '2024-10-06'),
(2, 'El arroyo', 1, 1, 'Av. Lecuna, Caracas 1014, Distrito Capital', 1, '2022-01-12'),
(3, 'Hotel Plaza', 1, 3, 'Av. 5 entre calles 23 y 24, Mérida 5101, Mérida', 2, '2022-03-25'),
(4, 'Queseyo', 1, 4, 'Una Direccion ', 2, '2022-03-25'),
(5, 'Hotel Paradise', 5, 5, 'Playa El Agua', 1, NULL);

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

--
-- Volcado de datos para la tabla `proveedores_restaurantes`
--

INSERT INTO `proveedores_restaurantes` (`id_restaurante`, `nombre_restaurante`, `horario_servicio`, `incluye_bebidas`, `id_ciudad_restaurante`, `direccion_restaurante`, `telefono_restaurante`, `correo_restaurante`, `id_estado_proveedor`, `fecha_registro_restaurante`) VALUES
(1, 'Arepa Planet', '08:00 - 22:00', 1, 4, 'Parque Nacional Canaima, Laguna de Canaima, Canaima 8001, Bolivar', '04141234567', 'contacto@arepaplanet.com', 1, '2025-11-08'),
(2, 'cacao', '10:00 - 20:00', 1, 2, 'Av. Porlamar, entre calles 1 y 2', '04141234567', 'contacto@cacao.com', 1, '2025-11-08'),
(3, 'cacao', '10:00 - 20:00', 1, 2, 'Av. Porlamar, entre calles 1 y 2', '04141234567', 'contacto@cacao.com', 1, '2025-11-08'),
(4, 'cacao', '10:00 - 20:00', 1, 2, 'Av. Porlamar, entre calles 1 y 2', '04141234567', 'contacto@cacao.com', 1, '2025-11-08'),
(5, 'cacao', '10:00 - 20:00', 1, 2, 'Av. Porlamar, entre calles 1 y 2', '04141234567', 'contacto@cacao.com', 1, '2025-11-08'),
(6, 'El Sabor Tropical', '12pm - 10pm', 1, 5, 'Centro Comercial La Vela', NULL, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_contable`
--

CREATE TABLE `registro_contable` (
  `id_registro` int(11) NOT NULL,
  `id_factura` int(11) DEFAULT NULL,
  `id_cuenta` int(11) NOT NULL,
  `id_tipo_mov` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `fecha_mov` date NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro_contable`
--

INSERT INTO `registro_contable` (`id_registro`, `id_factura`, `id_cuenta`, `id_tipo_mov`, `monto`, `fecha_mov`, `descripcion`) VALUES
(1, 3, 6, 3, 1200.50, '2025-01-12', 'Ingreso por Factura #3 (Importado)'),
(2, 4, 6, 3, 1200.50, '2025-02-12', 'Ingreso por Factura #4 (Importado)'),
(3, 5, 6, 3, 1200.50, '2025-01-12', 'Ingreso por Factura #5 (Importado)'),
(4, NULL, 6, 4, 1200.50, '2025-12-10', 'Egreso #1: GeneradoHistorial'),
(5, NULL, 6, 4, 1200.50, '2025-12-10', 'Egreso #2: GeneradoHistorial'),
(6, 3, 7, 3, 1200.50, '2025-01-12', 'Venta de Paquete Factura #3'),
(7, 4, 7, 3, 1200.50, '2025-02-12', 'Venta de Paquete Factura #4'),
(8, 5, 7, 3, 1200.50, '2025-01-12', 'Venta de Paquete Factura #5'),
(9, 9, 6, 3, 460.00, '2025-12-10', 'Ingreso a Caja por Factura #9'),
(10, 9, 7, 3, 460.00, '2025-12-10', 'Venta de Paquete Factura #9'),
(11, 10, 6, 3, 920.00, '2025-12-10', 'Ingreso a Caja por Factura #10'),
(12, 10, 7, 3, 920.00, '2025-12-10', 'Venta de Paquete Factura #10'),
(13, 11, 6, 3, 460.00, '2025-12-10', 'Ingreso a Caja por Factura #11'),
(14, 11, 7, 3, 460.00, '2025-12-10', 'Venta de Paquete Factura #11'),
(15, 11, 6, 2, 55.00, '2025-12-11', 'Pago Proveedor Aerolinea (Ref: 5)'),
(16, 11, 9, 1, 55.00, '2025-12-11', 'Pago Proveedor Aerolinea (Ref: 5)'),
(17, 12, 6, 3, 1840.00, '2025-12-11', 'Ingreso a Caja por Factura #12'),
(18, 12, 7, 3, 1840.00, '2025-12-11', 'Venta de Paquete Factura #12'),
(19, 12, 6, 2, 600.00, '2025-12-11', 'Pago Proveedor Aerolinea (Ref: 2)'),
(20, 12, 9, 1, 600.00, '2025-12-11', 'Pago Proveedor Aerolinea (Ref: 2)'),
(21, 12, 6, 2, 360.00, '2025-12-11', 'Pago Proveedor Hotel (Ref: 2)'),
(22, 12, 9, 1, 360.00, '2025-12-11', 'Pago Proveedor Hotel (Ref: 2)'),
(23, 12, 6, 2, 250.00, '2025-12-11', 'Pago Proveedor Restaurante (Ref: 2)'),
(24, 12, 9, 1, 250.00, '2025-12-11', 'Pago Proveedor Restaurante (Ref: 2)'),
(25, 13, 6, 3, 3220.00, '2025-12-11', 'Ingreso a Caja por Factura #13'),
(26, 13, 7, 3, 3220.00, '2025-12-11', 'Venta de Paquete Factura #13'),
(27, 13, 6, 2, 70.00, '2025-12-11', 'Pago Proveedor Aerolinea (Ref: 4)'),
(28, 13, 9, 1, 70.00, '2025-12-11', 'Pago Proveedor Aerolinea (Ref: 4)'),
(29, 13, 6, 2, 50.00, '2025-12-11', 'Pago Proveedor Hotel (Ref: 4)'),
(30, 13, 9, 1, 50.00, '2025-12-11', 'Pago Proveedor Hotel (Ref: 4)'),
(31, 13, 6, 2, 30.00, '2025-12-11', 'Pago Proveedor Restaurante (Ref: 4)'),
(32, 13, 9, 1, 30.00, '2025-12-11', 'Pago Proveedor Restaurante (Ref: 4)'),
(33, 14, 6, 3, 202.80, '2025-12-11', 'Ingreso a Caja por Factura #14'),
(34, 14, 7, 2, 202.80, '2025-12-11', 'Venta de Paquete Factura #14'),
(35, 15, 6, 3, 611.52, '2025-12-11', 'Ingreso a Caja por Factura #15'),
(36, 15, 7, 2, 611.52, '2025-12-11', 'Venta de Paquete Factura #15'),
(37, 16, 6, 3, 1070.16, '2025-12-11', 'Ingreso a Caja por Factura #16'),
(38, 16, 7, 2, 1070.16, '2025-12-11', 'Venta de Paquete Factura #16'),
(39, 17, 6, 3, 312.00, '2025-12-11', 'Ingreso a Caja por Factura #17'),
(40, 17, 7, 2, 312.00, '2025-12-11', 'Venta de Paquete Factura #17'),
(41, 18, 6, 3, 780.00, '2025-12-11', 'Ingreso a Caja por Factura #18'),
(42, 18, 7, 2, 780.00, '2025-12-11', 'Venta de Paquete Factura #18'),
(43, 18, 6, 2, 0.00, '2025-12-11', 'Pago Proveedor Aerolinea (Ref: )'),
(44, 18, 9, 1, 0.00, '2025-12-11', 'Pago Proveedor Aerolinea (Ref: )'),
(45, 19, 6, 3, 975.00, '2025-12-11', 'Ingreso a Caja por Factura #19'),
(46, 19, 7, 2, 975.00, '2025-12-11', 'Venta de Paquete Factura #19'),
(47, 20, 6, 3, 772.20, '2025-12-11', 'Ingreso a Caja por Factura #20'),
(48, 20, 7, 2, 772.20, '2025-12-11', 'Venta de Paquete Factura #20'),
(49, 21, 6, 3, 468.00, '2025-12-11', 'Ingreso a Caja por Factura #21'),
(50, 21, 7, 2, 468.00, '2025-12-11', 'Venta de Paquete Factura #21'),
(51, 22, 6, 3, 1029.60, '2025-12-11', 'Ingreso a Caja por Factura #22'),
(52, 22, 7, 2, 1029.60, '2025-12-11', 'Venta de Paquete Factura #22'),
(53, 22, 6, 2, 360.00, '2025-12-11', 'Pago Proveedor Aerolinea (Ref: 333)'),
(54, 22, 9, 1, 360.00, '2025-12-11', 'Pago Proveedor Aerolinea (Ref: 333)'),
(55, 22, 6, 2, 240.00, '2025-12-11', 'Pago Proveedor Hotel (Ref: 333)'),
(56, 22, 9, 1, 240.00, '2025-12-11', 'Pago Proveedor Hotel (Ref: 333)'),
(57, 22, 6, 2, 60.00, '2025-12-11', 'Pago Proveedor Restaurante (Ref: 333)'),
(58, 22, 9, 1, 60.00, '2025-12-11', 'Pago Proveedor Restaurante (Ref: 333)');

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

--
-- Volcado de datos para la tabla `registro_egresos`
--

INSERT INTO `registro_egresos` (`id_egreso`, `id_factura`, `tipo_PROV`, `proveedor_id_fk`, `monto_A_pagar`, `fecha_generacion`, `fecha_pago_real`, `numReferenciaPago`, `id_estado_transaccion_PROV`) VALUES
(1, 4, 'GeneradoHistorial', '0', 1200.50, '2025-12-10', '2025-12-15', '777', 1),
(2, 3, 'GeneradoHistorial', '0', 1200.50, '2025-12-10', '2025-12-16', '888', 1),
(3, 10, 'GeneradoHistorial', '0', 920.00, '2025-12-10', '2025-12-10', '887', 1),
(4, 11, 'GeneradoHistorial', '0', 460.00, '2025-12-10', '2025-12-10', '001', 1),
(16, 11, 'Aerolinea', '0', 55.00, '2025-12-11', '2025-12-11', '5', 2),
(17, 11, 'Hotel', '0', 0.00, '2025-12-11', '2025-12-11', '', 1),
(18, 11, 'Restaurante', '0', 0.00, '2025-12-11', '2025-12-11', '', 1),
(19, 12, 'Aerolinea', '0', 0.00, '2025-12-11', '2025-12-11', '2', 2),
(20, 12, 'Hotel', '0', 360.00, '2025-12-11', '2025-12-11', '2', 2),
(21, 12, 'Restaurante', '0', 250.00, '2025-12-11', '2025-12-11', '2', 2),
(22, 13, 'Aerolinea', '0', 70.00, '2025-12-11', '2025-12-11', '4', 2),
(23, 13, 'Hotel', '0', 50.00, '2025-12-11', '2025-12-11', '4', 2),
(24, 13, 'Restaurante', '0', 30.00, '2025-12-11', '2025-12-11', '4', 2),
(25, 14, 'Aerolinea', '0', 0.00, '2025-12-11', '2025-12-11', '', 1),
(26, 14, 'Hotel', '0', 0.00, '2025-12-11', '2025-12-11', '', 1),
(27, 14, 'Restaurante', '0', 0.00, '2025-12-11', '2025-12-11', '', 1),
(28, 16, 'Aerolinea', '0', 0.00, '2025-12-11', '2025-12-11', '', 1),
(29, 16, 'Hotel', '0', 0.00, '2025-12-11', '2025-12-11', '', 1),
(30, 16, 'Restaurante', '0', 0.00, '2025-12-11', '2025-12-11', '', 1),
(31, 18, 'Aerolinea', '0', 0.00, '2025-12-11', '2025-12-11', '', 2),
(32, 18, 'Hotel', '0', 0.00, '2025-12-11', '2025-12-11', '', 1),
(33, 18, 'Restaurante', '0', 0.00, '2025-12-11', '2025-12-11', '', 1),
(34, 21, 'Hotel', '0', 240.00, '2025-12-11', '2025-12-11', '111', 1),
(35, 21, 'Restaurante', '0', 60.00, '2025-12-11', '2025-12-11', '111', 1),
(36, 21, 'Aerolinea', '0', 0.00, '2025-12-11', '2025-12-11', '111', 1),
(37, 22, 'Aerolinea', '0', 360.00, '2025-12-11', '2025-12-11', '333', 2),
(38, 22, 'Hotel', '0', 240.00, '2025-12-11', '2025-12-11', '333', 2),
(39, 22, 'Restaurante', '0', 60.00, '2025-12-11', '2025-12-11', '333', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarifa_hospedaje`
--

CREATE TABLE `tarifa_hospedaje` (
  `id_tarifa_hospedaje` int(11) NOT NULL,
  `id_hospedaje` int(11) NOT NULL,
  `precio_por_dia` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tarifa_hospedaje`
--

INSERT INTO `tarifa_hospedaje` (`id_tarifa_hospedaje`, `id_hospedaje`, `precio_por_dia`) VALUES
(1, 1, 45.00),
(2, 3, 80.00),
(4, 3, 80.00),
(5, 3, 80.00),
(6, 3, 80.00),
(7, 3, 80.00),
(8, 3, 80.00),
(9, 3, 80.00),
(10, 3, 80.00),
(11, 3, 80.00),
(12, 5, 120.00),
(13, 5, 80.00);

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

--
-- Volcado de datos para la tabla `tarifa_por_destino`
--

INSERT INTO `tarifa_por_destino` (`id_tarifa_aerolinea`, `codigo_aerolinea`, `id_destino`, `precio_vuelos`) VALUES
(2, 'AA01', 2, 120.00),
(3, 'AA03', 1, 85.00),
(4, 'AA03', 1, 85.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarifa_restaurante`
--

CREATE TABLE `tarifa_restaurante` (
  `id_tarifa_restaurante` int(11) NOT NULL,
  `id_restaurante` int(11) NOT NULL,
  `precio_por_dia` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tarifa_restaurante`
--

INSERT INTO `tarifa_restaurante` (`id_tarifa_restaurante`, `id_restaurante`, `precio_por_dia`) VALUES
(1, 2, 18.00),
(2, 3, 20.00),
(3, 6, 45.00),
(4, 6, 25.00);

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
(4, 'Cabaña'),
(5, 'Hotel 5 Estrellas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_movimiento`
--

CREATE TABLE `tipo_movimiento` (
  `id_tipo_mov` int(11) NOT NULL,
  `tipo` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_movimiento`
--

INSERT INTO `tipo_movimiento` (`id_tipo_mov`, `tipo`) VALUES
(1, 'Debe'),
(2, 'Haber'),
(3, 'Ingreso'),
(4, 'Egreso');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `cedula_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `telefono_usuario` varchar(20) DEFAULT NULL,
  `correo_usuario` varchar(100) NOT NULL,
  `contraseña_usuario` varchar(255) NOT NULL,
  `direccion_usuario` varchar(100) DEFAULT NULL,
  `user_usuario` varchar(50) NOT NULL,
  `admin_usuario` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`cedula_usuario`, `nombre_usuario`, `telefono_usuario`, `correo_usuario`, `contraseña_usuario`, `direccion_usuario`, `user_usuario`, `admin_usuario`) VALUES
(15876543, 'Juan Pérez', '04121234567', 'juan.perez@email.com', '123456', 'Caracas, Venezuela', 'juanperez', 0),
(28281234, 'José Daniel', '04245793109', 'dalto@gmail.com', '$2b$10$pEqxCgDkGLQNs1kk7OszZeFqtbqOqEY5rahsf5RUSligKcSCg1inK', NULL, '', NULL),
(30657836, 'Regulo', '04245154013', 'regu123', '123', NULL, '', 0),
(31930239, 'Sarath', '04145589714', 'sarath@gmail.com', 'cama123$', NULL, '', NULL);

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
  ADD KEY `id_paquete` (`id_paquete`),
  ADD KEY `id_metodoP` (`id_metodoP`),
  ADD KEY `id_estado_transaccion` (`id_estado_transaccion`),
  ADD KEY `cedula_usuario` (`cedula_usuario`);

--
-- Indices de la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  ADD PRIMARY KEY (`id_metodoP`);

--
-- Indices de la tabla `nombre_cuenta`
--
ALTER TABLE `nombre_cuenta`
  ADD PRIMARY KEY (`id_cuenta`);

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
-- Indices de la tabla `registro_contable`
--
ALTER TABLE `registro_contable`
  ADD PRIMARY KEY (`id_registro`),
  ADD KEY `id_factura` (`id_factura`),
  ADD KEY `id_cuenta` (`id_cuenta`),
  ADD KEY `id_tipo_mov` (`id_tipo_mov`);

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
-- Indices de la tabla `tipo_movimiento`
--
ALTER TABLE `tipo_movimiento`
  ADD PRIMARY KEY (`id_tipo_mov`);

--
-- Indices de la tabla `usuario`
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
  ADD UNIQUE KEY `correo_usuario_14` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_15` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_16` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_17` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_18` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_19` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_20` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_21` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_22` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_23` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_24` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_25` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_26` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_27` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_28` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_29` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_30` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_31` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_32` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_33` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_34` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_35` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_36` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_37` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_38` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_39` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_40` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_41` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_42` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_43` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_44` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_45` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_46` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_47` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_48` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_49` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_50` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_51` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_52` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_53` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_54` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_55` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_56` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_57` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_58` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_59` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_60` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_61` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_62` (`correo_usuario`),
  ADD UNIQUE KEY `correo_usuario_63` (`correo_usuario`);

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
  MODIFY `id_ciudad_hospedaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `ciudad_restaurante`
--
ALTER TABLE `ciudad_restaurante`
  MODIFY `id_ciudad_restaurante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
  MODIFY `id_factura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `metodo_pago`
--
ALTER TABLE `metodo_pago`
  MODIFY `id_metodoP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `nombre_cuenta`
--
ALTER TABLE `nombre_cuenta`
  MODIFY `id_cuenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `paquete_turistico`
--
ALTER TABLE `paquete_turistico`
  MODIFY `id_paquete` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `proveedores_hospedaje`
--
ALTER TABLE `proveedores_hospedaje`
  MODIFY `id_hospedaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `proveedores_restaurantes`
--
ALTER TABLE `proveedores_restaurantes`
  MODIFY `id_restaurante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `registro_contable`
--
ALTER TABLE `registro_contable`
  MODIFY `id_registro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT de la tabla `registro_egresos`
--
ALTER TABLE `registro_egresos`
  MODIFY `id_egreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `tarifa_hospedaje`
--
ALTER TABLE `tarifa_hospedaje`
  MODIFY `id_tarifa_hospedaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `tarifa_por_destino`
--
ALTER TABLE `tarifa_por_destino`
  MODIFY `id_tarifa_aerolinea` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tarifa_restaurante`
--
ALTER TABLE `tarifa_restaurante`
  MODIFY `id_tarifa_restaurante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_hospedaje`
--
ALTER TABLE `tipo_hospedaje`
  MODIFY `id_tipo_hospedaje` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tipo_movimiento`
--
ALTER TABLE `tipo_movimiento`
  MODIFY `id_tipo_mov` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `factura_cliente`
--
ALTER TABLE `factura_cliente`
  ADD CONSTRAINT `factura_cliente_ibfk_137` FOREIGN KEY (`id_paquete`) REFERENCES `paquete_turistico` (`id_paquete`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `factura_cliente_ibfk_138` FOREIGN KEY (`id_metodoP`) REFERENCES `metodo_pago` (`id_metodoP`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `factura_cliente_ibfk_139` FOREIGN KEY (`id_estado_transaccion`) REFERENCES `estado_transaccion` (`id_estado_transaccion`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `factura_cliente_ibfk_140` FOREIGN KEY (`cedula_usuario`) REFERENCES `usuario` (`cedula_usuario`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `paquete_turistico`
--
ALTER TABLE `paquete_turistico`
  ADD CONSTRAINT `paquete_turistico_ibfk_187` FOREIGN KEY (`id_tarifa_aerolinea`) REFERENCES `tarifa_por_destino` (`id_tarifa_aerolinea`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paquete_turistico_ibfk_188` FOREIGN KEY (`id_tarifa_hospedaje`) REFERENCES `tarifa_hospedaje` (`id_tarifa_hospedaje`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `paquete_turistico_ibfk_189` FOREIGN KEY (`id_tarifa_restaurante`) REFERENCES `tarifa_restaurante` (`id_tarifa_restaurante`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `proveedores_aerolineas`
--
ALTER TABLE `proveedores_aerolineas`
  ADD CONSTRAINT `proveedores_aerolineas_ibfk_125` FOREIGN KEY (`id_estado_proveedor`) REFERENCES `estado_proveedores` (`id_estado_proveedor`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `proveedores_aerolineas_ibfk_126` FOREIGN KEY (`id_ciudad_base`) REFERENCES `ciudad_base` (`id_ciudad_base`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `proveedores_hospedaje`
--
ALTER TABLE `proveedores_hospedaje`
  ADD CONSTRAINT `proveedores_hospedaje_ibfk_187` FOREIGN KEY (`id_tipo_hospedaje`) REFERENCES `tipo_hospedaje` (`id_tipo_hospedaje`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `proveedores_hospedaje_ibfk_188` FOREIGN KEY (`id_ciudad_hospedaje`) REFERENCES `ciudad_hospedaje` (`id_ciudad_hospedaje`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `proveedores_hospedaje_ibfk_189` FOREIGN KEY (`id_estado_proveedor`) REFERENCES `estado_proveedores` (`id_estado_proveedor`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `proveedores_restaurantes`
--
ALTER TABLE `proveedores_restaurantes`
  ADD CONSTRAINT `proveedores_restaurantes_ibfk_125` FOREIGN KEY (`id_ciudad_restaurante`) REFERENCES `ciudad_restaurante` (`id_ciudad_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `proveedores_restaurantes_ibfk_126` FOREIGN KEY (`id_estado_proveedor`) REFERENCES `estado_proveedores` (`id_estado_proveedor`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `registro_contable`
--
ALTER TABLE `registro_contable`
  ADD CONSTRAINT `registro_contable_ibfk_44` FOREIGN KEY (`id_cuenta`) REFERENCES `nombre_cuenta` (`id_cuenta`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_contable_ibfk_45` FOREIGN KEY (`id_tipo_mov`) REFERENCES `tipo_movimiento` (`id_tipo_mov`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `registro_egresos`
--
ALTER TABLE `registro_egresos`
  ADD CONSTRAINT `registro_egresos_ibfk_10` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_100` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_102` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_104` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_106` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_108` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_109` FOREIGN KEY (`id_factura`) REFERENCES `factura_cliente` (`id_factura`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_110` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_12` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_14` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_16` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_18` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_2` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`),
  ADD CONSTRAINT `registro_egresos_ibfk_20` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_22` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_24` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_26` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_28` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_30` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_32` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_34` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_36` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_38` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_4` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_40` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_42` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_44` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_46` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_48` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_50` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_52` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_54` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_56` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_58` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_6` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_60` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_62` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_64` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_66` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_68` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_70` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_72` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_74` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_76` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_78` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_8` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_80` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_82` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_84` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_86` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_88` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_90` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_92` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_94` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_96` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `registro_egresos_ibfk_98` FOREIGN KEY (`id_estado_transaccion_PROV`) REFERENCES `estado_transaccion_prov` (`id_estado_transaccion_PROV`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `tarifa_hospedaje`
--
ALTER TABLE `tarifa_hospedaje`
  ADD CONSTRAINT `tarifa_hospedaje_ibfk_1` FOREIGN KEY (`id_hospedaje`) REFERENCES `proveedores_hospedaje` (`id_hospedaje`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `tarifa_por_destino`
--
ALTER TABLE `tarifa_por_destino`
  ADD CONSTRAINT `tarifa_por_destino_ibfk_125` FOREIGN KEY (`codigo_aerolinea`) REFERENCES `proveedores_aerolineas` (`codigo_aerolinea`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_por_destino_ibfk_126` FOREIGN KEY (`id_destino`) REFERENCES `destinos_manejados` (`id_destino`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `tarifa_restaurante`
--
ALTER TABLE `tarifa_restaurante`
  ADD CONSTRAINT `tarifa_restaurante_ibfk_1` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`),
  ADD CONSTRAINT `tarifa_restaurante_ibfk_10` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_11` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_12` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_13` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_14` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_15` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_16` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_17` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_18` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_19` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_2` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_20` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_21` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_22` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_23` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_24` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_25` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_26` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_27` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_28` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_29` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_3` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_30` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_31` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_32` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_33` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_34` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_35` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_36` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_37` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_38` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_39` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_4` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_40` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_41` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_42` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_43` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_44` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_45` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_46` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_47` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_48` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_49` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_5` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_50` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_51` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_52` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_53` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_54` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_55` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_56` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_57` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_58` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_59` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_6` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_60` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_61` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_62` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_63` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_7` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_8` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `tarifa_restaurante_ibfk_9` FOREIGN KEY (`id_restaurante`) REFERENCES `proveedores_restaurantes` (`id_restaurante`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
