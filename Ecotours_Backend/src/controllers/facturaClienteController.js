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
  const t = await db.sequelize.transaction(); // Iniciar transacción
  try {
    // 1️⃣ Crear factura normal
    const factura = await FacturaCliente.create(req.body, { transaction: t });

    const idFactura = factura.id_factura;
    const monto = factura.monto_pagado;
    const fecha = factura.fecha_pago || new Date();
    const idPaquete = req.body.id_paquete;

    // ---------------------------------------------------------
    // NUEVA LÓGICA: Generar Egresos Pendientes Automáticos
    // ---------------------------------------------------------

    // Buscar paquete con sus tarifas
    const paquete = await PaqueteTuristico.findByPk(idPaquete, {
      include: [
        { model: db.TarifaPorDestino, include: [db.ProveedorAerolinea] },
        { model: db.TarifaHospedaje, include: [db.ProveedorHospedaje] },
        { model: db.TarifaRestaurante, include: [db.ProveedorRestaurante] }
      ],
      transaction: t
    });

    if (paquete) {
      const personas = paquete.cantidad_personas || 1;

      // Helper para crear egreso
      const crearEgreso = async (tipo, tarifa, proveedorId) => {
        // DEBUG LOGS
        console.log(`[DEBUG] creando egreso para ${tipo}:`, {
          hayTarifa: !!tarifa,
          idProv: proveedorId,
          tarifaData: tarifa ? JSON.stringify(tarifa) : 'N/A'
        });

        if (!tarifa) return; // Si no hay tarifa, no generamos deuda

        // Calcular costo total (Tarifa * Personas)
        // Ajustar lógica según el tipo de tarifa
        let costoUnitario = 0;
        if (tipo === 'Aerolinea') costoUnitario = parseFloat(tarifa.precio_vuelos || 0);
        if (tipo === 'Hotel') costoUnitario = parseFloat(tarifa.precio_por_dia || 0);
        if (tipo === 'Restaurante') costoUnitario = parseFloat(tarifa.precio_por_dia || 0);

        const totalDeuda = costoUnitario * personas;

        if (totalDeuda > 0) {
          await db.RegistroEgresos.create({
            id_factura: idFactura,
            tipo_PROV: tipo,
            proveedor_id_fk: proveedorId || 0, // Id del proveedor específico
            monto_A_pagar: totalDeuda,
            fecha_generacion: new Date(),
            id_estado_transaccion_PROV: 1 // 1 = Pendiente
          }, { transaction: t });
        }
      };

      // 1. Aerolínea
      await crearEgreso(
        'Aerolinea',
        paquete.TarifaPorDestino,
        paquete.TarifaPorDestino?.id_proveedor_aerolinea
      );

      // 2. Hotel
      await crearEgreso(
        'Hotel',
        paquete.TarifaHospedaje,
        paquete.TarifaHospedaje?.id_proveedor_hospedaje
      );

      // 3. Restaurante
      await crearEgreso(
        'Restaurante',
        paquete.TarifaRestaurante,
        paquete.TarifaRestaurante?.id_proveedor_restaurante
      );
    }

    // ---------------------------------------------------------
    // FIN NUEVA LÓGICA
    // ---------------------------------------------------------


    // 2️⃣ Registrar asiento contable automático (INGRESO DE LA FACTURA)
    const caja = await db.NombreCuenta.findOne({ where: { nombre: 'Efectivo en bancos' }, transaction: t });
    const ventas = await db.NombreCuenta.findOne({ where: { nombre: 'Venta de mercancía' }, transaction: t });
    const ingreso = await db.TipoMovimiento.findOne({ where: { tipo: 'Ingreso' }, transaction: t });

    if (caja && ventas && ingreso) {
      // 1. Movimiento a Caja (Activo aumenta -> Debe)
      await db.RegistroContable.create({
        id_factura: idFactura,
        id_cuenta: caja.id_cuenta,
        id_tipo_mov: ingreso.id_tipo_mov,
        monto: monto,
        fecha_mov: fecha,
        descripcion: 'Ingreso a Caja por Factura #' + idFactura
      }, { transaction: t });

      // 2. Movimiento a Ventas (Ingreso aumenta -> Haber)
      await db.RegistroContable.create({
        id_factura: idFactura,
        id_cuenta: ventas.id_cuenta,
        id_tipo_mov: 2, // Haber (Ingreso aumenta por el Haber) -> CORREGIDO (antes usaba id dupe)
        // Nota: id_tipo_mov 1 es Debe (según initData?), id_tipo_mov 2 es Haber (Egreso?).
        // Si no tienes id estandar para Debe/Haber, usa lógica de initData. 
        // Asumo: 1=Debe, 2=Haber (basado en 'crearAsientoEgreso')
        monto: monto,
        fecha_mov: fecha,
        descripcion: 'Venta de Paquete Factura #' + idFactura
      }, { transaction: t });
    }

    await t.commit(); // Confirmar todo

    res.status(201).json({
      mensaje: "Factura creada, deudas a proveedores calculadas y asiento de ingreso registrado.",
      factura
    });

  } catch (error) {
    await t.rollback();
    console.error(error);
    res.status(500).json({ error: "Error al crear factura o asiento contable: " + error.message });
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
