const db = require('./src/models');

async function testQuery() {
    try {
        console.log('1. Connecting to DB...');
        await db.sequelize.authenticate();
        console.log('   Connection established.');

        console.log('2. Querying FacturaCliente (simple)...');
        const simple = await db.FacturaCliente.findAll({ limit: 1 });
        console.log(`   Found ${simple.length} simple records.`);

        console.log('3. Running complex query with includes...');
        const facturas = await db.FacturaCliente.findAll({
            include: [
                {
                    model: db.Usuario,
                    attributes: ['nombre_usuario']
                },
                {
                    model: db.PaqueteTuristico,
                    attributes: ['destino_paquete']
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

        console.log(`   Found ${facturas.length} complex records.`);
        if (facturas.length > 0) {
            console.log('   First item structure:', JSON.stringify(facturas[0].toJSON(), null, 2));
        }

    } catch (error) {
        console.error('ERROR OCCURRED:');
        console.error(error.message);
        if (error.original) {
            console.error('Original DB Error:', error.original.sqlMessage || error.original.message);
        }
    } finally {
        await db.sequelize.close();
    }
}

testQuery();
