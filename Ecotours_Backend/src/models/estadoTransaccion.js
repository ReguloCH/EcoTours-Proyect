const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const EstadoTransaccion = sequelize.define('EstadoTransaccion', {
    id_estado_transaccion: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    estado_transaccion: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
}, {
    tableName: 'estado_transaccion',
    timestamps: false,
});

module.exports = EstadoTransaccion;