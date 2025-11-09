const express = require ('express');
const { sequelize, connectDB } = require('./src/config/db'); 
const db = require('./src/models'); 
const app = express ();

const PORT = 3000; 
// Llama a la conexión
connectDB(); 

// Middleware para recibir JSON
app.use(express.json());

// Conecta las rutas de proveedor Aerolinea
app.use('/api/aerolineas', require('./src/routes/proveedorAerolineaRoutes'));

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
