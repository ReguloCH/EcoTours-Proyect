const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const TarifaPorDestino = sequelize.define('TarifaPorDestino', {
    id_tarifa_aerolinea: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    codigo_aerolinea: {
        type: DataTypes.STRING(10), 
        allowNull: false,
    },
    id_destino: {
        type: DataTypes.INTEGER, 
        allowNull: false,
    },
    precio_vuelos: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
    },
}, {
    tableName: 'tarifa_por_destino',
    timestamps: false,
});

module.exports = TarifaPorDestino;