// src/models/tipoHospedaje.js
const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const TipoHospedaje = sequelize.define('TipoHospedaje', {
    id_tipo_hospedaje: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    tipo_hospedaje: {
        type: DataTypes.STRING(100),
        allowNull: false,
    },
}, {
    tableName: 'tipo_hospedaje',
    timestamps: false,
});

module.exports = TipoHospedaje;