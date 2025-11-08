const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 


const Usuario = sequelize.define('Usuario', {

    cedula_usuario: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        allowNull: false,
    },

    nombre_usuario: {
        type: DataTypes.STRING(100),
        allowNull: false,
    },

    apellido_usuario: {
        type: DataTypes.STRING(100),
        allowNull: false,
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

    contraseña_usuario: {
        type: DataTypes.STRING(255), 
        allowNull: false,
    },

}, {
    tableName: 'usuario', 
    timestamps: false,    
});

module.exports = Usuario;




