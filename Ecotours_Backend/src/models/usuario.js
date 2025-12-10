const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const Usuario = sequelize.define('usuario', {
    cedula_usuario: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        allowNull: false,
    },

    nombre_usuario: {
        type: DataTypes.STRING(100),
        allowNull: false,
    },

    direccion_usuario: {
        type: DataTypes.STRING(100),
        allowNull: true,
    },

    telefono_usuario: {
        type: DataTypes.STRING(20),
        allowNull: true,
    },

    correo_usuario: {
        type: DataTypes.STRING(100),
        allowNull: false,
        unique: true, 
    },

    user_usuario: {
        type: DataTypes.STRING(50), 
        allowNull: false,
    },

    contraseña_usuario: {
        type: DataTypes.STRING(255), 
        allowNull: false,
    },

     admin_usuario: {
        type: DataTypes.BOOLEAN(), 
        allowNull: true,
    }
}, {
    tableName: 'usuario', 
    timestamps: false, 
});

module.exports = Usuario;