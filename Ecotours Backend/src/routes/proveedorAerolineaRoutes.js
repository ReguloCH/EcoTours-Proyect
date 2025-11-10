const express = require('express'); 
const router = express.Router();
const controller = require('../controllers/proveedorAerolineaController'); 
const { body } = require('express-validator'); 


const validaciones = [ 
  body('codigo_aerolinea').notEmpty().withMessage('El código es obligatorio'),
  body('nombre_aerolinea').notEmpty().withMessage('El nombre es obligatorio'),
  body('correo_aerolinea').isEmail().withMessage('Correo inválido'),
  body('telefono_aerolinea').matches(/^\d{11}$/).withMessage('Teléfono debe tener 11 dígitos'),
  body('id_estado_proveedor').isInt().withMessage('Estado proveedor debe ser numérico'),
  body('fecha_registro_aerolinea').isDate().withMessage('Fecha inválida'),
  body('id_ciudad_base').isInt().withMessage('Ciudad base debe ser numérica')
];

router.get('/', controller.getAll);
router.get('/', controller.getById);
router.post('/', validaciones, controller.create);
router.put('/', validaciones, controller.update);
router.delete('/', controller.delete);

module.exports = router;