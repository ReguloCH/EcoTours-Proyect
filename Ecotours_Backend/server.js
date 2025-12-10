const express = require('express');
const cors = require("cors");

// 🟢 Importación correcta de la BD y modelos
const { connectDB } = require('./src/config/db');
const db = require('./src/models');  // <-- Aquí vienen los modelos y sequelize

const app = express();
app.use(cors({ origin: "http://localhost:5173" }));

const PORT = 3000;

// 🟢 Conexión a la BD UNA sola vez (sin duplicar)
connectDB();

// Middleware para recibir JSON
app.use(express.json());

//  RUTAS
// Rutas del sistema
app.use("/api/usuario", require("./src/routes/usuarioRoutes"));
app.use("/api/historial-compras", require("./src/routes/historialComprasRoutes"));
app.use("/api/movimientos-contables", require("./src/routes/movimientosContablesRoutes"));
app.use("/api/cuentas-contables", require("./src/routes/cuentasContablesRoutes"));
app.use("/api/facturas-clientes", require("./src/routes/facturaClienteRoutes"));
app.use("/api/paquete-turistico", require("./src/routes/paqueteTuristicoRoutes"));
app.use("/api/proveedor-aerolinea", require("./src/routes/proveedorAerolineaRoutes"));
app.use("/api/proveedor-hospedaje", require("./src/routes/proveedorHospedajeRoutes"));
app.use("/api/proveedor-restaurante", require("./src/routes/proveedorRestauranteRoutes"));
app.use("/api/tarifa-hospedaje", require("./src/routes/tarifaHospedajeRoutes"));
app.use("/api/tarifa-restaurante", require("./src/routes/tarifaRestauranteRoutes"));
app.use("/api/tarifa-por-destino", require("./src/routes/tarifaPorDestinoRoutes"));
app.use("/api/tarifa-egresos", require("./src/routes/registroEgresosRoutes"));



// 🟢 NUEVA RUTA: historial de compras
app.use('/api/historial-compras', require('./src/routes/historialComprasRoutes'));

// Ruta de prueba
app.get('/', (req, res) => {
  res.send('HOLA ESTE ES EL SERVIDOR CON EXPRESS');
});

// 🟢 Cargar relaciones de Sequelize y sincronizar modelos
// 🟢 Cargar relaciones de Sequelize y sincronizar modelos
db.sequelize.sync({ alter: true })
  .then(async () => {
    console.log('¡Modelos sincronizados con la base de datos!');

    // Inicializar datos base
    const initData = require('./src/utils/initData');
    await initData();

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
