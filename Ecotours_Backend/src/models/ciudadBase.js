// src/models/ciudadBase.js
const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const CiudadBase = sequelize.define('CiudadBase', {
    id_ciudad_base: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    nombre_ciudad_base: {
        type: DataTypes.STRING(100),
        allowNull: false,
    },
}, {
    tableName: 'ciudad_base', // Nombre exacto de la tabla en SQL
    timestamps: false,
});

module.exports = CiudadBase;