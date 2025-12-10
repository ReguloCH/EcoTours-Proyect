const express = require("express");
const router = express.Router();
const db = require("../config/db");

// OBTENER TODO EL REGISTRO CONTABLE
router.get("/", (req, res) => {
  const q = `
    SELECT 
      rc.id_registro,
      rc.id_factura,
      rc.monto,
      rc.fecha_mov,
      rc.descripcion,
      nc.nombre AS cuenta_nombre,
      nc.tipo AS cuenta_tipo,
      tm.tipo AS tipo_movimiento
    FROM registro_contable rc
      INNER JOIN nombre_cuenta nc ON rc.id_cuenta = nc.id_cuenta
      INNER JOIN tipo_movimiento tm ON rc.id_tipo_mov = tm.id_tipo_mov
    ORDER BY rc.id_registro DESC
  `;

  db.query(q, (err, rows) => {
    if (err) return res.status(500).json({ error: err });
    res.json(rows);
  });
});

// FILTROS DINÁMICOS
router.get("/filtro", (req, res) => {
  const { factura, fecha, cuenta } = req.query;

  let q = `
    SELECT 
      rc.id_registro,
      rc.id_factura,
      rc.monto,
      rc.fecha_mov,
      rc.descripcion,
      nc.nombre AS cuenta_nombre,
      nc.tipo AS cuenta_tipo,
      tm.tipo AS tipo_movimiento
    FROM registro_contable rc
      INNER JOIN nombre_cuenta nc ON rc.id_cuenta = nc.id_cuenta
      INNER JOIN tipo_movimiento tm ON rc.id_tipo_mov = tm.id_tipo_mov
    WHERE 1 = 1
  `;

  const params = [];

  if (factura) {
    q += " AND rc.id_factura = ?";
    params.push(factura);
  }

  if (fecha) {
    q += " AND rc.fecha_mov = ?";
    params.push(fecha);
  }

  if (cuenta) {
    q += " AND rc.id_cuenta = ?";
    params.push(cuenta);
  }

  q += " ORDER BY rc.id_registro DESC";

  db.query(q, params, (err, rows) => {
    if (err) return res.status(500).json({ error: err });
    res.json(rows);
  });
});

module.exports = router;
