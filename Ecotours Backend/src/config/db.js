const { Sequelize } = require('sequelize');

const db = new Sequelize('ecotours_db', 'root', '',
  {
    host: 'localhost',
    dialect: "mysql",
    logging: false,
  });

const connectDB = async () => {
  try {
    await db.authenticate(); 
    console.log('Conectado correctamente a MySQL con Sequelize');
  } catch (error) {
    console.error('Error al conectar con MySQL:', error);
  }
};

module.exports = { sequelize: db, connectDB };
