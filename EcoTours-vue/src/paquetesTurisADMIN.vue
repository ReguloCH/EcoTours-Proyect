<template>
    <div class="pag-ADMIN-paquetes">
        <Sidebar_Admin />

        <main class="container-xl py-5 main-content-admin">
            <h1 class="text-center mb-5 titulo-admin">Gestión de Paquetes Turísticos</h1>
            <h2 class="text-center mb-4 sub-titulo-secundario">Creación de Paquete: CARACAS - LOS ROQUES</h2>

            <div class="card shadow-lg mb-5 tarjeta-transparente">
                <div class="card-header bg-naranja-principal text-white">
                    <h3 class="card-title mb-0">Registrar Nuevo Paquete</h3>
                </div>
                <div class="card-body">
                    <form @submit.prevent="agregarPaquete">
                        <div class="row g-3">
                            <div class="col-md-5">
                                <label for="destino" class="form-label">Destino del Paquete</label>
                                <input type="text" class="form-control" id="destino" v-model="nuevoPaquete.destino" required placeholder="Ej: Caracas - Los Roques">
                            </div>
                            <div class="col-md-4">
                                <label for="duracion" class="form-label">Duración del Viaje (días/noches)</label>
                                <input type="text" class="form-control" id="duracion" v-model="nuevoPaquete.duracion" required placeholder="Ej: 3 días / 2 noches">
                            </div>
                            <div class="col-md-3">
                                <label for="precio" class="form-label">Precio Paquete (USD)</label>
                                <input type="number" class="form-control" id="precio" v-model.number="nuevoPaquete.precio" required min="1">
                            </div>

                            <hr class="my-4">
                            
                            <div class="col-md-4">
                                <label for="aerolinea" class="form-label text-naranja">Aerolínea</label>
                                <select id="aerolinea" class="form-select" v-model="nuevoPaquete.aerolineaId" required>
                                    <option value="" disabled>-- Seleccione Aerolínea --</option>
                                    <option v-for="a in listaAerolineas" :key="a.id" :value="a.id">
                                        {{ a.nombreAerolinea }} ({{ a.codigoAerolinea }})
                                    </option>
                                </select>
                            </div>
                            
                            <div class="col-md-4">
                                <label for="hospedaje" class="form-label text-naranja">Hospedaje</label>
                                <select id="hospedaje" class="form-select" v-model="nuevoPaquete.hospedajeId" required>
                                    <option value="" disabled>-- Seleccione Hospedaje --</option>
                                    <option v-for="h in listaHospedajes" :key="h.id" :value="h.id">
                                        {{ h.nombre_hospedaje }} ({{ h.estado }})
                                    </option>
                                </select>
                            </div>

                            <div class="col-md-4">
                                <label for="alimentacionIncluida" class="form-label text-naranja">Alimentación</label>
                                <select id="alimentacionIncluida" class="form-select" v-model="nuevoPaquete.alimentacionIncluida" required>
                                    <option value="Incluida">Incluida</option>
                                    <option value="No Incluida">No Incluida</option>
                                </select>
                            </div>
                            
                            <div class="col-md-9">
                                <label for="imagenURL" class="form-label">URL de Imagen (Para Card del Cliente)</label>
                                <input type="url" class="form-control" id="imagenURL" v-model="nuevoPaquete.imagenURL" placeholder="Ej: /img/losroques-paquete.jpg" required>
                            </div>

                            <div class="col-md-3">
                                <label for="restaurante" class="form-label text-naranja">Restaurante</label>
                                <select v-if="nuevoPaquete.alimentacionIncluida === 'Incluida'" 
                                        id="restaurante" 
                                        class="form-select" 
                                        v-model="nuevoPaquete.restauranteId" 
                                        required>
                                    <option value="" disabled>-- Seleccione Restaurante --</option>
                                    <option v-for="r in listaRestaurantes" :key="r.id" :value="r.id">
                                        {{ r.nombreRestaurante }} ({{ r.ciudad }})
                                    </option>
                                </select>
                                <input v-else type="text" class="form-control" value="N/A" disabled>
                            </div>

                        </div>
                        
                        <button type="submit" class="btn btn-naranja-principal mt-4 w-100">
                            <i class="bi bi-plus-square-fill me-2"></i>
                            Registrar Paquete Turístico
                        </button>
                    </form>
                </div>
            </div>

            <div class="card shadow-lg tarjeta-transparente">
                <div class="card-header bg-naranja-oscuro text-white">
                    <h3 class="card-title mb-0">Paquetes Registrados (Total: {{ listaPaquetes.length }})</h3>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover tabla-datos">
                            <thead class="bg-naranja-claro">
                                <tr>
                                    <th>ID</th>
                                    <th>Destino</th>
                                    <th>Duración</th>
                                    <th>Precio</th>
                                    <th>Aerolínea</th>
                                    <th>Hospedaje</th>
                                    <th>Alimentación</th>
                                    <th>Restaurante</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="listaPaquetes.length === 0">
                                    <td colspan="8" class="text-center text-muted">Aún no se han creado paquetes turísticos.</td>
                                </tr>
                                <tr v-else v-for="paquete in listaPaquetes" :key="paquete.id">
                                    <td>{{ paquete.id }}</td>
                                    <td>{{ paquete.destino }}</td>
                                    <td>{{ paquete.duracion }}</td>
                                    <td>${{ paquete.precio }}</td>
                                    <td>{{ getProveedorNombre(paquete.aerolineaId, 'aerolineas') }}</td>
                                    <td>{{ getProveedorNombre(paquete.hospedajeId, 'hospedajes') }}</td>
                                    <td>
                                        <span :class="{'badge bg-success': paquete.alimentacionIncluida === 'Incluida', 'badge bg-danger': paquete.alimentacionIncluida === 'No Incluida'}">
                                            {{ paquete.alimentacionIncluida }}
                                        </span>
                                    </td>
                                    <td>
                                        <span v-if="paquete.alimentacionIncluida === 'Incluida'">
                                            {{ getProveedorNombre(paquete.restauranteId, 'restaurantes') }}
                                        </span>
                                        <span v-else>N/A</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
        
        <Footer_Admin />
    </div>
