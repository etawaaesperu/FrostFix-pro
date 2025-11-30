import { Router } from "express";
import {
    login,
    register,
    listarUsuarios,
    editarUsuario,
    eliminarUsuario
} from "../controllers/auth.controller.js";

const router = Router();

router.post("/login", login);
router.post("/register", register);

router.get("/usuarios", listarUsuarios);
router.put("/usuarios/:id", editarUsuario);
router.delete("/usuarios/:id", eliminarUsuario);

export default router;
