const { DataTypes } = require('sequelize');
const { sequelize } = require('../config/db'); 

const PaqueteTuristico = sequelize.define('PaqueteTuristico', {
    id_paquete: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false,
    },
    cantidad_personas: {
        type: DataTypes.INTEGER,
        allowNull: false,
        validate: {
        min: 1,
        isInt: true
        }
    },
    destino_paquete: {
        type: DataTypes.STRING(150),
        allowNull: false,
        validate: {
        len: [3, 150]
        }
    },
    duracion_paquete: {
        type: DataTypes.STRING(50), 
        allowNull: false,
        validate: {
        notEmpty: true
        }
    },
    descripcion_paquete: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    subtotal: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
        validate: {
        min: 0
        }
    },
    total_con_iva: {
        type: DataTypes.DECIMAL(10, 2),
        allowNull: false,
        validate: {
        min: 0
        }
    },
    id_tarifa_aerolinea: {
        type: DataTypes.INTEGER, 
        allowNull: true, 
    },
    id_tarifa_hospedaje: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
    id_tarifa_restaurante: {
        type: DataTypes.INTEGER,
        allowNull: true,
    },
}, {
    tableName: 'paquete_turistico',
    timestamps: false,
});

module.exports = PaqueteTuristico;