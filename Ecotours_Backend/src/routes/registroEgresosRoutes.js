const express = require('express');
const router = express.Router();
const controller = require('../controllers/registroEgresosController');
const { body } = require('express-validator');

const validaciones = [
  body('id_factura').isInt().withMessage('ID de factura debe ser numérico'),
  body('monto_egreso').isFloat({ min: 0 }).withMessage('Monto debe ser un número positivo'),
  body('fecha_egreso').isDate().withMessage('Fecha inválida'),
  body('id_estado_transaccion_PROV').isInt().withMessage('Estado transacción proveedor debe ser numérico')
];


router.get('/', controller.getAll);
router.get('/:id', controller.getById);
router.post('/', controller.create);
router.put('/:id', controller.update);
router.delete('/:id', controller.delete);

module.exports = router;