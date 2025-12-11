const db = require('./src/models');

async function seedDoubleEntry() {
    try {
        console.log('Connecting to DB...');
        await db.sequelize.authenticate();

        // Buscar Cuentas Clave
        const caja = await db.NombreCuenta.findOne({ where: { nombre: 'Caja General' } });
        const ventas = await db.NombreCuenta.findOne({ where: { nombre: 'Ventas de Paquetes' } });
        const gastoViaje = await db.NombreCuenta.findOne({ where: { nombre: 'Gastos de Viaje' } });

        const ingresoType = await db.TipoMovimiento.findOne({ where: { tipo: 'Ingreso' } });
        const egresoType = await db.TipoMovimiento.findOne({ where: { tipo: 'Egreso' } });

        console.log('Backfilling SALES (Facturas)...');
        // Buscamos todas las facturas
        const facturas = await db.FacturaCliente.findAll();

        for (const f of facturas) {
            // Buscamos si ya existe el asiento de "Ventas" para esta factura
            const ventaExist = await db.RegistroContable.findOne({
                where: {
                    id_factura: f.id_factura,
                    id_cuenta: ventas.id_cuenta
                }
            });

            if (!ventaExist) {
                console.log(`Creating Sales Entry for Invoice #${f.id_factura}`);
                await db.RegistroContable.create({
                    id_factura: f.id_factura,
                    id_cuenta: ventas.id_cuenta,
                    id_tipo_mov: ingresoType.id_tipo_mov,
                    monto: f.monto_pagado,
                    fecha_mov: f.fecha_inicio_viaje || new Date(),
                    descripcion: 'Venta de Paquete Factura #' + f.id_factura
                });
            }
        }

        console.log('Backfilling EXPENSES (Egresos)...');
        // Como los egresos no tienen FK directa en RegistroContable (son null), 
        // tenemos que iterar los registros que son "Salida de Caja" y buscar si tienen su pareja.
        // O mejor, iterar la tabla RegistroEgresos original y asegurar que tenga sus 2 asientos.

        const egresosProvs = await db.RegistroEgresos.findAll();

        for (const e of egresosProvs) {
            // Identificar descripción única o patrón
            const descCausacion = 'Causación Gasto: ' + e.tipo_PROV;

            const gastoExist = await db.RegistroContable.findOne({
                where: {
                    //id_factura: null,
                    descripcion: descCausacion
                    // Podríamos filtrar por monto y fecha también para ser más seguros
                }
            });

            if (!gastoExist) {
                console.log(`Creating Expense Entry for Egreso #${e.id_egreso}`);
                await db.RegistroContable.create({
                    id_factura: null,
                    id_cuenta: gastoViaje.id_cuenta, // Default a Gastos de Viaje
                    id_tipo_mov: egresoType.id_tipo_mov,
                    monto: e.monto_A_pagar,
                    fecha_mov: e.fecha_generacion,
                    descripcion: descCausacion
                });
            }
        }

        console.log('Double Entry Backfill Complete.');

    } catch (error) {
        console.error('Error:', error);
    } finally {
        await db.sequelize.close();
    }
}

seedDoubleEntry();
