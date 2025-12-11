const express = require("express");
const router = express.Router();
const { RegistroContable, NombreCuenta, TipoMovimiento } = require("../models");

// OBTENER TODO EL REGISTRO CONTABLE
router.get("/", async (req, res) => {
  try {
    const movimientos = await RegistroContable.findAll({
      include: [
        { model: NombreCuenta, as: 'NombreCuenta', attributes: ['nombre', 'tipo', 'codigo'] },
        { model: TipoMovimiento, as: 'TipoMovimiento', attributes: ['tipo'] }
      ],
      order: [['id_registro', 'DESC']]
    });

    // Mapeamos para que coincida con lo que espera el frontend
    const resultados = movimientos.map(m => {
      const tipoCuenta = m.NombreCuenta ? m.NombreCuenta.tipo : '';
      const tipoMov = m.TipoMovimiento ? m.TipoMovimiento.tipo : '';
      let movimiento = '---';

      if (['Activo', 'Gasto'].includes(tipoCuenta)) {
        movimiento = (tipoMov === 'Ingreso') ? 'Debe' : 'Haber';
      } else if (['Pasivo', 'Ingreso', 'Capital'].includes(tipoCuenta)) {
        movimiento = (tipoMov === 'Ingreso') ? 'Haber' : 'Debe';
      }

      return {
        id_registro: m.id_registro,
        id_factura: m.id_factura,
        id_cuenta: m.id_cuenta, // Added for filtering
        monto: m.monto,
        fecha_mov: m.fecha_mov,
        descripcion: m.descripcion,
        cuenta_nombre: m.NombreCuenta ? m.NombreCuenta.nombre : 'N/A',
        cuenta_tipo: m.NombreCuenta ? m.NombreCuenta.tipo : 'N/A',
        cuenta_codigo: m.NombreCuenta ? m.NombreCuenta.codigo : 'N/A',
        tipo_movimiento: movimiento
      };
    });

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
        { model: NombreCuenta, as: 'NombreCuenta', attributes: ['nombre', 'tipo', 'codigo'] },
        { model: TipoMovimiento, as: 'TipoMovimiento', attributes: ['tipo'] }
      ],
      order: [['id_registro', 'DESC']]
    });

    const resultados = movimientos.map(m => {
      const tipoCuenta = m.NombreCuenta ? m.NombreCuenta.tipo : '';
      const tipoMov = m.TipoMovimiento ? m.TipoMovimiento.tipo : '';
      let movimiento = '---';

      // Lógica Debe/Haber
      // Activo: Ingreso (Aumenta) -> Debe, Egreso (Disminuye) -> Haber
      if (tipoCuenta === 'Activo') {
        movimiento = (tipoMov === 'Ingreso') ? 'Debe' : 'Haber';
      }
      // Pasivo, Patrimonio e Ingresos: Ingreso (Aumenta) -> Haber, Egreso (Disminuye) -> Debe
      else if (['Pasivo', 'Ingreso', 'Capital'].includes(tipoCuenta)) {
        movimiento = (tipoMov === 'Ingreso') ? 'Haber' : 'Debe';
      }
      // Gasto: Egreso (Aumenta el gasto) -> Debe, Ingreso (Reversión) -> Haber
      else if (tipoCuenta === 'Gasto') {
        movimiento = (tipoMov === 'Egreso') ? 'Debe' : 'Haber';
      }

      return {
        id_registro: m.id_registro,
        id_factura: m.id_factura,
        id_cuenta: m.id_cuenta, // Added for filtering
        monto: m.monto,
        fecha_mov: m.fecha_mov,
        descripcion: m.descripcion,
        cuenta_nombre: m.NombreCuenta ? m.NombreCuenta.nombre : 'N/A',
        cuenta_tipo: m.NombreCuenta ? m.NombreCuenta.tipo : 'N/A',
        cuenta_codigo: m.NombreCuenta ? m.NombreCuenta.codigo : 'N/A',
        tipo_movimiento: movimiento // 'Debe' o 'Haber'
      };
    });

    // Filtrado en memoria para campos calculados si es necesario (ej: movimiento)
    // El filtro de cuenta y fecha ya se hizo en DB.

    res.json(resultados);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error al filtrar registros contables" });
  }
});

module.exports = router;
