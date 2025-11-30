-- FrostFixPro FULL CRUD SQL SCRIPT
USE frostfixpro;

-- USUARIOS CRUD
DELIMITER $$
CREATE PROCEDURE sp_UsuarioCrear(
    IN p_Nombre VARCHAR(100),
    IN p_Apellido VARCHAR(100),
    IN p_Correo VARCHAR(150),
    IN p_Contrasena VARCHAR(200),
    IN p_Rol VARCHAR(50),
    IN p_Username VARCHAR(150)
)
BEGIN
    INSERT INTO Usuarios (Nombre, Apellido, Correo, Contrasena, Rol, Username)
    VALUES (p_Nombre, p_Apellido, p_Correo, p_Contrasena, p_Rol, p_Username);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_UsuarioListar()
BEGIN
    SELECT * FROM Usuarios;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_UsuarioPorID(IN p_Id INT)
BEGIN
    SELECT * FROM Usuarios WHERE IdUsuario = p_Id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_UsuarioActualizar(
    IN p_Id INT,
    IN p_Nombre VARCHAR(100),
    IN p_Apellido VARCHAR(100),
    IN p_Correo VARCHAR(150),
    IN p_Rol VARCHAR(50),
    IN p_Username VARCHAR(150)
)
BEGIN
    UPDATE Usuarios
    SET Nombre = p_Nombre,
        Apellido = p_Apellido,
        Correo = p_Correo,
        Rol = p_Rol,
        Username = p_Username
    WHERE IdUsuario = p_Id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_UsuarioEliminar(IN p_Id INT)
BEGIN
    DELETE FROM Usuarios WHERE IdUsuario = p_Id;
END$$
DELIMITER ;

-- CLIENTES CRUD
DELIMITER $$
CREATE PROCEDURE sp_ClienteCrear(
    IN p_Nombre VARCHAR(100),
    IN p_Apellido VARCHAR(100),
    IN p_Telefono VARCHAR(15),
    IN p_Direccion VARCHAR(200),
    IN p_Correo VARCHAR(150)
)
BEGIN
    INSERT INTO Clientes (Nombre, Apellido, Telefono, Direccion, Correo)
    VALUES (p_Nombre, p_Apellido, p_Telefono, p_Direccion, p_Correo);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_ClienteListar()
BEGIN
    SELECT * FROM Clientes;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_ClientePorID(IN p_Id INT)
BEGIN
    SELECT * FROM Clientes WHERE IdCliente = p_Id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_ClienteActualizar(
    IN p_Id INT,
    IN p_Nombre VARCHAR(100),
    IN p_Apellido VARCHAR(100),
    IN p_Telefono VARCHAR(15),
    IN p_Direccion VARCHAR(200),
    IN p_Correo VARCHAR(150)
)
BEGIN
    UPDATE Clientes
    SET Nombre = p_Nombre,
        Apellido = p_Apellido,
        Telefono = p_Telefono,
        Direccion = p_Direccion,
        Correo = p_Correo
    WHERE IdCliente = p_Id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_ClienteEliminar(IN p_Id INT)
BEGIN
    DELETE FROM Clientes WHERE IdCliente = p_Id;
END$$
DELIMITER ;

-- EQUIPOS CRUD
DELIMITER $$
CREATE PROCEDURE sp_EquipoCrear(
    IN p_IdCliente INT,
    IN p_Tipo VARCHAR(100),
    IN p_Marca VARCHAR(100),
    IN p_Modelo VARCHAR(100),
    IN p_NumeroSerie VARCHAR(100)
)
BEGIN
    INSERT INTO Equipos (IdCliente, Tipo, Marca, Modelo, NumeroSerie)
    VALUES (p_IdCliente, p_Tipo, p_Marca, p_Modelo, p_NumeroSerie);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_EquipoListar()
BEGIN
    SELECT * FROM Equipos;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_EquipoPorID(IN p_Id INT)
