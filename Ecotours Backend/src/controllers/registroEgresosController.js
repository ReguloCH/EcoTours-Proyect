const db = require('../models');
const RegistroEgresos = db.RegistroEgresos;
const { validationResult } = require('express-validator');

//GET: Obtener todos los egresos con sus relaciones
exports.getAll = async (req, res) => {
  try {
    const egresos = await RegistroEgresos.findAll({
      include: [db.FacturaCliente, db.EstadoTransaccionProv]
    });
    res.json(egresos);
  } catch (error) {
    res.status(500).json({ error: 'Error al obtener egresos', detalle: error.message });
  }
};

//GET: Obtener un egreso por ID
exports.getById = async (req, res) => {
  try {
    const egreso = await RegistroEgresos.findByPk(req.params.id, {
      include: [db.FacturaCliente, db.EstadoTransaccionProv]
    });
    if (!egreso) return res.status(404).json({ error: 'Egreso no encontrado' });
    res.json(egreso);
  } catch (error) {
    res.status(500).json({ error: 'Error al buscar egreso', detalle: error.message });
  }
};

//POST: Crear nuevo egreso con validación
exports.create = async (req, res) => {
  const errores = validationResult(req);
  if (!errores.isEmpty()) return res.status(400).json({ errores: errores.array() });

  try {
    const nuevo = await RegistroEgresos.create(req.body);
    res.status(201).json(nuevo);
  } catch (error) {
    res.status(500).json({ error: 'Error al crear egreso', detalle: error.message });
  }
};

//PUT: Actualizar egreso existente
exports.update = async (req, res) => {
  const errores = validationResult(req);
  if (!errores.isEmpty()) return res.status(400).json({ errores: errores.array() });

  try {
    const actualizado = await RegistroEgresos.update(req.body, {
      where: { id_egreso: req.params.id }
    });
    res.json({ mensaje: 'Egreso actualizado', actualizado });
  } catch (error) {
    res.status(500).json({ error: 'Error al actualizar egreso', detalle: error.message });
  }
};

//DELETE: Eliminar egreso por ID
exports.delete = async (req, res) => {
  try {
    await RegistroEgresos.destroy({ where: { id_egreso: req.params.id } });
    res.json({ mensaje: 'Egreso eliminado' });
  } catch (error) {
    res.status(500).json({ error: 'Error al eliminar egreso', detalle: error.message });
  }
};