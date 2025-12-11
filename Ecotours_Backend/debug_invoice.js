const db = require('./src/models');

async function debugInvoice() {
    try {
        await db.sequelize.authenticate();
        console.log('DB Connected.');

        // 1. Check if User Exists
        const cedula = 'V-15876543'; // The one hardcoded in validacion
        const user = await db.Usuario.findByPk(cedula);
        console.log(`User ${cedula} exists?`, !!user);

        if (!user) {
            console.log('Creating dummy user...');
            await db.Usuario.create({
                cedula_usuario: cedula,
                nombre: 'Juan',
                apellido: 'Perez',
                telefono: '04121234567',
                email: 'juan@test.com', // Check exact field name in model
                direccion: 'Caracas',
                id_rol: 1 // Assuming 1 exists or role logic
            }).catch(e => console.error('Error creating user:', e.message));
        }

        // 2. Check Accounts
        const caja = await db.NombreCuenta.findOne({ where: { nombre: 'Efectivo en bancos' } });
        console.log('Cuenta Efectivo exists?', !!caja);

        // 3. Dry Run Invoice Creation (Simulated)
        // We won't actually create it to avoid clutter, or we can try and expect it to work
        if (user && caja) {
            console.log('Dependencies met. The API failure might be due to something else if this passes.');
        }

    } catch (error) {
        console.error('Debug Error:', error);
    } finally {
        await db.sequelize.close();
    }
}

debugInvoice();