BEGIN
    SELECT * FROM Equipos WHERE IdEquipo = p_Id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_EquipoActualizar(
    IN p_Id INT,
    IN p_Tipo VARCHAR(100),
    IN p_Marca VARCHAR(100),
    IN p_Modelo VARCHAR(100),
    IN p_NumeroSerie VARCHAR(100)
)
BEGIN
    UPDATE Equipos
    SET Tipo = p_Tipo,
        Marca = p_Marca,
        Modelo = p_Modelo,
        NumeroSerie = p_NumeroSerie
    WHERE IdEquipo = p_Id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_EquipoEliminar(IN p_Id INT)
BEGIN
    DELETE FROM Equipos WHERE IdEquipo = p_Id;
END$$
DELIMITER ;

-- ORDENES CRUD
DELIMITER $$
CREATE PROCEDURE sp_OrdenCrear(
    IN p_IdCliente INT,
    IN p_IdEquipo INT,
    IN p_IdTecnico INT,
    IN p_Descripcion VARCHAR(300)
)
BEGIN
    INSERT INTO OrdenesServicio (IdCliente, IdEquipo, IdTecnico, DescripcionProblema)
    VALUES (p_IdCliente, p_IdEquipo, p_IdTecnico, p_Descripcion);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_OrdenListar()
BEGIN
    SELECT * FROM OrdenesServicio;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_OrdenPorID(IN p_Id INT)
BEGIN
    SELECT * FROM OrdenesServicio WHERE IdOrden = p_Id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_OrdenActualizar(
    IN p_Id INT,
    IN p_Estado VARCHAR(20),
    IN p_FechaAtencion DATETIME
)
BEGIN
    UPDATE OrdenesServicio
    SET Estado = p_Estado,
        FechaAtencion = p_FechaAtencion
    WHERE IdOrden = p_Id;
END$$
DELIMITER ;

-- DIAGNOSTICOS CRUD
DELIMITER $$
CREATE PROCEDURE sp_DiagnosticoCrear(
    IN p_IdOrden INT,
    IN p_Diagnostico VARCHAR(300),
    IN p_Solucion VARCHAR(300)
)
BEGIN
    INSERT INTO Diagnosticos (IdOrden, Diagnostico, SolucionPropuesta)
    VALUES (p_IdOrden, p_Diagnostico, p_Solucion);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_DiagnosticoListar()
BEGIN
    SELECT * FROM Diagnosticos;
END$$
DELIMITER ;

-- REPUESTOS CRUD
DELIMITER $$
CREATE PROCEDURE sp_RepuestoCrear(
    IN p_Nombre VARCHAR(100),
    IN p_Descripcion VARCHAR(200),
    IN p_Precio DECIMAL(10,2),
    IN p_Stock INT
)
BEGIN
    INSERT INTO Repuestos (Nombre, Descripcion, Precio, Stock)
    VALUES (p_Nombre, p_Descripcion, p_Precio, p_Stock);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_RepuestoListar()
BEGIN
    SELECT * FROM Repuestos;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_RepuestoActualizar(
    IN p_Id INT,
    IN p_Nombre VARCHAR(100),
    IN p_Descripcion VARCHAR(200),
    IN p_Precio DECIMAL(10,2),
    IN p_Stock INT
)
BEGIN
    UPDATE Repuestos
    SET Nombre = p_Nombre,
        Descripcion = p_Descripcion,
        Precio = p_Precio,
        Stock = p_Stock
    WHERE IdRepuesto = p_Id;
END$$
DELIMITER ;

-- REPUESTOS USADOS CRUD
DELIMITER $$
CREATE PROCEDURE sp_RepuestoUsadoCrear(
    IN p_IdOrden INT,
    IN p_IdRepuesto INT,
    IN p_Cantidad INT
)
BEGIN
    INSERT INTO RepuestosUsados (IdOrden, IdRepuesto, Cantidad)
    VALUES (p_IdOrden, p_IdRepuesto, p_Cantidad);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_RepuestoUsadoListar()
BEGIN
    SELECT * FROM RepuestosUsados;
END$$
DELIMITER ;
