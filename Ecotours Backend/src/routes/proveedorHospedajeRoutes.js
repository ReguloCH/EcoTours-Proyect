const express = require('express');
const router = express.Router();
const controller = require('../controllers/proveedorHospedajeController');
const { body } = require('express-validator');

const validaciones = [
  body('nombre_hospedaje').notEmpty().withMessage('El nombre es obligatorio'),
  body('id_tipo_hospedaje').isInt().withMessage('Tipo de hospedaje debe ser numérico'),
  body('id_ciudad_hospedaje').isInt().withMessage('Ciudad debe ser numérica'),
  body('direccion_hospedaje').notEmpty().withMessage('La dirección es obligatoria'),
  body('telefono_hospedaje').matches(/^\d{11}$/).withMessage('Teléfono debe tener 11 dígitos'),
  body('correo_hospedaje').isEmail().withMessage('Correo inválido'),
  body('id_estado_proveedor').isInt().withMessage('Estado proveedor debe ser numérico'),
  body('fecha_registro_hospedaje').isDate().withMessage('Fecha inválida')
];


router.get('/', controller.getAll);
router.get('/:id', controller.getById);
router.post('/', controller.create);
router.put('/:id', controller.update);
router.delete('/:id', controller.delete);

module.exports = router;