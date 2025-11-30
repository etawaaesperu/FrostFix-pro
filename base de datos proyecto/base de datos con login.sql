DROP DATABASE IF EXISTS `FrostFixPro`;
CREATE DATABASE `frostfixpro` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `frostfixpro`;

----------------------------------
-- 1) Tablas Maestras y Usuarios
----------------------------------

CREATE TABLE `Usuarios` (
  `IdUsuario` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `Nombre` VARCHAR(100) NOT NULL,
  `Apellido` VARCHAR(100) NOT NULL,
  `Correo` VARCHAR(150) NOT NULL,
  `Contrasena` VARCHAR(200) NOT NULL,         -- cambié el nombre para evitar ñ en identificadores
  `Rol` ENUM('Administrador','Técnico','Recepcionista') NOT NULL,
  `FechaRegistro` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `Username` VARCHAR(150) DEFAULT NULL,
  UNIQUE KEY `UQ_Usuarios_Correo` (`Correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

----------------------------------
-- Tabla Clientes
----------------------------------
CREATE TABLE `Clientes` (
  `IdCliente` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `Nombre` VARCHAR(100) NOT NULL,
  `Apellido` VARCHAR(100) NOT NULL,
  `Telefono` VARCHAR(15),
  `Direccion` VARCHAR(200),
  `Correo` VARCHAR(150)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

----------------------------------
-- Tabla Repuestos
----------------------------------
CREATE TABLE `Repuestos` (
  `IdRepuesto` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `Nombre` VARCHAR(100) NOT NULL,
  `Descripcion` VARCHAR(200),
  `Precio` DECIMAL(10,2) NOT NULL,
  `Stock` INT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

------------------------------------
-- 2) Tablas Transaccionales
------------------------------------

CREATE TABLE `Equipos` (
  `IdEquipo` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `IdCliente` INT NOT NULL,
  `Tipo` VARCHAR(100) NOT NULL,
  `Marca` VARCHAR(100),
  `Modelo` VARCHAR(100),
  `NumeroSerie` VARCHAR(100),
  `FechaRegistro` DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `FK_Equipos_Clientes` FOREIGN KEY (`IdCliente`) REFERENCES `Clientes`(`IdCliente`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `OrdenesServicio` (
  `IdOrden` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `IdCliente` INT NOT NULL,
  `IdEquipo` INT NOT NULL,
  `IdTecnico` INT NULL,
  `FechaSolicitud` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `FechaAtencion` DATETIME NULL,
  `Estado` ENUM('Pendiente','En Proceso','Completado','Cancelado') DEFAULT 'Pendiente',
  `DescripcionProblema` VARCHAR(300),
  CONSTRAINT `FK_Ordenes_Clientes` FOREIGN KEY (`IdCliente`) REFERENCES `Clientes`(`IdCliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Ordenes_Equipos` FOREIGN KEY (`IdEquipo`) REFERENCES `Equipos`(`IdEquipo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_Ordenes_Tecnico` FOREIGN KEY (`IdTecnico`) REFERENCES `Usuarios`(`IdUsuario`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `Diagnosticos` (
  `IdDiagnostico` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `IdOrden` INT NOT NULL,
  `Diagnostico` VARCHAR(300),
  `SolucionPropuesta` VARCHAR(300),
  `FechaRegistro` DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `FK_Diagnosticos_Ordenes` FOREIGN KEY (`IdOrden`) REFERENCES `OrdenesServicio`(`IdOrden`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `RepuestosUsados` (
  `IdRepuestoUsado` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `IdOrden` INT NOT NULL,
  `IdRepuesto` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  CONSTRAINT `FK_RepuestosUsados_Orden` FOREIGN KEY (`IdOrden`) REFERENCES `OrdenesServicio`(`IdOrden`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RepuestosUsados_Repuesto` FOREIGN KEY (`IdRepuesto`) REFERENCES `Repuestos`(`IdRepuesto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

---------------------------------
-- 3) Insertar datos de ejemplo
---------------------------------

INSERT INTO `Usuarios` (`Nombre`,`Apellido`,`Correo`,`Contrasena`,`Rol`)
VALUES
('Omar','Paredes','omar@soporte.com','12345','Administrador'),
('Luis','Gonzales','luis@soporte.com','12345','Técnico'),
('Ana','Torres','ana@soporte.com','12345','Recepcionista');

INSERT INTO `Clientes` (`Nombre`,`Apellido`,`Telefono`,`Direccion`,`Correo`)
VALUES
('Carlos','Ramírez','987654321','Av. Perú 123','carlos@mail.com'),
('María','Gonzales','999111222','Jr. Lima 456','maria@mail.com');

INSERT INTO `Equipos` (`IdCliente`,`Tipo`,`Marca`,`Modelo`,`NumeroSerie`)
VALUES
(1,'Refrigeradora','LG','CoolMax 450','LGX12345'),
(2,'Congeladora','Samsung','Frost300','SNG67890');

INSERT INTO `OrdenesServicio` (`IdCliente`,`IdEquipo`,`IdTecnico`,`DescripcionProblema`)
VALUES
(1,1,2,'La refrigeradora no enfría correctamente'),
(2,2,2,'Congeladora hace mucho ruido al encender');

INSERT INTO `Diagnosticos` (`IdOrden`,`Diagnostico`,`SolucionPropuesta`)
VALUES
(1,'Compresor con falla eléctrica','Reemplazar el compresor'),
(2,'Ventilador desgastado','Cambiar el motor del ventilador');

INSERT INTO `Repuestos` (`Nombre`,`Descripcion`,`Precio`,`Stock`)
VALUES
('Compresor LGX450','Compresor para refrigeradora LG CoolMax',350.00,5),
('Motor de ventilador','Motor compatible con congeladoras Samsung',120.00,10);

INSERT INTO `RepuestosUsados` (`IdOrden`,`IdRepuesto`,`Cantidad`)
VALUES
(1,1,1),
(2,2,1);

