const express = require('express');
const router = express.Router();
const usuarioController = require('../controllers/usuarioController');
const { body, param } = require('express-validator');


const validacionesUsuario = [
  body('cédula_usuario').notEmpty().withMessage('La cédula es obligatoria'),
  body('nombre_usuario').notEmpty().withMessage('El nombre es obligatorio'),
  body('apellido_usuario').notEmpty().withMessage('El apellido es obligatorio'),
  body('correo_usuario').isEmail().withMessage('Correo inválido'),
  body('telefono_usuario').matches(/^\d{11}$/).withMessage('Teléfono debe tener 11 dígitos'),
  body('fecha_nacimiento_usuario').isDate().withMessage('Fecha de nacimiento inválida'),
  body('clave_usuario').isLength({ min: 6 }).withMessage('La clave debe tener al menos 6 caracteres')
];

const validarCedula = [
  param('cedula').notEmpty().withMessage('La cédula es obligatoria')
];


router.post('/', usuarioController.crearUsuario);
router.post('/login', usuarioController.login);
router.get('/', usuarioController.obtenerUsuarios);
router.get('/:cedula', usuarioController.buscarUsuarioPorCedula);
router.put('/:cedula', usuarioController.actualizarUsuario);
router.delete('/:cedula', usuarioController.eliminarUsuario);

module.exports = router;