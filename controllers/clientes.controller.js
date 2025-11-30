import pool from "../JS/connection.js";
import { success, error400, error500 } from "../utils/response.js";

// ---------- LOGIN ----------
export const login = async (req, res) => {
    try {
        const { correo, contrasena } = req.body;

        if (!correo || !contrasena) {
            return error400(res, "Faltan datos");
        }

        const [rows] = await pool.query(
            "SELECT * FROM Usuarios WHERE Correo = ? AND Contrasena = ?",
            [correo, contrasena]
        );

        if (rows.length === 0) {
            return error400(res, "Credenciales incorrectas");
        }

        return success(res, "Login exitoso", rows[0]);

    } catch (error) {
        return error500(res, error);
    }
};

// ---------- REGISTRO ----------
export const register = async (req, res) => {
    try {
        const { nombre, apellido, correo, contrasena, rol, username } = req.body;

        const [result] = await pool.query(
            "INSERT INTO Usuarios (Nombre, Apellido, Correo, Contrasena, Rol, Username) VALUES (?, ?, ?, ?, ?, ?)",
            [nombre, apellido, correo, contrasena, rol, username]
        );

        return success(res, "Usuario registrado", { id: result.insertId });

    } catch (error) {
        return error500(res, error);
    }
};

// ---------- LISTAR ----------
export const listarUsuarios = async (req, res) => {
    try {
        const [rows] = await pool.query("SELECT * FROM Usuarios");
        return success(res, "Listado de usuarios", rows);
    } catch (error) {
        return error500(res, error);
    }
};

// ---------- EDITAR ----------
export const editarUsuario = async (req, res) => {
    try {
        const { id } = req.params;
        const { nombre, apellido, correo, rol, username } = req.body;

        await pool.query(
            "UPDATE Usuarios SET Nombre=?, Apellido=?, Correo=?, Rol=?, Username=? WHERE IdUsuario=?",
            [nombre, apellido, correo, rol, username, id]
        );

        return success(res, "Usuario actualizado");

    } catch (error) {
        return error500(res, error);
    }
};

// ---------- ELIMINAR ----------
export const eliminarUsuario = async (req, res) => {
    try {
        const { id } = req.params;

        await pool.query("DELETE FROM Usuarios WHERE IdUsuario=?", [id]);

        return success(res, "Usuario eliminado");

    } catch (error) {
        return error500(res, error);
    }
};
