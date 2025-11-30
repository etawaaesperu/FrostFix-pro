import { pool } from "../JS/connection.js";
import { ok, error } from "../utils/response.js";

export const listarDiagnosticos = async (req, res) => {
    try {
        const [rows] = await pool.query("SELECT * FROM Diagnosticos");
        return ok(res, rows);
    } catch (err) { return error(res, err); }
};

export const crearDiagnostico = async (req, res) => {
    try {
        const { idOrden, diagnostico, solucion } = req.body;

        await pool.query(
            "INSERT INTO Diagnosticos (IdOrden, Diagnostico, SolucionPropuesta) VALUES (?,?,?)",
            [idOrden, diagnostico, solucion]
        );

        return ok(res, "Diagnóstico agregado");
    } catch (err) { return error(res, err); }
};
