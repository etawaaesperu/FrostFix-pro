// server.js (ES Modules)
import express from "express";
import cors from "cors";
import path from "path";
import { fileURLToPath } from "url";

import authRoutes from "./routes/auth.routes.js";
import clientesRoutes from "./routes/clientes.routes.js";
import equiposRoutes from "./routes/equipos.routes.js";
import repuestosRoutes from "./routes/repuestos.routes.js";
import ordenesRoutes from "./routes/ordenes.routes.js";
import diagnosticosRoutes from "./routes/diagnosticos.routes.js";
import repuestosUsadosRoutes from "./routes/repuestosUsados.routes.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());           // <-- SOLO esta (no bodyParser.json() adicional)
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "public"))); // si tienes HTML en /public

// Rutas API
app.use("/api/auth", authRoutes);
app.use("/api/clientes", clientesRoutes);
app.use("/api/equipos", equiposRoutes);
app.use("/api/repuestos", repuestosRoutes);
app.use("/api/ordenes", ordenesRoutes);
app.use("/api/diagnosticos", diagnosticosRoutes);
app.use("/api/repuestos-usados", repuestosUsadosRoutes);


app.listen(PORT, () => {
  console.log(`servidor corriendo en → http://localhost:${PORT}/`);
});
