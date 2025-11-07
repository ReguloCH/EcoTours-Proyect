const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const DestinoManejado = sequelize.define('DestinoManejado', {
    id_destino: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    nombre_destino: {
        type: DataTypes.STRING(100),
        allowNull: false,
    },
}, {
    tableName: 'destinos_manejados',
    timestamps: false,
});

module.exports = DestinoManejado;