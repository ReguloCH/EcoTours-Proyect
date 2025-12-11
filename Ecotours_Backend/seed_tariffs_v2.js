const db = require('./src/models');

async function seedTariffs() {
    try {
        console.log("🌱 Starting Seed Process...");

        // 1. Dependencies (FKs)
        const [estado, _e] = await db.EstadoProveedor.findOrCreate({
            where: { estado_proveedor: 'Activo' },
            defaults: { estado_proveedor: 'Activo' }
        });

        const [tipoH, _th] = await db.TipoHospedaje.findOrCreate({
            where: { tipo_hospedaje: 'Hotel 5 Estrellas' },
            defaults: { tipo_hospedaje: 'Hotel 5 Estrellas' }
        });

        const [ciudadH, _ch] = await db.CiudadHospedaje.findOrCreate({
            where: { ciudad_hospedaje: 'Margarita' },
            defaults: { ciudad_hospedaje: 'Margarita' }
        });

        const [ciudadR, _cr] = await db.CiudadRestaurante.findOrCreate({
            where: { ciudad_restaurante: 'Margarita' }, // Assuming model uses this field
            defaults: { ciudad_restaurante: 'Margarita' } // Based on pattern
        });

        console.log(`✅ Dependencies ready: Estado(${estado.id_estado_proveedor}), Tipo(${tipoH.id_tipo_hospedaje})`);

        // 2. Providers
        const [hotelProv, createdH] = await db.ProveedorHospedaje.findOrCreate({
            where: { nombre_hospedaje: 'Hotel Paradise' },
            defaults: {
                nombre_hospedaje: 'Hotel Paradise',
                id_tipo_hospedaje: tipoH.id_tipo_hospedaje,
                id_ciudad_hospedaje: ciudadH.id_ciudad_hospedaje,
                id_estado_proveedor: estado.id_estado_proveedor,
                direccion_hospedaje: 'Playa El Agua'
            }
        });
        console.log(`🏨 Hotel Provider: ${hotelProv.nombre_hospedaje} (Created: ${createdH})`);

        const [restProv, createdR] = await db.ProveedorRestaurante.findOrCreate({
            where: { nombre_restaurante: 'El Sabor Tropical' },
            defaults: {
                nombre_restaurante: 'El Sabor Tropical',
                id_ciudad_restaurante: ciudadR.id_ciudad_restaurante,
                id_estado_proveedor: estado.id_estado_proveedor,
                direccion_restaurante: 'Centro Comercial La Vela',
                horario_servicio: '12pm - 10pm',
                incluye_bebidas: true
            }
        });
        console.log(`🍽️ Restaurant Provider: ${restProv.nombre_restaurante} (Created: ${createdR})`);

        // 3. Tariffs

        // Hotel Tariffs
        const [tarifaHotel, createdTH] = await db.TarifaHospedaje.findOrCreate({
            where: { id_hospedaje: hotelProv.id_hospedaje, precio_por_dia: 120.00 },
            defaults: {
                id_hospedaje: hotelProv.id_hospedaje,
                precio_por_dia: 120.00
            }
        });
        console.log(`🛏️ Hotel Tariff ($120): Created? ${createdTH}`);

        const [tarifaHotel2, createdTH2] = await db.TarifaHospedaje.findOrCreate({
            where: { id_hospedaje: hotelProv.id_hospedaje, precio_por_dia: 80.00 },
            defaults: {
                id_hospedaje: hotelProv.id_hospedaje,
                precio_por_dia: 80.00
            }
        });
        console.log(`🛏️ Hotel Tariff ($80): Created? ${createdTH2}`);

        // Restaurant Tariffs
        const [tarifaRest, createdTR] = await db.TarifaRestaurante.findOrCreate({
            where: { id_restaurante: restProv.id_restaurante, precio_por_dia: 45.00 },
            defaults: {
                id_restaurante: restProv.id_restaurante,
                precio_por_dia: 45.00
            }
        });
        console.log(`🍴 Restaurant Tariff ($45): Created? ${createdTR}`);

        const [tarifaRest2, createdTR2] = await db.TarifaRestaurante.findOrCreate({
            where: { id_restaurante: restProv.id_restaurante, precio_por_dia: 25.00 },
            defaults: {
                id_restaurante: restProv.id_restaurante,
                precio_por_dia: 25.00
            }
        });
        console.log(`🍴 Restaurant Tariff ($25): Created? ${createdTR2}`);

        console.log("✅ Seed Completed Successfully. Please RESTART backend if using in-memory-like caches (not applicable for SQL but good practice if API caches).");

    } catch (error) {
        console.error("❌ Error seeding data:", error);
    }
}

// Execute logic
seedTariffs();
