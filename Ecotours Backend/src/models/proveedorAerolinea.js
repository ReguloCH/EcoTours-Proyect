const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const ProveedorAerolinea = sequelize.define('ProveedorAerolinea', {
    codigo_aerolinea: {
        type: DataTypes.STRING(10),
        primaryKey: true,
        allowNull: false,
    },
    nombre_aerolinea: {
        type: DataTypes.STRING(100),
        allowNull: false,
    },
    correo_aerolinea: {
        type: DataTypes.STRING(100),
        allowNull: true,
    },
    telefono_aerolinea: {
        type: DataTypes.STRING(20),
        allowNull: true,
    },
    id_estado_proveedor: {
        type: DataTypes.INTEGER, 
        allowNull: false,
    },
    fecha_registro_aerolinea: {
        type: DataTypes.DATEONLY,
        allowNull: true,
    },
    id_ciudad_base: {
        type: DataTypes.INTEGER, 
        allowNull: true,
    },
}, {
    tableName: 'proveedores_aerolineas',
    timestamps: false,
});

module.exports = ProveedorAerolinea;