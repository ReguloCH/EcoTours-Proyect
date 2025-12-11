const db = require('./src/models');

async function debugUserRelation() {
    try {
        await db.sequelize.authenticate();
        console.log('DB Connected.');

        const factura = await db.FacturaCliente.findOne({
            include: [
                { model: db.Usuario } // Include all attributes to be sure
            ]
        });

        if (!factura) {
            console.log('No facturas found to test.');
            return;
        }

        console.log('Factura ID:', factura.id_factura);
        console.log('Cedula Usuario in Invoice:', factura.cedula_usuario);

        // Check if property exists in various casings
        console.log('factura.Usuario:', factura.Usuario ? JSON.stringify(factura.Usuario.toJSON()) : 'undefined');
        console.log('factura.usuario:', factura.usuario ? JSON.stringify(factura.usuario.toJSON()) : 'undefined');

        // Check raw data
        console.log('Raw JSON:', JSON.stringify(factura.toJSON(), null, 2));

    } catch (error) {
        console.error('Error:', error);
    } finally {
        await db.sequelize.close();
    }
}

debugUserRelation();
