const express = require("express");
const router = express.Router();
const db = require("../models");

// GET historial de compras
router.get("/", async (req, res) => {
  try {
    const [rows] = await db.sequelize.query(`
      SELECT 
        f.id_factura AS id,
        u.nombre_usuario AS cliente,
        p.destino_paquete AS paquete,
        f.monto_pagado AS monto,
        f.fecha_inicio_viaje AS fecha_generacion,
        re.fecha_pago_real AS fecha_pago_real,
        re.numReferenciaPago AS referencia,
        et.estado_transaccion AS estado
      FROM factura_cliente f
      LEFT JOIN usuario u ON f.cedula_usuario = u.cedula_usuario
      LEFT JOIN paquete_turistico p ON f.id_paquete = p.id_paquete
      LEFT JOIN registro_egresos re ON re.id_factura = f.id_factura
      LEFT JOIN estado_transaccion et ON f.id_estado_transaccion = et.id_estado_transaccion
      ORDER BY f.id_factura DESC;
    `);

    res.json({ data: rows });

  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error obteniendo historial" });
  }
});

// PUT actualizar registro
router.put("/:id", async (req, res) => {
  try {
    const { fecha_pago_real, numReferenciaPago, id_estado_transaccion } = req.body;

    await db.sequelize.query(
      `
      UPDATE registro_egresos 
      SET fecha_pago_real = ?, numReferenciaPago = ?
      WHERE id_factura = ?
      `,
      {
        replacements: [
          fecha_pago_real,
          numReferenciaPago,
          req.params.id
        ]
      }
    );

    await db.sequelize.query(
      `
      UPDATE factura_cliente 
      SET id_estado_transaccion = ?
      WHERE id_factura = ?
      `,
      {
        replacements: [
          id_estado_transaccion,
          req.params.id
        ]
      }
    );

    res.json({ mensaje: "Registro actualizado correctamente" });

  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error actualizando historial" });
  }
});

module.exports = router;
