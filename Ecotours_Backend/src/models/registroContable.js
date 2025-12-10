const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const RegistroContable = sequelize.define('RegistroContable', {
    id_registro: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
    },
    id_factura: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    id_cuenta: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    id_tipo_mov: {
        type: DataTypes.INTEGER,
        allowNull: false
    },
    monto: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false
    },
    fecha_mov: {
        type: DataTypes.DATEONLY,
        allowNull: false
    },
    descripcion: {
        type: DataTypes.STRING(255),
        allowNull: true
    }
}, {
    tableName: 'registro_contable',
    timestamps: false
});

module.exports = RegistroContable;
