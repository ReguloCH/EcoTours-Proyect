const db = require('./src/models');

async function ensureAccounts() {
    try {
        await db.sequelize.authenticate();
        console.log("DB Connected.");

        const accounts = [
            { nombre: 'Efectivo en bancos', codigo: '1.1.1.2', tipo: 'Activo' },
            { nombre: 'Bienes y suministros', codigo: '5.4', tipo: 'Gasto' },
            { nombre: 'Venta de mercancía', codigo: '4.1', tipo: 'Ingreso' },
            { nombre: 'Gastos diversos', codigo: '5.9', tipo: 'Gasto' }
        ];

        for (const acc of accounts) {
            const [record, created] = await db.NombreCuenta.findOrCreate({
                where: { nombre: acc.nombre },
                defaults: acc
            });

            if (created) {
                console.log(`✅ Created account: ${acc.nombre}`);
            } else {
                console.log(`ℹ️ Account exists: ${acc.nombre} (ID: ${record.id_cuenta})`);
                // Optional: Update code if needed, but for now just ensure existence
            }
        }

        console.log("Validation complete.");

    } catch (err) {
        console.error("Error ensuring accounts:", err);
    } finally {
        await db.sequelize.close();
    }
}

ensureAccounts();
