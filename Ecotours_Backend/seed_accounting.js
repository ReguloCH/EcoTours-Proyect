const db = require('./src/models');

async function seedAccounting() {
    try {
        console.log('Connecting...');
        await db.sequelize.authenticate();
        console.log('Checking Accounts...');

        // 1. Ensure Accounts exist
        const [caja] = await db.NombreCuenta.findOrCreate({ where: { nombre: 'Caja General', tipo: 'Activo' } });
        const [ventas] = await db.NombreCuenta.findOrCreate({ where: { nombre: 'Ventas de Paquetes', tipo: 'Ingreso' } });

        // 2. Ensure Types exist
        const [ingreso] = await db.TipoMovimiento.findOrCreate({ where: { tipo: 'Ingreso' } });
        const [egreso] = await db.TipoMovimiento.findOrCreate({ where: { tipo: 'Egreso' } });

        console.log('Processing Facturas...');
        const facturas = await db.FacturaCliente.findAll();
        let createdIngresos = 0;

        for (const f of facturas) {
            // Check if entry exists for this invoice
            const exists = await db.RegistroContable.findOne({ where: { id_factura: f.id_factura } });
            if (!exists) {
                await db.RegistroContable.create({
                    id_factura: f.id_factura,
                    id_cuenta: caja.id_cuenta,
                    id_tipo_mov: ingreso.id_tipo_mov,
                    monto: f.monto_pagado,
                    fecha_mov: f.fecha_inicio_viaje || new Date(),
                    descripcion: `Ingreso por Factura #${f.id_factura} (Importado)`
                });
                createdIngresos++;
            }
        }
        console.log(`Created ${createdIngresos} accounting entries for Invoices.`);

        console.log('Processing Egresos...');
        // Egresos might not be linked to RegistroContable easily if we didn't add a column, 
        // but the controller logic does create them. 
        // We'll query Egresos and check if there's a matching RegistroContable by description usually, 
        // but here we can just add them if we are sure.
        // However, the current model RegistroContable DOES allow id_factura null.
        // The controller uses "Egreso #ID" in description. We can use that to check existence.

        const egresosProvs = await db.RegistroEgresos.findAll();
        let createdEgresos = 0;

        for (const e of egresosProvs) {
            const desc = `Egreso #${e.id_egreso}: ${e.tipo_PROV}`;
            const exists = await db.RegistroContable.findOne({ where: { descripcion: desc } });

            if (!exists) {
                await db.RegistroContable.create({
                    id_factura: null,
                    id_cuenta: caja.id_cuenta,
                    id_tipo_mov: egreso.id_tipo_mov,
                    monto: e.monto_A_pagar,
                    fecha_mov: e.fecha_generacion,
                    descripcion: desc
                });
                createdEgresos++;
            }
        }
        console.log(`Created ${createdEgresos} accounting entries for Egresos.`);

    } catch (error) {
        console.error('Error seeding accounting:', error);
    } finally {
        await db.sequelize.close();
    }
}

seedAccounting();
