const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const RegistroEgresos = sequelize.define('RegistroEgresos', {
    id_egreso: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    id_factura: {
        type: DataTypes.INTEGER, 
        allowNull: false,
    },
    tipo_PROV: {
        type: DataTypes.STRING(20), 
        allowNull: false,
    },
    proveedor_id_fk: {
        type: DataTypes.STRING(10), 
        allowNull: false,
    },
    monto_A_pagar: {
        type: DataTypes.DECIMAL(10, 2), 
        allowNull: false,
    },
    fecha_generacion: {
        type: DataTypes.DATEONLY,
        allowNull: false,
    },
    fecha_pago_real: {
        type: DataTypes.DATEONLY,
        allowNull: true, 
    },
    numReferenciaPago: {
        type: DataTypes.STRING(50),
        allowNull: true,
    },
    id_estado_transaccion_PROV: {
        type: DataTypes.INTEGER, 
        allowNull: false,
    },
}, {
    tableName: 'registro_egresos',
    timestamps: false,
});

module.exports = RegistroEgresos;