</template>

<script setup>
import { reactive, ref } from 'vue';
import Sidebar_Admin from './components/Sidebar_Admin.vue';
import Footer_Admin from './components/Footer_Admin.vue';

// SIMULACIÓN DE DATOS DE PROVEEDORES 

// Datos de AEROLÍNEAS 
const listaAerolineas = reactive([
    {
        id: 1, 
        codigoAerolinea: 'CONV001', 
        nombreAerolinea: 'CONVIASA', 
        ciudadesBase: ['Caracas', 'Maracaibo', ''],
        rutasPrincipales: ['Los Roques', 'Porlamar-Margarita', '', ''],
        telefonoContacto: '0251 (848) 555-10', 
        correoElectronico: 'conviasasoport@airparadise.com',
        representanteContacto: 'Juan Pérez',
        estado: 'Activo',
        fechaRegistro: '2025-10-15'
    },
]);

// Datos de HOSPEDAJE 
const listaHospedajes = reactive([
    {
        id: 2, 
        nombre_hospedaje: 'Posada Sol y Arena', 
        tipo: 'Posada', 
        estado: 'Archipiélago Los Roques', 
        direccion: 'Calle El Morro, Pampatar', 
        telefono: '+58 414-9876543', 
        correo: 'posadasol@gmail.com',
        contacto: 'Sr. Roberto Gómez',
        estado_proveedor: 'Activo',
        fecha_registro: '2025-09-01'
    },
]);

