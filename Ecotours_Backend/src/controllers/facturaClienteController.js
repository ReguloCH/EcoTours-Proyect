const db = require('../models');
const FacturaCliente = db.FacturaCliente;
const Usuario = db.Usuario;
const PaqueteTuristico = db.PaqueteTuristico;
const MetodoPago = db.MetodoPago;
const EstadoTransaccion = db.EstadoTransaccion;

// >>> IMPORTANTE: Conexion SQL directa para los asientos <<<
const sql = db.sequelize; 

exports.getAll = async (req, res) => {
  const facturas = await FacturaCliente.findAll({
    include: [Usuario, PaqueteTuristico, MetodoPago, EstadoTransaccion]
  });
  res.json(facturas);
};

exports.getById = async (req, res) => {
  const factura = await FacturaCliente.findByPk(req.params.id, {
    include: [Usuario, PaqueteTuristico, MetodoPago, EstadoTransaccion]
  });
  factura ? res.json(factura) : res.status(404).json({ error: 'Factura no encontrada' });
};

exports.create = async (req, res) => {
  try {
    // 1️⃣ Crear factura normal
    const factura = await FacturaCliente.create(req.body);

    const idFactura = factura.id_factura;
    const monto = factura.monto_pagado;

    // 2️⃣ Registrar asiento contable automático
    // (Caja DEBE - Ventas HABER)

    await sql.query(`
      INSERT INTO registro_contable
        (id_factura, id_nombre_cuenta, id_tipo_movimiento, monto)
      VALUES
        (?, 1, 1, ?),   -- Caja (Activo - Debe)
        (?, 3, 2, ?);   -- Ventas (Ingreso - Haber)
    `, {
      replacements: [idFactura, monto, idFactura, monto]
    });

    res.status(201).json({
      mensaje: "Factura creada y asiento contable registrado automáticamente.",
      factura
    });

  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error al crear factura o asiento contable." });
  }
};

exports.update = async (req, res) => {
  await FacturaCliente.update(req.body, { where: { id_factura: req.params.id } });
  res.json({ mensaje: 'Factura actualizada' });
};

exports.delete = async (req, res) => {
  await FacturaCliente.destroy({ where: { id_factura: req.params.id } });
  res.json({ mensaje: 'Factura eliminada' });
};
