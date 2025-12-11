const db = require('./src/models');

async function debugAssociations() {
    try {
        await db.sequelize.authenticate();
        console.log('DB Connected.');

        // 1. Check raw values in RegistroContable
        const registros = await db.RegistroContable.findAll({ limit: 5 });
        console.log('--- Raw RegistroContable Records ---');
        registros.forEach(r => {
            console.log(`ID: ${r.id_registro}, id_cuenta: ${r.id_cuenta}, id_tipo_mov: ${r.id_tipo_mov}`);
        });

        // 2. Check available IDs in NombreCuenta
        const cuentas = await db.NombreCuenta.findAll();
        console.log('\n--- Available NombreCuenta IDs ---');
        cuentas.forEach(c => {
            console.log(`ID: ${c.id_cuenta}, Nombre: ${c.nombre}, Codigo: ${c.codigo}`);
        });

        // 3. Check available IDs in TipoMovimiento
        const tipos = await db.TipoMovimiento.findAll();
        console.log('\n--- Available TipoMovimiento IDs ---');
        tipos.forEach(t => {
            console.log(`ID: ${t.id_tipo_mov}, Tipo: ${t.tipo}`);
        });

        // 4. Test Association
        console.log('\n--- Tesing Include ---');
        const fullTest = await db.RegistroContable.findOne({
            include: [
                { model: db.NombreCuenta },
                { model: db.TipoMovimiento }
            ]
        });
        console.log('Full Record JSON:', JSON.stringify(fullTest.toJSON(), null, 2));


    } catch (error) {
        console.error('Error:', error);
    } finally {
        await db.sequelize.close();
    }
}

debugAssociations();
