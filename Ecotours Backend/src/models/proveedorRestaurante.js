// src/models/proveedorRestaurante.js
const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const ProveedorRestaurante = sequelize.define('ProveedorRestaurante', {
    id_restaurante: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    nombre_restaurante: {
        type: DataTypes.STRING(150),
        allowNull: false,
    },
    horario_servicio: {
        type: DataTypes.STRING(50),
        allowNull: true, 
    },
    incluye_bebidas: {
        type: DataTypes.BOOLEAN, 
        allowNull: true,
    },
    id_ciudad_restaurante: {
        type: DataTypes.INTEGER, 
        allowNull: false,
    },
    direccion_restaurante: {
        type: DataTypes.STRING(255),
        allowNull: true,
    },
    telefono_restaurante: {
        type: DataTypes.STRING(20),
        allowNull: true,
    },
    correo_restaurante: {
        type: DataTypes.STRING(100),
        allowNull: true,
    },
    id_estado_proveedor: {
        type: DataTypes.INTEGER, 
        allowNull: false,
    },
    fecha_registro_restaurante: {
        type: DataTypes.DATEONLY, 
        allowNull: true,
    },
}, {
    tableName: 'PROVEEDORES_RESTAURANTES', 
    timestamps: false,
});

module.exports = ProveedorRestaurante;