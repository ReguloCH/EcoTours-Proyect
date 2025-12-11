const db = require('./src/models');

async function seedUser() {
    try {
        await db.sequelize.authenticate();
        console.log('Connecting...');

        const cedula = 15876543; // Integer

        const [user, created] = await db.Usuario.findOrCreate({
            where: { cedula_usuario: cedula },
            defaults: {
                nombre_usuario: 'Juan Pérez',
                direccion_usuario: 'Caracas, Venezuela',
                telefono_usuario: '04121234567',
                correo_usuario: 'juan.perez@email.com',
                user_usuario: 'juanperez',
                contraseña_usuario: '123456', // Insecure but for dev
                admin_usuario: false
            }
        });

        if (created) {
            console.log(`User ${cedula} created successfully.`);
        } else {
            console.log(`User ${cedula} already exists.`);
        }

    } catch (error) {
        console.error('Error seeding user:', error);
    } finally {
        await db.sequelize.close();
    }
}

seedUser();
