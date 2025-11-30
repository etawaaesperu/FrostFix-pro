import { pool } from "../JS/connection.js";
import { ok, error } from "../utils/response.js";

export const listarRepuestosUsados = async (req, res) => {
    try {
        const [rows] = await pool.query("SELECT * FROM RepuestosUsados");
        return ok(res, rows);
    } catch (err) { return error(res, err); }
};

export const crearRepuestoUsado = async (req, res) => {
    try {
        const { idOrden, idRepuesto, cantidad } = req.body;

        await pool.query(
            "INSERT INTO RepuestosUsados (IdOrden, IdRepuesto, Cantidad) VALUES (?,?,?)",
            [idOrden, idRepuesto, cantidad]
        );

        return ok(res, "Repuesto asignado");
    } catch (err) { return error(res, err); }
};
