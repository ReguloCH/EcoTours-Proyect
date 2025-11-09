const express = require ('express');
const { sequelize, connectDB } = require('./src/config/db'); 
const db = require('./src/models'); 
const app = express ();

const PORT = 3000; 
// Llama a la conexión
connectDB(); 

// Middleware para recibir JSON
app.use(express.json());

//  Conecta las rutas de usuarios
app.use('/api/usuarios', require('./src/routes/usuarioRoutes'));

// Conecta las rutas de paquetes turísticos
app.use('/api/paquetes', require('./src/routes/paqueteTuristicoRoutes'));
// Conecta las rutas de proveedor Aerolinea
app.use('/api/aerolineas', require('./src/routes/proveedorAerolineaRoutes'));
// Conecta las rutas de tarifa por destino
app.use('/api/tarifas-aerolineas', require('./src/routes/tarifaPorDestinoRoutes'));
// Conecta las rutas de proveedor Hospedaje
app.use('/api/hospedajes', require('./src/routes/proveedorHospedajeRoutes'));
// Conecta las rutas de tarifa por hospedaje
app.use('/api/tarifas-hospedajes', require('./src/routes/tarifaHospedajeRoutes'));
// Conecta las rutas de proveedor Restaurante
app.use('/api/restaurantes', require('./src/routes/proveedorRestauranteRoutes'));
// Conecta las rutas de tarifa por restaurante
app.use('/api/tarifas-restaurantes', require('./src/routes/tarifaRestauranteRoutes'));
// Conecta las rutas de facturas de clientes
app.use('/api/facturas', require('./src/routes/facturaClienteRoutes'));
// Conecta las rutas de registro de Egresos
app.use('/api/egresos', require('./src/routes/registroEgresosRoutes'));

// Ruta de prueba
app.get('/', (req, res) => {
  res.send('HOLA ESTE ES EL SERVIDOR CON EXPRESS');
});

// Sincroniza modelos y arranca el servidor
  db.sequelize.sync({ alter: true })
  .then(() => {
    console.log('¡Modelos sincronizados con la base de datos!');

    app.post('/test', (req, res) => {
    res.json({ mensaje: 'Ruta POST /test funcionando' });
    });

    app.listen(PORT, () => {

      console.log(`Servidor escuchando en http://localhost:${PORT}`);

    });
  })
  .catch(error => {

    console.error('Error al sincronizar modelos:', error);

  });
