const db = require('./src/models');

async function updateNewAccounting() {
    try {
        await db.sequelize.authenticate();
        console.log('DB Connected. Applying User Account Plan...');

        // Mapping: Old Name -> { New Name, New Code }
        const updates = [
            { old: 'Caja General', newName: 'Efectivo en bancos', code: '1.1.10.20' },
            { old: 'Bancos', newName: 'Efectivo en bancos (Secundario)', code: '1.1.10.21' }, // Avoid duplicate name collision if unique
            { old: 'Ventas de Paquetes', newName: 'Venta de mercancía', code: '4.1.10.10' },
            { old: 'Gastos de Viaje', newName: 'Bienes y suministros', code: '6.1.30.20' },
            { old: 'Gastos Administrativos', newName: 'Gastos diversos', code: '6.1.30.21' }, // Generic
            { old: 'Cuentas por Pagar', newName: 'Cuentas por pagar', code: '2.1.20.20' },
            { old: 'Proveedores', newName: 'Proveedores', code: '2.1.10.10' }, // Keep or map
            // Add Shareholders if missing
        ];

        for (const item of updates) {
            const [affected] = await db.NombreCuenta.update(
                { nombre: item.newName, codigo: item.code },
                { where: { nombre: item.old } }
            );
            console.log(`Updated '${item.old}' -> '${item.newName}' (${item.code}): ${affected} rows.`);
        }

        // Ensure 'Accionistas' exists
        const [accionistas, created] = await db.NombreCuenta.findOrCreate({
            where: { codigo: '3.1.10.11' },
            defaults: { nombre: 'Accionistas', tipo: 'Capital', codigo: '3.1.10.11' }
        });
        if (created) console.log('Created Accionistas account.');

    } catch (error) {
        console.error('Error:', error);
    } finally {
        await db.sequelize.close();
    }
}

updateNewAccounting();
