const express = require("express");
const router = express.Router();
const { NombreCuenta } = require("../models");

// OBTENER TODAS LAS CUENTAS CONTABLES
router.get("/", async (req, res) => {
    try {
        const cuentas = await NombreCuenta.findAll();
        res.json(cuentas);
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Error al obtener las cuentas contables" });
    }
});

module.exports = router;
