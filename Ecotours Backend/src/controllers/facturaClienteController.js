const db = require('../models');
const FacturaCliente = db.FacturaCliente;
const Usuario = db.Usuario;
const PaqueteTuristico = db.PaqueteTuristico;
const MetodoPago = db.MetodoPago;
const EstadoTransaccion = db.EstadoTransaccion;

exports.getAll = async (req, res) => {
  const facturas = await FacturaCliente.findAll({
    include: [Usuario, PaqueteTuristico, MetodoPago, EstadoTransaccion]
  });
  res.json(facturas);
};

exports.getById = async (req, res) => {
  const factura = await FacturaCliente.findByPk(req.params.id, {
    include: [Usuario, PaqueteTuristico, MetodoPago, EstadoTransaccion]
  });
  factura ? res.json(factura) : res.status(404).json({ error: 'Factura no encontrada' });
};

exports.create = async (req, res) => {
  const nueva = await FacturaCliente.create(req.body);
  res.status(201).json(nueva);
};

exports.update = async (req, res) => {
  await FacturaCliente.update(req.body, { where: { id_factura: req.params.id } });
  res.json({ mensaje: 'Factura actualizada' });
};

exports.delete = async (req, res) => {
  await FacturaCliente.destroy({ where: { id_factura: req.params.id } });
  res.json({ mensaje: 'Factura eliminada' });
};