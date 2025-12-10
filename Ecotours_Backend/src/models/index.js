const { sequelize } = require('../config/db');
const { DataTypes } = require('sequelize');
// IMPORTACIÓN DE TODOS LOS 19 MODELOS
// Claves Principales
const Usuario = require('./usuario');
const PaqueteTuristico = require('./paqueteTuristico');
const FacturaCliente = require('./facturaCliente');
const RegistroEgresos = require('./registroEgresos');
// Proveedores
const ProveedorAerolinea = require('./proveedorAerolinea');
const ProveedorHospedaje = require('./proveedorHospedaje');
const ProveedorRestaurante = require('./proveedorRestaurante');
// Tarifas
const TarifaPorDestino = require('./tarifaPorDestino');
const TarifaHospedaje = require('./tarifaHospedaje');
const TarifaRestaurante = require('./tarifaRestaurante');
// Catálogos
const CiudadBase = require('./ciudadBase');
const CiudadHospedaje = require('./ciudadHospedaje');
const CiudadRestaurante = require('./ciudadRestaurante');
const DestinoManejado = require('./destinoManejado');
const EstadoProveedor = require('./estadoProveedor');
const EstadoTransaccion = require('./estadoTransaccion');
const EstadoTransaccionProv = require('./estadoTransaccionProv');
const MetodoPago = require('./metodoPago');
const TipoHospedaje = require('./tipoHospedaje');

// CONTABILIDAD
const TipoMovimiento = require('./tipoMovimiento');
const NombreCuenta = require('./nombreCuenta');
const RegistroContable = require('./registroContable');

// POR AQUI, TENEMOS DEFINICIÓN DE RELACIONES
// RELACIONES DE TRANSACCIÓN: FACTURA_CLIENTE
FacturaCliente.belongsTo(Usuario, { foreignKey: 'cedula_usuario' });
Usuario.hasMany(FacturaCliente, { foreignKey: 'cedula_usuario' });

FacturaCliente.belongsTo(PaqueteTuristico, { foreignKey: 'id_paquete' });
PaqueteTuristico.hasMany(FacturaCliente, { foreignKey: 'id_paquete' });

FacturaCliente.belongsTo(MetodoPago, { foreignKey: 'id_metodoP' });
FacturaCliente.belongsTo(EstadoTransaccion, { foreignKey: 'id_estado_transaccion' });
// RELACIONES DE CONTABILIDAD: REGISTRO_EGRESOS

RegistroEgresos.belongsTo(FacturaCliente, { foreignKey: 'id_factura' });
FacturaCliente.hasMany(RegistroEgresos, { foreignKey: 'id_factura' });
RegistroEgresos.belongsTo(EstadoTransaccionProv, { foreignKey: 'id_estado_transaccion_PROV' });

// RELACIONES DE CONTABILIDAD: REGISTRO_CONTABLE
RegistroContable.belongsTo(FacturaCliente, { foreignKey: 'id_factura' });
RegistroContable.belongsTo(NombreCuenta, { foreignKey: 'id_cuenta' });
RegistroContable.belongsTo(TipoMovimiento, { foreignKey: 'id_tipo_mov' });

// RELACIONES DE PROVEEDORES Y CATÁLOGOS
// Los tres tipos de proveedores se asocian a EstadoProveedor y a sus respectivas ciudades/tipos.
ProveedorAerolinea.belongsTo(EstadoProveedor, { foreignKey: 'id_estado_proveedor' });
ProveedorAerolinea.belongsTo(CiudadBase, { foreignKey: 'id_ciudad_base' });

ProveedorHospedaje.belongsTo(EstadoProveedor, { foreignKey: 'id_estado_proveedor' });
ProveedorHospedaje.belongsTo(TipoHospedaje, { foreignKey: 'id_tipo_hospedaje' });
ProveedorHospedaje.belongsTo(CiudadHospedaje, { foreignKey: 'id_ciudad_hospedaje' });

ProveedorRestaurante.belongsTo(EstadoProveedor, { foreignKey: 'id_estado_proveedor' });
ProveedorRestaurante.belongsTo(CiudadRestaurante, { foreignKey: 'id_ciudad_restaurante' });
// RELACIONES DE TARIFAS
TarifaPorDestino.belongsTo(ProveedorAerolinea, { foreignKey: 'codigo_aerolinea' });
ProveedorAerolinea.hasMany(TarifaPorDestino, { foreignKey: 'codigo_aerolinea' });
TarifaPorDestino.belongsTo(DestinoManejado, { foreignKey: 'id_destino' });

TarifaHospedaje.belongsTo(ProveedorHospedaje, { foreignKey: 'id_hospedaje' });
ProveedorHospedaje.hasMany(TarifaHospedaje, { foreignKey: 'id_hospedaje' });

TarifaRestaurante.belongsTo(ProveedorRestaurante, { foreignKey: 'id_restaurante' });
ProveedorRestaurante.hasMany(TarifaRestaurante, { foreignKey: 'id_restaurante' });


// RELACIONES PAQUETE_TURISTICO 
PaqueteTuristico.belongsTo(TarifaPorDestino, { foreignKey: 'id_tarifa_aerolinea' });
PaqueteTuristico.belongsTo(TarifaHospedaje, { foreignKey: 'id_tarifa_hospedaje' });
PaqueteTuristico.belongsTo(TarifaRestaurante, { foreignKey: 'id_tarifa_restaurante' });

// --- 3. EXPORTAR OBJETO 'db' ---
const db = {};
db.sequelize = sequelize;
db.Usuario = Usuario;
db.PaqueteTuristico = PaqueteTuristico;
db.FacturaCliente = FacturaCliente;
db.RegistroEgresos = RegistroEgresos;
db.ProveedorAerolinea = ProveedorAerolinea;
db.ProveedorHospedaje = ProveedorHospedaje;
db.ProveedorRestaurante = ProveedorRestaurante;
db.TarifaPorDestino = TarifaPorDestino;
db.TarifaHospedaje = TarifaHospedaje;
db.TarifaRestaurante = TarifaRestaurante;
db.CiudadBase = CiudadBase;
db.CiudadHospedaje = CiudadHospedaje;
db.CiudadRestaurante = CiudadRestaurante;
db.DestinoManejado = DestinoManejado;
db.EstadoProveedor = EstadoProveedor;
db.EstadoTransaccion = EstadoTransaccion;
db.EstadoTransaccionProv = EstadoTransaccionProv;
db.MetodoPago = MetodoPago;
db.TipoHospedaje = TipoHospedaje;

db.TipoMovimiento = TipoMovimiento;
db.NombreCuenta = NombreCuenta;
db.RegistroContable = RegistroContable;

module.exports = db;