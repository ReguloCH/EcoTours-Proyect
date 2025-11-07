const express = require ('express');
const { sequelize, connectDB } = require('./src/config/db'); 
const db = require('./src/models'); 
const app = express ();
const PORT = 3000; 
// Llama a la conexión
connectDB(); 

db.sequelize.sync({ alter: true }) // 'alter: true' ajusta la tabla sin eliminar datos
    .then(() => {
        console.log('🗃️ ¡Modelos sincronizados con la base de datos!');

        app.listen(PORT, () => {
            console.log(`Servidor escuchando en http://localhost:${PORT}`);
        });
    })
    .catch(error => {
        console.error('❌ Error al sincronizar modelos:', error);
    });

app.use(express.json());

app.get('/', (req, res) =>{
    res.send('HOLA ESTE ES EL SERVIDOR CON EXPRESS');
});

