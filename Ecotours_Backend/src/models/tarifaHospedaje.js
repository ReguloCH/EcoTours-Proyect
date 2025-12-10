const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const TarifaHospedaje = sequelize.define('TarifaHospedaje', {
    id_tarifa_hospedaje: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    id_hospedaje: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    precio_por_dia: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
    },
}, {
    tableName: 'tarifa_hospedaje',
    timestamps: false,
});

module.exports = TarifaHospedaje;