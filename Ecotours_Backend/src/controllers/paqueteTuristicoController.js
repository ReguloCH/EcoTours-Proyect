const PaqueteTuristico = require('../models/paqueteTuristico');

// Crear paquete turístico
exports.crearPaquete = async (req, res) => {
  const {
    cantidad_personas,
    destino_paquete,
    duracion_paquete,
    descripcion_paquete,
    subtotal,
    total_con_iva,
    id_tarifa_aerolinea,
    id_tarifa_hospedaje,
    id_tarifa_restaurante
  } = req.body;

  if (!cantidad_personas || typeof cantidad_personas !== 'number' || cantidad_personas < 1) {
    return res.status(400).json({ error: 'La cantidad de personas debe ser un número mayor o igual a 1.' });
  }

  if (!destino_paquete || destino_paquete.trim().length < 3) {
    return res.status(400).json({ error: 'El destino debe tener al menos 3 caracteres.' });
  }

  if (!duracion_paquete || duracion_paquete.trim() === '') {
    return res.status(400).json({ error: 'La duración del paquete es obligatoria.' });
  }

  if (subtotal === undefined || isNaN(subtotal) || subtotal < 0) {
    return res.status(400).json({ error: 'El subtotal debe ser un número positivo.' });
  }

  if (total_con_iva === undefined || isNaN(total_con_iva) || total_con_iva < 0) {
    return res.status(400).json({ error: 'El total con IVA debe ser un número positivo.' });
  }

  try {
    const nuevoPaquete = await PaqueteTuristico.create({
      cantidad_personas,
      destino_paquete,
      duracion_paquete,
      descripcion_paquete,
      subtotal,
      total_con_iva,
      id_tarifa_aerolinea,
      id_tarifa_hospedaje,
      id_tarifa_restaurante
    });

    res.status(201).json(nuevoPaquete);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Obtener todos los paquetes turísticos
exports.obtenerPaquetes = async (req, res) => {
  try {
    const paquetes = await PaqueteTuristico.findAll();
    res.json(paquetes);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Actualizar paquete turístico
exports.actualizarPaquete = async (req, res) => {
  const id = req.params.id;

  try {
    const paquete = await PaqueteTuristico.findByPk(id);
    if (!paquete) {
      return res.status(404).json({ error: 'Paquete no encontrado.' });
    }

    await PaqueteTuristico.update(req.body, { where: { id_paquete: id } });
    res.json({ mensaje: 'Paquete actualizado correctamente.' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Eliminar paquete turístico
exports.eliminarPaquete = async (req, res) => {
  const id = req.params.id;

  try {
    const paquete = await PaqueteTuristico.findByPk(id);
    if (!paquete) {
      return res.status(404).json({ error: 'Paquete no encontrado.' });
    }

    await PaqueteTuristico.destroy({ where: { id_paquete: id } });
    res.json({ mensaje: 'Paquete eliminado correctamente.' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};