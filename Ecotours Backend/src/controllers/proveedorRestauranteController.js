const db = require('../models');
const ProveedorRestaurante = db.ProveedorRestaurante;
const { validationResult } = require('express-validator');

//GET: Obtener todos los restaurantes con sus tarifas asociadas
exports.getAll = async (req, res) => {
  try {
    const restaurantes = await ProveedorRestaurante.findAll({ include: db.TarifaRestaurante });
    res.json(restaurantes);
  } catch (error) {
    res.status(500).json({ error: 'Error al obtener restaurantes', detalle: error.message });
  }
};

//GET: Obtener un restaurante por ID
exports.getById = async (req, res) => {
  try {
    const restaurante = await ProveedorRestaurante.findByPk(req.params.id, { include: db.TarifaRestaurante });
    if (!restaurante) return res.status(404).json({ error: 'Restaurante no encontrado' });
    res.json(restaurante);
  } catch (error) {
    res.status(500).json({ error: 'Error al buscar restaurante', detalle: error.message });
  }
};

//POST: Crear nuevo restaurante con validación
exports.create = async (req, res) => {
  const errores = validationResult(req);
  if (!errores.isEmpty()) return res.status(400).json({ errores: errores.array() });

  try {
    const nuevo = await ProveedorRestaurante.create(req.body);
    res.status(201).json(nuevo);
  } catch (error) {
    res.status(500).json({ error: 'Error al crear restaurante', detalle: error.message });
  }
};

//PUT: Actualizar restaurante existente
exports.update = async (req, res) => {
  const errores = validationResult(req);
  if (!errores.isEmpty()) return res.status(400).json({ errores: errores.array() });

  try {
    const actualizado = await ProveedorRestaurante.update(req.body, {
      where: { id_restaurante: req.params.id }
    });
    res.json({ mensaje: 'Restaurante actualizado', actualizado });
  } catch (error) {
    res.status(500).json({ error: 'Error al actualizar restaurante', detalle: error.message });
  }
};

//DELETE: Eliminar restaurante por ID
exports.delete = async (req, res) => {
  try {
    await ProveedorRestaurante.destroy({ where: { id_restaurante: req.params.id } });
    res.json({ mensaje: 'Restaurante eliminado' });
  } catch (error) {
    res.status(500).json({ error: 'Error al eliminar restaurante', detalle: error.message });
  }
};