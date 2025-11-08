const Usuario = require('../models/usuario');
console.log('Modelo Usuario:', Usuario);


// Crear usuario con validaciones
exports.crearUsuario = async (req, res) => {
  const {
    cedula_usuario,
    nombre_usuario,
    apellido_usuario,
    telefono_usuario,
    correo_usuario,
    contraseña_usuario
  } = req.body;

  if (!cedula_usuario || !nombre_usuario || !apellido_usuario || !telefono_usuario || !correo_usuario || !contraseña_usuario) {
    return res.status(400).json({ error: 'Todos los campos son obligatorios.' });
  }

  if (!/^\d{7,8}$/.test(cedula_usuario)) {
    return res.status(400).json({ error: 'La cédula debe tener 7 u 8 dígitos numéricos.' });
  }

  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo_usuario)) {
    return res.status(400).json({ error: 'El formato del correo no es válido.' });
  }

  if (contraseña_usuario.length < 6) {
    return res.status(400).json({ error: 'La contraseña debe tener al menos 6 caracteres.' });
  }

  try {
    const existente = await Usuario.findOne({ where: { cedula_usuario } });
    if (existente) {
      return res.status(409).json({ error: 'Ya existe un usuario con esa cédula.' });
    }

    const nuevoUsuario = await Usuario.create(req.body);
    res.status(201).json(nuevoUsuario);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }

};

// Obtener todos los usuarios
exports.obtenerUsuarios = async (req, res) => {
  try {
    const usuarios = await Usuario.findAll();
    if (usuarios.length === 0) {
      return res.status(404).json({ mensaje: 'No hay usuarios registrados.' });
    }
    res.json(usuarios);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Actualizar usuario 
exports.actualizarUsuario = async (req, res) => {
  const cedula = req.params.cedula;
  const {
    nombre_usuario,
    apellido_usuario,
    telefono_usuario,
    correo_usuario,
    contraseña_usuario
  } = req.body;

  if (!nombre_usuario && !apellido_usuario && !telefono_usuario && !correo_usuario && !contraseña_usuario) {
    return res.status(400).json({ error: 'Debes enviar al menos un campo para actualizar.' });
  }

  if (correo_usuario && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo_usuario)) {
    return res.status(400).json({ error: 'El formato del correo no es válido.' });
  }

  if (contraseña_usuario && contraseña_usuario.length < 6) {
    return res.status(400).json({ error: 'La contraseña debe tener al menos 6 caracteres.' });
  }

  try {
    const usuario = await Usuario.findOne({ where: { cedula_usuario: cedula } });
    if (!usuario) {
      return res.status(404).json({ error: 'Usuario no encontrado.' });
    }

    await Usuario.update(req.body, { where: { cedula_usuario: cedula } });
    res.json({ mensaje: 'Usuario actualizado correctamente.' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Eliminar usuario
exports.eliminarUsuario = async (req, res) => {
  const cedula = req.params.cedula;

  try {
    const usuario = await Usuario.findOne({ where: { cedula_usuario: cedula } });
    if (!usuario) {
      return res.status(404).json({ error: 'Usuario no encontrado.' });
    }

    await Usuario.destroy({ where: { cedula_usuario: cedula } });
    res.json({ mensaje: 'Usuario eliminado correctamente.' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};