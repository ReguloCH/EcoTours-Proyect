const db = require('./src/models');

async function updateCodes() {
    try {
        await db.sequelize.authenticate();
        console.log('DB Connected. Updating Account Codes...');

        const mapping = {
            'Caja General': '1000',
            'Bancos': '1100',
            'Cuentas por Cobrar': '1200',
            'Proveedores': '2000',
            'Cuentas por Pagar': '2100',
            'Ventas de Paquetes': '4000',
            'Gastos de Viaje': '5000',
            'Gastos Administrativos': '5100'
        };

        for (const [nombre, codigo] of Object.entries(mapping)) {
            const [updated] = await db.NombreCuenta.update(
                { codigo: codigo },
                { where: { nombre: nombre } }
            );
            console.log(`Updated ${nombre} -> Code ${codigo}: ${updated} rows affected.`);
        }
    } catch (error) {
        console.error('Error updating codes:', error);
    } finally {
        await db.sequelize.close();
    }
}

updateCodes();