// Datos de ALIMENTACIÓN 
const listaRestaurantes = reactive([
    {
        id: 2, 
        nombreRestaurante: 'Sabores del Mar',
        ciudad: 'Archipiélago Los Roques',
        direccion: 'Frente al muelle principal, Gran Roque',
        telefono: '+58 414-5627890',
        correo: 'saboresdelmar@ecotours.com.ve',
        contacto: 'Luisana Rojas',
        horario: 'L-D 8:00 AM - 9:00 PM',
        estado_proveedor: 'Activo',
        fecha_registro: '2025-10-01'
    },
]);

// Objeto para consolidar los datos para la función de búsqueda
const proveedoresData = {
    aerolineas: listaAerolineas,
    hospedajes: listaHospedajes,
    restaurantes: listaRestaurantes
};

// LÓGICA DE GESTIÓN DE PAQUETES

// Arreglo principal (simulación BDD de Paquetes)
const listaPaquetes = reactive([]); 

// Contador e ID del nuevo paquete
const siguienteId = ref(1);

// Objeto reactivo para el formulario
const nuevoPaquete = reactive(inicializarPaquete());

function inicializarPaquete() {
    return {
        id: 0,
        destino: '',
        duracion: '',
        precio: null,
        aerolineaId: '',
        hospedajeId: '',
        alimentacionIncluida: 'Incluida', // Valor por defecto
        restauranteId: '', // Opcional, solo si está incluida
        imagenURL: '',
    };
}

// Función para obtener el nombre del proveedor en la tabla
function getProveedorNombre(id, tipo) {
    const proveedor = proveedoresData[tipo].find(p => p.id === id);
    if (!proveedor) return 'N/A';
    
    switch (tipo) {
        case 'aerolineas':
            return proveedor.nombreAerolinea;
        case 'hospedajes':
            return proveedor.nombre_hospedaje;
        case 'restaurantes':
            return proveedor.nombreRestaurante;
        default:
            return 'N/A';
    }
}

// Método para agregar un paquete nuevo
function agregarPaquete() {
    const nuevo = { ...nuevoPaquete }; 
    nuevo.id = siguienteId.value; 

    // Lógica para manejar el restaurante si no está incluido
    if (nuevo.alimentacionIncluida === 'No Incluida') {
        nuevo.restauranteId = null; 
    }

    listaPaquetes.push(nuevo); 
    siguienteId.value++; 
    alert(`Paquete "${nuevo.destino}" registrado con éxito.`);

    limpiarFormulario();
}

// Resetea el formulario
function limpiarFormulario() {
    Object.assign(nuevoPaquete, inicializarPaquete());
}

</script>

<style scoped>
.pag-ADMIN-paquetes {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    background: url('/img/paqueteTURISTICO.jpg') no-repeat center center fixed; 
    background-size: cover;
    color: #333;
}



:root {
    --naranja-principal: #ff6600; 
    --naranja-oscuro: #e65c00;
    --naranja-claro: #ffad66; 
}
.pag-ADMIN-paquetes {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    background-color: #f8f9fa; 
    color: #333;
}
.main-content-admin {
    flex-grow: 1;
}
.titulo-admin {
    color: var(--naranja-oscuro); 
    font-weight: 700;
}
.sub-titulo-secundario {
    color: #555;
    font-weight: 600;
}
.tarjeta-transparente {
    background-color: rgba(255, 255, 255, 0.95);
    border-radius: 12px;
}

/* Colores Naranja */
.bg-naranja-principal { background-color: var(--naranja-principal) !important; }
.bg-naranja-oscuro { background-color: var(--naranja-oscuro) !important; }
.bg-naranja-claro { background-color: var(--naranja-claro) !important; color: #333 !important; }

.btn-naranja-principal { 
    background-color: var(--naranja-principal) !important; 
    border-color: var(--naranja-principal) !important; 
    color: rgb(241, 180, 27) !important; 
    opacity: 1 !important;
}
.text-naranja { color: var(--naranja-oscuro); font-weight: 600; }
.badge { font-weight: 700; border-radius: 0.25rem; padding: 0.35em 0.65em; }
.bg-success { background-color: #198754 !important; }
.bg-danger { background-color: #dc3545 !important; }
</style>