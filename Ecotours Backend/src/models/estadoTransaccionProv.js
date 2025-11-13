const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const EstadoTransaccionProv = sequelize.define('EstadoTransaccionProv', {
    id_estado_transaccion_PROV: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    estado_transaccion_PROV: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
}, {
    tableName: 'estado_transaccion_PROV',
    timestamps: false,
});

module.exports = EstadoTransaccionProv;