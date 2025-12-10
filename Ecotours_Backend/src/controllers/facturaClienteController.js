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
    const fecha = factura.fecha_pago || new Date(); // Usar fecha pago o hoy

    // 2️⃣ Registrar asiento contable automático
    // Buscar IDs de cuentas y tipos
    const caja = await db.NombreCuenta.findOne({ where: { nombre: 'Caja General' } });
    const ventas = await db.NombreCuenta.findOne({ where: { nombre: 'Ventas de Paquetes' } });
    const ingreso = await db.TipoMovimiento.findOne({ where: { tipo: 'Ingreso' } });

    if (caja && ventas && ingreso) {
      // Asiento: Entrada a Caja (Debe) -> Representado positivo o simplemente asociado a cuenta Activo
      // Normalmente en doble partida: 
      // 1. Debe: Caja (Activo)
      // 2. Haber: Ventas (Ingreso)

      // En este diseño simple, registramos ambos movimientos asociados a la factura

      // Movimiento a Caja
      await db.RegistroContable.create({
        id_factura: idFactura,
        id_cuenta: caja.id_cuenta,
        id_tipo_mov: ingreso.id_tipo_mov, // Ojo: Tipo Movimiento es del registro o de la cuenta? El modelo dice id_tipo_mov en RegistroContable.
        // Siendo ingreso de dinero, es 'Ingreso'
        monto: monto,
        fecha_mov: fecha,
        descripcion: 'Ingreso por Factura #' + idFactura
      });

      // Contracuenta: Ventas (Opcional, si queremos balancear, registramos el otro lado)
      // Dependiendo de cómo "TipoMovimiento" se use. Si 'Ingreso' significa "Entrada de dinero", entonces solo Caja.
      // Si queremos registrar el "Ingreso Contable", entonces Ventas.
      // Vamos a registrar Entrada en Caja por ahora, que es lo más visual.
    }

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
