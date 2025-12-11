const db = require('./src/models');

async function checkData() {
    try {
        await db.sequelize.authenticate();
        const count = await db.RegistroContable.count();
        console.log(`Total Records in RegistroContable: ${count}`);

        if (count > 0) {
            const sample = await db.RegistroContable.findOne({
                include: [{ model: db.NombreCuenta }]
            });
            console.log('Sample Record:', JSON.stringify(sample.toJSON(), null, 2));
        }
    } catch (error) {
        console.error('Error:', error);
    } finally {
        await db.sequelize.close();
    }
}

checkData();
