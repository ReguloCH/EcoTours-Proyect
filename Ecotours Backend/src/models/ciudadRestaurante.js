const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const CiudadRestaurante = sequelize.define('CiudadRestaurante', {
    id_ciudad_restaurante: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    ciudad_restaurante: {
        type: DataTypes.STRING(100),
        allowNull: false,
    },
}, {
    tableName: 'ciudad_restaurante',
    timestamps: false,
});

module.exports = CiudadRestaurante;