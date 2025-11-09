const express = require('express');
const router = express.Router();
const controller = require('../controllers/tarifaPorDestinoController');
const { body } = require('express-validator');


const validaciones = [
  body('codigo_aerolinea').notEmpty().withMessage('Código de aerolínea es obligatorio'),
  body('id_destino').isInt().withMessage('ID de destino debe ser numérico'),
  body('precio_vuelos').isFloat({ min: 0 }).withMessage('Precio debe ser un número positivo'),
  body('fecha_inicio').isDate().withMessage('Fecha de inicio inválida'),
  body('fecha_fin').isDate().withMessage('Fecha de fin inválida')
];


router.get('/', controller.getAll);
router.get('/:id', controller.getById);
router.post('/', validaciones, controller.create);
router.put('/:id', validaciones, controller.update);
router.delete('/:id', controller.delete);

module.exports = router;