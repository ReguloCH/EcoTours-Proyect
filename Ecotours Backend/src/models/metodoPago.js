//gestion de los metodos de pago usados por el clientee
const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const MetodoPago = sequelize.define('MetodoPago', {
    id_metodoP: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    tipo_metodo: {
        type: DataTypes.STRING(50),
        allowNull: false,
    },
}, {
    tableName: 'metodo_pago',
    timestamps: false,
});

module.exports = MetodoPago;