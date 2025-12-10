const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db');

const TipoMovimiento = sequelize.define('TipoMovimiento', {
    id_tipo_mov: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
    },
    tipo: {
        type: DataTypes.STRING(20), // 'Ingreso' o 'Egreso'
        allowNull: false
    }
}, {
    tableName: 'tipo_movimiento',
    timestamps: false
});

module.exports = TipoMovimiento;
