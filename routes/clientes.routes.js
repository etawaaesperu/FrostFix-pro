import { Router } from "express";
import {
    listarClientes,
    crearCliente,
    editarCliente,
    eliminarCliente
} from "../controllers/clientes.controller.js";

const router = Router();

router.get("/", listarClientes);
router.post("/", crearCliente);
router.put("/:id", editarCliente);
router.delete("/:id", eliminarCliente);

export default router;
