const db = require('./src/models');

async function testMovimientos() {
    try {
        console.log('Connecting...');
        await db.sequelize.authenticate();

        console.log('Querying RegistroContable...');
        const movimientos = await db.RegistroContable.findAll({
            include: [
                { model: db.NombreCuenta, attributes: ['nombre', 'tipo'] },
                { model: db.TipoMovimiento, attributes: ['tipo'] }
            ],
            limit: 5
        });

        console.log(`Found ${movimientos.length} records.`);

        if (movimientos.length > 0) {
            const m = movimientos[0];
            console.log('First record ID:', m.id_registro);

            // Check property names for associations
            console.log('m.NombreCuenta:', JSON.stringify(m.NombreCuenta));
            console.log('m.nombreCuenta:', JSON.stringify(m.nombreCuenta));

            console.log('m.TipoMovimiento:', JSON.stringify(m.TipoMovimiento));
            console.log('m.tipoMovimiento:', JSON.stringify(m.tipoMovimiento));

            console.log('Full JSON:', JSON.stringify(m.toJSON(), null, 2));
        } else {
            // Check if tables allow insertion or seed data is missing
            const cuentasCount = await db.NombreCuenta.count();
            console.log(`Total Cuentas: ${cuentasCount}`);
            const tiposCount = await db.TipoMovimiento.count();
            console.log(`Total Tipos Mov: ${tiposCount}`);
        }

    } catch (error) {
        console.error('Error:', error);
    } finally {
        await db.sequelize.close();
    }
}

testMovimientos();
