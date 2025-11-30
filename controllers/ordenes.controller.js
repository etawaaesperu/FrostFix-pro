import { pool } from "../JS/connection.js";
import { ok, error } from "../utils/response.js";

export const listarOrdenes = async (req, res) => {
    try {
        const [rows] = await pool.query("SELECT * FROM OrdenesServicio");
        return ok(res, rows);
    } catch (err) { return error(res, err); }
};

export const crearOrden = async (req, res) => {
    try {
        const { idCliente, idEquipo, idTecnico, descripcion } = req.body;

        await pool.query(
            "INSERT INTO OrdenesServicio (IdCliente, IdEquipo, IdTecnico, DescripcionProblema) VALUES (?,?,?,?)",
            [idCliente, idEquipo, idTecnico, descripcion]
        );

        return ok(res, "Orden creada");
    } catch (err) { return error(res, err); }
};

export const actualizarOrden = async (req, res) => {
    try {
        const { id } = req.params;
        const { estado, fechaAtencion } = req.body;

        await pool.query(
            "UPDATE OrdenesServicio SET Estado=?, FechaAtencion=? WHERE IdOrden=?",
            [estado, fechaAtencion, id]
        );

        return ok(res, "Orden actualizada");
    } catch (err) { return error(res, err); }
};
