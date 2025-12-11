const express = require("express");
const router = express.Router();
const db = require("../models");

// GET historial de compras
router.get("/", async (req, res) => {
  try {
    const facturas = await db.FacturaCliente.findAll({
      include: [
        {
          model: db.Usuario,
          attributes: ['nombre_usuario']
        },
        {
          model: db.PaqueteTuristico,
          // attributes: ['destino_paquete', 'cantidad_personas'], // COMENTADO para traer todas las FKs de tarifas
          include: [
            {
              model: db.TarifaPorDestino,
              include: [{ model: db.ProveedorAerolinea, attributes: ['nombre_aerolinea'] }]
            },
            {
              model: db.TarifaHospedaje,
              include: [{ model: db.ProveedorHospedaje, attributes: ['nombre_hospedaje'] }]
            },
            {
              model: db.TarifaRestaurante,
              include: [{ model: db.ProveedorRestaurante, attributes: ['nombre_restaurante'] }]
            }
          ]
        },
        {
          model: db.EstadoTransaccion,
          attributes: ['estado_transaccion']
        },
        {
          model: db.RegistroEgresos,
          required: false
        }
      ],
      order: [['id_factura', 'DESC']]
    });

    const data = facturas.map(f => {
      const p = f.PaqueteTuristico;
      const egresos = f.RegistroEgresos || [];

      // Helper para buscar egreso por tipo
      const getEgreso = (tipo) => egresos.find(e => e.tipo_PROV === tipo);

      // Datos Aerolinea
      const egresoAero = getEgreso('Aerolinea');
      const tarifaAero = p?.TarifaPorDestino;
      const costoAero = tarifaAero ? parseFloat(tarifaAero.precio_vuelos || 0) * (p.cantidad_personas || 1) : 0;

      // Datos Hotel
      const egresoHotel = getEgreso('Hotel');
      const tarifaHotel = p?.TarifaHospedaje;
      const costoHotel = tarifaHotel ? parseFloat(tarifaHotel.precio_por_dia || 0) * (p.cantidad_personas || 1) : 0;

      // Datos Restaurante
      const egresoRest = getEgreso('Restaurante');
      const tarifaRest = p?.TarifaRestaurante;
      const costoRest = tarifaRest ? parseFloat(tarifaRest.precio_por_dia || 0) * (p.cantidad_personas || 1) : 0;

      const parsedAero = egresoAero ? parseFloat(egresoAero.monto_A_pagar) : costoAero;

      return {
        id: f.id_factura,
        cliente: f.Usuario?.nombre_usuario || 'Desconocido',
        paquete: p?.destino_paquete || 'Desconocido',
        monto: f.monto_pagado,
        fecha_generacion: f.fecha_inicio_viaje,
        estado: f.EstadoTransaccion?.estado_transaccion || 'Indefinido',
        referencia_factura: f.num_referencia || '', // Nueva propiedad para autocompletar pagos

        // Datos desglosados para el modal
        pagos: {
          aerolinea: {
            nombre: tarifaAero?.ProveedorAerolinea?.nombre_aerolinea || 'No asignado',
            monto: (egresoAero && parseFloat(egresoAero.monto_A_pagar) > 0) ? parseFloat(egresoAero.monto_A_pagar) : costoAero,
            fecha_pago: egresoAero?.fecha_pago_real || null,
            referencia: egresoAero?.numReferenciaPago || '',
            confirmado: egresoAero?.id_estado_transaccion_PROV === 2 // 2 = Pagado
          },
          hotel: {
            nombre: tarifaHotel?.ProveedorHospedaje?.nombre_hospedaje || 'No asignado',
            monto: (egresoHotel && parseFloat(egresoHotel.monto_A_pagar) > 0) ? parseFloat(egresoHotel.monto_A_pagar) : costoHotel,
            fecha_pago: egresoHotel?.fecha_pago_real || null,
            referencia: egresoHotel?.numReferenciaPago || '',
            confirmado: egresoHotel?.id_estado_transaccion_PROV === 2
          },
          restaurante: {
            nombre: tarifaRest?.ProveedorRestaurante?.nombre_restaurante || 'No asignado',
            monto: (egresoRest && parseFloat(egresoRest.monto_A_pagar) > 0) ? parseFloat(egresoRest.monto_A_pagar) : costoRest,
            fecha_pago: egresoRest?.fecha_pago_real || null,
            referencia: egresoRest?.numReferenciaPago || '',
            confirmado: egresoRest?.id_estado_transaccion_PROV === 2
          }
        }
      };
    });

    res.json({ data });

  } catch (error) {
    console.error("Error detallado en GET /:", error);
    res.status(500).json({ error: "Error obteniendo historial" });
  }
});

