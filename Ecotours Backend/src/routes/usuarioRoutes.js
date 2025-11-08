const express = require('express');
const router = express.Router();
const usuarioController = require('../controllers/usuarioController');

router.post('/', usuarioController.crearUsuario);
router.get('/', usuarioController.obtenerUsuarios);
router.put('/:cedula', usuarioController.actualizarUsuario);
router.delete('/:cedula', usuarioController.eliminarUsuario);
console.log('Rutas de usuario cargadas');

module.exports = router;