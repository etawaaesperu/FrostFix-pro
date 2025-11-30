import { pool } from "../JS/connection.js";
import { ok, error } from "../utils/response.js";

// ---------- LOGIN ----------
export const login = async (req, res) => {
    try {
        const { correo, contrasena } = req.body;

        if (!correo || !contrasena) {
            return error(res, "Faltan datos");
        }

        const [rows] = await pool.query(
            "SELECT * FROM Usuarios WHERE Correo = ? AND Contrasena = ?",
            [correo, contrasena]
        );

        if (rows.length === 0) {
            return error(res, "Credenciales incorrectas");
        }

        return ok(res, rows[0]);

    } catch (err) {
        return error(res, err.message);
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

        return ok(res, { id: result.insertId });

    } catch (err) {
        return error(res, err.message);
    }
};

// ---------- LISTAR ----------
export const listarUsuarios = async (req, res) => {
    try {
        const [rows] = await pool.query("SELECT * FROM Usuarios");
        return ok(res, rows);
    } catch (err) {
        return error(res, err.message);
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

        return ok(res, "Usuario actualizado");
    } catch (err) {
        return error(res, err.message);
    }
};

// ---------- ELIMINAR ----------
export const eliminarUsuario = async (req, res) => {
    try {
        const { id } = req.params;

        await pool.query("DELETE FROM Usuarios WHERE IdUsuario=?", [id]);

        return ok(res, "Usuario eliminado");
    } catch (err) {
        return error(res, err.message);
    }
};
