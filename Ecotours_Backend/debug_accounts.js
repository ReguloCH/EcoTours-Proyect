const db = require('./src/models');

async function checkAccounts() {
    try {
        const cuentas = await db.NombreCuenta.findAll();
        console.log("--- Existing Accounts ---");
        cuentas.forEach(c => {
            console.log(`${c.id_cuenta} | ${c.codigo} | ${c.nombre}`);
        });
    } catch (error) {
        console.error("Error:", error);
    } finally {
        await db.sequelize.close();
    }
}

checkAccounts();
