const express = require('express');
const router = express.Router();
const controller = require('../controllers/proveedorRestauranteController');
const { body } = require('express-validator');

const validaciones = [
  body('nombre_restaurante').notEmpty().withMessage('El nombre es obligatorio'),
  body('id_ciudad_restaurante').isInt().withMessage('Ciudad debe ser numérica'),
  body('direccion_restaurante').notEmpty().withMessage('La dirección es obligatoria'),
  body('telefono_restaurante').matches(/^\d{11}$/).withMessage('Teléfono debe tener 11 dígitos'),
  body('correo_restaurante').isEmail().withMessage('Correo inválido'),
  body('id_estado_proveedor').isInt().withMessage('Estado proveedor debe ser numérico'),
  body('fecha_registro_restaurante').isDate().withMessage('Fecha inválida')
];


router.get('/', controller.getAll);
router.get('/:id', controller.getById);
router.post('/', controller.create);
router.put('/:id', controller.update);
router.delete('/:id', controller.delete);

module.exports = router;