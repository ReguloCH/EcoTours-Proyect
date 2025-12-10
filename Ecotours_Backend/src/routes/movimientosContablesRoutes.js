const express = require("express");
const router = express.Router();
const { RegistroContable, NombreCuenta, TipoMovimiento } = require("../models");

// OBTENER TODO EL REGISTRO CONTABLE
router.get("/", async (req, res) => {
  try {
    const movimientos = await RegistroContable.findAll({
      include: [
        { model: NombreCuenta, attributes: ['nombre', 'tipo'] },
        { model: TipoMovimiento, attributes: ['tipo'] }
      ],
      order: [['id_registro', 'DESC']]
    });

    // Mapeamos para que coincida con lo que espera el frontend
    const resultados = movimientos.map(m => ({
      id_registro: m.id_registro,
      id_factura: m.id_factura,
      monto: m.monto,
      fecha_mov: m.fecha_mov,
      descripcion: m.descripcion,
      cuenta_nombre: m.NombreCuenta ? m.NombreCuenta.nombre : 'N/A',
      cuenta_tipo: m.NombreCuenta ? m.NombreCuenta.tipo : 'N/A',
      tipo_movimiento: m.TipoMovimiento ? m.TipoMovimiento.tipo : 'N/A'
    }));

    res.json(resultados);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error al obtener registros contables" });
  }
});

// FILTROS DINÁMICOS
router.get("/filtro", async (req, res) => {
  const { factura, fecha, cuenta } = req.query;
  const whereClause = {};

  if (factura) whereClause.id_factura = factura;
  if (fecha) whereClause.fecha_mov = fecha;
  if (cuenta) whereClause.id_cuenta = cuenta;

  try {
    const movimientos = await RegistroContable.findAll({
      where: whereClause,
      include: [
        { model: NombreCuenta, attributes: ['nombre', 'tipo'] },
        { model: TipoMovimiento, attributes: ['tipo'] }
      ],
      order: [['id_registro', 'DESC']]
    });

    const resultados = movimientos.map(m => ({
      id_registro: m.id_registro,
      id_factura: m.id_factura,
      monto: m.monto,
      fecha_mov: m.fecha_mov,
      descripcion: m.descripcion,
      cuenta_nombre: m.NombreCuenta ? m.NombreCuenta.nombre : 'N/A',
      cuenta_tipo: m.NombreCuenta ? m.NombreCuenta.tipo : 'N/A',
      tipo_movimiento: m.TipoMovimiento ? m.TipoMovimiento.tipo : 'N/A'
    }));

    res.json(resultados);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error al filtrar registros contables" });
  }
});

module.exports = router;
