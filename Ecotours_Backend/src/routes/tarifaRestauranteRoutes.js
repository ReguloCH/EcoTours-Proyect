const express = require('express');
const router = express.Router();
const controller = require('../controllers/tarifaRestauranteController');
const { body } = require('express-validator');


const validaciones = [
  body('id_restaurante').isInt().withMessage('ID de restaurante debe ser numérico'),
  body('precio_por_dia').isFloat({ min: 0 }).withMessage('Precio debe ser un número positivo'),
  body('fecha_inicio').isDate().withMessage('Fecha de inicio inválida'),
  body('fecha_fin').isDate().withMessage('Fecha de fin inválida')
];

router.get('/', controller.getAll);
router.get('/:id', controller.getById);
router.post('/', validaciones, controller.create);
router.put('/:id', validaciones, controller.update);
router.delete('/:id', controller.delete);

module.exports = router;