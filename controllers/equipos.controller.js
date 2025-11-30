import { pool } from "../JS/connection.js";
import { ok, error } from "../utils/response.js";

export const listarEquipos = async (req, res) => {
    try {
        const [rows] = await pool.query("SELECT * FROM Equipos");
        return ok(res, rows);
    } catch (err) { return error(res, err); }
};

export const crearEquipo = async (req, res) => {
    try {
        const { idCliente, tipo, marca, modelo, numeroSerie } = req.body;

        await pool.query(
            "INSERT INTO Equipos (IdCliente, Tipo, Marca, Modelo, NumeroSerie) VALUES (?,?,?,?,?)",
            [idCliente, tipo, marca, modelo, numeroSerie]
        );

        return ok(res, "Equipo creado");
    } catch (err) { return error(res, err); }
};

export const editarEquipo = async (req, res) => {
    try {
        const { id } = req.params;
        const { tipo, marca, modelo, numeroSerie } = req.body;

        await pool.query(
            "UPDATE Equipos SET Tipo=?, Marca=?, Modelo=?, NumeroSerie=? WHERE IdEquipo=?",
            [tipo, marca, modelo, numeroSerie, id]
        );

        return ok(res, "Equipo actualizado");
    } catch (err) { return error(res, err); }
};

export const eliminarEquipo = async (req, res) => {
    try {
        const { id } = req.params;

        await pool.query("DELETE FROM Equipos WHERE IdEquipo=?", [id]);

        return ok(res, "Equipo eliminado");
    } catch (err) { return error(res, err); }
};
