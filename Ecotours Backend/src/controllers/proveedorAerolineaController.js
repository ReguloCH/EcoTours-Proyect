const db = require('../models');
const ProveedorAerolinea = db.ProveedorAerolinea;
const { validationResult } = require('express-validator');

// GET: Listar todas las aerolíneas con sus tarifas
exports.getAll = async (req, res) => {
  try {
    const aerolineas = await ProveedorAerolinea.findAll({ include: db.TarifaPorDestino });
    res.json(aerolineas);
  } catch (error) {
    res.status(500).json({ error: 'Error al obtener aerolíneas', detalle: error.message });
  }
};

// GET: Buscar una aerolínea por código
exports.getById = async (req, res) => {
  try {
    const aerolinea = await ProveedorAerolinea.findByPk(req.params.codigo, { include: db.TarifaPorDestino });
    if (!aerolinea) return res.status(404).json({ error: 'Aerolínea no encontrada' });
    res.json(aerolinea);
  } catch (error) {
    res.status(500).json({ error: 'Error al buscar aerolínea', detalle: error.message });
  }
};

// POST: Crear nueva aerolínea con validación
exports.create = async (req, res) => {
  const errores = validationResult(req);
  if (!errores.isEmpty()) return res.status(400).json({ errores: errores.array() });

  try {
    const nueva = await ProveedorAerolinea.create(req.body);
    res.status(201).json(nueva);
  } catch (error) {
    res.status(500).json({ error: 'Error al crear aerolínea', detalle: error.message });
  }
};

// PUT: Actualizar aerolínea existente
exports.update = async (req, res) => {
  const errores = validationResult(req);
  if (!errores.isEmpty()) return res.status(400).json({ errores: errores.array() });

  try {
    const actualizada = await ProveedorAerolinea.update(req.body, {
      where: { codigo_aerolinea: req.params.codigo }
    });
    res.json({ mensaje: 'Aerolínea actualizada', actualizada });
  } catch (error) {
    res.status(500).json({ error: 'Error al actualizar aerolínea', detalle: error.message });
  }
};

// DELETE: Eliminar aerolínea por código
exports.delete = async (req, res) => {
  try {
    await ProveedorAerolinea.destroy({ where: { codigo_aerolinea: req.params.codigo } });
    res.json({ mensaje: 'Aerolínea eliminada' });
  } catch (error) {
    res.status(500).json({ error: 'Error al eliminar aerolínea', detalle: error.message });
  }
};