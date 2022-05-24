-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.24-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for choho_base
CREATE DATABASE IF NOT EXISTS `choho_base` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `choho_base`;

-- Dumping structure for table choho_base.asesor
CREATE TABLE IF NOT EXISTS `asesor` (
  `id_asesor` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL DEFAULT '0',
  `codigo_asesor` varchar(50) NOT NULL DEFAULT 'sin codigo',
  PRIMARY KEY (`id_asesor`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table choho_base.asesor: ~2 rows (approximately)
INSERT INTO `asesor` (`id_asesor`, `name`, `codigo_asesor`) VALUES
	(3, 'Rocio', 'C001'),
	(4, 'Antony', 'C002'),
	(5, 'Miguel', 'C003');

-- Dumping structure for table choho_base.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL DEFAULT 'sin nombre',
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table choho_base.cliente: ~0 rows (approximately)
INSERT INTO `cliente` (`id_cliente`, `name`) VALUES
	(1, 'The factory'),
	(2, 'Plaza Vea');

-- Dumping structure for table choho_base.detalle_pedido
CREATE TABLE IF NOT EXISTS `detalle_pedido` (
  `id_detalle` int(11) NOT NULL AUTO_INCREMENT,
  `id_pedido` int(11) NOT NULL DEFAULT 0,
  `id_producto` int(11) NOT NULL DEFAULT 0,
  `cantidad` int(11) NOT NULL,
  `valor_unitario` decimal(20,6) NOT NULL DEFAULT 0.000000,
  `total` decimal(20,6) NOT NULL DEFAULT 0.000000,
  PRIMARY KEY (`id_detalle`),
  KEY `FK1_pedido_detalle` (`id_pedido`),
  KEY `FK2_producto_detalle` (`id_producto`),
  CONSTRAINT `FK1_pedido_detalle` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK2_producto_detalle` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table choho_base.detalle_pedido: ~0 rows (approximately)
INSERT INTO `detalle_pedido` (`id_detalle`, `id_pedido`, `id_producto`, `cantidad`, `valor_unitario`, `total`) VALUES
	(2, 3, 2, 20, 18.500000, 370.000000),
	(3, 3, 4, 45, 15.400000, 1130.000000),
	(5, 5, 2, 15, 18.500000, 1500.000000),
	(6, 4, 4, 25, 15.400000, 3000.000000),
	(7, 5, 3, 16, 19.500000, 2000.000000),
	(8, 2, 3, 16, 19.500000, 2000.000000);

-- Dumping structure for table choho_base.pedido
CREATE TABLE IF NOT EXISTS `pedido` (
  `id_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL,
  `id_asesor` int(11) NOT NULL,
  `fecha_pago` datetime NOT NULL DEFAULT curdate(),
  `total_pedido` double NOT NULL,
  `estado` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id_pedido`),
  KEY `FK1_pedido_asesor` (`id_asesor`),
  KEY `FK2_pedido_cliente` (`id_cliente`),
  CONSTRAINT `FK1_pedido_asesor` FOREIGN KEY (`id_asesor`) REFERENCES `asesor` (`id_asesor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK2_pedido_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table choho_base.pedido: ~8 rows (approximately)
INSERT INTO `pedido` (`id_pedido`, `id_cliente`, `id_asesor`, `fecha_pago`, `total_pedido`, `estado`) VALUES
	(2, 2, 5, '2022-05-22 20:08:49', 1500, 'pendiente'),
	(3, 1, 3, '2022-05-22 00:00:00', 2500, 'pagado'),
	(4, 1, 5, '2022-05-22 00:00:00', 3000, 'pendiente'),
	(5, 1, 5, '2022-05-23 12:07:25', 3500, 'pagado'),
	(6, 2, 5, '2022-05-23 14:10:44', 4500, 'pendiente'),
	(7, 2, 3, '2022-05-23 14:15:11', 6500, 'pagado'),
	(9, 2, 3, '2022-05-23 14:15:53', 5.5, 'pendiente'),
	(10, 1, 5, '2022-05-23 16:06:13', 6500, 'pagado');

-- Dumping structure for table choho_base.productos
CREATE TABLE IF NOT EXISTS `productos` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(250) NOT NULL DEFAULT '0',
  `valor_unitario` varchar(250) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_producto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table choho_base.productos: ~2 rows (approximately)
INSERT INTO `productos` (`id_producto`, `tipo`, `valor_unitario`) VALUES
	(2, 'cadenas', '18.5'),
	(3, 'bateria', '19.5'),
	(4, 'lacteos', '15.4');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
