export const ok = (res, data = null, message = "OK") => {
    return res.json({
        ok: true,
        message,
        data
    });
};

export const error = (res, message = "Error en la petición") => {
    return res.status(400).json({
        ok: false,
        message
    });
};

export const error500 = (res, error) => {
    console.error("SERVER ERROR:", error);
    return res.status(500).json({
        ok: false,
        message: "Error interno del servidor",
        error: error.message
    });
};
