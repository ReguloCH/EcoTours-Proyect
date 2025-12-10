const { TipoMovimiento, NombreCuenta } = require('../models');

const initData = async () => {
    try {
        // Inicializar Tipos de Movimiento
        const countTipos = await TipoMovimiento.count();
        if (countTipos === 0) {
            await TipoMovimiento.bulkCreate([
                { tipo: 'Ingreso' },
                { tipo: 'Egreso' }
            ]);
            console.log('✅ Tipos de movimiento inicializados');
        }

        // Inicializar Nombres de Cuentas
        const countCuentas = await NombreCuenta.count();
        if (countCuentas === 0) {
            await NombreCuenta.bulkCreate([
                { nombre: 'Caja General', tipo: 'Activo' },
                { nombre: 'Bancos', tipo: 'Activo' },
                { nombre: 'Cuentas por Cobrar', tipo: 'Activo' },
                { nombre: 'Proveedores', tipo: 'Pasivo' },
                { nombre: 'Cuentas por Pagar', tipo: 'Pasivo' },
                { nombre: 'Ventas de Paquetes', tipo: 'Ingreso' },
                { nombre: 'Gastos de Viaje', tipo: 'Gasto' },
                { nombre: 'Gastos Administrativos', tipo: 'Gasto' }
            ]);
            console.log('✅ Cuentas contables inicializadas');
        }

    } catch (error) {
        console.error('⚠️ Error al inicializar datos:', error);
    }
};

module.exports = initData;
