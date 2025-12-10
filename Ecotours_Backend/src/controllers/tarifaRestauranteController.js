const db = require('../models');
const TarifaRestaurante = db.TarifaRestaurante;
const { validationResult } = require('express-validator');

//GET: Obtener todas las tarifas con su restaurante asociado
exports.getAll = async (req, res) => {
  try {
    const tarifas = await TarifaRestaurante.findAll({ include: db.ProveedorRestaurante });
    res.json(tarifas);
  } catch (error) {
    res.status(500).json({ error: 'Error al obtener tarifas', detalle: error.message });
  }
};

//GET: Obtener una tarifa por ID
exports.getById = async (req, res) => {
  try {
    const tarifa = await TarifaRestaurante.findByPk(req.params.id, { include: db.ProveedorRestaurante });
    if (!tarifa) return res.status(404).json({ error: 'Tarifa no encontrada' });
    res.json(tarifa);
  } catch (error) {
    res.status(500).json({ error: 'Error al buscar tarifa', detalle: error.message });
  }
};

//POST: Crear nueva tarifa con validación
exports.create = async (req, res) => {
  const errores = validationResult(req);
  if (!errores.isEmpty()) return res.status(400).json({ errores: errores.array() });

  try {
    const nueva = await TarifaRestaurante.create(req.body);
    res.status(201).json(nueva);
  } catch (error) {
    res.status(500).json({ error: 'Error al crear tarifa', detalle: error.message });
  }
};

//PUT: Actualizar tarifa existente
exports.update = async (req, res) => {
  const errores = validationResult(req);
  if (!errores.isEmpty()) return res.status(400).json({ errores: errores.array() });

  try {
    const actualizada = await TarifaRestaurante.update(req.body, {
      where: { id_tarifa_restaurante: req.params.id }
    });
    res.json({ mensaje: 'Tarifa actualizada', actualizada });
  } catch (error) {
    res.status(500).json({ error: 'Error al actualizar tarifa', detalle: error.message });
  }
};

//DELETE: Eliminar tarifa por ID
exports.delete = async (req, res) => {
  try {
    await TarifaRestaurante.destroy({ where: { id_tarifa_restaurante: req.params.id } });
    res.json({ mensaje: 'Tarifa eliminada' });
  } catch (error) {
    res.status(500).json({ error: 'Error al eliminar tarifa', detalle: error.message });
  }
};

