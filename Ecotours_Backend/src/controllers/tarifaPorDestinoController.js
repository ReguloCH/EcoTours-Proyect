const db = require('../models');
const TarifaPorDestino = db.TarifaPorDestino;
const { validationResult } = require('express-validator');

//GET: Obtener todas las tarifas con su aerolínea y destino
exports.getAll = async (req, res) => {
  try {
    const tarifas = await TarifaPorDestino.findAll({
      include: [db.ProveedorAerolinea, db.DestinoManejado]
    });
    res.json(tarifas);
  } catch (error) {
    res.status(500).json({ error: 'Error al obtener tarifas', detalle: error.message });
  }
};

//GET: Obtener una tarifa por ID
exports.getById = async (req, res) => {
  try {
    const tarifa = await TarifaPorDestino.findByPk(req.params.id, {
      include: [db.ProveedorAerolinea, db.DestinoManejado]
    });
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
    const nueva = await TarifaPorDestino.create(req.body);
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
    const actualizada = await TarifaPorDestino.update(req.body, {
      where: { id_tarifa_aerolinea: req.params.id }
    });
    res.json({ mensaje: 'Tarifa actualizada', actualizada });
  } catch (error) {
    res.status(500).json({ error: 'Error al actualizar tarifa', detalle: error.message });
  }
};

//DELETE: Eliminar tarifa por ID
exports.delete = async (req, res) => {
  try {
    await TarifaPorDestino.destroy({ where: { id_tarifa_aerolinea: req.params.id } });
    res.json({ mensaje: 'Tarifa eliminada' });
  } catch (error) {
    res.status(500).json({ error: 'Error al eliminar tarifa', detalle: error.message });
  }
};