// PUT actualizar registro (Manejo de Pagos a Proveedores)
router.put("/:id", async (req, res) => {
  const t = await db.sequelize.transaction(); // Transacción para asegurar integridad
  try {
    const idFactura = req.params.id;
    const { pagos } = req.body; // Esperamos un objeto { aerolinea: {...}, hotel: {...}, restaurante: {...} }

    if (!pagos) return res.status(400).json({ error: "Faltan datos de pagos" });

    // Helper para procesar cada tipo de pago
    const procesarPagoProveedor = async (tipo, datos) => {
      if (!datos) return;

      // 1. Buscar si ya existe el egreso
      let egreso = await db.RegistroEgresos.findOne({
        where: { id_factura: idFactura, tipo_PROV: tipo },
        transaction: t
      });

      const nuevoEstado = datos.confirmado ? 2 : 1; // 2=Pagado, 1=Pendiente

      if (egreso) {
        // Si cambia a confirmado (2) y antes no lo estaba, generar asiento contable
        const cambioAConfirmado = nuevoEstado === 2 && egreso.id_estado_transaccion_PROV !== 2;

        await egreso.update({
          fecha_pago_real: datos.fecha_pago,
          numReferenciaPago: datos.referencia,
          id_estado_transaccion_PROV: nuevoEstado,
          monto_A_pagar: datos.monto // Actualizar monto si cambió
        }, { transaction: t });

        if (cambioAConfirmado) {
          await crearAsientoEgreso(egreso, t);
        }
      } else {
        // Crear nuevo
        egreso = await db.RegistroEgresos.create({
          id_factura: idFactura,
          tipo_PROV: tipo,
          proveedor_id_fk: '0', // TODO: Idealmente obtener el ID real del proveedor
          monto_A_pagar: datos.monto || 0,
          fecha_generacion: new Date(),
          fecha_pago_real: datos.fecha_pago,
          numReferenciaPago: datos.referencia,
          id_estado_transaccion_PROV: nuevoEstado
        }, { transaction: t });

        if (nuevoEstado === 2) {
          await crearAsientoEgreso(egreso, t);
        }
      }
    };

    await procesarPagoProveedor('Aerolinea', pagos.aerolinea);
    await procesarPagoProveedor('Hotel', pagos.hotel);
    await procesarPagoProveedor('Restaurante', pagos.restaurante);

    // Verificar si TODOS estan pagados para actualizar factura global (Opcional)
    // const todosPagados = ... (Lógica extra si se desea actualizar estado factura)

    await t.commit();
    res.json({ mensaje: "Pagos actualizados correctamente" });

  } catch (error) {
    await t.rollback();
    console.error("Error actualizando historial:", error);
    res.status(500).json({ error: "Error actualizando historial: " + error.message });
  }
});

// Helper Función para Contabilidad (Bienes y Suministros vs Banco)
async function crearAsientoEgreso(egreso, t) {
  // 1. Crear Asiento HABER (Salida de Banco)
  // IMPORTANTE: Buscamos por NOMBRE, no por código, para evitar errores si los códigos cambian
  const cuentaBanco = await db.NombreCuenta.findOne({ where: { nombre: 'Efectivo en bancos' }, transaction: t });

  // 2. Crear Asiento DEBE (Gasto / Cuenta por Pagar)
  // Usaremos 'Bienes y suministros' como gasto genérico
  const cuentaGasto = await db.NombreCuenta.findOne({ where: { nombre: 'Bienes y suministros' }, transaction: t });

  if (!cuentaBanco || !cuentaGasto) {
    throw new Error("Error Crítico: No se encontraron las cuentas 'Efectivo en bancos' o 'Bienes y suministros' en la base de datos.");
  }

  // Haber (Salida dinero - Banco)
  await db.RegistroContable.create({
    id_factura: egreso.id_factura,
    id_cuenta: cuentaBanco.id_cuenta,
    id_tipo_mov: 2, // Haber
    fecha_mov: new Date(),
    monto: egreso.monto_A_pagar,
    descripcion: `Pago Proveedor ${egreso.tipo_PROV} (Ref: ${egreso.numReferenciaPago})`
  }, { transaction: t });

  // Debe (Gasto - Bienes y Suministros)
  await db.RegistroContable.create({
    id_factura: egreso.id_factura,
    id_cuenta: cuentaGasto.id_cuenta,
    id_tipo_mov: 1, // Debe
    fecha_mov: new Date(),
    monto: egreso.monto_A_pagar,
    descripcion: `Pago Proveedor ${egreso.tipo_PROV} (Ref: ${egreso.numReferenciaPago})`
  }, { transaction: t });
}

module.exports = router;
