const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const FacturaCliente = sequelize.define('FacturaCliente', {
    id_factura: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    cédula_usuario: {
        type: DataTypes.INTEGER, 
        allowNull: false,
    },
    id_paquete: {
        type: DataTypes.INTEGER, 
        allowNull: false,
    },
    id_metodoP: {
        type: DataTypes.INTEGER, 
        allowNull: false,
    },
    fecha_inicio_viaje: {
        type: DataTypes.DATEONLY,
        allowNull: true,
    },
    fecha_fin_viaje: {
        type: DataTypes.DATEONLY,
        allowNull: true,
    },

    monto_pagado: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
    },
    fecha_pago: {
        type: DataTypes.DATEONLY,
        allowNull: false,
    },
    num_referencia: {
        type: DataTypes.STRING(50),
        allowNull: true,
    },
    banco_origen: {
        type: DataTypes.STRING(100),
        allowNull: true,
    },
    comentario_adicional: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    id_estado_transaccion: {
        type: DataTypes.INTEGER, // FK a estado_transaccion
        allowNull: false,
    },
}, {
    tableName: 'factura_cliente',
    timestamps: false,
});

module.exports = FacturaCliente;