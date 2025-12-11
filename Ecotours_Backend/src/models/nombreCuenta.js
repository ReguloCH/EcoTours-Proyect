const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const NombreCuenta = sequelize.define('NombreCuenta', {
    id_cuenta: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
    },
    codigo: {
        type: DataTypes.STRING(20),
        allowNull: true
    },
    nombre: {
        type: DataTypes.STRING(50),
        allowNull: false
    },
    tipo: {
        type: DataTypes.STRING(20), // 'Activo', 'Pasivo', 'Ingreso', 'Gasto', etc.
        allowNull: false
    }
}, {
    tableName: 'nombre_cuenta',
    timestamps: false
});

module.exports = NombreCuenta;
