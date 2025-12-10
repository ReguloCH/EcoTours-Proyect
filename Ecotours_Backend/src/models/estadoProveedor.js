const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const EstadoProveedor = sequelize.define('EstadoProveedor', {
    id_estado_proveedor: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    estado_proveedor: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
}, {
    tableName: 'estado_proveedores',
    timestamps: false,
});

module.exports = EstadoProveedor;