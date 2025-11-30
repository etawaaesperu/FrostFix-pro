import { pool } from "../JS/connection.js";
import { ok, error } from "../utils/response.js";

export const listarRepuestos = async (req, res) => {
    try {
        const [rows] = await pool.query("SELECT * FROM Repuestos");
        return ok(res, rows);
    } catch (err) { return error(res, err); }
};

export const crearRepuesto = async (req, res) => {
    try {
        const { nombre, descripcion, precio, stock } = req.body;

        await pool.query(
            "INSERT INTO Repuestos (Nombre, Descripcion, Precio, Stock) VALUES (?,?,?,?)",
            [nombre, descripcion, precio, stock]
        );

        return ok(res, "Repuesto creado");
    } catch (err) { return error(res, err); }
};

export const editarRepuesto = async (req, res) => {
    try {
        const { id } = req.params;
        const { nombre, descripcion, precio, stock } = req.body;

        await pool.query(
            "UPDATE Repuestos SET Nombre=?, Descripcion=?, Precio=?, Stock=? WHERE IdRepuesto=?",
            [nombre, descripcion, precio, stock, id]
        );

        return ok(res, "Repuesto actualizado");
    } catch (err) { return error(res, err); }
};

export const eliminarRepuesto = async (req, res) => {
    try {
        const { id } = req.params;

        await pool.query("DELETE FROM Repuestos WHERE IdRepuesto=?", [id]);

        return ok(res, "Repuesto eliminado");
    } catch (err) { return error(res, err); }
};
