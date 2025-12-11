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
                { nombre: 'Caja General', tipo: 'Activo', codigo: '1000' },
                { nombre: 'Bancos', tipo: 'Activo', codigo: '1100' },
                { nombre: 'Cuentas por Cobrar', tipo: 'Activo', codigo: '1200' },
                { nombre: 'Proveedores', tipo: 'Pasivo', codigo: '2000' },
                { nombre: 'Cuentas por Pagar', tipo: 'Pasivo', codigo: '2100' },
                { nombre: 'Ventas de Paquetes', tipo: 'Ingreso', codigo: '4000' },
                { nombre: 'Gastos de Viaje', tipo: 'Gasto', codigo: '5000' },
                { nombre: 'Gastos Administrativos', tipo: 'Gasto', codigo: '5100' }
            ]);
            console.log('✅ Cuentas contables inicializadas');
        }

    } catch (error) {
        console.error('⚠️ Error al inicializar datos:', error);
    }
};

module.exports = initData;
