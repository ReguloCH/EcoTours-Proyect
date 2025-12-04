const express = require('express');
const router = express.Router();
const paqueteController = require('../controllers/paqueteTuristicoController');

router.post('/', paqueteController.crearPaquete);
router.get('/', paqueteController.obtenerPaquetes);
router.put('/:id', paqueteController.actualizarPaquete);
router.delete('/:id', paqueteController.eliminarPaquete);

module.exports = router;