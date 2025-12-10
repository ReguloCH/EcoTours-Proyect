const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const TarifaRestaurante = sequelize.define('TarifaRestaurante', {
    id_tarifa_restaurante: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    id_restaurante: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    precio_por_dia: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
    },
}, {
    tableName: 'tarifa_restaurante',
    timestamps: false,
});

module.exports = TarifaRestaurante;