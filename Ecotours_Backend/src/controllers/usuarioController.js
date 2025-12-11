const Usuario = require('../models/usuario');
const { encriptarContraseña, compararContraseñas } = require('../utils/encriptador');
const fs = require('fs');
const debugLogFile = require('path').join(__dirname, '..', '..', 'login_debug.log');
function appendDebug(msg) {
  try { fs.appendFileSync(debugLogFile, new Date().toISOString() + ' ' + msg + '\n'); } catch (e) { /* ignore */ }
}
console.log('Modelo Usuario:', Usuario);
appendDebug('Modelo Usuario: ' + (Usuario && Usuario.name ? Usuario.name : String(Usuario)));

// Crear usuario 
exports.crearUsuario = async (req, res) => {
  const {
    cedula_usuario,
    nombre_usuario,
    direccion_usuario,
    correo_usuario,
    telefono_usuario,
    user_usuario,
    contraseña_usuario,
    admin_usuario
  } = req.body;

  if (!cedula_usuario || !nombre_usuario || !direccion_usuario || !telefono_usuario || !correo_usuario || !user_usuario || !contraseña_usuario|| !admin_usuario) {
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

    const contraseñaEncriptada = await encriptarContraseña(contraseña_usuario);

    const nuevoUsuario = await Usuario.create({
      cedula_usuario,
      nombre_usuario,
      direccion_usuario,
      correo_usuario,
      telefono_usuario,
      user_usuario,
      contraseña_usuario: contraseñaEncriptada,
      admin_usuario
    });
    res.status(201).json(nuevoUsuario);
    
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Obtener todos los usuarios
exports.obtenerUsuarios = async (req, res) => {
  try {
    const usuarios = await Usuario.findAll({
    attributes: { exclude: ['contraseña_usuario'] }
   });
      if (usuarios.length === 0) {
        return res.status(404).json({ mensaje: 'No hay usuarios registrados.' });
      }
    res.status(200).json(usuarios);

  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Buscar usuario por cédula
exports.buscarUsuarioPorCedula = async (req, res) => {
  const cedula = req.params.cedula || req.query.cedula;

  if (!cedula) {
    return res.status(400).json({ error: 'Debe proporcionar la cédula del usuario.' });
  }

  if (!/^\d{7,8}$/.test(cedula)) {
    return res.status(400).json({ error: 'La cédula debe tener 7 u 8 dígitos numéricos.' });
  }

  try {
    const usuario = await Usuario.findOne({
      where: { cedula_usuario: cedula },
      attributes: { exclude: ['contraseña_usuario'] }
    });

    if (!usuario) {
      return res.status(404).json({ mensaje: 'Usuario no encontrado.' });
    }

    res.status(200).json(usuario);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Actualizar usuario 
exports.actualizarUsuario = async (req, res) => {
  const cedula = req.params.cedula;
  const {
    cedula_usuario,
    nombre_usuario,
    direccion_usuario,
    correo_usuario,
    telefono_usuario,
    user_usuario,
    contraseña_usuario,
    admin_usuario
  } = req.body;

  if (!cedula_usuario && !nombre_usuario && !direccion_usuario && !telefono_usuario && !correo_usuario && !user_usuario && !contraseña_usuario && !admin_usuario) {
    return res.status(400).json({ error: 'Debes enviar al menos un campo para actualizar.' });
  }

  if (correo_usuario && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(correo_usuario)) {
    return res.status(400).json({ error: 'El formato del correo no es válido.' });
  }

  if (contraseña_usuario && contraseña_usuario.length < 6) {
    return res.status(400).json({ error: 'La contraseña debe tener al menos 6 caracteres.' });
  }

  try {
    console.log('Body recibido:', req.body);

    const usuario = await Usuario.findByPk(cedula);
    if (!usuario) {
      return res.status(404).json({ error: 'Usuario no encontrado.' });
    }
    const datosActualizados = { ...req.body };

    if (datosActualizados.contraseña_usuario) {
      const nuevaEncriptada = await encriptarContraseña(datosActualizados.contraseña_usuario);
      usuario.contraseña_usuario = nuevaEncriptada;
    }
    if (nombre_usuario) usuario.nombre_usuario = nombre_usuario;
    if (direccion_usuario) usuario.direccion_usuario = direccion_usuario;
    if (telefono_usuario) usuario.telefono_usuario = telefono_usuario;
    if (correo_usuario) usuario.correo_usuario = correo_usuario;
    if (user_usuario) usuario.user_usuario = user_usuario;
    if (admin_usuario) usuario.admin_usuario = admin_usuario;

    await usuario.save();

    res.status(200).json({ mensaje: 'Usuario actualizado correctamente.' });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Login: acepta `identifier` (correo o username) y `password` en body
exports.login = async (req, res) => {
  const { identifier, password } = req.body;

  if (!identifier || !password) {
    return res.status(400).json({ error: 'Debe enviar identifier y password.' });
  }

  try {
    console.log('[LOGIN] identifier:', identifier);
    appendDebug('[LOGIN] identifier: ' + identifier);
    const usuario = await Usuario.findOne({
      where: {
        // Buscar por correo_usuario o user_usuario
        [require('sequelize').Op.or]: [
          { correo_usuario: identifier },
          { user_usuario: identifier }
        ]
      }
    });
    console.log('[LOGIN] usuario encontrado?:', !!usuario);
    appendDebug('[LOGIN] usuario encontrado?: ' + (!!usuario));

    if (!usuario) {
      return res.status(404).json({ error: 'Usuario no encontrado.' });
    }

    let coincide = false;

    const almacenada = usuario.contraseña_usuario || '';
    console.log('[LOGIN] contraseña almacenada (prefijo):', almacenada ? almacenada.slice(0, 10) : '<vacía>');
    appendDebug('[LOGIN] contraseña almacenada (prefijo): ' + (almacenada ? almacenada.slice(0,10) : '<vacía>'));

    // Si la contraseña almacenada parece un hash bcrypt (empieza por $2a$/$2b$/$2y$), usar compararContraseñas
    if (/^\$2[aby]\$/.test(almacenada)) {
      console.log('[LOGIN] contraseña parece ser bcrypt hash');
      appendDebug('[LOGIN] contraseña parece ser bcrypt hash');
      coincide = await compararContraseñas(password, almacenada);
      console.log('[LOGIN] resultado compararContraseñas:', coincide);
      appendDebug('[LOGIN] resultado compararContraseñas: ' + coincide);
    } else {
      console.log('[LOGIN] contraseña almacenada no parece ser hash, comparando texto plano');
      appendDebug('[LOGIN] contraseña almacenada no parece ser hash, comparando texto plano');
      // Contraseña en texto plano en DB (migración). Comparamos directamente y si coincide, la encriptamos.
      if (password === almacenada) {
        coincide = true;
        try {
          const nuevaEncriptada = await encriptarContraseña(password);
          usuario.contraseña_usuario = nuevaEncriptada;
          await usuario.save();
          appendDebug('[LOGIN] contraseña migrada a hash y guardada');
        } catch (e) {
          // si falla la migración, continuamos y permitimos el login si las credenciales eran correctas
          console.error('Error al encriptar y guardar contraseña durante migración:', e.message);
          appendDebug('[LOGIN] error al migrar contraseña: ' + (e && e.message ? e.message : String(e)));
        }
      }
    }

    if (!coincide) {
      return res.status(401).json({ error: 'Credenciales inválidas.' });
    }

    // Si el usuario no es administrador, denegar acceso
    if (!usuario.admin_usuario) {
      appendDebug('[LOGIN] usuario no es administrador, denegando acceso');
      return res.status(403).json({ error: 'No tienes permisos de administrador.' });
    }

    // Responder con datos mínimos (sin contraseña)
    const { cedula_usuario, nombre_usuario, correo_usuario, user_usuario, admin_usuario } = usuario;
    return res.status(200).json({ cedula_usuario, nombre_usuario, correo_usuario, user_usuario, admin_usuario });
  } catch (error) {
    appendDebug('[LOGIN] error catch: ' + (error && error.message ? error.message : String(error)));
    return res.status(500).json({ error: error.message });
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