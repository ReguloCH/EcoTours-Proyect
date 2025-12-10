const bcrypt = require('bcrypt');
const SALT_ROUNDS = 10;

module.exports = {
    encriptarContraseña: async (contraseñaPlana) => {
        return await bcrypt.hash(contraseñaPlana, SALT_ROUNDS);
    },

    compararContraseñas: async (contraseñaPlana, contraseñaEncriptada) => {
        return await bcrypt.compare(contraseñaPlana, contraseñaEncriptada);
    }
};

