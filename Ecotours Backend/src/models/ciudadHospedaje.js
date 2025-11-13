// src/models/ciudadHospedaje.js
const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const CiudadHospedaje = sequelize.define('CiudadHospedaje', {
    id_ciudad_hospedaje: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    ciudad_hospedaje: {
        type: DataTypes.STRING(100),
        allowNull: false,
    },
}, {
    tableName: 'ciudad_hospedaje',
    timestamps: false,
});

module.exports = CiudadHospedaje;