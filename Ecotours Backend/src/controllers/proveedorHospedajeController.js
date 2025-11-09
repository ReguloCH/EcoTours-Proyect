const db = require('../models');
const ProveedorHospedaje = db.ProveedorHospedaje;
const { validationResult } = require('express-validator');

//GET: Obtener todos los hospedajes con sus tarifas asociadas
exports.getAll = async (req, res) => {
  try {
    const hospedajes = await ProveedorHospedaje.findAll({ include: db.TarifaHospedaje });
    res.json(hospedajes);
  } catch (error) {
    res.status(500).json({ error: 'Error al obtener hospedajes', detalle: error.message });
  }
};

//GET: Obtener un hospedaje por ID
exports.getById = async (req, res) => {
  try {
    const hospedaje = await ProveedorHospedaje.findByPk(req.params.id, { include: db.TarifaHospedaje });
    if (!hospedaje) return res.status(404).json({ error: 'Hospedaje no encontrado' });
    res.json(hospedaje);
  } catch (error) {
    res.status(500).json({ error: 'Error al buscar hospedaje', detalle: error.message });
  }
};

//POST: Crear nuevo hospedaje con validación
exports.create = async (req, res) => {
  const errores = validationResult(req);
  if (!errores.isEmpty()) return res.status(400).json({ errores: errores.array() });

  try {
    const nuevo = await ProveedorHospedaje.create(req.body);
    res.status(201).json(nuevo);
  } catch (error) {
    res.status(500).json({ error: 'Error al crear hospedaje', detalle: error.message });
  }
};

//PUT: Actualizar hospedaje existente
exports.update = async (req, res) => {
  const errores = validationResult(req);
  if (!errores.isEmpty()) return res.status(400).json({ errores: errores.array() });

  try {
    const actualizado = await ProveedorHospedaje.update(req.body, {
      where: { id_hospedaje: req.params.id }
    });
    res.json({ mensaje: 'Hospedaje actualizado', actualizado });
  } catch (error) {
    res.status(500).json({ error: 'Error al actualizar hospedaje', detalle: error.message });
  }
};

//DELETE: Eliminar hospedaje por ID
exports.delete = async (req, res) => {
  try {
    await ProveedorHospedaje.destroy({ where: { id_hospedaje: req.params.id } });
    res.json({ mensaje: 'Hospedaje eliminado' });
  } catch (error) {
    res.status(500).json({ error: 'Error al eliminar hospedaje', detalle: error.message });
  }
};

