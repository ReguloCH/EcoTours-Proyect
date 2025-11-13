// src/models/proveedorHospedaje.js
const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const ProveedorHospedaje = sequelize.define('ProveedorHospedaje', {
    id_hospedaje: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    nombre_hospedaje: {
        type: DataTypes.STRING(150),
        allowNull: false,
    },
    id_tipo_hospedaje: {
        type: DataTypes.INTEGER, // FK a tipo_hospedaje
        allowNull: false,
    },
    id_ciudad_hospedaje: {
        type: DataTypes.INTEGER, // FK a ciudad_hospedaje
        allowNull: false,
    },
    direccion_hospedaje: {
        type: DataTypes.STRING(255),
        allowNull: true,
    },
    // ... otros campos de contacto ...
    id_estado_proveedor: {
        type: DataTypes.INTEGER, // FK a estado_proveedores
        allowNull: false,
    },
    fecha_registro_hospedaje: {
        type: DataTypes.DATEONLY,
        allowNull: true,
    },
}, {
    tableName: 'proveedores_hospedaje',
    timestamps: false,
});

module.exports = ProveedorHospedaje;